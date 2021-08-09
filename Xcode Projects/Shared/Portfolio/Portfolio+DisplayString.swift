import Foundation

extension Portfolio {
    
    var returnPercentageString: String {
        guard let p = profitPercentage else { return "" }
        return (p < 0 ? "" : "+") + p.decimalString() + "%"
    }
    
    var valueDisplayString: String {
        value.decimalString(fractionDigits: 0) //+ " " + currency.symbol
    }
}
