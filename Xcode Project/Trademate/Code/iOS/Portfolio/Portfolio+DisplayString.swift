import Foundation

extension Portfolio {
    
    var returnPercentageString: String {
        guard let p = profitPercentage else { return "" }
        return (p < 0 ? "" : "+") + p.decimalString() + "%"
    }
    
    var valueDisplayString: String {
        balanceNumericalValue.decimalString(fractionDigits: 0) //+ " " + currency.symbol
    }
}
