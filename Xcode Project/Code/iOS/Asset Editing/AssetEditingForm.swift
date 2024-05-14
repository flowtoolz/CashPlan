import SwiftUI

struct AssetEditingForm: View {
    
    var body: some View {
        Form {
            Section(header: Text("Asset")) {
                HStack {
                    Label("Name", systemImage: "building.2")
                    TextField("",
                              text: $viewModel.editingState.name,
                              onEditingChanged: { if !$0 { viewModel.commit() } })
                        .multilineTextAlignment(.trailing)
                }
                
                // TODO: close (pop?) currency selector using latest navigation types
                NavigationLink {
                    CurrencyPicker(title: "Asset Currency",
                                   subtitle: "How the Asset is Priced and Traded",
                                   selectedCurrency: $viewModel.editingState.currency,
                                   isBeingPresented: $isPresentingCurrencyPicker)
                } label: {
                    HStack {
                        Label {
                            Text("Currency")
                        } icon: {
                            CurrencyView(currency: viewModel.editingState.currency)
                        }
                        Spacer()
                        Text(viewModel.editingState.currency.name)
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    Label("Current Price", systemImage: "arrow.up.right")
                    TextField("",
                              text: $viewModel.editingState.priceString,
                              onEditingChanged: { if !$0 { viewModel.commit() } })
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
            Section(header: Text("My Position")) {
                HStack {
                    Label("Quantity", systemImage: "number")
                    TextField("",
                              text: $viewModel.editingState.amountString,
                              onEditingChanged: { if !$0 { viewModel.commit() } })
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
                HStack {
                    Label("Open Price", systemImage: "arrow.down.left")
                    TextField("",
                              text: $viewModel.editingState.openingPriceString,
                              onEditingChanged: { if !$0 { viewModel.commit() } })
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    @ObservedObject private(set) var viewModel: AssetEditingFormModel
}

class AssetEditingFormModel: ObservableObject {
    
    init(_ editingState: AssetEditingState = AssetEditingState(),
         handleCommit: @escaping (AssetEditingState) -> Void = { _ in }) {
        self.editingState = editingState
        self.handleCommit = handleCommit
    }
    
    func commit() { handleCommit(editingState) }
    
    private let handleCommit: (AssetEditingState) -> Void
    
    lazy var name = $editingState.map { $0.name }
    
    @Published var editingState: AssetEditingState
}
