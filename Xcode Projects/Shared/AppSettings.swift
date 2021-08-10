import Foundation
import SwiftObserver
import SwiftyToolz

class AppSettings: Observer {
    static let shared = AppSettings()
    
    private init() {
        observe(currency).new() { CurrencyPersister.save($0) }
    }
    
    let currency = Var(CurrencyPersister.loadCurrency())
    
    let receiver = Receiver()
}

private struct CurrencyPersister {
    static func loadCurrency() -> Currency {
        guard let data = UserDefaults.standard.data(forKey: currencyKey) else {
            return .usDollar
        }
        
        guard let decodedCurrency = Currency(data) else {
            log(error: "Couldn't decode portfolio currency")
            return .usDollar
        }
        
        return decodedCurrency
    }
    
    static func save(_ currency: Currency) {
        guard let data = currency.encode() else {
            return log(error: "couldn't encode portfolio currency")
        }
        UserDefaults.standard.set(data, forKey: currencyKey)
    }
    
    static let currencyKey = "portfolioCurrencyDataKey"
}
