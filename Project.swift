import ProjectDescription
import TheoryDiagramsProjectDescription

let project = Project(
  name: "TheoryDiagrams",
  organizationName: "Modality",
  packages: TheoryDiagramsTargets.packages,
  settings: .settings(configurations: [
    .debug(name: "Debug", xcconfig: "Configuration/Signing.xcconfig"),
    .release(name: "Release", xcconfig: "Configuration/Signing.xcconfig")
  ]),
  targets: TheoryDiagramsTargets().all,
  additionalFiles: ["README.md", "Package.swift", "Tuist.swift", "Tuist/**", "Configuration/**"],
  resourceSynthesizers: [.strings()]
)
