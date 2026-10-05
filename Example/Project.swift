import ProjectDescription

let project = Project(
  name: "SpiralOfFifthsDemo",
  organizationName: "Modality Lab",
  settings: .settings(
    base: [
      "SWIFT_VERSION": "6.0",
      "SWIFT_STRICT_CONCURRENCY": "complete"
    ],
    configurations: [
      .debug(name: "Debug", xcconfig: "../Configuration/Signing.xcconfig"),
      .release(name: "Release", xcconfig: "../Configuration/Signing.xcconfig")
    ]
  ),
  targets: [
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
        .external(name: "TheoryDiagrams"),
        .external(name: "SwiftMusicTheory"),
        .external(name: "ModalityCore"),
        .external(name: "ModalityDesign"),
        .external(name: "MarkdownUI")
      ],
      settings: .settings(base: [
        "INFOPLIST_FILE[sdk=macosx*]": "SpiralOfFifthsDemo/Resources/Info.macOS.plist",
        "INFOPLIST_FILE[sdk=iphone*]": "SpiralOfFifthsDemo/Resources/Info.iOS.plist",
        "INFOPLIST_FILE[sdk=xr*]": "SpiralOfFifthsDemo/Resources/Info.visionOS.plist",
        "CODE_SIGN_ENTITLEMENTS[sdk=macosx*]": "SpiralOfFifthsDemo/Resources/Entitlements.macOS.entitlements",
        "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=macosx*]": "AppIcon.macOS",
        "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=iphone*]": "AppIcon.iOS",
        "ASSETCATALOG_COMPILER_APPICON_NAME[sdk=xr*]": "AppIcon.solidimagestack"
      ])
    )
  ],
  additionalFiles: [
    .glob(pattern: "Project.swift"),
    .glob(pattern: "Workspace.swift"),
    .glob(pattern: "Tuist.swift"),
    .glob(pattern: "Tuist/Package.swift"),
    .glob(pattern: "../README.md"),
    .glob(pattern: "../Package.swift"),
    .glob(pattern: "../Docs/**"),
    .glob(pattern: "../Configuration/**", excluding: ["../Configuration/*.local.xcconfig"])
  ],
  resourceSynthesizers: [.strings()]
)
