// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let testablePackageSettings = Settings.settings(base: [
  "SWIFT_VERSION": "6.0",
  "SWIFT_STRICT_CONCURRENCY": "complete",
  "ENABLE_TESTABILITY": "YES"
])

let packageSettings = PackageSettings(
  productTypes: [
    "SwiftMusicTheory": .framework,
    "ModalityCore": .framework,
    "ModalityDesign": .framework,
    "TheoryDiagrams": .framework
  ],
  targetSettings: [
    "SwiftMusicTheory": testablePackageSettings,
    "ModalityCore": testablePackageSettings,
    "ModalityDesign": testablePackageSettings,
    "TheoryDiagrams": testablePackageSettings
  ],
  includeLocalPackageTestTargets: true
)
#endif

let package = Package(
  name: "SpiralOfFifthsDemo",
  dependencies: [
    .package(path: "../.."),
    .package(url: "https://github.com/gonzalezreal/swift-markdown-ui", exact: "2.4.0")
  ]
)
