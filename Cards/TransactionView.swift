import Foundation
import SwiftUI


struct TransactionView: View {
    @ScaledMetric var imageHeight: CGFloat = 16
    var transaction: CreditCardTransaction

    @Environment(\.stylesheet.amountColor) private var amountColor

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            RemoteImage(url: transaction.category.customIconURL)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
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
                .foregroundStyle(amountColor)
                .font(.headline)
                .layoutPriority(1)
        }
        .foregroundStyle(transaction.state == .pending ? .secondary : .primary)
        .accessibilityElement(children: .combine)
        .accessibilityCustomContent("Category", transaction.category.rawValue)
        .accessibilityCustomContent("Description", transaction.title)
        .accessibilityCustomContent("Price", Text("\(transaction.price, format: .price)"))
        .accessibilityCustomContent("Date", Text(transaction.date, formatter: dateFormatter))
        .accessibilityInputLabels([transaction.title, transaction.category.rawValue])
    }
}

#Preview {
    TransactionView(transaction: sampleTransactions[0])
        .useStylesheet()
}

#Preview {
    TransactionView(transaction: sampleTransactions[1])
        .useStylesheet()
}
