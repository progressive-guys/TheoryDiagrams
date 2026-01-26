import SwiftMusicTheory
import TheoryDiagrams
import ModalityCore
import ModalityDesign

@MainActor
final class SoFOnboarding {
  
  let noteColors: NoteColors
  
  init(noteColors: NoteColors) {
    self.noteColors = noteColors
  }
  
  lazy var cSequence = Note.c.sequence(length: 14)
  
  lazy var cSequenceBackwards = Note.c.sequence(length: 10, intervalToMove: .fourth())
  
  lazy var fullSequence = Note.b.flat(2).sequence(length: 23)
  
  lazy var cofRing = Ring<Note>(
    id: "CoFRing",
    wedges: Note.f.sequence(length: 12).enumerated().map { index, note in
      .init(
        id: note.description,
        color: noteColors[note],
        start: .degrees(-135 + 30 * Double(index)),
        width: .degrees(30),
        content: .init(type: .label, containing: note, font: .SoFNotesFont, text: note.notation)
      )
    },
    innerRadius: 0.2,
    heigth: 0.1
  )
  
  lazy var accidentalsPattern = AccidentalsPattern(noteColors: noteColors)
  
  lazy var spiralSequence = Note.f.flat(3).sequence(length: 49)
  lazy var spiralSelectedNoteIndex = spiralSequence.firstIndex(of: Note.c) ?? 0
  lazy var animatableSpiral = Ring<Note>(
    id: "SoF",
    wedges: spiralSequence.enumerated().map { index, note in
      Ring<Note>.Wedge(
        id: note.description,
        color: noteColors[note],
        start: .degrees(-45 + 30 * Double(index)),
        width: .degrees(30),
        zIndex: Double(spiralSequence.count / 2 - index) / Double(spiralSequence.count),
        content: .init(type: .label, containing: note, font: .SoFNotesFont, text: note.notation),
        isFocused: (spiralSelectedNoteIndex..<spiralSelectedNoteIndex + 12).contains(index)
      )
    },
    innerRadius: 0.2,
    heigth: 0.1
  )

  lazy var spiralEnharmonicsSelectedIndex = spiralSequence.firstIndex(of: Note.f.sharp()) ?? 0
  lazy var spiralEnharmonics = Ring<Note>(
    id: "spiralEnharmonics",
    wedges: spiralSequence.enumerated().map { index, note in
      Ring<Note>.Wedge(
        id: note.description,
        color: spiralSequence[spiralEnharmonicsSelectedIndex].isEnharmonic(to: note) ? noteColors[.f.sharp()] : .gray,
        start: .degrees(-45 + 30 * Double(index)),
        width: .degrees(30),
        zIndex: Double(spiralSequence.count / 2 - index) / Double(spiralSequence.count),
        content: .init(
          type: .label,
          containing: note,
          font: .SoFNotesFont,
          text: note.notation
        ),
        isFocused: spiralSequence[spiralEnharmonicsSelectedIndex].isEnharmonic(to: note)
      )
    },
    innerRadius: 0.2,
    heigth: 0.1
  )
  
  lazy var eSequence = Note.e.sequence(length: 12)
  lazy var aSharpNotesCoF = Ring<Note>(
    id: "aSharpNotesCoF",
    wedges: eSequence.enumerated().map { index, note in
      Ring<Note>.Wedge(
        id: note.description,
        color: noteColors[note],
        start: .degrees(75 + 30 * Double(index)),
        width: .degrees(30),
        content: .init(
          type: .label,
          containing: note,
          font: .SoFNotesFont,
          text: note.notation
        )
      )
    },
    innerRadius: 0.3,
    heigth: 0.15
  )
  
  lazy var aSharpMajor = Mode(root: .a.sharp(), scale: .diatonic)
  lazy var aSharpDegreesCoF = Ring<String>(
    id: "aSharpDegreesCoF",
    wedges: eSequence.enumerated().compactMap { index, note in
      guard let degree = self.aSharpMajor.degree(under: note) else { return nil }
      
      return Ring.Wedge(
        id: note.description,
        color: noteColors[note],
        start: .degrees(75 + 30 * Double(index)),
        width: .degrees(30),
        content: .init(type: .label, containing: degree.functionTitle, font: .SoFNotesFont, text: degree.functionTitle)
      )
    },
    innerRadius: 0.2,
    heigth: 0.1
  )
  
  lazy var modeFormulaDiagram = ModeFormulaDiagram(
    mode: Mode(root: .c, scale: .diatonic),
    noteColors: noteColors
  )
}
