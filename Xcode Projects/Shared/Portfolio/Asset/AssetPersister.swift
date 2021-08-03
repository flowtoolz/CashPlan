import Foundation
import SwiftyToolz

struct AssetPersister {
    static func save(_ assets: [Asset]) {
        guard let assetsData = assets.encode() else {
            return log(error: "couldn't encode position records")
        }
        
        UserDefaults.standard.set(assetsData, forKey: assetsKey)
    }
    
    static func load() -> [Asset] {
        guard let assetsData = UserDefaults.standard.data(forKey: assetsKey) else {
            return []
        }
        
        guard let assets = [Asset](assetsData) else {
            log(error: "could not decode assets")
            return []
        }
        
        return assets
    }
    
    private static let assetsKey = "positionsDataKey"
}
