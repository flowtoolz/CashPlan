import SwiftUI
import Combine
import SwiftyToolz

@main
struct TrademateApp: App {
    
    init() {
        Portfolio.shared.resetAssets(with: AssetPersister.load())
        
        // TODO: observe each asset ...
        // persist assets whenever the array changes
        observations += Portfolio.shared.$assets.sink(receiveValue: AssetPersister.save)
    }
    
    private var observations = [AnyCancellable]()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                log("app went to background")
            case .inactive:
                log("app became inactive")
                AssetPersister.save(Portfolio.shared.assets)
            case .active:
                log("app became active")
            @unknown default:
                log(error: "unknown scene phase")
            }
        }
    }
    
    @Environment(\.scenePhase) private var scenePhase
}
