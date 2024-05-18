import SwiftUI

struct AssetEditingForm: View {
    
    var body: some View {
        Form {
            Section(header: Text("Asset")) {
                HStack {
                    Label("Name", systemImage: "building.2")
                    TextField("", text: $viewModel.editingState.name)
                        .multilineTextAlignment(.trailing)
                }
                
                NavigationLink {
                    CurrencyPicker(title: "Asset Currency",
                                   subtitle: "How the Asset is Priced and Traded",
                                   selectedCurrency: $viewModel.editingState.currency)
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
                    TextField("", text: $viewModel.editingState.priceString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
            Section(header: Text("My Position")) {
                HStack {
                    Label("Quantity", systemImage: "number")
                    TextField("", text: $viewModel.editingState.amountString)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
                HStack {
                    Label("Open Price", systemImage: "arrow.down.left")
                    TextField("", text: $viewModel.editingState.openingPriceString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
        }
    }
    
    @ObservedObject private(set) var viewModel: AssetEditingFormModel
}

class AssetEditingFormModel: ObservableObject {
    
    init(_ editingState: AssetEditingState = AssetEditingState()) {
        self.editingState = editingState
    }
    
    lazy var name = $editingState.map { $0.name }
    
    @Published var editingState: AssetEditingState
}
