// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "TheoryDiagrams",
  defaultLocalization: "en",
  platforms: [.iOS(.v16), .macOS(.v13), .visionOS(.v1)],
  products: [
    .library(name: "TheoryDiagrams", targets: ["TheoryDiagrams"]),
  ],
  dependencies: [
    .package(url: "https://github.com/modality-lab/SwiftMusicTheory.git", branch: "main"),
    .package(url: "https://github.com/modality-lab/ModalityCore.git", branch: "master"),
  ],
  targets: [
    .target(
      name: "TheoryDiagrams",
      dependencies: [
        "SwiftMusicTheory",
        .product(name: "ModalityCore", package: "ModalityCore"),
        .product(name: "ModalityDesign", package: "ModalityCore"),
      ],
      path: "TheoryDiagrams",
      sources: ["Sources"],
      resources: [.process("Resources")]
    ),
    .testTarget(
      name: "TheoryDiagramsUnitTests",
      dependencies: ["TheoryDiagrams"],
      path: "UnitTests"
    ),
  ]
)
