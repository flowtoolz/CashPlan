import SwiftUIToolzOLD
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
//            .refreshable {
//                print("✅ REFRESH Edited Asset")
//            }
    }
    
    @State private var title: String
    @State private var viewModel: AssetEditingViewModel
}

class AssetEditingViewModel {
    
    init(_ asset: Asset) {
        self.formModel = AssetEditingFormModel(.init(asset))
        
        editingObservation = formModel.$editingState.sink { editingState in
            editingState.writeValidInputs(to: asset)
        }
    }
    
    private var editingObservation: AnyCancellable?
    
    lazy var title = formModel.name
    var defaultTitle: String { formModel.editingState.name }
    
    let formModel: AssetEditingFormModel
}
