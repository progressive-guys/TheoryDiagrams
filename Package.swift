// swift-tools-version: 5.9
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
    .package(url: "https://github.com/exyte/PopupView.git", from: "3.0.0"),
  ],
  targets: [
    .target(
      name: "TheoryDiagrams",
      dependencies: [
        "SwiftMusicTheory",
        .product(name: "ModalityCore", package: "ModalityCore"),
        .product(name: "ModalityDesign", package: "ModalityCore"),
        .product(name: "PopupView", package: "PopupView"),
      ],
      resources: [.process("Resources")]
    ),
    .testTarget(name: "TheoryDiagramsTests", dependencies: ["TheoryDiagrams"]),
  ]
)
