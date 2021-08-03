import SwiftUI
import SwiftyToolz

struct AssetCreationView: View {
    
    var body: some View {
        AssetEditingForm(viewModel: viewModel.formModel)
            .navigationTitle(title)
            .navigationBarItems(trailing: Button {
                if viewModel.addAssetIfStateIsValid() {
                    isBeingPresented = false
                }
            } label: {
                Text("Add")
            })
            .bind($title, to: viewModel.title)
    }
    
    @State private var title = AssetCreationViewModel.defaultTitle
    
    @Binding private(set) var isBeingPresented: Bool
    
    private let viewModel = AssetCreationViewModel()
}

class AssetCreationViewModel {
    
    func addAssetIfStateIsValid() -> Bool {
        guard let newAsset = formModel.editingState.asset else { return false }
        Portfolio.shared.assets += newAsset
        // TODO: it's the portfolio's or the view model's responsibility to sort this ...
        Portfolio.shared.assets.sort()
        return true
    }
    
    lazy var title = formModel.$editingState
        .map { $0.name }
        .map { $0.isEmpty ? Self.defaultTitle : $0 }
    
    static let defaultTitle = "New Asset"
    
    let formModel = AssetEditingFormModel()
}
