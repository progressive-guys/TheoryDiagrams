// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import ProjectDescription
let useLocalProjects = !Environment.localProjectsRoot.getString(default: "").isEmpty
let testablePackageSettings = Settings.settings(base: [
  "SWIFT_VERSION": "6.0",
  "SWIFT_STRICT_CONCURRENCY": "complete",
  "ENABLE_TESTABILITY": "YES"
])
let packageSettings = PackageSettings(
  productTypes: [
    "SwiftMusicTheory": .framework,
    "ModalityCore": .framework,
    "ModalityDesign": .framework
  ],
  targetSettings: [
    "SwiftMusicTheory": testablePackageSettings,
    "ModalityCore": testablePackageSettings,
    "ModalityDesign": testablePackageSettings
  ]
)
#else
let useLocalProjects = false
#endif

let package = Package(
  name: "TheoryDiagrams",
  dependencies: [.package(url: "https://github.com/gonzalezreal/swift-markdown-ui", exact: "2.4.0")] + (useLocalProjects
    ? []
    : [
      .package(url: "https://github.com/modality-lab/SwiftMusicTheory.git", branch: "main"),
      .package(url: "https://github.com/modality-lab/ModalityCore.git", branch: "master"),
    ])
)
