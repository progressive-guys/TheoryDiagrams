import ProjectDescription
import TheoryDiagramsProjectDescription

let project = Project(
  name: "SpiralOfFifthsDemo",
  organizationName: "Modality Lab",
  packages: TheoryDiagramsTargets.packages + [
    .remote(url: "https://github.com/gonzalezreal/swift-markdown-ui", requirement: .exact("2.4.0"))
  ],
  settings: .settings(configurations: [
    .debug(name: "Debug", xcconfig: "../Configuration/Signing.xcconfig"),
    .release(name: "Release", xcconfig: "../Configuration/Signing.xcconfig")
  ]),
  targets: [TheoryDiagramsTargets.demo()],
  resourceSynthesizers: [.strings()]
)
