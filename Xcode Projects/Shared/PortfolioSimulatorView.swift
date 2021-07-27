import SwiftUI
import FoundationToolz
import SwiftyToolz

struct PortfolioSimulatorView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioSimulatorView()
    }
}

struct PortfolioSimulatorView: View {
    var body: some View {
        List {
            Section(header: Text("Positions")) {
                ForEach(portfolio.positions) { position in
                    PositionView(displayCurrency: $portfolio.currency,
                                 position: position)
                }
                .onDelete(perform: delete)
                Button {
                    isPresentingAddPositionView = true
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Position")
                        Spacer()
                    }
                }
                .foregroundColor(.accentColor)
                .popover(isPresented: $isPresentingAddPositionView) {
                    AddPositionView(isBeingPresented: $isPresentingAddPositionView)
                }
            }
        }
        .navigationTitle("Portfolio")
        .listStyle(GroupedListStyle())
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isPresentingCurrencySelector = true
                } label: {
                    Image(systemName: portfolio.currency.symbolName)
                }
            }
        }
        .popover(isPresented: $isPresentingCurrencySelector) {
            NavigationView {
                CurrencySelector(selectedCurrency: $portfolio.currency,
                                 isBeingPresented: $isPresentingCurrencySelector)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private func  delete(at offsets: IndexSet) {
        portfolio.positions.remove(atOffsets: offsets)
    }
    
    @State private var isPresentingCurrencySelector = false
    @State private var isPresentingAddPositionView = false
    @ObservedObject private(set) var portfolio = Portfolio.shared
}

struct PositionView: View {
    var body: some View {
        NavigationLink(destination: EditPositionView(position)) {
            VStack {
                HStack {
                    Text(position.name)
                    Spacer()
                    Text("\(position.valueDisplayString(in: displayCurrency))")
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.secondary)
                    
                }
                HStack {
                    Text(position.profitPercentageDisplayString)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(position.isLoss ? .red : .green)
                    Spacer()
                    Text(position.profitDisplayString(in: displayCurrency))
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(position.isLoss ? .red : .green)
                }
            }
        }
    }
    
    @Binding private(set) var displayCurrency: Currency
    @ObservedObject private(set) var position: Position
}

struct EditPositionView: View {
    
    init(_ position: Position) {
        self.position = position
        let initialInput = PositionInput(positionName: position.name,
                                         amountString: "\(position.amount)",
                                         currency: position.currency,
                                         buyingPriceString: "\(position.buyingPrice)",
                                         currentPriceString: "\(position.currentPrice)")
        _input = State(wrappedValue: initialInput)
    }
    
