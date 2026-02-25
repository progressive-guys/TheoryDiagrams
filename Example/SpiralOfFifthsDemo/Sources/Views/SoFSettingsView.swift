import Foundation
import TheoryDiagrams
import SwiftUI
import Combine
import ModalityCore

public struct SoFSettingsView: View {
  
  @ObservedObject
  var spiralOfFifths: SpiralOfFifths
  
  @State private var isReversedProjectionHintShown = false
  
  public init(spiralOfFifths: SpiralOfFifths) {
    self.spiralOfFifths = spiralOfFifths
  }
  
  public var body: some View {
    settings
  }
  
  private var settings: some View {
    VStack {
      reversedProjectionToggle
      
      if #available(iOS 16.0, macOS 13.0, *) {
      } else {
        Spacer()
      }
      
      Text(SpiralOfFifthsAppStrings.socialMediaTip)
        .multilineTextAlignment(.center)
        .font(.caption)
        .foregroundStyle(Color.gray.opacity(0.8))
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 8)
      
      socialNetworks
        .padding(.top, 24)
        .padding(.bottom, 16)
    }
  }
  
  var socialNetworks: some View {
    HStack {
      Spacer()
      
      Link(destination: URL(string: "https://www.instagram.com/modality.fm")!) {
        Image("instagram", bundle: .main)
          .resizable()
          .frame(width: 32, height: 32)
          .padding(.trailing, 16)
          .foregroundStyle(Color.white)
      }
      
      Link(destination: URL(string: "https://t.me/ModalityFM")!) {
        Image("telegram", bundle: .main)
          .resizable()
          .frame(width: 32, height: 32)
          .foregroundStyle(Color.white)
      }
      
      Spacer()
    }
  }
  
  private var reversedProjectionToggle: some View {
    HStack {
      Button {
        isReversedProjectionHintShown.toggle()
      } label: {
        Image(systemName: "info")
          .font(.headline)
          .foregroundStyle(spiralOfFifths.selectedNoteColor)
          .padding(6)
          .background { Circle().fill(Color.gray.opacity(0.3)) }
      }
      .buttonStyle(.plain)
      .frame(width: 32, height: 32)
      .popover(isPresented: $isReversedProjectionHintShown) {
        ZStack(alignment: .top) {
          Color.backgroundColor
          Text(SpiralOfFifthsAppStrings.reverseSpiralProjectionHint)
            .font(.system(size: 13))
            .foregroundStyle(.primary)
            .padding(8)
            .popoverPresentationIfAvailable()
        }
      }
      
      Toggle(isOn: $spiralOfFifths.reversedProjection) {
        Text(SpiralOfFifthsAppStrings.reverseSpiralProjection)
          .foregroundStyle(.primary)
      }
    }
    .toggleStyle(SwitchToggleStyle(tint: spiralOfFifths.selectedNoteColor))
    .padding(16)
  }
}
