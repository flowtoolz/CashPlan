import SwiftUIToolz
import SwiftUI

struct AssetList: View {
    var body: some View {
        List {
            ForEach(portfolio.assets) { asset in
                PlainNavigationLink(destination: AssetEditingView(asset)) {
                    AssetListRow(viewModel: AssetListRowModel(asset))
                }
            }
            .onDelete(perform: delete)

            NavigationLink(destination: AssetCreationView(isBeingPresented: $isPresentingAddPositionView),
                           isActive: $isPresentingAddPositionView) {
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
    }
    
    private func delete(at offsets: IndexSet) {
        portfolio.assets.remove(atOffsets: offsets)
    }
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    @State private var isPresentingAddPositionView = false
    @ObservedObject private(set) var portfolio = Portfolio.shared
    @ObservedObject private(set) var settings = AppSettings.shared
}
