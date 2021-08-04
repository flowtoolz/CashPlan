extension Asset.Properties {
    
    // MARK: - Profit Percentage
    
    var profitPercentage: Double? {
        guard let profitFactor = profitFactor else { return nil }
        return (profitFactor - 1.0) * 100.0
    }
    
    var profitFactor: Double? {
        if openingValue == 0 {
            return price == 0 ? 1 : nil
        } else {
            return value / openingValue
        }
    }
    
    // MARK: - Profit
    
    var profit: Cash {
        .init(value: profitValue, currency: currency)
    }
    
    var profitValue: Double {
        (price - openingPrice) * Double(amount)
    }
}
