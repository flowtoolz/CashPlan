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
        .navigationTitle("Assets")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isPresentingCurrencyPicker = true
                } label: {
                    CurrencyView(currency: settings.currency)
                }
            }
        }
        .onAppear {
            // TODO: it's the portfolio's or the view model's responsibility to observe assets and resort them ...
            Portfolio.shared.assets.sort()
        }
    }
    
    private var assetCreationView: some View {
        AssetCreationView { newAsset in
            isPresentingAssetCreationView = false
            Portfolio.shared.assets += newAsset
        }
    }
    
    private func delete(at offsets: IndexSet) {
        portfolio.assets.remove(atOffsets: offsets)
    }
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    @State private var isPresentingAssetCreationView = false
    @ObservedObject private(set) var portfolio = Portfolio.shared
    @ObservedObject private(set) var settings = AppSettings.shared
}
