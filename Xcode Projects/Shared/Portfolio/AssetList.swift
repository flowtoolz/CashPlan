import SwiftUI

struct AssetList: View {
    var body: some View {
        List {
            ForEach(portfolio.positions) { position in
                AssetListRow(displayCurrency: $portfolio.currency,
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
                    Image(systemName: portfolio.currency.symbolName)
                }
            }
        }
        .popover(isPresented: $isPresentingCurrencySelector) {
            NavigationView {
                CurrencyPicker(subtitle: "In Which the Portfolio is Displayed",
                               selectedCurrency: $portfolio.currency,
                               isBeingPresented: $isPresentingCurrencySelector)
            }
        }
    }
    
    private func  delete(at offsets: IndexSet) {
        portfolio.positions.remove(atOffsets: offsets)
    }
    
    @State private var isPresentingCurrencySelector = false
    @State private var isPresentingAddPositionView = false
    @ObservedObject private(set) var portfolio = Portfolio.shared
}
