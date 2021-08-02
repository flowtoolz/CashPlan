import Combine
import SwiftObserver
import SwiftyToolz

class AssetListRowModel: ObservableObject, Observer {
    init(asset: Asset) {
        self.asset = asset
        
        observe(asset) { [weak self] event in
            switch event {
            case .propertiesDidChange: self?.objectWillChange.send()
            }
        }
        
        observations += AppSettings.shared.$currency.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    private var observations = [AnyCancellable]()
    
    var isLoss: Bool { asset.isLoss }
    
    var assetName: String { asset.name }
    
    var profitPercentageDisplayString: String {
        let percentage = ((asset.currentPrice / asset.buyingPrice) - 1.0) * 100.0
        return (percentage > 0 ? "+" : "") + percentage.decimalString() + "%"
    }
    
    var profitDisplayString: String {
        let p = asset.profit(in: displayCurrency)
        return (p > 0 ? "+" : "") + p.decimalString()
    }
    
    var valueDisplayString: String {
        asset.value(in: displayCurrency).decimalString()
    }
    
    private var displayCurrency: Currency { AppSettings.shared.currency }
    
    private let asset: Asset
    
    let receiver = Receiver()
}
