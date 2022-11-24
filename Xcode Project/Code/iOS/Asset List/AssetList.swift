import SwiftUIToolzOLD
import SwiftUI
import SwiftyToolz

struct AssetList: View {
    var body: some View {
        List {
            ForEach(portfolio.assets) { asset in
                AssetListRow(viewModel: AssetListRowModel(asset))
            }
            .onDelete(perform: delete)

            NavigationLink(destination: assetCreationView) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Asset")
                }
                .foregroundColor(.accentColor)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Assets")
        .toolbar {
            Button {
                isPresentingCurrencyPicker = true
            } label: {
                CurrencyView(currency: currency)
            }
        }
        .bind($currency, to: AppSettings.shared.$currency.new())
        .refreshable {
            print("✅ REFRESH Asset List")
        }
    }
    
    private var assetCreationView: some View {
        AssetCreationView { newAsset in
            DispatchQueue.main.async {
                Portfolio.shared.add(newAsset)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        portfolio.removeAsset(at: offsets)
    }
    
    @State private var currency = AppSettings.shared.currency
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    
    @ObservedObject private(set) var portfolio = Portfolio.shared
}
