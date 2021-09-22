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
                viewModel.addButtonWasTapped { shouldDismiss in
                    if shouldDismiss { dismiss() }
                }
            } label: {
                Text(AssetCreationViewModel.addButtonTitle)
            })
            .bind($title, to: viewModel.title)
            .refreshable {
                print("✅ REFRESH New Asset")
            }
    }
    
    @State private var title = AssetCreationViewModel.defaultTitle
    
    private let viewModel: AssetCreationViewModel
    
    // programmatic dismissal
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
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
