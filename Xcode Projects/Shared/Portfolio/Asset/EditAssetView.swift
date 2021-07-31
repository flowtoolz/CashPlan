import SwiftUI
import SwiftyToolz

struct EditPositionView: View {
    
    init(_ position: Asset) {
        self.position = position
        let initialInput = PositionInput(positionName: position.name,
                                         amountString: "\(position.amount)",
                                         currency: position.currency,
                                         buyingPriceString: "\(position.buyingPrice)",
                                         currentPriceString: "\(position.currentPrice)")
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
                    TextField("", text: $input.positionName)
                        .multilineTextAlignment(.trailing)
                }
                NavigationLink(destination: CurrencyPicker(title: assetCurrencyTitle,
                                                           subtitle: assetCurrencySubtitle,
                                                           selectedCurrency: $input.currency,
                                                           isBeingPresented: $isPresentingCurrencySelector),
                               isActive: $isPresentingCurrencySelector) {
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
        .listStyle(GroupedListStyle())
        .navigationTitle(input.positionName)
        .onChange(of: input) { _ in
            updatePositionIfInputIsValid()
        }
    }
    
    @State private var isPresentingCurrencySelector = false
    
    private func updatePositionIfInputIsValid() {
        guard !input.positionName.isEmpty,
              let amount = integer(from: input.amountString),
              let buyingPrice = double(from: input.buyingPriceString),
              let currentPrice = double(from: input.currentPriceString) else { return }
        
        position.name = input.positionName
        position.amount = amount
        position.currency = input.currency
        position.buyingPrice = buyingPrice
        position.currentPrice = currentPrice
        
        Portfolio.shared.assets.sort()
    }
    
    @State private var input: PositionInput
    private let position: Asset
    
    struct PositionInput: Equatable {
        var positionName: String
        var amountString: String
        var currency: Currency
        var buyingPriceString: String
        var currentPriceString: String
    }
}

struct AddPositionView: View {
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Asset")) {
                    HStack {
                        Label {
                            Text("Name:")
                                .foregroundColor(.secondary)
                        } icon: {
                            Image(systemName: "building.2")
                        }
                        TextField("", text: $positionName)
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
            //            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveAndCloseIfInputIsValid()
                    } label: {
                        Text("Add")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isBeingPresented = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    @State private var isPresentingCurrencySelector = false
    
    private func saveAndCloseIfInputIsValid() {
        guard !positionName.isEmpty,
              let amount = integer(from: amountString),
              let buyingPrice = double(from: buyingPriceString),
              let currentPrice = double(from: currentPriceString) else { return }
        
        let newPosition = Asset(name: positionName,
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
    @State private var positionName: String = ""
    @State private var amountString: String = ""
    @State private var buyingPriceString: String = ""
    @State private var currentPriceString: String = ""
}

let assetCurrencyTitle = "Asset Currency"
let assetCurrencySubtitle = "In Which this Asset is Priced and Traded"
