import ProjectDescription

public struct TheoryDiagramsTargets {
  private let sourceRoot: String
  private let isStandalone: Bool
  static let deploymentTargets = DeploymentTargets.multiplatform(iOS: "16.0", macOS: "13.0", visionOS: "1.0")

  public init(
    sourceRoot: String = ".",
    isStandalone: Bool = true
  ) {
    self.sourceRoot = sourceRoot
    self.isStandalone = isStandalone
  }

  private var targets: [Target] {
    [
      .target(
        name: "TheoryDiagrams",
        destinations: [.iPad, .iPhone, .mac, .appleVision],
        product: .framework,
        bundleId: "pure.tones.TheoryDiagrams",
        deploymentTargets: Self.deploymentTargets,
        infoPlist: .default,
        sources: ["\(sourceRoot)/Sources/TheoryDiagrams/**"],
        dependencies: [
          isStandalone ? .package(product: "SwiftMusicTheory") : .target(name: "SwiftMusicTheory"),
          isStandalone ? .package(product: "ModalityCore") : .target(name: "ModalityCore"),
          isStandalone ? .package(product: "ModalityDesign") : .target(name: "ModalityDesign"),
          isStandalone ? .package(product: "NavigationBackport") : .external(name: "NavigationBackport")
        ]
      )
    ]
  }

  public var unitTests: [Target] {
    [
      .target(
        name: "TheoryDiagramsTests",
        destinations: [.iPad, .iPhone, .mac, .appleVision],
        product: .unitTests,
        bundleId: "pure.tones.TheoryDiagrams.tests",
        deploymentTargets: Self.deploymentTargets,
        infoPlist: .default,
        sources: ["\(sourceRoot)/Tests/TheoryDiagramsTests/**"],
        dependencies: [
          .target(name: "TheoryDiagrams")
        ]
      )
    ]
  }

  public var all: [Target] { targets + unitTests }
}
