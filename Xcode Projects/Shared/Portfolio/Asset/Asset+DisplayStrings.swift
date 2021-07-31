import Foundation

extension Asset {
    
    var profitPercentageDisplayString: String {
        let percentage = ((currentPrice / buyingPrice) - 1.0) * 100.0
        return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
    }
    
    func profitDisplayString(in targetCurrency: Currency) -> String {
        let p = profit(in: targetCurrency)
        return (p > 0 ? "+" : "") + p.decimalString()
    }
    
    func valueDisplayString(in targetCurrency: Currency) -> String {
        value(in: targetCurrency).decimalString()
    }
}
