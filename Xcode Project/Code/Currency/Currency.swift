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
                               dollarPrice: 1.0894, // https://www.google.com/finance/quote/EUR-USD
                               symbol: "€",
                               name: "Euro")
    
    static let swissFranc = Currency(code: "CHF",
                                     dollarPrice: 1.1001, // https://www.google.com/finance/quote/CHF-USD
                                     symbol: "CHF",
                                     name: "Swiss Franc")
    
    static let britishPound = Currency(code: "GBP",
                                       dollarPrice: 1.2705, // https://www.google.com/finance/quote/GBP-USD
                                       symbol: "£",
                                       name: "British Pound")
    
    static let bitCoin = Currency(code: "BTC",
                                  dollarPrice: 67194.1, // https://www.google.com/finance/quote/BTC-USD
                                  symbol: "₿",
                                  name: "Bitcoin")
    
    static let canadianDollar = Currency(code: "CAD",
                                         dollarPrice: 0.7343, // https://www.google.com/finance/quote/CAD-USD
                                         symbol: "C$",
                                         name: "Canadian Dollar")
    
    static let australianDollar = Currency(code: "AUD",
                                           dollarPrice: 0.6701, // https://www.google.com/finance/quote/AUD-USD
                                           symbol: "A$",
                                           name: "Australian Dollar")
    
    let code: String
    let dollarPrice: Double
    let symbol: String
    let name: String
}
