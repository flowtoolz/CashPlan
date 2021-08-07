import FoundationToolz
import Foundation
import SwiftObserver
import SwiftyToolz

class Portfolio: Observer, ObservableObject {
    
    // MARK: - Life Cycle
    
    static let shared = Portfolio()
    private init() {}
    
    // MARK: - Editing Assets
    
    func add(_ asset: Asset) {
        ensureObservation(of: asset)
        assets.insertSorted(asset)
    }
    
    func removeAsset(at indices: IndexSet) {
        indices.compactMap { assets.at($0) }.forEach(stopObserving)
        assets.remove(atOffsets: indices)
    }
    
    func resetAssets(with assets: [Asset]) {
        self.assets.forEach(stopObserving)
        self.assets = assets.sorted()
        self.assets.forEach(ensureObservation(of:))
    }
    
    // MARK: - Observing Assets
    
    private func ensureObservation(of asset: Asset) {
        guard !isObserving(asset) else { return }
        
        observe(asset) { [weak self] _ in
            self?.assets.sort()
            // TODO: recompute portfolio metrics
        }
    }
    
    let receiver = Receiver()
    
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
        assets.map {
            $0.properties.balance.in(AppSettings.shared.currency).value
        }
        .reduce(0, +)
    }
    
    var profit: Double {
        assets.map {
            $0.properties.profit.in(AppSettings.shared.currency).value
        }.reduce(0, +)
    }
    
    var openingValue: Double {
        assets.map {
            $0.properties.openingBalance.in(AppSettings.shared.currency).value
        }.reduce(0, +)
    }
    
    // MARK: - Assets
    
    @Published private(set) var assets = [Asset]()
}
