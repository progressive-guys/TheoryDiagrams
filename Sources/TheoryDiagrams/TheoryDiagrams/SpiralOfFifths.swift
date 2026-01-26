import Combine
import ModalityCore
import SwiftUI
import os
import SwiftMusicTheory
import ModalityDesign

@MainActor
public final class SpiralOfFifths: ObservableObject {
  
  @Published var isNoteSelectionFloaterPresented = false

  @Published private(set) var currentMode: Mode
  @Published private(set) var mainScale: Scale {
    didSet {
      geometry = Geometry(modesCount: mainScale.degrees.count, sizeClass: sizeClass)
    }
  }
  @Published private var notesSpiral: Spiral<Note>

  @Published private var selectedNoteIndex: Int = 0
  @Published private var selectedModeIndex: Int = 0

  private var geometry: Geometry
  
  var placeholders: [Placeholder] {
    let parallelModesCount = parallelModes.count
    
    return parallelModes[0..<parallelModesCount - 1].enumerated().map { index, mode in
      Placeholder(
        color: parallelModeColor(for: mode).opacity(Double(parallelModesCount - index) / Double(parallelModesCount) * 0.7),
        radius: geometry.modeOuterRadius(at: index)
      )
    }
  }
  
  @Published public var sizeClass: UserInterfaceSizeClass {
    didSet {
      geometry = Geometry(modesCount: mainScale.degrees.count, sizeClass: sizeClass)
    }
  }
  
  public lazy var colors = NoteColors(spiral: notesSpiral)
  
  func parallelModeColor(for mode: Mode) -> Color {
    colors[relativeModes.first(where: { $0.scale == mode.scale })!.root]
  }

  var angles: [Note: Angle] {
    allNotes.enumerated().makeDictionary { noteIndex, note in (note, angle(for: noteIndex)) }
  }
  
  var allNotes: [Note] { notesSpiral.elements }

  var displayedNotes: [Note] {
    let stepsBack = reversedProjection ? (notesSpiral.spiralTurnLength - relativeModesDistance) : 0
    return notesSpiral
      .projection(from: firstNoteInModeIndex - stepsBack)
  }
  
  var parallelModes: [Mode] {
    relativeModes.compactMap { $0.at(root: selectedNote) }
  }

  var relativeModes: [Mode] {
    let relativeModes = currentMode.relativeModes
    return allNotes.compactMap { note in relativeModes.first(where: { $0.root == note }) }
  }

  // MARK: - Init

  public init(notesSpiral: Spiral<Note>, initialMode: Mode) {
    self.notesSpiral = notesSpiral
    self.currentMode = initialMode
    self.mainScale = initialMode.scale
    let defaultSizeClass = UserInterfaceSizeClass.byDefault
    self.sizeClass = defaultSizeClass
    self.geometry = Geometry(modesCount: initialMode.scale.degrees.count, sizeClass: defaultSizeClass)
    self.reversedProjection = UserDefaults.standard.object(forKey: "reversedProjectionSetting") as? Bool ?? true

    rootSelected(initialMode.root)
    relativeModeSelected(initialMode)
  }

  // MARK: - Public
  
  public var selectedNote: Note {
    allNotes[selectedNoteIndex]
  }
  
  public var selectedNoteColor: Color {
    colors[selectedNote]
  }

  @Published public var reversedProjection: Bool = true {
    didSet {
      UserDefaults.standard.set(reversedProjection, forKey: "reversedProjectionSetting")
    }
  }

  @Published public var spiralFolded: Bool = false {
    didSet {
      self.notesSpiral.spiralTurnLength = spiralFolded ? modesCount : Interval.octave().semitonesCount()

      let step = spiralFolded ? -1 : 1
      var stepsDispatched = 0

      while stepsDispatched != foldingDiff {
        stepsDispatched += 1
        let _ = Task.delayed(seconds: 0.1 * Double(stepsDispatched)) { @MainActor [weak self] in
          withAnimation(.bouncy(extraBounce: 0.2)) {
            self?.notesSpiral.spiralTurnLength += step
          }
        }
      }
    }
  }

