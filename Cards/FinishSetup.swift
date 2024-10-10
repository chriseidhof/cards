import SwiftUI

fileprivate struct MaxWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

extension View {
    func measureAndApplyWidth(width: CGFloat?) -> some View {
        self
            .fixedSize()
            .background {
            GeometryReader { proxy in
                Color.clear.preference(key: MaxWidthKey.self, value: proxy.size.width)
            }
        }
        .frame(width: width)
    }
}

struct FinishSetup: View {
    @ScaledMetric private var logoWidth = 30
    @State private var width: CGFloat? = nil

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "leaf")
                    .font(.title)
                    .measureAndApplyWidth(width: width)
                VStack(alignment: .leading) {
                    Text("Go Paperless")
                        .font(.headline)
                    Text("Cut down on paper by having billing statements and more provided to you electronically.")
                }
            }
            HStack {
                Image("apple_pay")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: logoWidth)
                    .measureAndApplyWidth(width: width)
                VStack(alignment: .leading) {
                    Text("Notifications")
                        .font(.headline)
                    Text("Personalize notifications to stay on top of your account.")
                }
            }
            HStack {
                Image(systemName: "bell")
                    .measureAndApplyWidth(width: width)
                VStack(alignment: .leading) {
                    Text("Notifications")
                        .font(.headline)
                    Text("Personalize notifications to stay on top of your account.")
                }
            }
        }
        .onPreferenceChange(MaxWidthKey.self, perform: { width = $0 })
    }
}


#Preview {
    FinishSetup()
}
