import Foundation
import ModalityCore
import SwiftUI
import SwiftMusicTheory

struct NoteView: View {
  
  let note: Note
  let noteColor: Color
  
  var body: some View {
    RoundedRectangle(cornerRadius: 16)
      .fill(noteColor)
      .frame(height: 20)
      .overlay {
        Text(note.notation)
          .font(.system(size: 11).bold())
          .lineLimit(1)
          .foregroundStyle(.primary)
      }
  }
}
