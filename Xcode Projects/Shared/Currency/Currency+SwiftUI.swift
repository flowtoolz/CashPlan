extension Currency {
    var symbolName: String {
        switch code {
        case "USD": return "dollarsign.circle"
        case "GBP": return "sterlingsign.circle"
        case "EUR": return "eurosign.circle"
        case "CHF": return "francsign.circle"
        case "BTC": return "bitcoinsign.circle"
        default: return "1.circle"
        }
    }
}
