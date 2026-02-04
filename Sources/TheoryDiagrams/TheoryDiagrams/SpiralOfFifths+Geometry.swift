import SwiftUI

extension SpiralOfFifths {
  struct Geometry {
    let modesWedgesHeight: CGFloat
    
    let degreesInnerRadius: CGFloat
    let degreesHeight: CGFloat
    
    let notesInnerRadius: CGFloat
    let notesOuterRadius: CGFloat
    let notesHeight: CGFloat
    
    /// Needed for compact horizontalSizeClass
    let yShift: CGFloat
    let scale: CGFloat
    let aspectRatio: CGFloat
    
    init(modesCount: Int, sizeClass: UserInterfaceSizeClass) {
      let center: CGFloat = 0.5
      
      self.degreesInnerRadius = 0.08
      self.degreesHeight = 0.05
      
      self.notesInnerRadius = degreesInnerRadius + degreesHeight
      self.notesHeight = 0.08
      self.notesOuterRadius = notesInnerRadius + notesHeight
      
      self.modesWedgesHeight = (center - notesOuterRadius) / CGFloat(modesCount)
      
      let shiftedBy = modesWedgesHeight * CGFloat(modesCount - 1)
      
      switch sizeClass {
      case .compact:
        self.yShift = shiftedBy / 2
        self.scale = 1 / (1 - shiftedBy)
        self.aspectRatio = 1 / (notesOuterRadius * 2 + modesWedgesHeight * CGFloat(modesCount))
      case .regular: fallthrough @unknown default:
        self.yShift = 0
        self.scale = 1
        self.aspectRatio = 1
      }
    }
    
    func modeInnerRadius(at index: Int) -> CGFloat {
      notesOuterRadius + CGFloat(index) * modesWedgesHeight
    }
    
    func modeOuterRadius(at index: Int) -> CGFloat {
      modeInnerRadius(at: index + 1)
    }
  }
  
  struct Placeholder: Sendable, Identifiable {
    let color: Color
    let radius: CGFloat
    var id: CGFloat { radius }
  }
}
