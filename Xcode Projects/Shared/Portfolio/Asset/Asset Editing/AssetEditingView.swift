import SwiftUI
import Combine
import SwiftyToolz

struct AssetEditingView: View {
    
    init(_ asset: Asset) {
        _viewModel = StateObject(wrappedValue: AssetEditingViewModel(asset))
    }
    
    var body: some View {
        AssetEditingForm(state: $viewModel.editingState)
            .navigationTitle(viewModel.editingState.name)
    }
    
    @StateObject private var viewModel: AssetEditingViewModel
}

class AssetEditingViewModel: ObservableObject {
    
    init(_ asset: Asset) {
        self.asset = asset
        editingState = AssetEditingState(asset)
        
        observations += $editingState.sink { newState in
            newState.writeValidInputs(to: asset)
            // TODO: it's the portfolio's or the view model's responsibility to observe assets and resort them ...
            Portfolio.shared.assets.sort()
        }
    }
    
    private var observations = [AnyCancellable]()
    @Published var editingState: AssetEditingState
    
    private let asset: Asset
}
