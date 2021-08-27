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
        TabView {
            PortfolioView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Portfolio")
                }
            Text("Watchlist")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Watchlist")
                }
            AlertsView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                }
        }
        .accentColor(.trademateAccent(for: colorScheme))
        
    }
    
    @Environment(\.colorScheme) private var colorScheme
}