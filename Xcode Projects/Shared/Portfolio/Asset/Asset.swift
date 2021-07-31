import Foundation

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
    
    private(set) var id: UUID
    
    @Published var name: String
    @Published var amount: Int
    @Published var currency: Currency
    @Published var buyingPrice: Double
    @Published var currentPrice: Double
}
