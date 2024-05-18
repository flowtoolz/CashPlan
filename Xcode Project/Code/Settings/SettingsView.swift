import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Overall Display Currency") {
                    NavigationLink {
                        CurrencyPicker(title: "My Currency",
                                       subtitle: "For Cash Values and Metrics",
                                       selectedCurrency: $currency)
                    } label: {
                        HStack {
                            Label {
                                Text("My Currency")
                            } icon: {
                                CurrencyView(currency: currency)
                            }
                            Spacer()
                            Text(currency.name)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onChange(of: currency) { _, newCurrency in
                        AppSettings.shared.currency = newCurrency
                    }
                }
                
                Section("We'd love to hear your ideas") {
                    NavigationLink {
                        List {
                            Section("This app is at the earliest stage 🚀") {
                                FeatureLabels()
                            }
                        }
                        .navigationTitle("Ideas")
                    } label: {
                        Label("See Some Feature Ideas", systemImage: "lightbulb")
                    }
                    
                    FeedbackLink()
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    @State private var currency = AppSettings.shared.currency
}
