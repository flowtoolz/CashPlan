import SwiftUI
import SwiftyToolz

struct CurrencyView: View {
    var body: some View {
        Image(systemName: Self.symbolName(for: currency))
    }
    
    let currency: Currency
    
    static func symbolName(for currency: Currency) -> String {
        switch currency.code {
        case "USD", "AUD", "CAD":
            return "dollarsign.circle"
        case "GBP":
            return "sterlingsign.circle"
        case "EUR":
            return "eurosign.circle"
        case "CHF":
            return "francsign.circle"
        case "BTC":
            return "bitcoinsign.circle"
        default:
            log(warning: "No symbol name was set for currency \(currency.name) (\(currency.code))")
            return "1.circle"
        }
    }
}
