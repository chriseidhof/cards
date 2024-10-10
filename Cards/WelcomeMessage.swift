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
    }
}

#Preview {
    WelcomeMessage(isPresented: .constant(true))
        .padding()
}
