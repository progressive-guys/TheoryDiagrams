@testable import ModalityCore
@testable import TheoryDiagrams
@testable import SwiftMusicTheory
import Foundation
import Testing

final class SpiralOfFifthsTests {

  @Suite
  @MainActor
  struct Diatonic {
    let cof = SpiralOfFifths.cMajor

    @Test
    func displayableNotes() {
      let notes: [Note] = [.f, .c, .g, .d, .a, .e, .b]

      #expect(cof.allNotes == [
        notes.map { $0.flat(3) },
        notes.map { $0.flat(2) },
        notes.map { $0.flat() },
        notes,
        notes.map { $0.sharp() },
        notes.map { $0.sharp(2) },
        notes.map { $0.sharp(3) },
      ].flatMap { $0 })
    }

    @Test
    func testDisplayedNotes() {
      cof.reversedProjection = false
      #expect(cof.displayedNotes.shifted(by: cof.offsetToCenter) == [.c, .g, .d, .a, .e, .b, .f.sharp(), .c.sharp(), .g.sharp(), .d.sharp(), .a.sharp(), .f])

      cof.reversedProjection = true
      #expect(cof.displayedNotes.shifted(by: cof.offsetToCenter) == [.c, .g, .d, .a, .e, .b, .g.flat(), .d.flat(), .a.flat(), .e.flat(), .b.flat(), .f])
    }

    @Test
    func testRelativeModes() {
      
    }
  }
}
