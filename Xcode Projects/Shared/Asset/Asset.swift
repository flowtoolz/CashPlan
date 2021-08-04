import SwiftObserver

class Asset: Codable, Observable {

    init(properties: Properties) {
        self.properties = properties
    }
    
    enum CodingKeys: CodingKey { case properties }
    
    var properties: Properties {
        didSet {
            if properties != oldValue { send(properties) }
        }
    }
    
    let messenger = Messenger<Properties>()
    
    struct Properties: Codable, Equatable {
        
        var name: String
        
        // MARK: - Opening Balance
        
        var openingBalance: Cash {
            .init(value: openingValue,
                  currency: currency)
        }
        
        var openingValue: Double {
            openingPrice * Double(amount)
        }
        
        var isLoss: Bool { openingPrice > price }
        var openingPrice: Double
        
        // MARK: - Balance
        
        var balance: Cash {
            .init(value: value,
                  currency: currency)
        }
        
        var currency: Currency
        
        var value: Double {
            price * Double(amount)
        }
        
        var amount: Int
        var price: Double
    }
}
