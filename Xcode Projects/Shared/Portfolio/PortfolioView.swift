import SwiftUIToolz
import SwiftUI

struct PortfolioView: View {
    
    var body: some View {
        NavigationView {
            List {
                PlainNavigationLink(destination: AssetList(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)) {
                    AssetsOverView()
                }
                PlainNavigationLink(destination: FutureVisionView(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)) {
                    FutureVisionOverView()
                }
            }
            .navigationTitle("Portfolio")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isPresentingCurrencyPicker = true
                    } label: {
                        CurrencyView(currency: settings.currency)
                    }
                }
            }
        }
        .popover(isPresented: $isPresentingCurrencyPicker) {
            NavigationView {
                CurrencyPicker(title: "My Currency",
                               subtitle: "For Cash Values and Metrics",
                               selectedCurrency: $settings.currency,
                               isBeingPresented: $isPresentingCurrencyPicker)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                isPresentingCurrencyPicker = false
                            } label: {
                                Text("Cancel")
                            }
                        }
                    }
            }
            .accentColor(.trademateAccent(for: colorScheme))
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    @ObservedObject private(set) var settings = AppSettings.shared
}
