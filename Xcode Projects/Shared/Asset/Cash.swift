extension Cash {
    
    func `in`(_ targetCurrency: Currency) -> Cash {
        guard currency.code != targetCurrency.code else { return self }
        let valueInUSDollar = value * currency.dollarPrice
        let valueInTargetCurrency = valueInUSDollar / targetCurrency.dollarPrice
        return Cash(value: valueInTargetCurrency, currency: targetCurrency)
    }
}

struct Cash {
    let value: Double
    let currency: Currency
}
