struct Currency: Equatable, Identifiable, Codable {
    
    var id: String { code }
    
    static let all: [Currency] = [
        bitCoin,
        britishPound,
        euro,
        swissFranc,
        usDollar
    ]
    
    static let bitCoin = Currency(code: "BTC",
                                  dollarPrice: 36861.70,
                                  symbol: "₿",
                                  name: "Bitcoin")
    
    static let usDollar = Currency(code: "USD",
                                   dollarPrice: 1.0,
                                   symbol: "$",
                                   name: "US Dollar")
    
    static let euro = Currency(code: "EUR",
                               dollarPrice: 1.18,
                               symbol: "€",
                               name: "Euro")
    
    static let swissFranc = Currency(code: "CHF",
                                     dollarPrice: 1.09,
                                     symbol: "CHF",
                                     name: "Swiss Franc")
    
    static let britishPound = Currency(code: "GBP",
                                       dollarPrice: 1.38,
                                       symbol: "£",
                                       name: "British Pound")
    
    let code: String
    let dollarPrice: Double
    let symbol: String
    let name: String
    //    case usDollar, euro, britishPound, canadianDollar, australianDollar, swissFranc, bitCoin
}
