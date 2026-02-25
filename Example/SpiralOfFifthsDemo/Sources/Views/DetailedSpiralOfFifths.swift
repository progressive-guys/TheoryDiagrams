import SwiftUI
import Combine
import SwiftMusicTheory
import TheoryDiagrams
import ModalityCore
import ModalityDesign

@MainActor
public final class DetailedSpiralOfFifths: ObservableObject {
  @Published public var spiralOfFifths: SpiralOfFifths
  public let modesTable: ModesTable

  private var cancellables = Set<AnyCancellable>()

  public init(initialMode: Mode, notesSpiral: Spiral<Note>) {
    let spiralOfFifths = SpiralOfFifths(notesSpiral: notesSpiral, initialMode: initialMode)
    self.spiralOfFifths = spiralOfFifths
    self.modesTable = ModesTable(spiralOfFifths: spiralOfFifths)

    spiralOfFifths.objectWillChange
      .sink { [weak self] _ in self?.objectWillChange.send() }
      .store(in: &cancellables)
  }
}

public struct DetailedSpiralOfFifthsView: View {
  
  @ObservedObject
  var viewModel: DetailedSpiralOfFifths
  
  @Environment(\.horizontalSizeClass) var sizeClass: UserInterfaceSizeClass?
  
  public init(
    viewModel: DetailedSpiralOfFifths
  ) {
    self.viewModel = viewModel
  }
  
  @ViewBuilder
  private var infoButton: some View {
    WindowOpenableButton(
      windowTitle: "Spiral of Fifths Info",
      windowId: WindowID(rawValue: "SoFInfo")
    ) {
      Image(systemName: "info.circle")
        .resizable()
        .foregroundStyle(viewModel.spiralOfFifths.selectedNoteColor)
        .frame(width: 24, height: 24)
        .padding(16)
        .contentShape(Rectangle())
    } windowContent: {
      SoFOnboardingView(noteColors: viewModel.spiralOfFifths.colors)
        .frame(minWidth: 500, minHeight: 800)
    }
    .buttonStyle(.plain)
  }
  
  private var settingsButton: some View {
    SettingsGearButton(
      label: { Image(systemName: "gear") },
      settingsView: {
        SoFSettingsView(spiralOfFifths: viewModel.spiralOfFifths)
          .adaptableSheet
          .background(Color.backgroundColor)
      })
    .foregroundStyle(viewModel.spiralOfFifths.selectedNoteColor)
  }
  
  @State var selectedTab = 0
  
  public var body: some View {
    ZStack(alignment: .top) {
#if os(macOS)
      diagramsView
#else
      TabView(selection: $selectedTab) {
        diagramsView
          .tabItem {
            Image(systemName: "circle.dashed")
            Text(SpiralOfFifthsAppStrings.diagramsTabTitle)
          }
          .toolbarBackground
          .tag(0)
        
        onboardingView
          .tabItem {
            Image(systemName: "safari.fill")
            Text(SpiralOfFifthsAppStrings.tutorialTabTitle)
          }
          .toolbarBackground
          .tag(1)
      }
      .colorScheme(.dark)
      .tint(viewModel.spiralOfFifths.selectedNoteColor)
#endif
      HStack {
#if os(macOS)
        infoButton
#endif
        Spacer()
        settingsButton
      }
      .opacity(selectedTab == 0 ? 1 : 0)
#if os(iOS)
      .animation(.linear, value: UIDevice.current.userInterfaceIdiom == .pad ? selectedTab : -1)
      .transition(.opacity)
#endif
    }
  }
  
  private var diagramsView: some View {
    VStack {
      SpiralOfFifthsView(spiralOfFifths: viewModel.spiralOfFifths)
        .layoutPriority(1)
      
      Spacer()
      
      Divider()
      
      HStack {
        Spacer()
        ModesTableView(
          modesTable: viewModel.modesTable,
          segmentedControlSelectionColor: viewModel.spiralOfFifths.selectedNoteColor
        )
        Spacer()
      }
      
    }
    .padding(.vertical, 16)
    .onAppear { viewModel.spiralOfFifths.sizeClass = sizeClass ?? .regular }
    .onChange(of: sizeClass) { viewModel.spiralOfFifths.sizeClass = $0 ?? .regular }
    .background {
      Color.backgroundColor.ignoresSafeArea()
    }
  }
  
  private var onboardingView: some View {
    SoFOnboardingView(noteColors: viewModel.spiralOfFifths.colors)
  }
}

fileprivate extension View {
  
#if os(iOS) || os(visionOS)
  @ViewBuilder
  var toolbarBackground: some View {
    if #available(iOS 16.0, *) {
      self.toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(Color.backgroundColor, for: .tabBar)
    } else {
      self
    }
  }
#endif
}

#Preview {
  DetailedSpiralOfFifthsView(viewModel: DetailedSpiralOfFifths(initialMode: Mode(root: .c, scale: .diatonic), notesSpiral: .withTripleAlterations))
}
