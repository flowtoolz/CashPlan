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
            .listStyle(PlainListStyle())
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
            NavigationView {
                CurrencyPicker(title: "My Currency",
                               subtitle: "For Cash Values and Metrics",
                               selectedCurrency: $currency)
                    .navigationBarItems(leading: Button {
                        isPresentingCurrencyPicker = false
                    } label: {
                        Text("Cancel")
                    })
            }
        }
        .onChange(of: currency) { newCurrency in
            AppSettings.shared.currency = newCurrency
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    @State private var currency = AppSettings.shared.currency
}
