import Foundation

let baseURL = URL(string: "https://objcio-workshops.s3.amazonaws.com/amex/")!

enum TransactionCategory: String, Codable {
    case food
    case clothing
    case entertainment
    case other
}

extension TransactionCategory {
    var customIconURL: URL {
        baseURL.appending(path: "\(customIconName).png")
    }
    
    private var customIconName: String {
        switch self {
        case .food:
            return "pot-food-light"
        case .clothing:
            return "shirt-sharp-light"
        case .entertainment:
            return "popcorn-light"
        case .other:
            return "file-lines-sharp-light"
        }
    }
}

enum TransactionState: String, Codable {
    case pending
    case completed
}

struct CreditCardTransaction: Codable, Identifiable {
    var id = UUID()
    var state: TransactionState
    var price: Price
    var title: String
    var date: Date
    var category: TransactionCategory
}

extension CreditCardTransaction {
    static var all: URL {
        baseURL.appending(path: "transactions.json")
    }
}

struct Price: Codable, Hashable {
    var cents: Int
    init(cents: Int) {
        self.cents = cents
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.cents)
    }

    enum CodingKeys: CodingKey {
        case cents
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.cents = try container.decode(Int.self)
    }
}

let sampleTransactions: [CreditCardTransaction] = [
    .init(state: .pending, price: .init(cents: 212), title: "1.75% for foreign use", date: .now, category: .other),
    .init(state: .completed, price: .init(cents: 1234), title: "Amazon.co.uk", date: .now, category: .entertainment)
]

extension TransactionCategory {
    var iconName: String {
        switch self {
        case .food:
            "takeoutbag.and.cup.and.straw"
        case .clothing:
            "tshirt"
        case .entertainment:
            "popcorn"
        case .other:
            "doc.plaintext"
        }
    }
}

enum OfferCategory: String, Codable, Hashable, CaseIterable {
    case services
    case entertainment
    case dining
    case shopping
    case travel
    case wellness
    case groceries

    var name: String { rawValue.capitalized }
}

extension OfferCategory {
    var systemImageName: String {
        switch self {
        case .services:
            "wrench.and.screwdriver" // Suitable for services
        case .entertainment:
            "sparkles.tv" // Represents entertainment or media
        case .dining:
            "fork.knife" // Suitable for dining/food services
        case .shopping:
            "bag" // Represents shopping/bag purchases
        case .travel:
            "airplane" // Travel-related symbol
        case .wellness:
            "heart.text.square" // Suitable for wellness/fitness
        case .groceries:
            "cart" // Suitable for groceries
        }
    }
}
