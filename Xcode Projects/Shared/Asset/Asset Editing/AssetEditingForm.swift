import SwiftUI

struct AssetEditingForm: View {
    
    var body: some View {
        Form {
            Section(header: Text("Asset")) {
                HStack {
                    Label {
                        Text("Name:")
                            .foregroundColor(.secondary)
                    } icon: {
                        Image(systemName: "building.2")
                    }
                    TextField("", text: $viewModel.editingState.name)
                        .multilineTextAlignment(.trailing)
                }
                NavigationLink(destination: CurrencyPicker(title: "Asset Currency",
                                                           subtitle: "How the Asset is Priced and Traded",
                                                           selectedCurrency: $viewModel.editingState.currency,
                                                           isBeingPresented: $isPresentingCurrencyPicker),
                               isActive: $isPresentingCurrencyPicker) {
                    HStack {
                        Label {
                            Text("Currency")
                                .fixedSize(horizontal: true, vertical: false)
                        } icon: {
                            CurrencyView(currency: viewModel.editingState.currency)
                        }
                        Spacer()
                        Text(viewModel.editingState.currency.name)
                            .foregroundColor(.secondary)
                    }
                }
                HStack {
                    Label {
                        Text("Current Price:")
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: true, vertical: false)
                    } icon: {
                        Image(systemName: "arrow.up.right")
                    }
                    TextField("", text: $viewModel.editingState.priceString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
            Section(header: Text("My Position")) {
                HStack {
                    Label {
                        Text("Amount:")
                            .foregroundColor(.secondary)
                    } icon: {
                        Image(systemName: "number")
                    }
                    TextField("", text: $viewModel.editingState.amountString)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
                HStack {
                    Label {
                        Text("Opening Price:")
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: true, vertical: false)
                    } icon: {
                        Image(systemName: "arrow.down.left")
                    }
                    TextField("", text: $viewModel.editingState.openingPriceString)
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
    init(_ editingState: AssetEditingState = AssetEditingState()) {
        self.editingState = editingState
    }
    
    @Published var editingState = AssetEditingState()
}
