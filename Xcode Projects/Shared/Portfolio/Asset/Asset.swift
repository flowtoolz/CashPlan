import Foundation

extension Asset {
    
    var profitPercentageDisplayString: String {
        let percentage = ((currentPrice / buyingPrice) - 1.0) * 100.0
        return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
    }
    
    func profitDisplayString(in targetCurrency: Currency) -> String {
        let p = profit(in: targetCurrency)
        return (p > 0 ? "+" : "") + p.decimalString()
    }
    
    func valueDisplayString(in targetCurrency: Currency) -> String {
        value(in: targetCurrency).decimalString()
    }
}

class Asset: Identifiable, ObservableObject, Comparable, Equatable {
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Asset, rhs: Asset) -> Bool {
        abs(lhs.profit) > abs(rhs.profit)
    }
    
    internal init(id: UUID = UUID(),
                  name: String,
                  amount: Int,
                  currency: Currency,
                  buyingPrice: Double,
                  currentPrice: Double) {
        self.id = id
        self.name = name
        self.amount = amount
        self.currency = currency
        self.buyingPrice = buyingPrice
        self.currentPrice = currentPrice
    }
    
    func value(in targetCurrency: Currency) -> Double {
        guard currency.code != targetCurrency.code else { return value }
        let valueInUSDollar = value * currency.dollarPrice
        return valueInUSDollar / targetCurrency.dollarPrice
    }
    
    func profit(in targetCurrency: Currency) -> Double {
        guard currency.code != targetCurrency.code else { return profit }
        let profitInUSDollar = profit * currency.dollarPrice
        return profitInUSDollar / targetCurrency.dollarPrice
    }
    
    var profit: Double {
        (currentPrice - buyingPrice) * Double(amount)
    }
    
    var value: Double {
        currentPrice * Double(amount)
    }
    
    var buyingValue: Double {
        buyingPrice * Double(amount)
    }
    
    var isLoss: Bool {
        buyingPrice > currentPrice
    }
    
    var record: Record {
        .init(id: id,
              name: name,
              amount: amount,
              currency: currency,
              buyingPrice: buyingPrice,
              currentPrice: currentPrice)
    }
    
    struct Record: Codable {
        let id: UUID
        let name: String
        let amount: Int
        let currency: Currency
        let buyingPrice: Double
        let currentPrice: Double
    }
    
    private(set) var id: UUID
    @Published var name: String
    @Published var amount: Int
    @Published var currency: Currency
    @Published var buyingPrice: Double
    @Published var currentPrice: Double
}
