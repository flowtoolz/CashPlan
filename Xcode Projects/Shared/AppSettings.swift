import Foundation
import SwiftyToolz

class AppSettings: ObservableObject {
    static let shared = AppSettings()
    private init() {}
    
    @Published var currency = CurrencyPersister.loadCurrency() {
        didSet { CurrencyPersister.save(currency) }
    }
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
