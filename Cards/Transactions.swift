import Foundation
import SwiftUI

struct Transactions: View {
    var transactions: [CreditCardTransaction]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(transactions) { transaction in
                    TransactionView(transaction: transaction)
                }
                .withDividers()
            }
            .padding()
            .background(.white, in: .rect(cornerRadius: 8))
            .padding()
        }
        .background(.quaternary)
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
}