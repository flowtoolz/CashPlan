import SwiftUI
import SwiftyToolz

@main
struct CashPlanApp: App {
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
                Portfolio.shared.persistPositions()
                Portfolio.shared.persistCurrency()
            case .active:
                log("app became active")
            @unknown default:
                log(error: "unknown scene phase")
            }
        }
    }
    
    @Environment(\.scenePhase) private var scenePhase
}
