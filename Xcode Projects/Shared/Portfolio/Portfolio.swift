import FoundationToolz
import Foundation
import SwiftObserver
import SwiftyToolz

class Portfolio: Observer, ObservableObject {
    
    // MARK: - Life Cycle
    
    static let shared = Portfolio()
    private init() {}
    
    // MARK: - Edit Assets
    
    func add(_ asset: Asset) {
        ensureObservation(of: asset)
        assets.insertSorted(asset)
        updateMetrics()
    }
    
    func removeAsset(at indices: IndexSet) {
        indices.compactMap { assets.at($0) }.forEach(stopObserving)
        assets.remove(atOffsets: indices)
        updateMetrics()
    }
    
    func resetAssets(with assets: [Asset]) {
        self.assets.forEach(stopObserving)
        self.assets = assets.sorted()
        self.assets.forEach(ensureObservation(of:))
        updateMetrics()
    }
    
    // MARK: - Observe Assets
    
    private func ensureObservation(of asset: Asset) {
        guard !isObserving(asset) else { return }
        
        observe(asset) { [weak self] _ in
            self?.updateAssetOrder()
            self?.updateMetrics()
        }
    }
    
    let receiver = Receiver()
    
    // MARK: - Metrics in Terms of User Currency
    
    private func updateMetrics() {
        value = computeValue()
        profit = computeProfit()
        profitPercentage = computeProfitPercentage()
    }
    
    @Published private(set) var profitPercentage: Double? = 0
    
    private func computeProfitPercentage() -> Double? {
        Calculator.profitPercentage(open: computeOpeningValue(),
                                    close: computeValue())
    }
    
    private func computeOpeningValue() -> Double {
        assets.map {
            $0.properties.openingBalance.in(AppSettings.shared.currency).value
        }.reduce(0, +)
    }
    
    var isAtALoss: Bool { profit < 0 }
    
    @Published private(set) var profit: Double = 0
    
    private func computeProfit() -> Double {
        assets.map {
            $0.properties.profit.in(AppSettings.shared.currency).value
        }.reduce(0, +)
    }
    
    @Published private(set) var value: Double = 0
    
    private func computeValue() -> Double {
        assets.map {
            $0.properties.balance.in(AppSettings.shared.currency).value
        }
        .reduce(0, +)
    }
    
    // MARK: - Assets
    
    private func updateAssetOrder() { assets.sort() }
    
    @Published private(set) var assets = [Asset]()
}
