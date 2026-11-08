import ModalityBuild
import ProjectDescription
import TheoryDiagramsBuild

let project = Project.linted(
  name: "TheoryDiagrams",
  targets: TheoryDiagramsProject.targets(
    swiftMusicTheory: .library("SwiftMusicTheory"),
    modalityCore: .library("ModalityCore"),
    modalityDesign: .library("ModalityDesign", package: "ModalityCore")
  ),
  lintPaths: [
    "TheoryDiagrams": ["TheoryDiagrams/Sources"],
    "TheoryDiagramsUnitTests": ["UnitTests"],
  ]
)