  public var cursor: CursorView.Cursor {
    CursorView.Cursor(
      start: angle(for: selectedNoteIndex),
      width: wedgesWidth,
      innerRadius: geometry.notesInnerRadius,
      outerRadius: geometry.modeOuterRadius(at: 0),
      yShift: geometry.yShift,
      scale: geometry.scale,
      aspectRatio: geometry.aspectRatio
    )
  }

  public var degreesRing: Ring<String> {
    Ring(
      id: "degreesRing",
      wedges: relativeModes
        .compactMap { relativeMode -> Ring<String>.Wedge? in
          let degree = self.currentMode.degree(under: relativeMode.root)!
          let angle = angles[relativeMode.root]!
          let index = allNotes.firstIndex(of: relativeMode.root)!
          
          return Ring<String>.Wedge(
            id: "degree \(degree.function.number)",
            color: colors[relativeMode.root],
            start: index > selectedNoteIndex ? angle : angle + .degrees(360),
            width: wedgesWidth,
            content: Ring<String>.Wedge.Content(
              type: .label,
              containing: degree.functionTitle,
              font: .system(size: 10, weight: .heavy),
              text: degree.functionTitle
            )
          )
        },
      innerRadius: geometry.degreesInnerRadius,
      heigth: geometry.degreesHeight,
      yShift: geometry.yShift,
      scale: geometry.scale,
      aspectRatio: geometry.aspectRatio
    )
  }
  
  public var notesRing: Ring<Note> {
    let displayedNotes = displayedNotes
    return Ring(
      id: "notesRing",
      wedges: allNotes.enumerated().compactMap { allNotesIndex, note in
        guard let displayedNotesIndex = displayedNotes.firstIndex(of: note) else { return nil }

        let id = note.semitonesNormalized
        return Ring<Note>.Wedge(
          id: "\(id)",
          color: colors[note],
          start: angle(for: displayedNotesIndex),
          width: wedgesWidth,
          content: Ring<Note>.Wedge.Content(
            type: .label,
            containing: note,
            font: .SoFNotesFont,
            text: note.notation
          )
        )
      },
      innerRadius: geometry.notesInnerRadius,
      heigth: geometry.notesHeight,
      yShift: geometry.yShift,
      scale: geometry.scale,
      aspectRatio: geometry.aspectRatio
    )
  }

  public var parallelModesRings: [Ring<Mode>] {
    let modesCount = modesCount
    
    return parallelModes
      .enumerated()
      .map { (modeIndex, parallelMode) in
        let modeIndex = (modeIndex - selectedModeIndex + modesCount) % modesCount
        
        return Ring(
          id: "Parallel Ring \(parallelMode.shortName)",
          wedges: [
            Ring<Mode>.Wedge(
              id: "Parallel \(parallelMode.shortName)",
              color: parallelModeColor(for: parallelMode),
              start: angles[parallelMode.root]!,
              width: wedgesWidth,
              content: .init(
                type: .circularLabel,
                containing: parallelMode,
                font: .modesFont,
                text: parallelMode.shortName
              )
            )
          ],
          innerRadius: geometry.modeInnerRadius(at: modeIndex),
          heigth: geometry.modesWedgesHeight,
          yShift: geometry.yShift,
          scale: geometry.scale,
          aspectRatio: geometry.aspectRatio
        )
      }
  }

  public var relativeModesRing: Ring<Mode> {
    Ring(
      id: "relativeModesRing",
      wedges: relativeModes.compactMap { mode in
        Ring<Mode>.Wedge(
          id: mode.shortName,
          color: colors[mode.root],
          start: angles[mode.root]!,
          width: wedgesWidth,
          content: .init(
            type: .circularLabel,
            containing: mode,
            font: .modesFont,
            text: mode.shortName
          )
        )
      },
      innerRadius: geometry.modeInnerRadius(at: 0),
      heigth: geometry.modesWedgesHeight,
      yShift: geometry.yShift,
      scale: geometry.scale,
      aspectRatio: geometry.aspectRatio
    )
  }

