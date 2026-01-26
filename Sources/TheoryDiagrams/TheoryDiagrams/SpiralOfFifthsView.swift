import SwiftUI
import Combine
import ModalityCore
import ModalityDesign
import SwiftMusicTheory
import PopupView

public struct SpiralOfFifthsView: View {
  
  @ObservedObject
  var spiralOfFifths: SpiralOfFifths
  
  public init(spiralOfFifths: SpiralOfFifths) {
    self.spiralOfFifths = spiralOfFifths
  }
  
  public var body: some View {
    ZStack {
      placeholders
      degreesRing
      notesRing
      parallelModesRings
      relativeModesRing
      
      CursorView(cursor: spiralOfFifths.cursor)
        .animation(.wedge, value: spiralOfFifths.cursor)
    }
    .popup(isPresented: $spiralOfFifths.isNoteSelectionFloaterPresented) {
      Text(SpiralOfFifthsStrings.accidentalSelectionError)
        .font(.system(size: 13, weight: .bold, design: .rounded))
        .foregroundStyle(.primary)
        .padding(16)
        .background {
          RoundedRectangle(cornerRadius: 32)
            .fill(spiralOfFifths.selectedNoteColor)
        }
        .shadow(radius: 8)
    } customize: {
      $0.autohideIn(3)
        .type(.floater(verticalPadding: 0, horizontalPadding: 0, useSafeAreaInset: true))
        .appearFrom(.topSlide)
        .position(.top)
    }
  }
  
  @ViewBuilder
  fileprivate var placeholders: some View {
    if spiralOfFifths.sizeClass == .regular {
      GeometryReader { geometry in
        let minDemension = min(geometry.size.width, geometry.size.height)
        ForEach(spiralOfFifths.placeholders) { placeholder in
          Circle()
            .stroke(lineWidth: 1)
            .fill(placeholder.color)
            .frame(width: minDemension * placeholder.radius * 2)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
      }
    }
  }
  
  private var degreesRing: some View {
    RingView(ring: spiralOfFifths.degreesRing)
  }
  
  private var notesRing: some View {
    RingView<Note>(ring: spiralOfFifths.notesRing) {
      spiralOfFifths.rootSelected($0.content.containing)
    }
  }
  
  private var relativeModesRing: some View {
    RingView(ring: spiralOfFifths.relativeModesRing) {
      spiralOfFifths.relativeModeSelected($0.content.containing)
    }
  }
  
  private var parallelModesRings: some View {
    ForEach(spiralOfFifths.parallelModesRings) { modeRing in
      RingView(ring: modeRing) {
        spiralOfFifths.parallelModeSelected($0.content.containing)
      }
      .animation(.smooth, value: modeRing.innerRadius)
      //      .transition(.scaleAndFade)
    }
  }
}

#Preview {
  SpiralOfFifthsView(spiralOfFifths: .cMajor)
}
