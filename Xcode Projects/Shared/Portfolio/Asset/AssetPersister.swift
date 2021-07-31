import Foundation
import SwiftyToolz

struct AssetPersister {
    static func save(_ assets: [Asset]) {
        guard let recordsData = assets.map({ AssetRecord($0) }).encode() else {
            return log(error: "couldn't encode position records")
        }
        
        UserDefaults.standard.set(recordsData, forKey: assetsKey)
    }
    
    static func load() -> [Asset] {
        guard let data = UserDefaults.standard.data(forKey: assetsKey) else {
            return []
        }
        
        guard let records = [AssetRecord](data) else {
            log(error: "could not decode asset records")
            return []
        }
        
        return records.map { $0.asset }
    }
    
    private static let assetsKey = "positionsDataKey"
}

private extension AssetRecord {
    var asset: Asset {
        Asset(id: id,
              name: name,
              amount: amount,
              currency: currency,
              buyingPrice: buyingPrice,
              currentPrice: currentPrice)
    }
    
    init(_ asset: Asset) {
        id = asset.id
        name = asset.name
        amount = asset.amount
        currency = asset.currency
        buyingPrice = asset.buyingPrice
        currentPrice = asset.currentPrice
    }
}

private struct AssetRecord: Codable {
    let id: UUID
    let name: String
    let amount: Int
    let currency: Currency
    let buyingPrice: Double
    let currentPrice: Double
}
