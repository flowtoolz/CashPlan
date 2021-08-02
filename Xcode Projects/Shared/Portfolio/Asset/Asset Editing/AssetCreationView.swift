import SwiftUI
import SwiftyToolz

struct AssetCreationView: View {
    
    var body: some View {
        AssetEditingForm(state: $editingState)
            .navigationTitle("New Asset")
            .navigationBarItems(trailing: Button {
                saveAndCloseIfInputIsValid()
            } label: {
                Text("Add")
            })
    }
    
    private func saveAndCloseIfInputIsValid() {
        guard let newAsset = editingState.asset else { return }
        Portfolio.shared.assets += newAsset
        // TODO: it's the portfolio's or the view model's responsibility to sort this ...
        Portfolio.shared.assets.sort()
        isBeingPresented = false
    }
    
    @Binding private(set) var isBeingPresented: Bool
    
    @State private var editingState = AssetEditingState()
}
