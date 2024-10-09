import SwiftUI

extension Color {
    static let amexBlue = Color(red: 0.06, green: 0.1, blue: 0.24)
}

struct Stylesheet {
    var listBackground = AnyShapeStyle(.quaternary)
    var listItemBackground = AnyShapeStyle(.white)
    var amountColor = Color.green

    static let light = Stylesheet()
    static let dark = Stylesheet(listBackground: .init(.background), listItemBackground: AnyShapeStyle(Color.amexBlue), amountColor: .purple)
}

struct StylesheetKey: EnvironmentKey {
    static let defaultValue = Stylesheet.light
}

extension EnvironmentValues {
    var stylesheet: Stylesheet {
        get { self[StylesheetKey.self] }
        set { self[StylesheetKey.self] = newValue }
    }
}

struct UseStylesheet: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .environment(\.stylesheet, colorScheme == .light ? .light : .dark)
    }
}

extension View {
    func useStylesheet() -> some View {
        modifier(UseStylesheet())
    }
}
