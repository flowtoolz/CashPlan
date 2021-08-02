import SwiftUI

struct AssetEditingView: View {
    
    init(_ asset: Asset) {
        self.asset = asset
        _state = State(wrappedValue: AssetEditingState(asset))
    }
    
    var body: some View {
        AssetEditingForm(state: $state)
            .navigationTitle(state.name)
            .onChange(of: state) { _ in
                state.writeValidInputs(to: asset)
                // TODO: it's the portfolio's or the view model's responsibility to observe assets and resort them ...
                Portfolio.shared.assets.sort()
            }
    }
    
    @State private var state: AssetEditingState
    private let asset: Asset
}