  public func parallelModeSelected(_ parallelMode: Mode) {
    self.selectedModeIndex = parallelModes.firstIndex(where: { $0.scale == parallelMode.scale })!
    self.currentMode = parallelMode
  }

  public func relativeModeSelected(_ relativeMode: Mode) {
    guard relativeMode.root.isSelectable else {
      isNoteSelectionFloaterPresented = true
      return
    }

    guard let selectedModeIndex = relativeModes.firstIndex(of: relativeMode) else {
      Logger.default.debug("Can not find \(relativeMode) in relative modes: \(self.relativeModes)")
      return
    }

    guard rootSelected(relativeMode.root) else { return }

    self.currentMode = relativeMode
    self.selectedModeIndex = selectedModeIndex
  }

  @discardableResult
  public func rootSelected(_ note: Note) -> Bool {
    guard note.isSelectable else {
      isNoteSelectionFloaterPresented = true
      return false
    }
    
    self.currentMode = currentMode.at(root: note)
    self.selectedNoteIndex = allNotes.firstIndex(of: note)!
    
    return true
  }

  // MARK: - Private

  private var firstNoteInModeIndex: Int {
    let firstNoteInMode = relativeModes.first?.root
    return allNotes.firstIndex { $0 == firstNoteInMode } ?? 0
  }
  
  private var lastNoteInModeIndex: Int {
    let lastNoteInMode = relativeModes.last?.root
    return allNotes.firstIndex { $0 == lastNoteInMode } ?? 0
  }
  
  private var modesCount: Int { relativeModes.count }
  private var relativeModesDistance: Int { lastNoteInModeIndex - firstNoteInModeIndex + 1 }
  private var foldingDiff: Int { Interval.octave().semitonesCount() - modesCount }

  var offsetToCenter: Int {
    let initialIndex = notesSpiral.elements.firstIndex(of: .c) ?? 0
    return notesSpiral.spiralTurnLength - initialIndex % notesSpiral.spiralTurnLength
  }

  private func angle(for noteIndex: Int) -> Angle {
    initialAngle + wedgesWidth * Double(noteIndex)
  }

  private var initialAngle: Angle {
    let pathFix: Angle = .degrees(-90)
    let centerFix: Angle = {
      switch sizeClass {
      case .compact:
        return -wedgesWidth * 0.5
      case .regular: fallthrough @unknown default:
        return wedgesWidth * (Double(offsetToCenter) - 0.5)
      }
    }()
    let foldingFix: Angle = spiralFolded ? .degrees(720) : .zero
    let compactSizeClassFix: Angle = {
      switch sizeClass {
      case .compact:
        return wedgesWidth * Double(selectedNoteIndex)
      case .regular: fallthrough @unknown default:
        return Angle.zero
      }
    }()
    let result = pathFix + centerFix - compactSizeClassFix - foldingFix

//    print("spiralFolded: \(spiralFolded), wedgesWidth: \(Int(wedgesWidth.degrees)), foldingFix: \(Int(foldingFix.degrees)), offsetToCenter: \(offsetToCenter), centerFix: \(Int(centerFix.degrees)), result: \(Int(result.degrees))")
    return result
  }

  private var wedgesWidth: Angle {
    .degrees(360 / Double(notesSpiral.spiralTurnLength))
  }
}

fileprivate extension Note {
  var isSelectable: Bool {
    abs(accidental.semitonesDifference) < 2
  }
}

extension SpiralOfFifths {
  public static var cMajor: SpiralOfFifths {
    SpiralOfFifths(notesSpiral: .withTripleAlterations, initialMode: Mode(root: .c, scale: .diatonic))
  }

  public static var cHarmonicMajor: SpiralOfFifths {
    SpiralOfFifths(notesSpiral: .withTripleAlterations, initialMode: Mode(root: .c, scale: .harmonicMajor))
  }
}
