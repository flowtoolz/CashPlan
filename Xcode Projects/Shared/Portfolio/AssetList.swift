import SwiftUI

struct AssetList: View {
    var body: some View {
        List {
            ForEach(portfolio.assets) { position in
                AssetListRow(displayCurrency: $settings.currency,
                             asset: position)
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
                AssetCreationView(isBeingPresented: $isPresentingAddPositionView)
            }
        }
        .navigationTitle("Assets")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isPresentingCurrencyPicker = true
                } label: {
                    Image(systemName: settings.currency.symbolName)
                }
            }
        }
    }
    
    private func  delete(at offsets: IndexSet) {
        portfolio.assets.remove(atOffsets: offsets)
    }
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    @State private var isPresentingAddPositionView = false
    @ObservedObject private(set) var portfolio = Portfolio.shared
    @ObservedObject private(set) var settings = AppSettings.shared
}

let userCurrencyTitle = "My Currency"
let userCurrencySubtitle = "Display Cash Balances and Metrics In"
