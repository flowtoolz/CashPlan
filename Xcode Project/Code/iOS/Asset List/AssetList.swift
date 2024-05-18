import SwiftUI
import SwiftyToolz

struct AssetList: View {
    var body: some View {
        List {
            ForEach(portfolio.assets) { asset in
                AssetListRow(viewModel: AssetListRowModel(asset))
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
        .navigationTitle("Assets")
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isPresentingAssetCreationForm = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
//        .refreshable {
//            print("✅ REFRESH Asset List")
//        }
    }
    
    private func delete(at offsets: IndexSet) {
        portfolio.removeAsset(at: offsets)
    }
    
    @State private var isPresentingAssetCreationForm = false
    
    @ObservedObject private(set) var portfolio = Portfolio.shared
}
