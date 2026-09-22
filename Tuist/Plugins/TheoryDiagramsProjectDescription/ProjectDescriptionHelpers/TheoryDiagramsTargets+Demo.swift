import ProjectDescription

public extension TheoryDiagramsTargets {
  static func demo(
    sourceRoot: String = ".",
    isStandalone: Bool = true
  ) -> Target {
    .target(
      name: "SpiralOfFifthsDemo",
      destinations: [.iPad, .iPhone, .mac, .appleVision],
      product: .app,
      bundleId: "com.modality-lab.SpiralOfFifthsDemo",
      deploymentTargets: deploymentTargets,
      infoPlist: .default,
      resources: [
        .glob(
          pattern: "\(sourceRoot)/SpiralOfFifthsDemo/Resources/**",
          excluding: [
            "\(sourceRoot)/SpiralOfFifthsDemo/Resources/**/*.entitlements",
            "\(sourceRoot)/SpiralOfFifthsDemo/Resources/**/*.plist"
          ]
        )
      ],
      buildableFolders: [.folder("\(sourceRoot)/SpiralOfFifthsDemo/Sources")],
      dependencies: [
        isStandalone ? .project(target: "TheoryDiagrams", path: "..") : .target(name: "TheoryDiagrams"),
        isStandalone ? .package(product: "ModalityCore") : .target(name: "ModalityCore"),
        isStandalone ? .package(product: "ModalityDesign") : .target(name: "ModalityDesign"),
        isStandalone ? .package(product: "MarkdownUI") : .external(name: "MarkdownUI")
      ],
      settings: .settings(
        base: [
          "INFOPLIST_FILE[sdk=macosx*]": "\(sourceRoot)/SpiralOfFifthsDemo/Resources/Info.macOS.plist",
          "INFOPLIST_FILE[sdk=iphone*]": "\(sourceRoot)/SpiralOfFifthsDemo/Resources/Info.iOS.plist",
          "INFOPLIST_FILE[sdk=xr*]": "\(sourceRoot)/SpiralOfFifthsDemo/Resources/Info.visionOS.plist",
          "CODE_SIGN_ENTITLEMENTS[sdk=macosx*]": "\(sourceRoot)/SpiralOfFifthsDemo/Resources/Entitlements.macOS.entitlements",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=macosx*]": "AppIcon.macOS",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=iphone*]": "AppIcon.iOS",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=xr*]": "AppIcon.solidimagestack"
        ]
      )
    )
  }
}
