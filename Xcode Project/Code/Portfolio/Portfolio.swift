import FoundationToolz
import Foundation
import Combine
import SwiftObserver
import SwiftyToolz

class Portfolio: Observer, Combine.ObservableObject {
    
    // MARK: - Life Cycle
    
    static let shared = Portfolio()
    
    private init() {
        observeUserCurrency()
    }
    
    // MARK: - Edit Assets
    
    func resetWithDemoAssets() {
        let demoAssetProperties: [Asset.Properties] = [
            .init(name: "Tesla",
                  openingPrice: 14.07,
                  currency: .usDollar,
                  amount: 17,
                  price: 168.47),
            .init(name: "Microsoft",
                  openingPrice: 127.13,
                  currency: .usDollar,
                  amount: 17,
                  price: 414.74),
            .init(name: "Walt Disney",
                  openingPrice: 134.04,
                  currency: .usDollar,
                  amount: 27,
                  price: 105.79),
            .init(name: "NVIDIA",
                  openingPrice: 42.21,
                  currency: .usDollar,
                  amount: 7,
                  price: 898.78),
            .init(name: "Apple",
                  openingPrice: 49.3,
                  currency: .usDollar,
                  amount: 27,
                  price: 183.05),
            .init(name: "Alphabet",
                  openingPrice: 58.21,
                  currency: .usDollar,
                  amount: 37,
                  price: 170.29),
            .init(name: "Vanguard S&P 500 ETF",
                  openingPrice: 264.52,
                  currency: .usDollar,
                  amount: 27,
                  price: 478.74),
        ]
        
        resetAssets(with: demoAssetProperties.map(Asset.init))
    }
    
    func add(_ asset: Asset) {
        ensureObservation(of: asset)
        assets.insertSorted(asset)
        updateMetrics()
    }
    
    func removeAsset(at indices: IndexSet) {
        indices.compactMap { assets.at($0)?.$properties }.forEach(stopObserving)
        assets.remove(atOffsets: indices)
        updateMetrics()
    }
    
    func resetAssets(with newAssets: [Asset]) {
        assets.map { $0.$properties }.forEach(stopObserving)
        assets = newAssets.sorted()
        assets.forEach(ensureObservation(of:))
        updateMetrics()
    }
    
    // MARK: - Observe Sources
    
    private func observeUserCurrency() {
        observe(AppSettings.shared.$currency) { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.balanceNumericalValue = self.computeBalanceNumericalValue()
            }
        }
    }
    
    private func ensureObservation(of asset: Asset) {
        guard !isObserving(asset.$properties) else { return }
        
        observe(asset.$properties) { [weak self] _ in
            DispatchQueue.main.async { // ensure exclusive access to Asset.properties
                self?.updateAssetOrder()
                self?.updateMetrics()
            }
        }
    }
    
    let receiver = Receiver()
    
    // MARK: - Metrics in Terms of User Currency
    
    private func updateMetrics() {
        balanceNumericalValue = computeBalanceNumericalValue()
        profitNumericalValue = computeProfitNumericalValue()
        profitPercentage = computeProfitPercentage()
    }
    
    @Published private(set) var profitPercentage: Double? = 0
    
    private func computeProfitPercentage() -> Double? {
        Calculator.profitPercentage(open: computeOpeningBalanceNumericalValue(),
                                    close: computeBalanceNumericalValue())
    }
    
    private func computeOpeningBalanceNumericalValue() -> Double {
        assets.map {
            $0.properties.openingBalance.in(currency).numericalValue
        }.reduce(0, +)
    }
    
    var isAtALoss: Bool { profitNumericalValue < 0 }
    
    @Published private(set) var profitNumericalValue: Double = 0
    
    private func computeProfitNumericalValue() -> Double {
        assets.map {
            $0.properties.profit.in(currency).numericalValue
        }.reduce(0, +)
    }
    
    @Published private(set) var balanceNumericalValue: Double = 0
    
    private func computeBalanceNumericalValue() -> Double {
        assets.map {
            $0.properties.balance.in(currency).numericalValue
        }
        .reduce(0, +)
    }
    
    private var currency: Currency { AppSettings.shared.currency }
    
    // MARK: - Assets
    
    private func updateAssetOrder() { assets.sort() }
    
    @Published private(set) var assets = [Asset]()
}
