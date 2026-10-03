import SwiftUI
import SwiftMusicTheory
import ModalityCore
import Combine
import ModalityDesign

public struct ModeFormulaDiagramView: View {
  
  @ObservedObject
  var viewModel: ModeFormulaDiagram
  
  public init(viewModel: ModeFormulaDiagram) {
    self._viewModel = ObservedObject(wrappedValue: viewModel)
  }
  
  public var body: some View {
    VStack {
      selectControl
      pattern
        .padding([.horizontal, .bottom], 16)
    }
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(viewModel.noteColors[viewModel.selectedMode.root])
    )
  }
  
  private var pattern: some View {
    HStack(spacing: 0) {
      ForEach(viewModel.pattern) { pattern in
        VStack {
          Text(pattern.tonesTitle)
            .font(.notesFont)
          Text(pattern.noteTitle)
            .font(.notesFont)
        }
          .frame(maxWidth: .infinity)
          .foregroundStyle(pattern.focused ? .primary : Color.primary.opacity(0.1))
          .background {
            if pattern.focused {
              VStack {
                Spacer()
                Rectangle()
                  .fill(Color.cursorColor.opacity(0.5))
                  .frame(height: 2)
              }
            }
          }
          .animation(.linear(duration: 0.3), value: pattern.focused)
      }
    }
  }
  
  private var selectControl: some View {
    SegmentedControl(
      selection: $viewModel.selectedMode,
      options: viewModel.modes,
      label: \.shortName,
      selectionColor: .white.opacity(0.2),
      backgroundColor: viewModel.noteColors[viewModel.selectedMode.root],
    )
  }
}
