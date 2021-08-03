import Combine
import SwiftObserver
import SwiftyToolz

class AssetListRowModel: Observer {
    
    // MARK: - Life Cycle & Observing
    
    init(asset: Asset) {
        self.asset = asset
        assetName = asset.name
        profitPercentageString = Self.profitPercentageString(for: asset)
        profitString = Self.profitString(for: asset)
        valueString = Self.valueString(for: asset)
        
        observe(asset) { [weak self] event in
            switch event {
            case .propertiesDidChange: self?.assetPropertiesDidChange()
            }
        }
        
        observations += AppSettings.shared.$currency.sink { [weak self] newCurrency in
            self?.currencyWillChange(to: newCurrency)
        }
    }
    
    let receiver = Receiver()
    private var observations = [AnyCancellable]()
    
    // MARK: - React to Changes
    
    private func assetPropertiesDidChange() {
        assetName = asset.name
        updateMetricStrings()
    }
    
    private func currencyWillChange(to newCurrency: Currency) {
        updateMetricStrings(displayCurrency: newCurrency)
    }
    
    private func updateMetricStrings(displayCurrency: Currency = AppSettings.shared.currency) {
        profitPercentageString = Self.profitPercentageString(for: asset)
        profitString = Self.profitString(for: asset,
                                         displayCurrency: displayCurrency)
        valueString = Self.valueString(for: asset,
                                       displayCurrency: displayCurrency)
    }
    
    // MARK: -
    
    @Published var assetName: String
    
    // MARK: -
    
    @Published var profitPercentageString: String
    
    private static func profitPercentageString(for asset: Asset) -> String {
        let percentage = ((asset.currentPrice / asset.buyingPrice) - 1.0) * 100.0
        return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
    }
    
    // MARK: -
    
    @Published var profitString: String
    
    private static func profitString(for asset: Asset,
                                     displayCurrency: Currency = AppSettings.shared.currency) -> String {
        let p = asset.profit(in: displayCurrency)
        return (p > 0 ? "+" : "") + p.decimalString()
    }
    
    // MARK: -
    
    @Published var valueString: String
    
    private static func valueString(for asset: Asset,
                                    displayCurrency: Currency = AppSettings.shared.currency) -> String {
        asset.value(in: displayCurrency).decimalString()
    }
    
    // MARK: -
    
    var isLoss: Bool { asset.isLoss }
    
    private let asset: Asset
}
