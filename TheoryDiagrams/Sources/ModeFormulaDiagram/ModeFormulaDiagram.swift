import Combine
import ModalityCore
import SwiftUI
import os
import SwiftMusicTheory
import ModalityDesign

@MainActor
public final class ModeFormulaDiagram: ObservableObject {
  
  struct PatternCell: Identifiable {
    let id: Int
    let degreeTitle: String
    let tonesTitle: String
    let noteTitle: String
    let focused: Bool
  }
  
  var pattern: [PatternCell] {
    degrees.enumerated().map { index, degree in
      let selectedModeIndex = modes.firstIndex(of: selectedMode) ?? 0
      let degreeIndex = index % modes.count
      return PatternCell(
        id: index,
        degreeTitle: "\(degreeIndex + 1)",
        tonesTitle: degree.intervalFromPrevious.tonesTitle,
        noteTitle: modes[degreeIndex].root.notation,
        focused: (selectedModeIndex..<selectedModeIndex + modes.count).contains(index)
      )
    }
  }
  
  public let modes: [Mode]
  @Published public var selectedMode: Mode
  public let noteColors: NoteColors
  private let degrees: [Scale.Degree]
  
  public init(mode: Mode, noteColors: NoteColors) {
    self.modes = mode.relativeModes
    self.selectedMode = mode
    self.noteColors = noteColors
    self.degrees = mode.scale.degrees + mode.scale.degrees.dropLast()
  }
}

fileprivate extension Interval {
  var tonesTitle: String {
    let semitones = semitonesCount()
    switch semitones {
    case 1: return "H"
    case 2: return "W"
    default:
      if semitones % 2 == 0 {
        return "\(Int(Double(semitones) / 2))W"
      } else {
        return String(format: "%.1fW", Double(semitones) / 2)
      }
    }
  }
}

extension Mode: @retroactive Identifiable {
  public var id: String {
    self.description
  }
}
