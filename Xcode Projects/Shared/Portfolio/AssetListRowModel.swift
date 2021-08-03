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
        .map { $0.profitPercentage }
        .map { (profitPercentage: Double?) -> String in
            guard let percentage = profitPercentage else { return "" }
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
