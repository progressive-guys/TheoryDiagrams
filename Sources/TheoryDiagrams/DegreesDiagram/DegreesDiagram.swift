import SwiftUI
import Combine

@MainActor
public final class DegreesDiagram: ObservableObject {
  
  let spiralOfFifths: SpiralOfFifths
  
  public init(spiralOfFifths: SpiralOfFifths) {
    self.spiralOfFifths = spiralOfFifths
  }
}
