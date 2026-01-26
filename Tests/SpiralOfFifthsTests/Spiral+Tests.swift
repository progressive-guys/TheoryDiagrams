import ModalityCore
import SwiftMusicTheory
import Foundation
import Testing

final class SpiralTests {

  private let spiralOfFifths = Spiral<Note>.withTripleAlterations

  private let firstOctave = [
    Note.f, .c, .g, .d, .a, .e, .b, .f.sharp(), .c.sharp(), .g.sharp(), .d.sharp(), .a.sharp()
  ].map { $0.flat(3) }

  @Test(arguments: 0..<38)
  func spiralProjection(_ startIndex: Int) async throws {
    let turn = startIndex / spiralOfFifths.spiralTurnLength

    let answer = firstOctave
      .enumerated()
      .map { noteIndex, note in
        noteIndex < startIndex % spiralOfFifths.spiralTurnLength
          ? note.diatonicEnharmonism(shifted: -turn - 1)
          : note.diatonicEnharmonism(shifted: -turn)
      }

    print(answer)

    #expect(spiralOfFifths.projection(from: startIndex) == answer)
  }

//  @Test
//  func spiralProjection() async throws {
//    let startIndex = spiralOfFifths.elements.firstIndex(of: .c)!
//    let turn = startIndex / spiralOfFifths.spiralTurnLength
//
//    let answer: [Note] = [
//      .c, .g, .d, .a, .e, .b, .f.sharp(), .c.sharp(), .g.sharp(), .d.sharp(), .a.sharp(), .f
//    ]
//
//    #expect(spiralOfFifths.projection(from: startIndex) == answer)
//  }
}
