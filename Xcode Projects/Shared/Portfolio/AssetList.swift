import SwiftUI

struct AssetList: View {
    var body: some View {
        List {
            ForEach(portfolio.assets) { position in
                AssetListRow(displayCurrency: $currencyProvider.currency,
                             position: position)
            }
            .onDelete(perform: delete)
            Button {
                isPresentingAddPositionView = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Asset")
                    Spacer()
                }
            }
            .foregroundColor(.accentColor)
            .popover(isPresented: $isPresentingAddPositionView) {
                AddPositionView(isBeingPresented: $isPresentingAddPositionView)
            }
        }
        .navigationTitle("Assets")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isPresentingCurrencySelector = true
                } label: {
                    Image(systemName: currencyProvider.currency.symbolName)
                }
            }
        }
        .popover(isPresented: $isPresentingCurrencySelector) {
            NavigationView {
                CurrencyPicker(title: appCurrencyTitle,
                               subtitle: appCurrencySubtitle,
                               selectedCurrency: $currencyProvider.currency,
                               isBeingPresented: $isPresentingCurrencySelector)
            }
        }
    }
    
    private func  delete(at offsets: IndexSet) {
        portfolio.assets.remove(atOffsets: offsets)
    }
    
    @State private var isPresentingCurrencySelector = false
    @State private var isPresentingAddPositionView = false
    @ObservedObject private(set) var portfolio = Portfolio.shared
    @ObservedObject private(set) var currencyProvider = AppSettings.shared
}

let appCurrencyTitle = "App Currency"
let appCurrencySubtitle = "To Display All Cash Values and Metrics"
