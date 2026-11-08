import ProjectDescription

public enum SpiralOfFifthsDemoProject {

  public static func targets(
    swiftMusicTheory: TargetDependency,
    modalityCore: TargetDependency,
    modalityDesign: TargetDependency
  ) -> [Target] {
    [
      .target(
        name: "SpiralOfFifthsDemo",
        destinations: [.iPad, .iPhone, .mac, .appleVision],
        product: .app,
        bundleId: "com.modality-lab.SpiralOfFifthsDemo",
        deploymentTargets: .multiplatform(iOS: "16.0", macOS: "13.0", visionOS: "1.0"),
        infoPlist: .default,
        resources: [
          .glob(
            pattern: "SpiralOfFifthsDemo/Resources/**",
            excluding: ["SpiralOfFifthsDemo/Resources/**/*.entitlements", "SpiralOfFifthsDemo/Resources/**/*.plist"]
          )
        ],
        buildableFolders: [.folder("SpiralOfFifthsDemo/Sources")],
        dependencies: [
          .project(target: "TheoryDiagrams", path: ".."),
          swiftMusicTheory,
          modalityCore,
          modalityDesign,
          .external(name: "MarkdownUI")
        ],
        settings: .settings(base: [
          "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "",
          "INFOPLIST_FILE[sdk=macosx*]": "SpiralOfFifthsDemo/Resources/Info.macOS.plist",
          "INFOPLIST_FILE[sdk=iphone*]": "SpiralOfFifthsDemo/Resources/Info.iOS.plist",
          "INFOPLIST_FILE[sdk=xr*]": "SpiralOfFifthsDemo/Resources/Info.visionOS.plist",
          "CODE_SIGN_ENTITLEMENTS[sdk=macosx*]": "SpiralOfFifthsDemo/Resources/Entitlements.macOS.entitlements",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=macosx*]": "AppIcon.macOS",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=iphone*]": "AppIcon.iOS",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=xr*]": "AppIcon.solidimagestack"
        ])
      )
    ]
  }
}
