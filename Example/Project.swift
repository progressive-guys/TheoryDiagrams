import ModalityBuild
import ProjectDescription
import TheoryDiagramsBuild

let lintPaths: [String: [String]] = [
  "SpiralOfFifthsDemo": ["SpiralOfFifthsDemo/Sources"]
]

let project = Project(
  name: "SpiralOfFifthsDemo",
  organizationName: "Modality Lab",
  settings: .settings(
    base: [
      "SWIFT_VERSION": "6.0",
      "SWIFT_STRICT_CONCURRENCY": "complete",
      "ENABLE_USER_SCRIPT_SANDBOXING": "NO",
      "STRING_CATALOG_GENERATE_SYMBOLS": "YES"
    ],
    configurations: [
      .debug(name: "Debug", xcconfig: "../Configuration/Signing.xcconfig"),
      .release(name: "Release", xcconfig: "../Configuration/Signing.xcconfig")
    ]
  ),
  targets: SpiralOfFifthsDemoProject.targets(
    swiftMusicTheory: .library("SwiftMusicTheory"),
    modalityCore: .library("ModalityCore"),
    modalityDesign: .library("ModalityDesign", package: "ModalityCore")
  )
  .map {
    $0.withLint(paths: lintPaths[$0.name] ?? [])
  },
  additionalFiles: [
    .glob(pattern: "Project.swift"),
    .glob(pattern: "Workspace.swift"),
    .glob(pattern: "Tuist.swift"),
    .glob(pattern: "Tuist/Package.swift"),
    .glob(pattern: "../README.md"),
    .glob(pattern: "../Package.swift"),
    .glob(pattern: "../Docs/**"),
    .glob(pattern: "../Configuration/**", excluding: ["../Configuration/*.local.xcconfig"])
  ],
  resourceSynthesizers: [.strings()]
)
