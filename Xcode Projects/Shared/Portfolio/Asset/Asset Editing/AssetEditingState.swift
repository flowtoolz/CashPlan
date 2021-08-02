/// Create editing state from asset and vice versa
extension AssetEditingState {
    
    init(_ asset: Asset) {
        name = asset.name
        amountString = "\(asset.amount)"
        currency = asset.currency
        buyingPriceString = "\(asset.buyingPrice)"
        currentPriceString = "\(asset.currentPrice)"
    }
    
    var asset: Asset? {
        guard !name.isEmpty,
              let amount = integer(from: amountString),
              let buyingPrice = double(from: buyingPriceString),
              let currentPrice = double(from: currentPriceString) else {
            return nil
        }
        
        return Asset(name: name,
                     amount: amount,
                     currency: currency,
                     buyingPrice: buyingPrice,
                     currentPrice: currentPrice)
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
            asset.properties.buyingPrice = buyingPrice
        }
        
        if let currentPrice = double(from: currentPriceString) {
            asset.properties.currentPrice = currentPrice
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
