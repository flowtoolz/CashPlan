struct Currency: Equatable, Identifiable, Codable {
    
    var id: String { code }
    
    static let all: [Currency] = [
        usDollar,
        euro,
        britishPound,
        swissFranc,
        canadianDollar,
        australianDollar,
        bitCoin
    ]
    
    static let usDollar = Currency(code: "USD",
                                   dollarPrice: 1.0,
                                   symbol: "$",
                                   name: "US Dollar")
    
    static let euro = Currency(code: "EUR",
                               dollarPrice: 1.19,
                               symbol: "€",
                               name: "Euro")
    
    static let swissFranc = Currency(code: "CHF",
                                     dollarPrice: 1.10,
                                     symbol: "CHF",
                                     name: "Swiss Franc")
    
    static let britishPound = Currency(code: "GBP",
                                       dollarPrice: 1.39,
                                       symbol: "£",
                                       name: "British Pound")
    
    static let bitCoin = Currency(code: "BTC",
                                  dollarPrice: 41579.80,
                                  symbol: "₿",
                                  name: "Bitcoin")
    
    static let canadianDollar = Currency(code: "CAD",
                                         dollarPrice: 0.8,
                                         symbol: "C$",
                                         name: "Canadian Dollar")
    
    static let australianDollar = Currency(code: "AUD",
                                           dollarPrice: 0.73,
                                           symbol: "A$",
                                           name: "Australian Dollar")
    
    let code: String
    let dollarPrice: Double
    let symbol: String
    let name: String
}
