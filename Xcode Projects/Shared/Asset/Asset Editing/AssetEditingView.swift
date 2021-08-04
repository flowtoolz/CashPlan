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
        self.asset = asset
        self.formModel = AssetEditingFormModel(.init(asset))
        
        formObservation = formModel.$editingState.sink { [weak self] newState in
            guard let self = self,
                  newState != self.formModel.editingState else { return }
            newState.writeValidInputs(to: asset)
        }
    }
    
    lazy var title = formModel.$editingState.map { $0.name }
    var defaultTitle: String { formModel.editingState.name }
    
    private var formObservation: AnyCancellable?
    let formModel: AssetEditingFormModel
    
    private let asset: Asset
}
