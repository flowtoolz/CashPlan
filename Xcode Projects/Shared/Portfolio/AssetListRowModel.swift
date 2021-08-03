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
            let percentage = ((properties.currentPrice / properties.buyingPrice) - 1.0) * 100.0
            return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
        }
        .publisher()
    
    lazy var profitString = asset.properties
        .new()
        .publisher()
        .combineLatest(AppSettings.shared.$currency)
        .map { (assetProperties: Asset.Properties, currency: Currency) -> String in
            let profit = assetProperties.profit(in: currency)
            return (profit > 0 ? "+" : "") + profit.decimalString()
        }
    
    lazy var valueString = asset.properties
        .new()
        .publisher()
        .combineLatest(AppSettings.shared.$currency)
        .map { (assetProperties: Asset.Properties, currency: Currency) -> String in
            assetProperties.value(in: currency).decimalString()
        }
    
    // MARK: - Asset
    
    var isLoss: Bool { asset.properties.value.isLoss }
    private let asset: Asset
}
