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
                NavigationLink(destination: Text("Portfolio"),
                               tag: Tab.portfolio,
                               selection: $selectedTab) {
                    Label("Portfolio", systemImage: "chart.pie")
                }
                NavigationLink(destination: Text("Watchlist"),
                               tag: Tab.watchlist,
                               selection: $selectedTab) {
                    Label("Watchlist", systemImage: "star")
                }
                NavigationLink(destination: Text("Notifications"),
                               tag: Tab.notifications,
                               selection: $selectedTab) {
                    Label("Notifications", systemImage: "bell")
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
