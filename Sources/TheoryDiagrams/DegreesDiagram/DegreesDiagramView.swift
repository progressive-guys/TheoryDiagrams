import SwiftUI

public struct DegreesDiagramView: View {
  
  @ObservedObject
  var degreesDiagram: DegreesDiagram
  
  public init(degreesDiagram: DegreesDiagram) {
    self.degreesDiagram = degreesDiagram
  }
  
  public var body: some View {
    VStack {
      
    }
  }
}
