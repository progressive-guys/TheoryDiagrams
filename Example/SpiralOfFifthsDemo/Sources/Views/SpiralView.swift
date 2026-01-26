import SwiftUI
import ModalityCore
import ModalityDesign
import SwiftMusicTheory
import TheoryDiagrams

public struct SpiralView: View {
  
  let ring: Ring<Note>
  let scrollProgress: Double
  
  init(scrollProgress: Double, ring: Ring<Note>) {
    self.ring = ring
    self.scrollProgress = scrollProgress
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        ForEach(ring.wedges.enumerated().array, id: \.element.id) { wedgeIndex, wedge in
          WedgeView(
            wedge: wedge,
            ring: ring
          )
          .rotation3DEffect(
            .degrees(scrollProgress * 45),
            axis: (x: 1, y: 0.0, z: 0.0),
            anchorZ: wedge.zIndex * scrollProgress * geometry.size.height,
            perspective: 0.03
          )
          .opacity(wedge.isFocused ? 1 : (scrollProgress * (0.5 - abs(wedge.zIndex)) * 2))
        }
      }
    }
  }
}
