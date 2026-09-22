# TheoryDiagrams

![Version](https://img.shields.io/github/v/release/modality-lab/TheoryDiagrams)
![Swift](https://img.shields.io/badge/Swift-5.9+-orange?logo=swift)
![Platforms](https://img.shields.io/badge/Platforms-iOS%2016%20%7C%20macOS%2013%20%7C%20visionOS%201-blue)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen)
![License](https://img.shields.io/github/license/modality-lab/TheoryDiagrams)

A SwiftUI library for interactive music theory diagrams, including the Spiral of Fifths visualization, chord tables, mode formula diagrams, and scale degree diagrams.

## Features

- **SpiralOfFifthsView**: Interactive circular/spiral visualization of the circle of fifths with support for different scales and modes


|           Diatonic           |           Harmonic major           |
| :--------------------------: | :--------------------------------: |
| ![](./Docs/SoF_diatonic.png) | ![](./Docs/SoF_harmonic_Major.png) |

- **ModesTableView**: Table view showing chord relationships and modes
![](./Docs/modes_table.png)

## Requirements

- iOS 16.0+
- macOS 13.0+
- visionOS 1.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/modality-lab/TheoryDiagrams.git", from: "1.0.0"),
]
```

Then add to your target:

```swift
.target(
  name: "YourTarget",
  dependencies: [
    .product(name: "TheoryDiagrams", package: "TheoryDiagrams"),
  ]
)
```

## Tuist

Run from the module directory:

```sh
tuist generate --no-open
```

The local `TheoryDiagramsProjectDescription` plugin owns the targets and test groups. The main workspace reads these groups for its test schemes. The standalone projects use the package platform requirements, default Tuist build settings and remote Swift packages. The plugin defines dependencies for both build modes. The main repository supplies its build settings, source paths and `isStandalone: false`.

For local signing, add `DEVELOPMENT_TEAM = your_team_id` to `Configuration/Signing.local.xcconfig`. Git ignores this file.

## Usage

```swift
import TheoryDiagrams
import SwiftUI

struct ContentView: View {
  @State private var spiralOfFifths = SpiralOfFifths.cMajor
  
  var body: some View {
    SpiralOfFifthsView(spiralOfFifths: spiralOfFifths)
  }
}
```

## Example App

The `Example/` folder contains a full demo application showcasing all diagram components with:

- Interactive spiral of fifths with note selection
- Onboarding flow explaining music theory concepts
- Settings for customizing the visualization
- Support for iOS, macOS, and visionOS

### Running the Example

1. Generate the example:

   ```bash
   cd Example
   tuist generate --no-open
   open SpiralOfFifthsDemo.xcworkspace
   ```

2. Select your target platform and run.

## Dependencies

- [SwiftMusicTheory](https://github.com/modality-lab/SwiftMusicTheory) - Music theory primitives
- [ModalityCore](https://github.com/modality-lab/ModalityCore) - Core utilities and design components
- [PopupView](https://github.com/exyte/PopupView) - Popup presentations
