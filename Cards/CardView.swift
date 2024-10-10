import SwiftUI

struct CardView: View {
    @State private var taps = 0

    var body: some View {
        Image("card")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleDownAndUpEffect(scale: 1.1, trigger: taps)
            .containerRelativeFrame(.horizontal, count: 3, span: 1, spacing: 0)
            .onTapGesture { taps += 1 }
    }
}

#Preview {
    CardView()
        .useStylesheet()
}
