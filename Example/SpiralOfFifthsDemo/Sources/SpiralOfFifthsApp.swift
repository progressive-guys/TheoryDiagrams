import SwiftUI
import ModalityCore
import SwiftMusicTheory

@main
struct SpiralOfFifthsApp: App {
  @StateObject var viewModel = DetailedSpiralOfFifths(initialMode: Mode(root: .c, scale: .diatonic), notesSpiral: .withTripleAlterations)

  var body: some Scene {
    #if os(macOS)
    WindowGroup {
      DetailedSpiralOfFifthsView(viewModel: viewModel)
        .frame(minWidth: 300, minHeight: 600)
    }
    Settings {
      SoFSettingsView(spiralOfFifths: viewModel.spiralOfFifths)
        .frame(width: 500, height: 200)
    }
    #elseif os(visionOS)
    WindowGroup {
      DetailedSpiralOfFifthsView(viewModel: viewModel)
        .glassBackgroundEffect()
    }
    .windowStyle(.plain)
    #else
    WindowGroup {
      DetailedSpiralOfFifthsView(viewModel: viewModel)
    }
    #endif
  }
}
