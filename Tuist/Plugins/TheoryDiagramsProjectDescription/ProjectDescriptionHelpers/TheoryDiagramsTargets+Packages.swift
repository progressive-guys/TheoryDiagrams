import ProjectDescription

public extension TheoryDiagramsTargets {
  static let packages: [Package] = [
    .remote(url: "https://github.com/modality-lab/SwiftMusicTheory.git", requirement: .branch("main")),
    .remote(url: "https://github.com/modality-lab/ModalityCore.git", requirement: .branch("master")),
    .remote(url: "https://github.com/johnpatrickmorgan/NavigationBackport", requirement: .exact("0.9.3"))
  ]
}
