import FoundationToolz
import Foundation
import SwiftyToolz

struct AssetPersister {
    
    static func save(_ assets: [Asset]) {
        guard let assetsData = assets.encode() else {
            return log(error: "couldn't encode position records")
        }
        
        storage.set(assetsData, forKey: assetArrayDataKey)
    }
    
    static func load() -> [Asset] {
        guard let assetsData = storage.data(forKey: assetArrayDataKey) else {
            return []
        }
        
        guard let assets = [Asset](assetsData) else {
            log(error: "could not decode assets")
            return []
        }
        
        return assets
    }
    
    private static var storage: UserDefaults { .standard }
    
    private static let assetArrayDataKey = "AssetArrayData"
}
