import Foundation

public enum SpiralOfFifthsStrings {
  public static let accidentalSelectionError = String(
    localized: "accidental_selection_error",
    defaultValue: "You can't select double sharped/flattened Note as root",
    comment: "Error shown when user tries to select an invalid accidental"
  )
  
  public static let relativeModeChords = String(
    localized: "relative_mode_chords",
    defaultValue: "Relative Mode Chords",
    comment: "Section title for chords in relative modes"
  )
  
  public static let parallelModeChords = String(
    localized: "parallel_mode_chords",
    defaultValue: "Parallel Mode Chords",
    comment: "Section title for chords in parallel modes"
  )
  
  public static let degrees = String(
    localized: "degrees",
    defaultValue: "Scale Degrees",
    comment: "Musical scale degrees label"
  )
}
