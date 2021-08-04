import Foundation

extension Portfolio {
    
    var returnPercentageString: String {
        let p = profitLossPercentage
        return (p < 0 ? "" : "+") + p.decimalString() + "%"
    }
    
    var valueDisplayString: String {
        value.decimalString(fractionDigits: 0) //+ " " + currency.symbol
    }
    
    var profitDisplayString: String {
        profit.decimalString(fractionDigits: 0) //+ " " + currency.symbol
    }
}
