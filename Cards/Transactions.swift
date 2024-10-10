import Foundation
import SwiftUI

struct Transactions: View {
    var transactions: [CreditCardTransaction]

    @Environment(\.stylesheet) private var stylesheet
    @State private var showWelcomeMessage = true

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                CardView()
                    .accessibilityHidden(true)
                    .onTapGesture(count: 2) {
                        withAnimation {
                            showWelcomeMessage.toggle()
                        }
                    }
                 if showWelcomeMessage {
                    WelcomeMessage(isPresented: $showWelcomeMessage.animation())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(stylesheet.listItemBackground, in: .rect(cornerRadius: 8))
                        .transition(.slide.combined(with: .opacity).combined(with: .blur))
                }
                LazyVStack(spacing: 16) {
                    ForEach(transactions) { transaction in
                        TransactionView(transaction: transaction)
                    }
                    .withDividers()
                }
                .padding()
                .background(stylesheet.listItemBackground, in: .rect(cornerRadius: 8))
                .drawingGroup()
            }
            .padding()
        }
        .background(stylesheet.listBackground)
    }
}

// Bonus
extension View {
    func withDividers() -> some View {
        Group(subviews: self) { coll in
            coll.first
            ForEach(coll.dropFirst()) { subview in
                Divider()
                subview
            }
        }
    }
}


#Preview {
    Transactions(transactions: sampleTransactions)
        .useStylesheet()
}
