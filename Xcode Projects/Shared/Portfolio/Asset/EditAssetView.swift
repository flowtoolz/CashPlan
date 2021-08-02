import SwiftUI
import SwiftyToolz

struct AssetEditingView: View {
    
    init(_ asset: Asset) {
        self.asset = asset
        let initialInput = AssetEditingState(name: asset.name,
                                      amountString: "\(asset.amount)",
                                      currency: asset.currency,
                                      buyingPriceString: "\(asset.buyingPrice)",
                                      currentPriceString: "\(asset.currentPrice)")
        _input = State(wrappedValue: initialInput)
    }
    
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
                    TextField("", text: $input.name)
                        .multilineTextAlignment(.trailing)
                }
                NavigationLink(destination: CurrencyPicker(title: assetCurrencyTitle,
                                                           subtitle: assetCurrencySubtitle,
                                                           selectedCurrency: $input.currency,
                                                           isBeingPresented: $isPresentingCurrencyPicker),
                               isActive: $isPresentingCurrencyPicker) {
                    HStack {
                        Label {
                            Text("Currency")
                                .fixedSize(horizontal: true, vertical: false)
                        } icon: {
                            CurrencyView(currency: input.currency)
                        }
                        Spacer()
                        Text(input.currency.name)
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
                    TextField("", text: $input.currentPriceString)
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
                    TextField("", text: $input.amountString)
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
                    TextField("", text: $input.buyingPriceString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
        }
        .navigationTitle(input.name)
        .onChange(of: input) { _ in
            updateAssetIfInputIsValid()
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    
    private func updateAssetIfInputIsValid() {
        guard !input.name.isEmpty,
              let amount = integer(from: input.amountString),
              let buyingPrice = double(from: input.buyingPriceString),
              let currentPrice = double(from: input.currentPriceString) else { return }
        
        asset.name = input.name
        asset.amount = amount
        asset.currency = input.currency
        asset.buyingPrice = buyingPrice
        asset.currentPrice = currentPrice
        
        Portfolio.shared.assets.sort()
    }
    
    @State private var input: AssetEditingState
    private let asset: Asset
}

struct AssetCreationView: View {
    
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
                    TextField("", text: $editingState.name)
                        .multilineTextAlignment(.trailing)
                }
                NavigationLink(destination: CurrencyPicker(title: assetCurrencyTitle,
                                                           subtitle: assetCurrencySubtitle,
                                                           selectedCurrency: $editingState.currency,
                                                           isBeingPresented: $isPresentingCurrencySelector),
                               isActive: $isPresentingCurrencySelector) {
                    HStack {
                        Label {
                            Text("Currency")
                                .fixedSize(horizontal: true, vertical: false)
                        } icon: {
                            CurrencyView(currency: editingState.currency)
                        }
                        Spacer()
                        Text(editingState.currency.name)
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
                    TextField("", text: $editingState.currentPriceString)
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
                    TextField("", text: $editingState.amountString)
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
                    TextField("", text: $editingState.buyingPriceString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
        }
        .navigationTitle("New Asset")
        .navigationBarItems(trailing: Button {
            saveAndCloseIfInputIsValid()
        } label: {
            Text("Add")
        })
    }
    
    @State private var isPresentingCurrencySelector = false
    
    private func saveAndCloseIfInputIsValid() {
        guard !editingState.name.isEmpty,
              let amount = integer(from: editingState.amountString),
              let buyingPrice = double(from: editingState.buyingPriceString),
              let currentPrice = double(from: editingState.currentPriceString) else { return }
        
        let newPosition = Asset(name: editingState.name,
                                amount: amount,
                                currency: editingState.currency,
                                buyingPrice: buyingPrice,
                                currentPrice: currentPrice)
        
        Portfolio.shared.assets += newPosition
        Portfolio.shared.assets.sort()
        isBeingPresented = false
    }
    
    @Binding private(set) var isBeingPresented: Bool
    
    @State private var editingState = AssetEditingState()
}

let assetCurrencyTitle = "Asset Currency"
let assetCurrencySubtitle = "How the Asset is Priced and Traded"

struct AssetEditingState: Equatable {
    var name = ""
    var amountString = ""
    var currency = Currency.usDollar
    var buyingPriceString = ""
    var currentPriceString = ""
}
