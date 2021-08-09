import Combine
import SwiftObserver
import SwiftyToolz

class AssetListRowModel {
    
    // MARK: - Life Cycle
    
    init(_ asset: Asset) { self.asset = asset }
    
    // MARK: - Properties
    
    var assetNameInitial: String {
        asset.properties.name
    }
    
    lazy private(set) var assetName = asset
        .map { $0.name }
        .publisher()
    
    var profitPercentageStringInitial: String {
        Self.profitPercentageString(from: asset.properties)
    }
    
    lazy private(set) var profitPercentageString = asset
        .map { Self.profitPercentageString(from: $0) }
        .publisher()
    
    private static func profitPercentageString(from properties: Asset.Properties) -> String {
        guard let percentage = properties.profitPercentage else { return "" }
        return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
    }
    
    var valueStringInitial: String {
        Self.valueString(from: asset.properties,
                         in: AppSettings.shared.currency)
    }
    
    lazy var valueString = asset
        .publisher()
        .combineLatest(AppSettings.shared.$currency)
        .map { assetProperties, currency in
            Self.valueString(from: assetProperties, in: currency)
        }
    
    private static func valueString(from properties: Asset.Properties,
                                    in currency: Currency) -> String {
        properties.balance.in(currency).value.decimalString()
    }
    
    // MARK: - Asset
    
    var isLoss: Bool { asset.properties.isLoss }
    private let asset: Asset
}
