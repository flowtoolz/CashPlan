import FoundationToolz
import Foundation
import SwiftyToolz

class Portfolio: ObservableObject {
    static let shared = Portfolio()
    private init() {}
    
    // MARK: - Metrics
    
    var returnPercentageString: String {
        let p = returnPercentage
        return (p < 0 ? "" : "+") + p.decimalString() + "%"
    }
    
    var returnPercentage: Double {
        let v = value
        return ((v / (v - profit)) - 1.0) * 100.0
    }
    
    var valueDisplayString: String {
        value.decimalString(fractionDigits: 0) //+ " " + currency.symbol
    }
    
    var isAtALoss: Bool { profit < 0 }
    
    var value: Double {
        positions.map { $0.value(in: currency) }.reduce(0, +)
    }
    
    var profitDisplayString: String {
        profit.decimalString(fractionDigits: 0) //+ " " + currency.symbol
    }
    
    var profit: Double {
        positions.map { $0.profit(in: currency) }.reduce(0, +)
    }
    
    // MARK: - Positions
    
    @Published var positions: [Asset] = loadPositions() {
        didSet { persistPositions() }
    }
    
    func persistPositions() {
        guard let recordsData = positions.map({ $0.record }).encode() else {
            return log(error: "couldn't encode position records")
        }
        UserDefaults.standard.set(recordsData, forKey: "positionsDataKey")
    }
    
    private static func loadPositions() -> [Asset] {
        guard let data = UserDefaults.standard.data(forKey: "positionsDataKey") else {
            return []
        }
        
        guard let records = [Asset.Record](data) else {
            log(error: "could not decode position records")
            return []
        }
        
        return records.map {
            Asset(id: $0.id,
                     name: $0.name,
                     amount: $0.amount,
                     currency: $0.currency,
                     buyingPrice: $0.buyingPrice,
                     currentPrice: $0.currentPrice)
        }
    }
    
    // MARK: - Currency
    
    @Published var currency = loadCurrency() {
        didSet { persistCurrency() }
    }
    
    static func loadCurrency() -> Currency {
        guard let data = UserDefaults.standard.data(forKey: "portfolioCurrencyDataKey") else {
            return .usDollar
        }
        
        guard let decodedCurrency = Currency(data) else {
            log(error: "Couldn't decode portfolio currency")
            return .usDollar
        }
        
        return decodedCurrency
    }
    
    func persistCurrency() {
        guard let data = currency.encode() else {
            return log(error: "couldn't encode portfolio currency")
        }
        UserDefaults.standard.set(data, forKey: "portfolioCurrencyDataKey")
    }
}
