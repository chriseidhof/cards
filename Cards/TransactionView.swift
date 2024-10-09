import Foundation
import SwiftUI


struct TransactionView: View {
    @ScaledMetric var imageHeight: CGFloat = 16
    var transaction: CreditCardTransaction

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: transaction.category.iconName)
                .frame(height: imageHeight)
                .accessibilityHidden(true)
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.date, formatter: dateFormatter)
                    .foregroundStyle(.secondary)
                    .accessibilitySortPriority(-1)
            }
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(transaction.price, format: .price)")
                .foregroundStyle(.green)
                .font(.headline)
                .layoutPriority(1)
        }
        .foregroundStyle(transaction.state == .pending ? .secondary : .primary)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    TransactionView(transaction: sampleTransactions[0])
}

#Preview {
    TransactionView(transaction: sampleTransactions[1])
}
