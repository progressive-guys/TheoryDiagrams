import ProjectDescription

public enum TheoryDiagramsProject {

  public static func targets(
    swiftMusicTheory: TargetDependency,
    modalityCore: TargetDependency,
    modalityDesign: TargetDependency
  ) -> [Target] {
    [
      .target(
        name: "TheoryDiagrams",
        destinations: [.iPhone, .iPad, .mac, .appleVision],
        product: .framework,
        bundleId: "com.modality.TheoryDiagrams",
        infoPlist: .default,
        sources: ["TheoryDiagrams/Sources/**"],
        resources: ["TheoryDiagrams/Resources/**"],
        dependencies: [
          swiftMusicTheory,
          modalityCore,
          modalityDesign
        ],
        settings: .settings(configurations: [.release(name: "Release", settings: ["ENABLE_TESTABILITY": "YES"])])
      ),
      .target(
        name: "TheoryDiagramsUnitTests",
        destinations: [.iPhone, .iPad, .mac, .appleVision],
        product: .unitTests,
        bundleId: "com.modality.TheoryDiagramsUnitTests",
        infoPlist: .default,
        sources: ["UnitTests/**"],
        dependencies: [.target(name: "TheoryDiagrams")],
        settings: .settings(base: ["MACOSX_DEPLOYMENT_TARGET": "14.0"])
      ),
    ]
  }
}
