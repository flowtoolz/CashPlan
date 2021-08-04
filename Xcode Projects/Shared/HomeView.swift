import SwiftUI

struct HomeView: View {
    
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
                    Image(systemName: "message.fill")
                    Text("Alerts")
                }
        }
        .accentColor(.trademateAccent(for: colorScheme))
        
    }
    
    @Environment(\.colorScheme) private var colorScheme
}
