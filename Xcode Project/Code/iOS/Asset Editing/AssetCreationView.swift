import SwiftUI
import SwiftyToolz

struct AssetCreationView: View {
    
    var body: some View {
        AssetEditingForm(viewModel: viewModel.formModel)
            .navigationTitle(title)
            .toolbar {
                Button(AssetCreationViewModel.addButtonTitle) {
                    viewModel.addButtonWasTapped { shouldDismiss in
                        if shouldDismiss {
                            isPresentingAssetCreationForm = false
                        }
                    }
                }
            }
            .bind($title, to: viewModel.title)
//            .refreshable {
//                print("✅ REFRESH New Asset")
//            }
    }
    
    @State private var title = AssetCreationViewModel.defaultTitle
    @State var viewModel: AssetCreationViewModel
    @Binding var isPresentingAssetCreationForm: Bool
}

class AssetCreationViewModel {
    
    init(action: @escaping (Asset) -> Void) {
        self.action = action
    }
    
    func addButtonWasTapped(shouldDismiss: (Bool) -> Void) {
        if let asset = formModel.editingState.asset {
            action(asset)
            shouldDismiss(true)
        } else {
            shouldDismiss(false)
        }
    }
    
    static let addButtonTitle = "Add"
    
    lazy var title = formModel.name
        .map { $0.isEmpty ? Self.defaultTitle : $0 }
    
    static let defaultTitle = "New Asset"
    
    let formModel = AssetEditingFormModel()
    private let action: (Asset) -> Void
}
