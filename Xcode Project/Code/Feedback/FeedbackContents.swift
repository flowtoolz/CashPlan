import SwiftUI

struct FeatureLabels: View {
    var body: some View {
        Label {
            VStack(alignment: .leading) {
                Text("Detailed Custom Alerts")
                Text("Via tags, markets, metrics etc.")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image(systemName: "bell")
                .foregroundColor(.accentColor)
        }
        
        Label {
            VStack(alignment: .leading) {
                Text("Metrics for Charts and Alerts")
                Text("Like volume, RSI and SMA")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image(systemName: "waveform.path.ecg")
                .foregroundColor(.accentColor)
        }
        
        Label {
            VStack(alignment: .leading) {
                Text("Ticker Watchlists")
                Text("Tag-based, price targets etc.")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image(systemName: "list.star")
                .foregroundColor(.accentColor)
        }
        
        Label {
            VStack(alignment: .leading) {
                Text("Charts (obviously)")
                Text("Including unconventional types")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image("chart.xyaxis.line")
                .foregroundColor(.accentColor)
        }
        
        Label {
            VStack(alignment: .leading) {
                Text("Intelligent Alerts")
                Text("Deep learning on historic data")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image("brain")
                .foregroundColor(.accentColor)
        }
        
        Label {
            VStack(alignment: .leading) {
                Text("Test Custom Buy/Sell Signals")
                Text("Performance on historic data")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image("testtube.2")
                .foregroundColor(.accentColor)
        }
        
        Label {
            VStack(alignment: .leading) {
                Text("3 Performance Measures")
                Text("Profitability, continuity, passivity")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image(systemName: "chart.bar")
                .foregroundColor(.accentColor)
        }
        
        Label {
            VStack(alignment: .leading) {
                Text("Sync iOS and macOS")
                Text("Portfolio, tags etc. in iCloud")
                    .foregroundColor(.secondary)
            }
        } icon: {
            Image(systemName: "icloud")
                .foregroundColor(.accentColor)
        }
    }
}

struct FeedbackLink: View {
    
    var body: some View {
        Group {
            if let email = URL(string: "mailto:" + emailAddress) {
                Link(destination: email) {
                    Label("Send a Feedback Email", systemImage: "envelope")
                        .foregroundColor(.accentColor)
                }
            } else {
                Label("Send Feedback to " + emailAddress,
                      systemImage: "envelope")
            }
        }
    }
    
    private let emailAddress = "hello@codeface.io"
}
