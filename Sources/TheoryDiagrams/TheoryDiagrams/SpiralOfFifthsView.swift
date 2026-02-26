import SwiftUI
import Combine
import ModalityCore
import ModalityDesign
import SwiftMusicTheory

public struct SpiralOfFifthsView: View {

  private static let referenceSize: CGFloat = 500

  @ObservedObject
  var spiralOfFifths: SpiralOfFifths

  @State private var fontScale: CGFloat = 1.0

  public init(spiralOfFifths: SpiralOfFifths) {
    self._spiralOfFifths = ObservedObject(wrappedValue: spiralOfFifths)
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
    .observeSize { size in
      fontScale = min(size.width, size.height) / Self.referenceSize
    }
    .toast(isPresented: $spiralOfFifths.isNoteSelectionFloaterPresented) {
      Text(SpiralOfFifthsStrings.accidentalSelectionError)
        .font(.system(size: 13, weight: .bold, design: .rounded))
        .foregroundStyle(.primary)
        .padding(16)
        .background {
          RoundedRectangle(cornerRadius: 32)
            .fill(spiralOfFifths.selectedNoteColor)
        }
        .shadow(radius: 8)
    }
  }
  
  @ViewBuilder
  fileprivate var placeholders: some View {
    if spiralOfFifths.sizeClass == .regular {
      GeometryReader { geometry in
        let minDimension = min(geometry.size.width, geometry.size.height)
        ForEach(spiralOfFifths.placeholders) { placeholder in
          Circle()
            .stroke(lineWidth: 1)
            .fill(placeholder.color)
            .frame(width: minDimension * placeholder.radius * 2)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
      }
    }
  }

  private var degreesRing: some View {
    RingView(ring: spiralOfFifths.degreesRing(fontScale: fontScale))
  }

  private var notesRing: some View {
    RingView<Note>(ring: spiralOfFifths.notesRing(fontScale: fontScale)) {
      spiralOfFifths.rootSelected($0.content.containing)
    }
  }

  private var relativeModesRing: some View {
    RingView(ring: spiralOfFifths.relativeModesRing(fontScale: fontScale)) {
      spiralOfFifths.relativeModeSelected($0.content.containing)
    }
  }

  private var parallelModesRings: some View {
    ForEach(spiralOfFifths.parallelModesRings(fontScale: fontScale)) { modeRing in
      RingView(ring: modeRing) {
        spiralOfFifths.parallelModeSelected($0.content.containing)
      }
      .animation(.smooth, value: modeRing.innerRadius)
    }
  }
}

#Preview {
  SpiralOfFifthsView(spiralOfFifths: .cMajor)
}
