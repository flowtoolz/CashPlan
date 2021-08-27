import Combine
import SwiftObserver
import SwiftyToolz

class AssetListRowModel {
    
    // MARK: - Life Cycle
    
    init(_ asset: Asset) { self.asset = asset }
    
    // MARK: - Properties
    
    lazy var assetName = asset.$properties
        .new()
        .map { $0.name }
        .publisher()
    
    lazy var profitPercentageString = asset.$properties
        .new()
        .map { (properties) -> String in
            guard let percentage = properties.profitPercentage else { return "" }
            return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
        }
        .publisher()
    
    lazy var balanceNumericalValueString = asset.$properties
        .new()
        .publisher()
        .combineLatest(AppSettings.shared.$currency.new().publisher())
        .map { properties, currency in
            properties.balance.in(currency).numericalValue.decimalString()
        }
    
    // MARK: - Asset
    
    var isLoss: Bool { asset.properties.isLoss }
    private let asset: Asset
}
