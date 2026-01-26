// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum SpiralOfFifthsDemoStrings: Sendable {
  /// You can't select double sharped/flattened Note as root
  public static let accidentalSelectionError = SpiralOfFifthsDemoStrings.tr("Localizable", "accidental_selection_error")
  /// \nThis diagram showcases all chords in all modes of the scale so you can easily find a chords for modal interchange.\n\nIn the App, you can navigate both through the relative modes, located in a circle on top of the corresponding root note, and through parallel modes, which stack radially on top of each other.\n
  public static let chordDiagram = SpiralOfFifthsDemoStrings.tr("Localizable", "chord_diagram")
  /// \n## Scale Degrees and Chords\nThe inner circle shows the chords corresponding to each scale degree. Roman numerals (I, IV, V, etc.) represent scales degree within the selected mode.\nA capital letter means a major chord is formed on that degree, while a lowercase letter indicates a minor chord. A number accompanied by a small circle (°) represents a diminished chord, and a plus sign (+) - an augmented chord. \n♭/♯ signifies that a degree is flattened or sharpened by a semitone in relation to the major diatonic scale\n\nFor example, in the key of C minor, the chords are:\n\n- i (C minor)\n- ii° (D diminished)\n- ♭III (E♭ major)\n- iv (F minor)\n- v (G minor)\n- ♭VI (A♭ major)\n- ♭VII (B♭ major)\n\nThe following diagram shows how degrees alternate moving from Lydian to Locrian:\n
  public static let chords = SpiralOfFifthsDemoStrings.tr("Localizable", "chords")
  /// \nCombining these sequences, we get:\n
  public static let combiningSequences = SpiralOfFifthsDemoStrings.tr("Localizable", "combining_sequences")
  /// Scale Degrees
  public static let degrees = SpiralOfFifthsDemoStrings.tr("Localizable", "degrees")
  /// Diagrams
  public static let diagramsTabTitle = SpiralOfFifthsDemoStrings.tr("Localizable", "diagrams_tab_title")
  /// \nNotice that there is a diminished sixth between A# and F. While it's enharmonic to a perfect Fifth, its diatonic function is different. Without introducing this interval, you cannot close the cycle, as the Perfect Fifth away from A# is E#, as demonstrated earlier.\n\nThis Circle of Fifths structure is useful for modulation, as closely related keys (adjacent on the circle) share many common tones, facilitating smoother key changes.\nAlso notice, that each note become warmer as it goes up in the spiral. This showcases, that modulations from C Major to G Major sounds more bright, than modulation in opposite direction.\n\n## Visualizing the Notes in 3D\n\nThe notes sequence can also be visualized in 3D: \n
  public static let diminishedSixth = SpiralOfFifthsDemoStrings.tr("Localizable", "diminished_sixth")
  /// \nIf we take every 12th note we observe another interesting pattern, that highlights the enharmonic equivalents: Fbb, Eb, D# and so on. The distance between the notes is Diminished Second (enharmonic equivalents of Unison), which sharpens the previous note in chromatic scale. You can tap on any note in the table above to highlight its enharmonics.\n\nBy taking these notes in batches of 12 and cycling them, we get the complete Circle of Fifths: \n
  public static let enharmonicEquivalents = SpiralOfFifthsDemoStrings.tr("Localizable", "enharmonic_equivalents")
  /// \n\nFrom the sequences above, we see a repeating pattern of 7 notes, each cycle getting sharper by a half step:\n
  public static let identifyingPatterns = SpiralOfFifthsDemoStrings.tr("Localizable", "identifying_patterns")
  /// \n# The Circle of Fifths: A Musician's Compass\n\nThe Circle of Fifths is a fundamental tool in music theory, showcasing the relationship between all the 12 tones of the chromatic scale. It's invaluable for analyzing and understanding scales, modes, key signatures and the diatonic functions of chords. Think of it as a compass or a map for navigating musical landscapes.\n\n## Identifying Patterns\nThe Circle of Fifths is constructed by moving up in perfect Fifths. Here’s a sequence of Fifths starting from C:\n
  public static let intro = SpiralOfFifthsDemoStrings.tr("Localizable", "intro")
  /// \nMoving in the opposite direction, we use perfect fourths:\n
  public static let movingInFourths = SpiralOfFifthsDemoStrings.tr("Localizable", "moving_in_fourths")
  /// Parallel Mode Chords
  public static let parallelModeChords = SpiralOfFifthsDemoStrings.tr("Localizable", "parallel_mode_chords")
  /// \nRelative modes are useful because they allow you to use the same set of notes to create different tonalities or moods. \n\n### Parallel Modes\nParallel modes share the same tonic note but have different key signatures. For example **C Major** and **C Minor**: Both scales start on C, but C Major has no sharps or flats, while C Minor has B♭, E♭, and A♭.\nParallel modes are useful for exploring different emotional qualities or characteristics while maintaining the same tonal center.\n
  public static let parallelModes = SpiralOfFifthsDemoStrings.tr("Localizable", "parallel_modes")
  /// Relative Mode Chords
  public static let relativeModeChords = SpiralOfFifthsDemoStrings.tr("Localizable", "relative_mode_chords")
  /// Project from bottom turn
  public static let reverseSpiralProjection = SpiralOfFifthsDemoStrings.tr("Localizable", "reverse_spiral_projection")
  /// Project notes outside the selected scale from the previous spiral turn to change enharmonic equivalents (e.g., flats instead of sharps).
  public static let reverseSpiralProjectionHint = SpiralOfFifthsDemoStrings.tr("Localizable", "reverse_spiral_projection_hint")
  /// \nNotice, that modes are placed in order of their brightness. The brightest mode in Diatonic scale is Lydian, the darkest is Locrian. Each time moving to the next mode, one of the degrees becomes brighter.\n\n## Scale and Modes\nThe Circle of Fifths can be very useful for scales visualization and manipulation.\n\n### Relative Modes\nEach relative mode of a scale is tied to the others by sharing the same set of notes. Changes only their function. Each mode starts on a different note of the scale and has a distinct sound and character.\n
  public static let scaleAndModes = SpiralOfFifthsDemoStrings.tr("Localizable", "scale_and_modes")
  /// We're working hard, and there's a lot more on the way — new features, diagrams, scales, tutorials, and apps.\nFollow us to stay updated!
  public static let socialMediaTip = SpiralOfFifthsDemoStrings.tr("Localizable", "social_media_tip")
  /// \nEach turn of the spiral represents a full octave (12 notes). As the spiral ascends or descends, it traverses through enharmonically equivalent notes. For example, Gb and F# occupy the same position but on different turns of the spiral.\n
  public static let spiralDescription = SpiralOfFifthsDemoStrings.tr("Localizable", "spiral_description")
  /// You can think of the Circle of Fifths as a projection of the Spiral onto a plane, moving up and down along the Spiral.\n\n## Practical Application for Musicians\n\nIn everyday practice, musicians typically interact with natural notes, sharps, and flats. Double and triple accidentals are more theoretical, used to describe certain scales or modes accurately. For example, the A# major scale includes notes like F##, C## and G##. You can navigate through natural, sharps and flats in the App.\n
  public static let spiralProjection = SpiralOfFifthsDemoStrings.tr("Localizable", "spiral_projection")
  /// Tutorial
  public static let tutorialTabTitle = SpiralOfFifthsDemoStrings.tr("Localizable", "tutorial_tab_title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension SpiralOfFifthsDemoStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftformat:enable all
// swiftlint:enable all
