import Combine
import SwiftObserver
import SwiftyToolz

class AssetListRowModel {
    
    // MARK: - Life Cycle
    
    init(_ asset: Asset) { self.asset = asset }
    
    // MARK: - Publishers
    
    lazy private(set) var assetName = asset.properties
        .new()
        .map { $0.name }
        .publisher()
    
    lazy private(set) var profitPercentageString = asset.properties
        .new()
        .map { (properties: Asset.Properties) -> String in
            guard properties.buyingPrice > 0 else {
                return properties.currentPrice > 0 ? "100%" : "0%"
            }
            let percentage = ((properties.currentPrice / properties.buyingPrice) - 1.0) * 100.0
            return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
        }
        .publisher()
    
    lazy var valueString = asset.properties
        .new()
        .publisher()
        .combineLatest(AppSettings.shared.$currency)
        .map { assetProperties, currency in
            assetProperties.value(in: currency).decimalString()
        }
    
    // MARK: - Asset
    
    var isLoss: Bool { asset.properties.value.isLoss }
    private let asset: Asset
}
