import SwiftUIToolz
import SwiftUI
import Combine

struct AssetEditingView: View {
    
    init(_ viewModel: AssetEditingViewModel) {
        self.viewModel = viewModel
        _title = State(wrappedValue: viewModel.defaultTitle)
    }
    
    var body: some View {
        AssetEditingForm(viewModel: viewModel.formModel)
            .navigationTitle(title)
            .bind($title, to: viewModel.title)
    }
    
    @State private var title: String
    
    private let viewModel: AssetEditingViewModel
}

class AssetEditingViewModel {
    
    init(_ asset: Asset) {
        self.formModel = AssetEditingFormModel(.init(asset)) { committedState in
            committedState.writeValidInputs(to: asset)
        }
    }
    
    lazy var title = formModel.name
    var defaultTitle: String { formModel.editingState.name }
    
    let formModel: AssetEditingFormModel
}
