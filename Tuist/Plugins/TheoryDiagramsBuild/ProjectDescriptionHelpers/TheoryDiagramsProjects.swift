import ProjectDescription

public enum TheoryDiagramsProjects: String, CaseIterable {

  case library = "."
  case example = "Example"

  public func targets(
    swiftMusicTheory: TargetDependency,
    modalityCore: TargetDependency,
    modalityDesign: TargetDependency
  ) -> [Target] {
    switch self {
    case .library: TheoryDiagramsProject.targets(
      swiftMusicTheory: swiftMusicTheory,
      modalityCore: modalityCore,
      modalityDesign: modalityDesign
    )

    case .example: SpiralOfFifthsDemoProject.targets(
      swiftMusicTheory: swiftMusicTheory,
      modalityCore: modalityCore,
      modalityDesign: modalityDesign
    )
    }
  }
}