    var body: some View {
        List {
            HStack {
                Label("Asset", systemImage: "building.2")
                    .fixedSize(horizontal: true, vertical: false)
                TextField("Asset", text: $input.positionName)
                    .multilineTextAlignment(.trailing)
                    .font(.system(.body, design: .monospaced))
            }
            HStack {
                Label("Amount", systemImage: "number")
                    .fixedSize(horizontal: true, vertical: false)
                TextField("Amount", text: $input.amountString)
                    .multilineTextAlignment(.trailing)
                    .font(.system(.body, design: .monospaced))
                    .keyboardType(.numberPad)
            }
            NavigationLink(destination: CurrencySelector(selectedCurrency: $input.currency,
                                                         isBeingPresented: $isPresentingCurrencySelector),
                           isActive: $isPresentingCurrencySelector) {
                HStack {
                    Label("Currency", systemImage: input.currency.symbolName)
                        .fixedSize(horizontal: true, vertical: false)
                    Spacer()
                    Text(input.currency.symbol)
                        .font(.system(.body, design: .monospaced))
                }
            }
            HStack {
                Label("Opening Price", systemImage: "arrow.down.right")
                    .fixedSize(horizontal: true, vertical: false)
                TextField("Opening Price", text: $input.buyingPriceString)
                    .multilineTextAlignment(.trailing)
                    .font(.system(.body, design: .monospaced))
                    .keyboardType(.decimalPad)
            }
            HStack {
                Label("Current Price", systemImage: "arrow.up.right")
                    .fixedSize(horizontal: true, vertical: false)
                    .foregroundColor(.green)
                TextField("Current Price", text: $input.currentPriceString)
                    .multilineTextAlignment(.trailing)
                    .font(.system(.body, design: .monospaced))
                    .keyboardType(.decimalPad)
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
        
        Portfolio.shared.persistPositions()
    }
    
    @State private var input: PositionInput
    private let position: Position
    
    struct PositionInput: Equatable {
        var positionName: String
        var amountString: String
        var currency: Currency
        var buyingPriceString: String
        var currentPriceString: String
    }
}

struct CurrencySelector: View {
    var body: some View {
        List(Currency.all) { currency in
            Button {
                selectedCurrency = currency
                isBeingPresented = false
            } label: {
                HStack {
                    Image(systemName: currency.symbolName + (currency == selectedCurrency ? ".fill" : ""))
                        .foregroundColor(currency == selectedCurrency ? .accentColor : .primary)
                        .imageScale(.large)
                    Text(currency.name + " (" + currency.symbol + ")")
                    Spacer()
                }
            }
        }
        .navigationTitle("Currency")
    }
    
    @Binding var selectedCurrency: Currency
    @Binding var isBeingPresented: Bool
}

extension Currency {
    var symbolName: String {
        switch code {
        case "USD": return "dollarsign.circle"
        case "GBP": return "sterlingsign.circle"
        case "EUR": return "eurosign.circle"
        case "CHF": return "francsign.circle"
        case "BTC": return "bitcoinsign.circle"
        default: return "1.circle"
        }
    }
}

struct Currency: Equatable, Identifiable, Codable {
    
    var id: String { code }
    
    static let all: [Currency] = [
        bitCoin,
        britishPound,
        euro,
        swissFranc,
        usDollar
    ]
    
    static let bitCoin = Currency(code: "BTC",
                                  dollarPrice: 36861.70,
                                  symbol: "₿",
                                  name: "Bitcoin")
    
    static let usDollar = Currency(code: "USD",
                                   dollarPrice: 1.0,
                                   symbol: "$",
                                   name: "US Dollar")
    
    static let euro = Currency(code: "EUR",
                               dollarPrice: 1.18,
                               symbol: "€",
                               name: "Euro")
    
    static let swissFranc = Currency(code: "CHF",
                                     dollarPrice: 1.09,
                                     symbol: "CHF",
                                     name: "Swiss Franc")
    
    static let britishPound = Currency(code: "GBP",
                                       dollarPrice: 1.38,
                                       symbol: "£",
                                       name: "British Pound")
    
    let code: String
    let dollarPrice: Double
    let symbol: String
    let name: String
//    case usDollar, euro, britishPound, canadianDollar, australianDollar, swissFranc, bitCoin
}

struct AddPositionView: View {
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Label("Asset", systemImage: "building.2")
                        .fixedSize(horizontal: true, vertical: false)
                    TextField("Asset", text: $positionName)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
                HStack {
                    Label("Amount", systemImage: "number")
                        .fixedSize(horizontal: true, vertical: false)
                    TextField("Amount", text: $amountString)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
                NavigationLink(destination: CurrencySelector(selectedCurrency: $currency,
                                                             isBeingPresented: $isPresentingCurrencySelector),
                               isActive: $isPresentingCurrencySelector) {
                    HStack {
                        Label("Currency", systemImage: currency.symbolName)
                            .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                        Text(currency.symbol)
                            .font(.system(.body, design: .monospaced))
                    }
                }
                HStack {
                    Label("Opening Price", systemImage: "arrow.down.right")
                        .fixedSize(horizontal: true, vertical: false)
                    TextField("Opening Price", text: $buyingPriceString)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
                HStack {
                    Label("Current Price", systemImage: "arrow.up.right")
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundColor(.green)
                    TextField("Current Price", text: $currentPriceString)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
            .navigationTitle("Add Position")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveAndCloseIfInputIsValid()
                    } label: {
                        Text("Save")
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
        
        let newPosition = Position(name: positionName,
                                   amount: amount,
                                   currency: currency,
                                   buyingPrice: buyingPrice,
                                   currentPrice: currentPrice)
        
        Portfolio.shared.positions += newPosition
        isBeingPresented = false
    }
    
    @Binding private(set) var isBeingPresented: Bool
    
    @State private var currency = Currency.usDollar
    @State private var positionName: String = ""
    @State private var amountString: String = ""
    @State private var buyingPriceString: String = ""
    @State private var currentPriceString: String = ""
}

class Portfolio: ObservableObject {
    static let shared = Portfolio()
    private init() {}
    
    // MARK: - Metrics
    
    var returnPercentageString: String {
        String(format: "%.2f", returnPercentage) + " %"
    }
    
    var returnPercentage: Double {
        let v = value
        return ((v / (v - profit)) - 1.0) * 100.0
    }
    
    var valueDisplayString: String {
        String(format: "%.0f", value) //+ " " + currency.symbol
    }
    
    var isAtALoss: Bool { profit < 0 }
    
    var value: Double {
        positions.map { $0.value(in: currency) }.reduce(0, +)
    }
    
    var profitDisplayString: String {
        String(format: "%.0f", profit) //+ " " + currency.symbol
    }
    
    var profit: Double {
        positions.map { $0.profit(in: currency) }.reduce(0, +)
    }
    
    // MARK: - Positions
    
    @Published var positions: [Position] = loadPositions() {
        didSet { persistPositions() }
    }
    
    func persistPositions() {
        guard let recordsData = positions.map({ $0.record }).encode() else {
            return log(error: "couldn't encode position records")
        }
        UserDefaults.standard.set(recordsData, forKey: "positionsDataKey")
    }
    
    private static func loadPositions() -> [Position] {
        guard let data = UserDefaults.standard.data(forKey: "positionsDataKey") else {
            return []
        }

        guard let records = [Position.Record](data) else {
            log(error: "could not decode position records")
            return []
        }
        
        return records.map {
            Position(id: $0.id,
                     name: $0.name,
                     amount: $0.amount,
                     currency: $0.currency,
                     buyingPrice: $0.buyingPrice,
                     currentPrice: $0.currentPrice)
        }
    }
    
    // MARK: - Currency
    
    @Published var currency = loadCurrency() {
        didSet { persistCurrency() }
    }
    
    static func loadCurrency() -> Currency {
        guard let data = UserDefaults.standard.data(forKey: "portfolioCurrencyDataKey") else {
            return .usDollar
        }
        
        guard let decodedCurrency = Currency(data) else {
            log(error: "Couldn't decode portfolio currency")
            return .usDollar
        }
        
        return decodedCurrency
    }
    
    func persistCurrency() {
        guard let data = currency.encode() else {
            return log(error: "couldn't encode portfolio currency")
        }
        UserDefaults.standard.set(data, forKey: "portfolioCurrencyDataKey")
    }
}

extension Position {
    
    var profitPercentageDisplayString: String {
        let percentage = ((currentPrice / buyingPrice) - 1.0) * 100.0
        return (percentage > 0 ? "+" : "") + String(format: "%.2f", percentage) + " %"
    }
    
    func profitDisplayString(in targetCurrency: Currency) -> String {
        let p = profit(in: targetCurrency)
        return (p > 0 ? "+" : "") + String(format: "%.2f", p)
    }
    
    func valueDisplayString(in targetCurrency: Currency) -> String {
        String(format: "%.2f", value(in: targetCurrency))
    }
}

class Position: Identifiable, ObservableObject {
    internal init(id: UUID = UUID(),
                  name: String,
                  amount: Int,
                  currency: Currency,
                  buyingPrice: Double,
                  currentPrice: Double) {
        self.id = id
        self.name = name
        self.amount = amount
        self.currency = currency
        self.buyingPrice = buyingPrice
        self.currentPrice = currentPrice
    }
    
    func value(in targetCurrency: Currency) -> Double {
        guard currency.code != targetCurrency.code else { return value }
        let valueInUSDollar = value * currency.dollarPrice
        return valueInUSDollar / targetCurrency.dollarPrice
    }
    
    func profit(in targetCurrency: Currency) -> Double {
        guard currency.code != targetCurrency.code else { return profit }
        let profitInUSDollar = profit * currency.dollarPrice
        return profitInUSDollar / targetCurrency.dollarPrice
    }
    
    var profit: Double {
        (currentPrice - buyingPrice) * Double(amount)
    }
    
    var value: Double {
        currentPrice * Double(amount)
    }
    
    var buyingValue: Double {
        buyingPrice * Double(amount)
    }
    
    var isLoss: Bool {
        buyingPrice > currentPrice
    }
    
    var record: Record {
        .init(id: id,
              name: name,
              amount: amount,
              currency: currency,
              buyingPrice: buyingPrice,
              currentPrice: currentPrice)
    }
    
    struct Record: Codable {
        let id: UUID
        let name: String
        let amount: Int
        let currency: Currency
        let buyingPrice: Double
        let currentPrice: Double
    }

    private(set) var id: UUID
    @Published var name: String
    @Published var amount: Int
    @Published var currency: Currency
    @Published var buyingPrice: Double
    @Published var currentPrice: Double
}
