import FoundationToolz
import Foundation
import SwiftyToolz

class Portfolio: ObservableObject {
    
    static let shared = Portfolio()
    private init() {}
    
    // MARK: - Metrics in Terms of User Currency
    
    var profitLossPercentage: Double {
        let openingValue = openingValue
        let value = value
        
        guard openingValue != 0 else {
            if value > 0 { return 100 }
            else { return 0 }
        }
        
        let growthFactor = value / openingValue

        return (growthFactor - 1.0) * 100.0
    }
    
    var isAtALoss: Bool { profit < 0 }
    
    var value: Double {
        assets.map { $0.properties.value.value(in: AppSettings.shared.currency) }.reduce(0, +)
    }
    
    var profit: Double {
        assets.map { $0.properties.value.profit(in: AppSettings.shared.currency) }.reduce(0, +)
    }
    
    var openingValue: Double {
        assets.map { $0.properties.value.openingValue(in: AppSettings.shared.currency) }.reduce(0, +)
    }
    
    // MARK: - Assets
    
    @Published var assets = [Asset]()
}
