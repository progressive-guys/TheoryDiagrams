import Foundation

private final class AppBundleFinder {}

private let appResourceBundle: Bundle = {
  let bundleName = "SpiralOfFifthsDemo"
  let candidates = [
    Bundle.main.resourceURL,
    Bundle(for: AppBundleFinder.self).resourceURL,
    Bundle.main.bundleURL,
  ]
  
  for candidate in candidates {
    let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
    if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
      return bundle
    }
  }
  
  return Bundle(for: AppBundleFinder.self)
}()

enum SpiralOfFifthsAppStrings {
  static let socialMediaTip = NSLocalizedString(
    "social_media_tip",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let reverseSpiralProjectionHint = NSLocalizedString(
    "reverse_spiral_projection_hint",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let reverseSpiralProjection = NSLocalizedString(
    "reverse_spiral_projection",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let intro = NSLocalizedString(
    "intro",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let movingInFourths = NSLocalizedString(
    "moving_in_fourths",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let combiningSequences = NSLocalizedString(
    "combining_sequences",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let identifyingPatterns = NSLocalizedString(
    "identifying_patterns",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let enharmonicEquivalents = NSLocalizedString(
    "enharmonic_equivalents",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let diminishedSixth = NSLocalizedString(
    "diminished_sixth",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let spiralDescription = NSLocalizedString(
    "spiral_description",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let spiralProjection = NSLocalizedString(
    "spiral_projection",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let chords = NSLocalizedString(
    "chords",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let scaleAndModes = NSLocalizedString(
    "scale_and_modes",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let parallelModes = NSLocalizedString(
    "parallel_modes",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let chordDiagram = NSLocalizedString(
    "chord_diagram",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let diagramsTabTitle = NSLocalizedString(
    "diagrams_tab_title",
    bundle: appResourceBundle,
    comment: ""
  )
  
  static let tutorialTabTitle = NSLocalizedString(
    "tutorial_tab_title",
    bundle: appResourceBundle,
    comment: ""
  )
}
