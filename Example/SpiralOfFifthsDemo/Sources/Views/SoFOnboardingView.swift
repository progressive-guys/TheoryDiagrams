import SwiftUI
import MarkdownUI
import ModalityCore
import ModalityDesign
import SwiftMusicTheory
import TheoryDiagrams

public struct SoFOnboardingView: View {
  
  @State private var scrollOffset: CGFloat = 0
  
  private var onboarding: SoFOnboarding
  
  public init(noteColors: NoteColors) {
    self.onboarding = SoFOnboarding(noteColors: noteColors)
  }
  
  public var body: some View {
    ScrollView(showsIndicators: false) {
      LazyVStack(alignment: .leading, spacing: 0) {
        Markdown(SpiralOfFifthsAppStrings.intro)
        notesView(for: onboarding.cSequence)
          .componentPaddings

        Markdown(SpiralOfFifthsAppStrings.movingInFourths)
        notesView(for: onboarding.cSequenceBackwards)
          .componentPaddings
        Markdown(SpiralOfFifthsAppStrings.combiningSequences)

        notesGradientView(for: onboarding.fullSequence)
          .componentPaddings

        Markdown(SpiralOfFifthsAppStrings.identifyingPatterns)
        HStack {
          Spacer(minLength: 0)
          AccidentalsPatternView(viewModel: onboarding.accidentalsPattern)
            .frame(maxWidth: 600)
          Spacer(minLength: 0)
        }
          .componentPaddings

        Markdown(SpiralOfFifthsAppStrings.enharmonicEquivalents)

        RingView(ring: onboarding.cofRing)
          .frame(height: 320)

        Markdown(SpiralOfFifthsAppStrings.diminishedSixth)
        
        HStack {
          Spacer(minLength: 0)
          GeometryReader { geometry in
            SpiralView(
              scrollProgress: calculateScrollProgress(in: geometry),
              ring: onboarding.animatableSpiral
            )
          }
          .frame(height: 900)
          .frame(maxWidth: 400)
          Spacer(minLength: 0)
        }
        
        Markdown(SpiralOfFifthsAppStrings.spiralDescription)
        
        HStack {
          Spacer(minLength: 0)
          GeometryReader { geometry in
            SpiralView(
              scrollProgress: 1,
              ring: onboarding.spiralEnharmonics
            )
          }
          .frame(height: 700)
          .frame(maxWidth: 400)
          Spacer(minLength: 0)
        }
        
        Markdown(SpiralOfFifthsAppStrings.spiralProjection)
        
        ZStack {
          RingView(ring: onboarding.aSharpNotesCoF)
          RingView(ring: onboarding.aSharpDegreesCoF)
        }
        .frame(height: 384)
        .componentPaddings
        
        Markdown(SpiralOfFifthsAppStrings.chords)
        
        HStack {
          Spacer(minLength: 0)
          ModesTableView(
            modesTable: ModesTable(spiralOfFifths: .cMajor, diagramType: .degrees, interactable: false),
            segmentedControlSelectionColor: onboarding.noteColors[.c]
          )
          Spacer(minLength: 0)
        }.componentPaddings
        
        Markdown(SpiralOfFifthsAppStrings.scaleAndModes)
        
        HStack {
          Spacer(minLength: 0)
          ModeFormulaDiagramView(viewModel: onboarding.modeFormulaDiagram)
            .frame(maxWidth: 600)
          Spacer(minLength: 0)
        }.componentPaddings
        
        Markdown(SpiralOfFifthsAppStrings.parallelModes)
        
        HStack {
          Spacer(minLength: 0)
          ModesTableView(
            modesTable: ModesTable(spiralOfFifths: .cMajor, diagramType: .parallelModeChords, interactable: false),
            segmentedControlSelectionColor: onboarding.noteColors[.c]
          )
          Spacer(minLength: 0)
        }.componentPaddings
        
        Markdown(SpiralOfFifthsAppStrings.chordDiagram)
      }
      .padding(16)
      .padding(.top, 32)
    }
    .markdownTextStyle {
      ForegroundColor(.primary)
      BackgroundColor(nil)
    }
    .background {
      Color.backgroundColor.ignoresSafeArea()
    }
  }
  
  private func notesGradientView(for sequence: [Note]) -> some View {
    HStack(spacing: 0) {
      ForEach(sequence, id: \.description) { note in
        Text(note.notation)
          .frame(maxWidth: .infinity)
          .font(.system(size: 11).bold())
          .lineLimit(1)
          .foregroundStyle(.primary)
      }
    }
    .padding(.horizontal, 4)
    .frame(height: 20)
    .background {
      RoundedRectangle(cornerRadius: 16)
        .fill(
          LinearGradient(
            colors: [onboarding.noteColors[sequence.first!], onboarding.noteColors[sequence.last!]],
            startPoint: .leading,
            endPoint: .trailing
          )
        )
    }
  }
  
  private func notesView(for sequence: [Note]) -> some View {
    HStack(spacing: 4) {
      ForEach(sequence, id: \.description) { note in
        NoteView(note: note, noteColor: onboarding.noteColors[note])
      }
    }
  }
  
  private func calculateScrollProgress(in geometry: GeometryProxy) -> CGFloat {
    let minY = geometry.frame(in: .global).minY
    let screenHeight = geometry.frame(in: .global).height
    let spiralViewHeight = geometry.size.height
    
    let startOffset = screenHeight - spiralViewHeight / 4
    let endOffset = -spiralViewHeight / 4
    
    let scrollProgress: CGFloat = if minY > startOffset { 0.0 }
    else if minY <= endOffset { 1.0 }
    else { 1.0 - (minY - endOffset) / (startOffset - endOffset) }
    
    return scrollProgress
  }
}

fileprivate extension View {
  var componentPaddings: some View {
    self
      .padding(.top, 16)
      .padding(.bottom, 32)
  }
}
