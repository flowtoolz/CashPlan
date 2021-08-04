import Combine
import SwiftObserver
import SwiftyToolz

class AssetListRowModel {
    
    // MARK: - Life Cycle
    
    init(_ asset: Asset) { self.asset = asset }
    
    // MARK: - Publishers
    
    lazy private(set) var assetName = asset
        .map { $0.name }
        .publisher()
    
    lazy private(set) var profitPercentageString = asset
        .map { $0.profitPercentage }
        .map { (profitPercentage: Double?) -> String in
            guard let percentage = profitPercentage else { return "" }
            return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
        }
        .publisher()
    
    lazy var valueString = asset
        .publisher()
        .combineLatest(AppSettings.shared.$currency)
        .map { assetProperties, currency in
            assetProperties.balance.in(currency).value.decimalString()
        }
    
    // MARK: - Asset
    
    var isLoss: Bool { asset.properties.isLoss }
    private let asset: Asset
}
