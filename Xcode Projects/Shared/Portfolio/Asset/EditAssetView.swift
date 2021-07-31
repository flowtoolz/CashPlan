import SwiftUI
import SwiftyToolz

struct AssetEditingView: View {
    
    init(_ asset: Asset) {
        self.asset = asset
        let initialInput = AssetInput(name: asset.name,
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
                        Label("Currency", systemImage: input.currency.symbolName)
                            .fixedSize(horizontal: true, vertical: false)
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
    
    @State private var input: AssetInput
    private let asset: Asset
    
    struct AssetInput: Equatable {
        var name: String
        var amountString: String
        var currency: Currency
        var buyingPriceString: String
        var currentPriceString: String
    }
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
                    TextField("", text: $name)
                        .multilineTextAlignment(.trailing)
                }
                NavigationLink(destination: CurrencyPicker(title: assetCurrencyTitle,
                                                           subtitle: assetCurrencySubtitle,
                                                           selectedCurrency: $currency,
                                                           isBeingPresented: $isPresentingCurrencySelector),
                               isActive: $isPresentingCurrencySelector) {
                    HStack {
                        Label("Currency", systemImage: currency.symbolName)
                            .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                        Text(currency.name)
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
                    TextField("", text: $currentPriceString)
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
                    TextField("", text: $amountString)
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
                    TextField("", text: $buyingPriceString)
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
        guard !name.isEmpty,
              let amount = integer(from: amountString),
              let buyingPrice = double(from: buyingPriceString),
              let currentPrice = double(from: currentPriceString) else { return }
        
        let newPosition = Asset(name: name,
                                amount: amount,
                                currency: currency,
                                buyingPrice: buyingPrice,
                                currentPrice: currentPrice)
        
        Portfolio.shared.assets += newPosition
        Portfolio.shared.assets.sort()
        isBeingPresented = false
    }
    
    @Binding private(set) var isBeingPresented: Bool
    
    @State private var currency = Currency.usDollar
    @State private var name: String = ""
    @State private var amountString: String = ""
    @State private var buyingPriceString: String = ""
    @State private var currentPriceString: String = ""
}

let assetCurrencyTitle = "Asset Currency"
let assetCurrencySubtitle = "How the Asset is Priced and Traded"
