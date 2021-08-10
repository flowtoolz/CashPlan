extension Cash {
    
    func `in`(_ targetCurrency: Currency) -> Cash {
        guard currency.code != targetCurrency.code else { return self }
        let valueInUSDollar = numericalValue * currency.dollarPrice
        let valueInTargetCurrency = valueInUSDollar / targetCurrency.dollarPrice
        return Cash(numericalValue: valueInTargetCurrency, currency: targetCurrency)
    }
}

struct Cash {
    let numericalValue: Double
    let currency: Currency
}
