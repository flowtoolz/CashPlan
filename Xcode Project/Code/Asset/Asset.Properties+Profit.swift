extension Asset.Properties {
    
    // MARK: - Profit Percentage
    
    var profitPercentage: Double? {
        Calculator.profitPercentage(open: openingNumericalValue,
                                    close: numericalValue)
    }
    
    // MARK: - Profit
    
    var profit: Cash {
        .init(numericalValue: profitNumericalValue,
              currency: currency)
    }
    
    var profitNumericalValue: Double {
        (price - openingPrice) * Double(amount)
    }
}
