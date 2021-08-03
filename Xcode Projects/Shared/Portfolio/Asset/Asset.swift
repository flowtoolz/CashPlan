import SwiftObserver
import SwiftyToolz

extension Asset: Identifiable, Comparable, Equatable {
    static func == (lhs: Asset, rhs: Asset) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Asset, rhs: Asset) -> Bool {
        abs(lhs.properties.value.profit) > abs(rhs.properties.value.profit)
    }
    
    var id: HashValue { hashValue(self) }
}

class Asset: Codable {

    init(name: String,
         amount: Int,
         currency: Currency,
         buyingPrice: Double,
         currentPrice: Double) {
        properties = Var(.init(name: name,
                               amount: amount,
                               currency: currency,
                               buyingPrice: buyingPrice,
                               currentPrice: currentPrice))
    }
    
    
    
    var name: String { properties.value.name }
    var amount: Int { properties.value.amount }
    var currency: Currency { properties.value.currency }
    var buyingPrice: Double { properties.value.buyingPrice }
    var currentPrice: Double { properties.value.currentPrice }
    
    private(set) var properties: Var<Properties>
    
    struct Properties: Codable, Equatable {
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
        
        var name: String
        var amount: Int
        var currency: Currency
        var buyingPrice: Double
        var currentPrice: Double
    }
}
