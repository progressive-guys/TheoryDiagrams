import SwiftUI
import Combine
import ModalityCore
import SwiftMusicTheory
import ModalityDesign

public struct ModesTableView: View {
  
  @ObservedObject
  var modesTable: ModesTable
  
  var segmentedControlSelectionColor: Color
  
  public init(modesTable: ModesTable, segmentedControlSelectionColor: Color) {
    self.modesTable = modesTable
    self.segmentedControlSelectionColor = segmentedControlSelectionColor
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      if modesTable.interactable {
        CustomizableSegmentedControl(
          selection: $modesTable.diagramType,
          options: ModesTable.DiagramType.allCases,
          selectionView: {
            segmentedControlSelectionColor
              .animation(.linear)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          },
          segmentContent: { option, isPressed in
            Text(option.title)
              .font(.system(size: 10, weight: .semibold, design: .rounded))
              .foregroundColor(isPressed ? .secondary : .primary)
              .lineLimit(1)
              .padding(.vertical, 2)
              .frame(maxWidth: .infinity)
          }
        )
        .insets(.all, 4)
        .segmentedControlContentStyle(.blendMode())
        .segmentedControl(interSegmentSpacing: 2)
        .segmentedControlSlidingAnimation(.bouncy)
        .background(segmentedControlSelectionColor.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.bottom, 4)
      }

      ForEach(modesTable.raws) { raw in
        rawView(raw)
          .onTapGesture { modesTable.parallelModeSelected(raw.mode) }
      }
    }
    .frame(maxWidth: 640)
  }
  
  fileprivate func rawView(_ raw: ModesTable.Raw) -> some View {
    HStack {
      Text(raw.mode.names.first ?? raw.mode.shortName)
        .foregroundStyle(raw.modeColor)
        .font(.system(size: 13, weight: .bold))
        .lineLimit(1)
        .frame(minWidth: 80, alignment: .leading)
      
      ForEach(raw.cells) { cell in
        cellView(cell)
      }
    }
    .padding(2)
    .background {
      RoundedRectangle(cornerRadius: 6, style: .continuous)
        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        .fill(raw.isSelected ? Color.cursorColor : .clear)
        .animation(.linear, value: raw.isSelected)
    }
  }
  
  fileprivate func cellView(_ cell: ModesTable.Cell) -> some View {
    RoundedRectangle(cornerRadius: 6, style: .continuous)
      .fill(cell.color)
      .animation(.linear, value: cell.color)
      .frame(minHeight: 14)
      .overlay {
        HStack(alignment: .lastTextBaseline, spacing: 0) {
          switch cell.cellType {
          case .chord(let chord):
            Text(chord.root.notation)
              .font(.system(size: 11 ,weight: .bold))
            Text(chord.triad.title)
              .lineLimit(1)
              .font(.system(size: 8, weight: .light))
          case .degree:
            Text(cell.scaleDegree.functionTitle)
              .font(.system(size: 11 ,weight: .black))
          case .unknown:
            EmptyView()
          }
        }
        .animation(.smooth, value: cell.cellType)
        .foregroundStyle(.primary)
      }
  }
}

#Preview {
  ZStack {
    Color.backgroundColor.ignoresSafeArea()
    ModesTableView(modesTable: ModesTable(spiralOfFifths: .cMajor), segmentedControlSelectionColor: .gray)
      .frame(height: 164)
      .border(Color.red)
  }
}
