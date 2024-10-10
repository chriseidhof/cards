import Foundation
import SwiftUI

struct Transactions: View {
    var transactions: [CreditCardTransaction]

    @Environment(\.stylesheet) private var stylesheet

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                CardView()
                    .accessibilityHidden(true)
                LazyVStack(spacing: 16) {
                    ForEach(transactions) { transaction in
                        TransactionView(transaction: transaction)
                    }
                    .withDividers()
                }
                .padding()
                .background(stylesheet.listItemBackground, in: .rect(cornerRadius: 8))
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
