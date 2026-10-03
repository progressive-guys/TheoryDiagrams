import Combine
import ModalityCore
import SwiftUI
import os
import SwiftMusicTheory

@MainActor
public final class ModesTable: ObservableObject {
  
  public enum DiagramType: CaseIterable, Hashable, Identifiable, Sendable {
    case relativeModeChords
    case parallelModeChords
    case degrees
    
    public var id: Self { self }
    
    var title: String {
      switch self {
      case .degrees: return SpiralOfFifthsStrings.degrees
      case .parallelModeChords: return SpiralOfFifthsStrings.parallelModeChords
      case .relativeModeChords: return SpiralOfFifthsStrings.relativeModeChords
      }
    }
  }
  
  struct Cell: Identifiable {
    var id: Scale.Degree { scaleDegree }
    
    enum CellType: Equatable {
      case chord(Chord)
      case degree
      case unknown
    }
    
    let scaleDegree: Scale.Degree
    let cellType: CellType
    let color: Color
  }
  
  struct Raw: Identifiable {
    var id: Scale { mode.scale }
    
    let mode: Mode
    let modeColor: Color
    let cells: [Cell]
    let isSelected: Bool
  }
  
  @Published var diagramType: DiagramType
  let interactable: Bool
  
  private let spiralOfFifths: SpiralOfFifths
  private var cancellables = Set<AnyCancellable>()
  
  public init(
    spiralOfFifths: SpiralOfFifths,
    diagramType: DiagramType = .parallelModeChords,
    interactable: Bool = true
  ) {
    self.diagramType = diagramType
    self.interactable = interactable
    self.spiralOfFifths = spiralOfFifths
    
    spiralOfFifths.objectWillChange
      .sink { [weak self] _ in self?.objectWillChange.send() }
      .store(in: &cancellables)
  }
  
  func parallelModeSelected(_ mode: Mode) {
    switch diagramType {
    case .parallelModeChords:
      spiralOfFifths.parallelModeSelected(mode)
    case .relativeModeChords:
      spiralOfFifths.relativeModeSelected(mode)
    case .degrees:
      break
    }
  }
  
  var raws: [Raw] {
    let modes = switch diagramType {
    case .relativeModeChords:
      spiralOfFifths.relativeModes
    case .parallelModeChords, .degrees:
      spiralOfFifths.parallelModes
    }
    
    return modes.map { mode in
      Raw(
        mode: mode,
        modeColor: spiralOfFifths.selectedNoteColor,
        cells: mode.notes.enumerated()
          .map { index, note in
            let degree = mode.scale.degrees[index]
            guard let chord = mode.chords.first(where: { $0.root == note }) else { return Cell(scaleDegree: degree, cellType: .unknown, color: .clear) }
            
            return Cell(
              scaleDegree: degree,
              cellType: {
                switch diagramType {
                case .degrees: .degree
                case .relativeModeChords, .parallelModeChords: .chord(chord)
                }
              }(),
              color: spiralOfFifths.colors[chord.root]
            )
          },
        isSelected: interactable && mode == spiralOfFifths.currentMode
      )
    }
  }
}
