import SwiftUI
import SwiftyToolz

struct AssetList: View {
    var body: some View {
        List {
            ForEach(portfolio.assets) { asset in
                AssetListRow(viewModel: AssetListRowModel(asset))
            }
            .onDelete(perform: delete)

            Button {
                isPresentingAssetCreationForm = true
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Asset")
                }
                .foregroundColor(.accentColor)
            }
            .sheet(isPresented: $isPresentingAssetCreationForm) {
                NavigationStack {
                    AssetCreationView(
                        viewModel: AssetCreationViewModel(action: { newAsset in
                            DispatchQueue.main.async {
                                Portfolio.shared.add(newAsset)
                            }
                        }),
                        isPresentingAssetCreationForm: $isPresentingAssetCreationForm
                    )
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Assets")
        .toolbar {
            Button {
                isPresentingCurrencyPicker = true
            } label: {
                CurrencyView(currency: currency)
            }
        }
        .bind($currency, to: AppSettings.shared.$currency.new())
//        .refreshable {
//            print("✅ REFRESH Asset List")
//        }
    }
    
    private func delete(at offsets: IndexSet) {
        portfolio.removeAsset(at: offsets)
    }
    
    @State private var currency = AppSettings.shared.currency
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    
    @State private var isPresentingAssetCreationForm = false
    
    @ObservedObject private(set) var portfolio = Portfolio.shared
}
