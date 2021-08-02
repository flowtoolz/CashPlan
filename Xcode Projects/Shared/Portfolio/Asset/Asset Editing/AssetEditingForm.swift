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
                    TextField("", text: $state.name)
                        .multilineTextAlignment(.trailing)
                }
                NavigationLink(destination: CurrencyPicker(title: "Asset Currency",
                                                           subtitle: "How the Asset is Priced and Traded",
                                                           selectedCurrency: $state.currency,
                                                           isBeingPresented: $isPresentingCurrencyPicker),
                               isActive: $isPresentingCurrencyPicker) {
                    HStack {
                        Label {
                            Text("Currency")
                                .fixedSize(horizontal: true, vertical: false)
                        } icon: {
                            CurrencyView(currency: state.currency)
                        }
                        Spacer()
                        Text(state.currency.name)
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
                    TextField("", text: $state.currentPriceString)
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
                    TextField("", text: $state.amountString)
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
                    TextField("", text: $state.buyingPriceString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    @Binding private(set) var state: AssetEditingState
}
