import SwiftUIToolz
import SwiftUI
import SwiftyToolz

struct AssetList: View {
    var body: some View {
        List {
            ForEach(portfolio.assets) { asset in
                PlainNavigationLink(destination: AssetEditingView(.init(asset))) {
                    AssetListRow(viewModel: AssetListRowModel(asset))
                }
            }
            .onDelete(perform: delete)

            NavigationLink(destination: assetCreationView,
                           isActive: $isPresentingAssetCreationView) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Asset")
                }
                .foregroundColor(.accentColor)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Assets")
        .navigationBarItems(trailing: Button {
            isPresentingCurrencyPicker = true
        } label: {
            CurrencyView(currency: currency)
        })
        .bind($currency, to: AppSettings.shared.$currency.new())
    }
    
    private var assetCreationView: some View {
        AssetCreationView { newAsset in
            isPresentingAssetCreationView = false
            Portfolio.shared.add(newAsset)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        portfolio.removeAsset(at: offsets)
    }
    
    @State private var isPresentingAssetCreationView = false
    @State private var currency = AppSettings.shared.currency
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    
    @ObservedObject private(set) var portfolio = Portfolio.shared
}
