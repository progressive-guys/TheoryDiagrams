import ProjectDescription
import TheoryDiagramsBuild

let workspace = Workspace(
  name: "TheoryDiagrams",
  projects: TheoryDiagramsProjects.allCases.map { .relativeToManifest($0.rawValue) },
  generationOptions: .options(lastXcodeUpgradeCheck: "27.1")
)
