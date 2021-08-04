/// Create editing state from asset and vice versa
extension AssetEditingState {
    
    init(_ asset: Asset) {
        name = asset.properties.name
        amountString = "\(asset.properties.amount)"
        currency = asset.properties.currency
        buyingPriceString = "\(asset.properties.openingPrice)"
        currentPriceString = "\(asset.properties.price)"
    }
    
    var asset: Asset? {
        guard !name.isEmpty,
              let amount = integer(from: amountString),
              let openingPrice = double(from: buyingPriceString),
              let price = double(from: currentPriceString) else {
            return nil
        }
        
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
        
        if let amount = integer(from: amountString) {
            asset.properties.amount = amount
        }
        
        if let buyingPrice = double(from: buyingPriceString) {
            asset.properties.openingPrice = buyingPrice
        }
        
        if let currentPrice = double(from: currentPriceString) {
            asset.properties.price = currentPrice
        }
    }
}

struct AssetEditingState: Equatable {
    var name = ""
    var amountString = ""
    var currency = Currency.usDollar
    var buyingPriceString = ""
    var currentPriceString = ""
}
