//

import Foundation
import SwiftUI

struct LoadTransactions: View {
    @State private var transactions: [CreditCardTransaction]? = nil

    var body: some View {
        ZStack {
            if let transactions {
                Transactions(transactions: transactions)
            } else {
                ProgressView()
            }
        }.task {
            do {
                let (data, _) = try await URLSession.shared.data(from: CreditCardTransaction.all)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                transactions = try decoder.decode([CreditCardTransaction].self, from: data)
            } catch {
                print(error)
            }

        }
    }
}

#Preview {
    LoadTransactions()
        .useStylesheet()
}

