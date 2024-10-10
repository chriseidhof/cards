import SwiftUI

struct Badge<Label: View>: View {
    @ViewBuilder var label: Label
    @ScaledMetric(relativeTo: .footnote) private var indicatorHeight: CGFloat = 20
    @ScaledMetric(relativeTo: .footnote) private var padding = 4

    var body: some View {
        label
            .font(.footnote.monospacedDigit()).bold()
            .foregroundStyle(.white)
            .padding(.horizontal, padding)
            .frame(height: indicatorHeight)
            .frame(minWidth: indicatorHeight)
            .background(.red.gradient, in: .capsule)
    }
}

extension View {
    func badge(_ text: String?, alignment: Alignment = .topTrailing) -> some View {
        overlay(alignment: alignment) {
            ZStack {
                if let t = text {
                    Badge {
                        Text(t)
                    }
                        .fixedSize()
                }
            }
            .alignmentGuide(alignment.vertical) { $0[VerticalAlignment.center] }
            .alignmentGuide(alignment.horizontal) { $0[HorizontalAlignment.center]}
        }

    }
}


struct BadgePreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Button("Test") {}
                .buttonStyle(.bordered)
                .badge("100")
                .frame(maxWidth: 100)

        Text("Hello, world")
            .badge("5")

        Text("A larger badge")
            .badge("200", alignment: .bottomTrailing)

        Text("Accessibility")
            .badge("123", alignment: .topLeading)
            .environment(\.sizeCategory, .accessibilityLarge)
        }
    }
}
