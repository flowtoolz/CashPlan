import SwiftUIToolz
import SwiftUI
import SwiftyToolz

struct AssetCreationView: View {
    
    init(action: @escaping (Asset) -> Void) {
        viewModel = AssetCreationViewModel(action: action)
    }
    
    var body: some View {
        AssetEditingForm(viewModel: viewModel.formModel)
            .navigationTitle(title)
            .navigationBarItems(trailing: Button {
                viewModel.addButtonWasTapped()
            } label: {
                Text(AssetCreationViewModel.addButtonTitle)
            })
            .bind($title, to: viewModel.title)
    }
    
    @State private var title = AssetCreationViewModel.defaultTitle
    
    private let viewModel: AssetCreationViewModel
}

class AssetCreationViewModel {
    
    init(action: @escaping (Asset) -> Void) {
        self.action = action
    }
    
    func addButtonWasTapped() {
        formModel.editingState.asset.forSome(action)
    }
    
    static let addButtonTitle = "Add"
    
    lazy var title = formModel.$editingState
        .map { $0.name }
        .map { $0.isEmpty ? Self.defaultTitle : $0 }
    
    static let defaultTitle = "New Asset"
    
    let formModel = AssetEditingFormModel()
    private let action: (Asset) -> Void
}
