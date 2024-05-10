import SwiftObserver

/// Create editing state from asset and vice versa
extension AssetEditingState {
    
    init(_ asset: Asset) {
        self.init(name: asset.properties.name,
                  amountString: "\(asset.properties.amount)",
                  currency: asset.properties.currency,
                  openingPriceString: "\(asset.properties.openingPrice)",
                  priceString: "\(asset.properties.price)")
    }
    
    var asset: Asset? {
        guard !name.isEmpty else { return nil }
        
        let amount = integer(from: amountString)
        let openingPrice = double(from: openingPriceString)
        let price = double(from: priceString)
        
        return .init(properties: .init(name: name,
                                       openingPrice: openingPrice,
                                       currency: currency,
                                       amount: amount,
                                       price: price))
    }
    
    func writeValidInputs(to asset: Asset) {
        asset.properties.currency = currency
        
        if !name.isEmpty {
            asset.properties.name = name
        }
        
        asset.properties.amount = integer(from: amountString)
        asset.properties.openingPrice = double(from: openingPriceString)
        asset.properties.price = double(from: priceString)
    }
}

struct AssetEditingState: Equatable {
    var name = ""
    var amountString = ""
    var currency = AppSettings.shared.currency
    var openingPriceString = ""
    var priceString = ""
}
