import Combine
import SwiftObserver
import SwiftyToolz

class AssetListRowModel {
    
    // MARK: - Life Cycle
    
    init(_ asset: Asset) {
        self.asset = asset
        
        assetName = asset.properties.name
        profitPercentageString = Self.profitPercentageString(from: asset.properties)
        valueString = Self.valueString(from: asset.properties,
                                       in: AppSettings.shared.currency)
        
        observeSourcesAndUpdate()
    }
    
    // MARK: - Observe Sources
    
    private func observeSourcesAndUpdate() {
        subscriptions += asset.publisher().sink { [weak self] properties in
            self?.update(with: properties)
        }
        
        subscriptions += AppSettings.shared.$currency.sink { [weak self] newCurrency in
            guard let self = self else { return }
            self.valueString = Self.valueString(from: self.asset.properties,
                                                in: newCurrency)
        }
    }
    
    private var subscriptions = [AnyCancellable]()
    
    private func update(with properties: Asset.Properties) {
        assetName = properties.name
        profitPercentageString = Self.profitPercentageString(from: properties)
        valueString = Self.valueString(from: properties,
                                       in: AppSettings.shared.currency)
    }
    
    // MARK: - Properties
    
    @Published private(set) var assetName: String
    
    @Published private(set) var profitPercentageString: String
    
    private static func profitPercentageString(from properties: Asset.Properties) -> String {
        guard let percentage = properties.profitPercentage else { return "" }
        return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
    }
    
    @Published private(set) var valueString: String
    
    private static func valueString(from properties: Asset.Properties,
                                    in currency: Currency) -> String {
        properties.balance.in(currency).value.decimalString()
    }
    
    // MARK: - Asset
    
    var isLoss: Bool { asset.properties.isLoss }
    private let asset: Asset
}
