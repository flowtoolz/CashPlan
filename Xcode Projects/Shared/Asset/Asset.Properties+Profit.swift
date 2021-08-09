extension Asset.Properties {
    
    // MARK: - Profit Percentage
    
    var profitPercentage: Double? {
        Calculator.profitPercentage(open: openingValue, close: value)
    }
    
    // MARK: - Profit
    
    var profit: Cash {
        .init(value: profitValue, currency: currency)
    }
    
    var profitValue: Double {
        (price - openingPrice) * Double(amount)
    }
}
