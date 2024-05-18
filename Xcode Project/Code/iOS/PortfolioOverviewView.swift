import SwiftUIToolzOLD
import SwiftUI
import SwiftObserver

struct PortfolioOverviewView: View {
    
    var body: some View {
        NavigationStack {
            List {
                AssetsOverView(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)
                
                ProjectionOverView(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)
            }
            .navigationTitle("Portfolio")
            .toolbar {
                Button {
                    isPresentingCurrencyPicker = true
                } label: {
                    CurrencyView(currency: currency)
                }
            }
        }
        .sheet(isPresented: $isPresentingCurrencyPicker) {
            NavigationStack {
                CurrencyPicker(title: "My Currency",
                               subtitle: "For Cash Values and Metrics",
                               selectedCurrency: $currency)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingCurrencyPicker = false
                        }
                    }
                }
            }
        }
        .onChange(of: currency) { _, newCurrency in
            AppSettings.shared.currency = newCurrency
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    @State private var currency = AppSettings.shared.currency
}
