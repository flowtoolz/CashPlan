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
            .navigationBarItems(trailing: Button {
                isPresentingCurrencyPicker = true
            } label: {
                CurrencyView(currency: currency)
            })
        }
        .sheet(isPresented: $isPresentingCurrencyPicker) {
            NavigationView {
                CurrencyPicker(title: "My Currency",
                               subtitle: "For Cash Values and Metrics",
                               selectedCurrency: $currency,
                               isBeingPresented: $isPresentingCurrencyPicker)
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
