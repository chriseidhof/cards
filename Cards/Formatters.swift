//

import Foundation

var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, YYYY"
    return dateFormatter
}()

struct PriceFormatStyle: FormatStyle {
    func format(_ value: Price) -> String {
        (Double(value.cents)/100).formatted(.currency(code: "USD"))
    }
}

extension FormatStyle where Self == PriceFormatStyle {
    static var price: Self { .init() }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ price: Price) {
        let f = PriceFormatStyle()
        appendLiteral(f.format(price))
    }
}
