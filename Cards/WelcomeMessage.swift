import SwiftUI

struct WelcomeMessage: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("🎉 Welcome to Highlights")
                    .font(.headline)
                Spacer()
                Button("Close", systemImage: "xmark") {
                    isPresented = false
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .accessibilityHidden(true)
            }
            Text("Get account insights and learn about what's new in the app.")
        }
        .accessibilityElement(children: .combine)
        .accessibilityAction(action: {
            isPresented = false
        }, label: { Text("Close") })
        // This is nice for VoiceOver, but awkward for Voice Control as there
        // is no labeled "close" button. So you might want to expose the texts
        // as one element and the close button as another. See https://www.basbroek.nl/optimizing-assistive-technology
    }
}

#Preview {
    WelcomeMessage(isPresented: .constant(true))
        .padding()
}
