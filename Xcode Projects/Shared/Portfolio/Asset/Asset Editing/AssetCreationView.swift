import SwiftUI
import SwiftyToolz

struct AssetCreationView: View {
    
    var body: some View {
        AssetEditingForm(state: $viewModel.editingState)
            .navigationTitle("New Asset")
            .navigationBarItems(trailing: Button {
                if viewModel.addAssetIfStateIsValid() {
                    isBeingPresented = false
                }
            } label: {
                Text("Add")
            })
    }
    
    @Binding private(set) var isBeingPresented: Bool
    @StateObject private var viewModel = AssetCreationViewModel()
}

class AssetCreationViewModel: ObservableObject {
    
    func addAssetIfStateIsValid() -> Bool {
        guard let newAsset = editingState.asset else { return false }
        Portfolio.shared.assets += newAsset
        // TODO: it's the portfolio's or the view model's responsibility to sort this ...
        Portfolio.shared.assets.sort()
        return true
        
    }
    
    @Published var editingState = AssetEditingState()
}
