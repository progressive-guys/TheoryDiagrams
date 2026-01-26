import ProjectDescription

let project = Project(
  name: "SpiralOfFifthsDemo",
  organizationName: "Modality Lab",
  packages: [
    .local(path: ".."),
    .remote(url: "https://github.com/gonzalezreal/swift-markdown-ui", requirement: .exact("2.4.0")),
  ],
  targets: [
    .target(
      name: "SpiralOfFifthsDemo",
      destinations: [.iPad, .iPhone, .mac, .appleVision],
      product: .app,
      bundleId: "com.modality-lab.SpiralOfFifthsDemo",
      infoPlist: .default,
      sources: ["SpiralOfFifthsDemo/Sources/**/*.swift"],
      resources: [
        .glob(pattern: "SpiralOfFifthsDemo/Resources/**", excluding: ["**/*.entitlements", "**/*.plist"])
      ],
      dependencies: [
        .package(product: "TheoryDiagrams"),
        .package(product: "ModalityCore"),
        .package(product: "ModalityDesign"),
        .package(product: "MarkdownUI"),
      ],
      settings: .settings(
        base: [
          "IPHONEOS_DEPLOYMENT_TARGET": "16.0",
          "MACOSX_DEPLOYMENT_TARGET": "13.0",
          "SWIFT_VERSION": "6.0",
          "INFOPLIST_FILE[sdk=macosx*]": "SpiralOfFifthsDemo/Resources/Info.macOS.plist",
          "INFOPLIST_FILE[sdk=iphoneos*]": "SpiralOfFifthsDemo/Resources/Info.iOS.plist",
          "INFOPLIST_FILE[sdk=iphonesimulator*]": "SpiralOfFifthsDemo/Resources/Info.iOS.plist",
          "INFOPLIST_FILE[sdk=xros*]": "SpiralOfFifthsDemo/Resources/Info.visionOS.plist",
          "INFOPLIST_FILE[sdk=xrsimulator*]": "SpiralOfFifthsDemo/Resources/Info.visionOS.plist",
          "CODE_SIGN_ENTITLEMENTS[sdk=macosx*]": "SpiralOfFifthsDemo/Resources/Entitlements.macOS.entitlements",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=macosx*]": "AppIcon.macOS",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=iphoneos*]": "AppIcon.iOS",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=iphonesimulator*]": "AppIcon.iOS",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=xros*]": "AppIcon.solidimagestack",
          "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=xrsimulator*]": "AppIcon.solidimagestack",
        ]
      )
    )
  ],
  resourceSynthesizers: [
    .strings(),
  ]
)
