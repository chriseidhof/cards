import SwiftUI

extension Set {
    subscript(contains element: Element) -> Bool {
        get { contains(element) }
        set {
            if newValue {
                insert(element)
            } else {
                remove(element)
            }
        }
    }
}

extension Set<OfferCategory> {
    var isEmpty_: Bool {
        get { isEmpty }
        set {
            if newValue {
                self = []
            } else {
                // not sure
            }
        }
    }
}


struct OfferPicker: View {
    var categories: [OfferCategory] = OfferCategory.allCases
    @State private var selection: Set<OfferCategory> = [] // empty means all

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Toggle("All", systemImage: "rectangle.grid.2x2", isOn: $selection.isEmpty_)
                ForEach(categories, id: \.self) { category in
                    Toggle(category.name, systemImage: category.systemImageName, isOn: $selection[contains: category])
                }
            }
            .toggleStyle(MyToggleStyle())
        }
        .accessibilityLabel("Categories")
        .scrollIndicators(.hidden)
        .animation(.default, value: selection)
    }
}

struct MyToggleStyle: ToggleStyle {
    @ScaledMetric var padding = 8
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(configuration.isOn ? .white : .accentColor)
            .padding(padding)
            .padding(.horizontal, padding)
            .background(Capsule().fill(Color.accentColor).opacity(configuration.isOn ? 1 : 0.2))
            .accessibilityValue(Text("Enabled"), isEnabled: configuration.isOn)
            .onTapGesture {
                configuration.isOn.toggle()
            }
    }
}

#Preview {
    OfferPicker()
        .safeAreaPadding(.horizontal)
}
