struct Calculator {
    
    static func profitPercentage(open: Double,
                                 close: Double) -> Double? {
        profitPercentage(fromFactor: profitFactor(open: open,
                                                  close: close))
    }
    
    static func profitPercentage(fromFactor factor: Double?) -> Double? {
        guard let factor = factor else { return nil }
        return (factor - 1.0) * 100.0
    }
    
    static func profitFactor(open: Double,
                             close: Double) -> Double? {
        if open == 0 {
            return close == 0 ? 1 : nil
        } else {
            return close / open
        }
    }
}
