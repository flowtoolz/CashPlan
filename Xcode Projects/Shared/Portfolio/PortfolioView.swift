import SwiftUIToolz
import SwiftUI
import SwiftObserver

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
                        CurrencyView(currency: currency)
                    }
                }
            }
        }
        .popover(isPresented: $isPresentingCurrencyPicker) {
            NavigationView {
                CurrencyPicker(title: "My Currency",
                               subtitle: "For Cash Values and Metrics",
                               selectedCurrency: $currency,
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
        .onChange(of: currency) { newCurrency in
            AppSettings.shared.currency <- newCurrency
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var currency = AppSettings.shared.currency.value
}
