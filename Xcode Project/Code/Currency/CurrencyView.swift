import SwiftUI
import SwiftyToolz

struct CurrencyView: View {
    var body: some View {
        Image(systemName: Self.symbolName(for: currency))
    }
    
    let currency: Currency
    
    static func symbolName(for currency: Currency) -> String {
        switch currency.code {
        case "USD", "AUD", "CAD": "dollarsign.circle"
        case "GBP": "sterlingsign.circle"
        case "EUR": "eurosign.circle"
        case "CHF": "francsign.circle"
        case "BTC": "bitcoinsign.circle"
        default: {
                log(warning: "No symbol name was set for currency \(currency.name) (\(currency.code))")
                return "1.circle"
            }()
        }
    }
}
