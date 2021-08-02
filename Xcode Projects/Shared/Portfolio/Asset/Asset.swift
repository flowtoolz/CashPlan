import SwiftObserver
import SwiftyToolz

class Asset: Identifiable, Comparable, Equatable, Observable {
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Asset, rhs: Asset) -> Bool {
        abs(lhs.profit) > abs(rhs.profit)
    }
    
    var id: HashValue { hashValue(self) }
    
    init(name: String,
         amount: Int,
         currency: Currency,
         buyingPrice: Double,
         currentPrice: Double) {
        properties = .init(name: name,
                           amount: amount,
                           currency: currency,
                           buyingPrice: buyingPrice,
                           currentPrice: currentPrice)
    }
    
    func value(in targetCurrency: Currency) -> Double {
        guard currency.code != targetCurrency.code else { return value }
        let valueInUSDollar = value * currency.dollarPrice
        return valueInUSDollar / targetCurrency.dollarPrice
    }
    
    func openingValue(in targetCurrency: Currency) -> Double {
        guard currency.code != targetCurrency.code else { return openingValue }
        let openingValueInUSDollar = openingValue * currency.dollarPrice
        return openingValueInUSDollar / targetCurrency.dollarPrice
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
    
    var openingValue: Double {
        buyingPrice * Double(amount)
    }
    
    var isLoss: Bool {
        buyingPrice > currentPrice
    }
    
    var name: String { properties.name }
    var amount: Int { properties.amount }
    var currency: Currency { properties.currency }
    var buyingPrice: Double { properties.buyingPrice }
    var currentPrice: Double { properties.currentPrice }
    
    var properties: Properties {
        didSet {
            if oldValue != properties {
                send(.propertiesDidChange)
            }
        }
    }
    
    struct Properties: Equatable {
        var name: String
        var amount: Int
        var currency: Currency
        var buyingPrice: Double
        var currentPrice: Double
    }
    
    let messenger = Messenger<Event>()
    enum Event { case propertiesDidChange }
}
