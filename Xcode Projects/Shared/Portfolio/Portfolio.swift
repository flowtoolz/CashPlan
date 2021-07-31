import FoundationToolz
import Foundation
import SwiftyToolz

class Portfolio: ObservableObject {
    
    static let shared = Portfolio()
    private init() {}
    
    // MARK: - Metrics in Terms of Selected Currency
    
    var returnPercentage: Double {
        let v = value
        return ((v / (v - profit)) - 1.0) * 100.0
    }
    
    var isAtALoss: Bool { profit < 0 }
    
    var value: Double {
        assets.map { $0.value(in: AppSettings.shared.currency) }.reduce(0, +)
    }
    
    var profit: Double {
        assets.map { $0.profit(in: AppSettings.shared.currency) }.reduce(0, +)
    }
    
    // MARK: - Assets
    
    @Published var assets = [Asset]()
}
