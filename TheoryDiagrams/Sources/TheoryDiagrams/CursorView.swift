import SwiftUI
import ModalityCore
import ModalityDesign

public struct CursorView: View {
  public struct Cursor: Equatable {
    var start: Angle
    var width: Angle
    let innerRadius: CGFloat
    let outerRadius: CGFloat
    let yShift: CGFloat
    let scale: CGFloat
    let aspectRatio: CGFloat
  }
  
  var cursor: Cursor
  
  public var body: some View {
    GeometryReader { geometryProxy in
      WedgeShape(
        geometry: WedgeGeometry(
          start: cursor.start,
          end: cursor.start + cursor.width,
          innerRadiusNorm: cursor.innerRadius,
          outerRadiusNorm: cursor.outerRadius,
          size: geometryProxy.size,
          shiftFactor: cursor.yShift,
          scaleFactor: cursor.scale,
          aspectRatio: cursor.aspectRatio
        )
      )
      .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .butt, lineJoin: .round))
      .fill(Color.cursorColor)
    }
  }
}

extension CursorView: @preconcurrency Animatable {
  
  public var animatableData: AnimatablePair<Double, Double> {
    get {
      AnimatablePair(cursor.start.degrees, cursor.width.degrees)
    }
    set {
      cursor.start = .degrees(newValue.first)
      cursor.width = .degrees(newValue.second)
    }
  }
}
