import ProjectDescription
import ModalityBuild

let project = Project.linted(
  name: "TheoryDiagrams",
  targets: [
    .target(
      name: "TheoryDiagrams",
      destinations: [.iPhone, .iPad, .mac, .appleVision],
      product: .framework,
      bundleId: "com.modality.TheoryDiagrams",
      infoPlist: .default,
      sources: ["TheoryDiagrams/Sources/**"],
      resources: ["TheoryDiagrams/Resources/**"],
      dependencies: [.library("SwiftMusicTheory"), .library("ModalityCore"), .library("ModalityDesign", package: "ModalityCore")],
      settings: .modalitySettings(release: ["ENABLE_TESTABILITY": "YES"])
    ),
    .target(
      name: "TheoryDiagramsUnitTests",
      destinations: [.iPhone, .iPad, .mac, .appleVision],
      product: .unitTests,
      bundleId: "com.modality.TheoryDiagramsUnitTests",
      infoPlist: .default,
      sources: ["UnitTests/**"],
      dependencies: [.target(name: "TheoryDiagrams")],
      settings: .modalitySettings(base: ["MACOSX_DEPLOYMENT_TARGET": "14.0"])
    ),
  ],
  lintPaths: [
    "TheoryDiagrams": ["TheoryDiagrams/Sources"],
    "TheoryDiagramsUnitTests": ["UnitTests"],
  ]
)
