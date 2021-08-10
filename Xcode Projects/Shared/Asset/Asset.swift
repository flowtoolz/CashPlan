import SwiftObserver

class Asset: Codable {

    init(properties: Properties) {
        self.properties = Var(properties)
    }
    
    private(set) var properties: Var<Properties>
    
    struct Properties: Codable, Equatable {
        
        var name: String
        
        // MARK: - Opening Balance
        
        var openingBalance: Cash {
            .init(numericalValue: openingNumericalValue,
                  currency: currency)
        }
        
        var openingNumericalValue: Double {
            openingPrice * Double(amount)
        }
        
        var isLoss: Bool { openingPrice > price }
        var openingPrice: Double
        
        // MARK: - Balance
        
        var balance: Cash {
            .init(numericalValue: numericalValue,
                  currency: currency)
        }
        
        var currency: Currency
        
        var numericalValue: Double {
            price * Double(amount)
        }
        
        var amount: Int
        var price: Double
    }
}
