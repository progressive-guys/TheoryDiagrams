import SwiftUI
import Combine
import ModalityCore
import SwiftMusicTheory
import ModalityDesign
import TheoryDiagrams

@MainActor
final class AccidentalsPattern: ObservableObject, Sendable {
  
  struct Raw: Identifiable {
    
    var id: Int { index }
    let index: Int
    let notes: [Note]
  }
  
  let noteColors: NoteColors
  let startedNote = Note.f.flat(2)
  let raws: [Raw]
  let colomnsCount = 7
  
  @Published var selectedNote: Note
  
  init(noteColors: NoteColors) {
    self.noteColors = noteColors
    self.selectedNote = Note.f.flat(2)
    self.raws = Note.f.flat(2).sequence(length: 35).batched(by: colomnsCount).enumerated().map(Raw.init)
  }
  
  func highligth() {
    Note.f.flat(2)
      .sequence(length: 13)
      .enumerated()
      .forEach { index, note in
        _ = Task.delayed(seconds: 0.06 * Double(index)) { @MainActor in
          selectedNote = note
        }
      }
  }
}

struct AccidentalsPatternView: View {
  
  @ObservedObject
  private var viewModel: AccidentalsPattern
  
  init(viewModel: AccidentalsPattern) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 8) {
      ForEach(viewModel.raws) { raw in
        HStack(spacing: 0) {
          ForEach(raw.notes.enumerated().array, id: \.1.description) { noteIndex, note in
            HStack {
              Spacer()
              Text(note.notation)
                .font(.notesFont.monospaced())
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
              Spacer()
            }
            .onTapGesture {
              viewModel.selectedNote = note
            }
            .overlay {
              let isSelected = viewModel.selectedNote.isEnharmonic(to: note)
              RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(isSelected ? Color.cursorColor : .clear)
                .animation(.easeInOut, value: isSelected)
            }
          }
        }
      }
    }
    .padding(8)
    .background {
      RoundedRectangle(cornerRadius: 8).fill(gradient)
    }
  }
  
  private var gradient: some ShapeStyle {
    LinearGradient(
      colors: [
        viewModel.noteColors[viewModel.raws.first!.notes.first!],
        viewModel.noteColors[viewModel.raws.last!.notes.last!]
      ],
      startPoint: .top,
      endPoint: .bottom
    )
  }
}
