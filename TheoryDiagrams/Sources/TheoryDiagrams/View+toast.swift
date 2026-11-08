import SwiftUI

extension View {
  func toast<Content: View>(
    isPresented: Binding<Bool>,
    duration: TimeInterval = 3,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    modifier(ToastModifier(isPresented: isPresented, duration: duration, content: content))
  }
}

private struct ToastModifier<ToastContent: View>: ViewModifier {
  @Binding var isPresented: Bool
  let duration: TimeInterval
  @ViewBuilder let content: () -> ToastContent

  func body(content: Content) -> some View {
    let toast = content
      .overlay(alignment: .top) {
        if isPresented {
          self.content()
            .transition(.move(edge: .top).combined(with: .opacity))
        }
      }
      .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isPresented)

    #if os(visionOS)
    toast.onChange(of: isPresented) { _, presented in
      scheduleDismissal(presented)
    }
    #else
    toast.onChange(of: isPresented, perform: scheduleDismissal)
    #endif
  }

  private func scheduleDismissal(_ presented: Bool) {
    if presented {
      Task {
        try? await Task.sleep(for: .seconds(duration))
        await MainActor.run { isPresented = false }
      }
    }
  }
}
