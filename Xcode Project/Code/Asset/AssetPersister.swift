import FoundationToolz
import Foundation
import SwiftyToolz

struct AssetPersister {
    
    static func save(_ assets: [Asset]) {
        guard let assetsPropertiesData = assets.map({ $0.properties }).encode() else {
            return log(error: "couldn't encode assets")
        }
        
        storage.set(assetsPropertiesData, forKey: assetArrayDataKey)
    }
    
    static func load() -> [Asset] {
        guard let assetsPropertiesData = storage.data(forKey: assetArrayDataKey) else {
            return []
        }
        
        guard let assetsProperties = [Asset.Properties](assetsPropertiesData) else {
            log(error: "could not decode assets")
            return []
        }
        
        return assetsProperties.map(Asset.init(properties:))
    }
    
    private static var storage: UserDefaults { .standard }
    
    private static let assetArrayDataKey = "AssetArrayData"
}
