import SwiftUI
import FoundationToolz
import CombineObserver
import SwiftObserver
import SwiftyToolz

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Text("Assets"),
                               tag: Tab.portfolio,
                               selection: $selectedTab) {
                    Label("Assets", systemImage: "building.2")
                }
                NavigationLink(destination: Text("Target"),
                               tag: Tab.watchlist,
                               selection: $selectedTab) {
                    Label("Target", systemImage: "target")
                }
                NavigationLink(destination: FeedbackView(),
                               tag: Tab.notifications,
                               selection: $selectedTab) {
                    Label("Feedback", systemImage: "bubble.left")
                }
            }
            .listStyle(SidebarListStyle())
            .toolbar {
                ToolbarItem {
                    Button {
                        NSApp.keyWindow?.firstResponder?.tryToPerform(
                            #selector(NSSplitViewController.toggleSidebar),
                            with: nil
                        )
                    } label: {
                        Label("Toggle Sidebar", systemImage: "sidebar.left")
                    }
                }
            }
        }
    }
    
    @State private var selectedTab: Tab? = .portfolio
    
    enum Tab {
        case portfolio
        case watchlist
        case notifications
    }
}
