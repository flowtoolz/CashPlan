import SwiftObserver

/// Create editing state from asset and vice versa
extension AssetEditingState {
    
    init(_ asset: Asset) {
        let assetProperties = asset.properties.value
        name = assetProperties.name
        amountString = "\(assetProperties.amount)"
        currency = assetProperties.currency
        openingPriceString = "\(assetProperties.openingPrice)"
        priceString = "\(assetProperties.price)"
    }
    
    var asset: Asset? {
        guard !name.isEmpty,
              let amount = integer(from: amountString),
              let openingPrice = double(from: openingPriceString),
              let price = double(from: priceString) else {
            return nil
        }
        
        return .init(properties: .init(name: name,
                                       openingPrice: openingPrice,
                                       currency: currency,
                                       amount: amount,
                                       price: price))
    }
    
    func writeValidInputs(to asset: Asset) {
        var newProperties = asset.properties.value
        
        newProperties.currency = currency
        
        if !name.isEmpty {
            newProperties.name = name
        }
        
        if let amount = integer(from: amountString) {
            newProperties.amount = amount
        }
        
        if let buyingPrice = double(from: openingPriceString) {
            newProperties.openingPrice = buyingPrice
        }
        
        if let currentPrice = double(from: priceString) {
            newProperties.price = currentPrice
        }
        
        asset.properties <- newProperties
    }
}

struct AssetEditingState: Equatable {
    var name = ""
    var amountString = ""
    var currency = Currency.usDollar
    var openingPriceString = ""
    var priceString = ""
}
