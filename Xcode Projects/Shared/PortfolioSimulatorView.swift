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
            ForEach(portfolio.positions) { position in
                PositionView(position: position)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Positions")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isPresentingAddPositionView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .popover(isPresented: $isPresentingAddPositionView) {
            AddPositionView(isBeingPresented: $isPresentingAddPositionView)
        }
    }
    
    private func  delete(at offsets: IndexSet) {
        portfolio.positions.remove(atOffsets: offsets)
    }
    
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
                    Text("\(position.valueDisplayString)")
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.secondary)
                    
                }
                HStack {
                    Text(position.profitPercentageDisplayString)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(position.isLoss ? .red : .green)
                    Spacer()
                    Text(position.profitDisplayString)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(position.isLoss ? .red : .green)
                }
            }
        }
    }
    
    @ObservedObject private(set) var position: Position
}

struct EditPositionView: View {
    
    init(_ position: Position) {
        self.position = position
        let initialInput = PositionInput(positionName: position.name,
                                         amountString: "\(position.amount)",
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
            }
            HStack {
                Label("Opening Price", systemImage: "arrow.down.right")
                    .fixedSize(horizontal: true, vertical: false)
                TextField("Opening Price", text: $input.buyingPriceString)
                    .multilineTextAlignment(.trailing)
                    .font(.system(.body, design: .monospaced))
            }
            HStack {
                Label("Current Price", systemImage: "arrow.up.right")
                    .fixedSize(horizontal: true, vertical: false)
                    .foregroundColor(.green)
                TextField("Current Price", text: $input.currentPriceString)
                    .multilineTextAlignment(.trailing)
                    .font(.system(.body, design: .monospaced))
            }
        }
        .navigationTitle(input.positionName)
        .onChange(of: input) { _ in
            updatePositionIfInputIsValid()
        }
    }
    
    private func updatePositionIfInputIsValid() {
        guard !input.positionName.isEmpty,
              let amount = integer(from: input.amountString),
              let buyingPrice = double(from: input.buyingPriceString),
              let currentPrice = double(from: input.currentPriceString) else { return }
        
        position.name = input.positionName
        position.amount = amount
        position.buyingPrice = buyingPrice
        position.currentPrice = currentPrice
        
        Portfolio.shared.persistPositions()
    }
    
    @State private var input: PositionInput
    private let position: Position
    
    struct PositionInput: Equatable {
        var positionName: String
        var amountString: String
        var buyingPriceString: String
        var currentPriceString: String
    }
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
    
    private func saveAndCloseIfInputIsValid() {
        guard !positionName.isEmpty,
              let amount = integer(from: amountString),
              let buyingPrice = double(from: buyingPriceString),
              let currentPrice = double(from: currentPriceString) else { return }
        
        let newPosition = Position(name: positionName,
                                   amount: amount,
                                   buyingPrice: buyingPrice,
                                   currentPrice: currentPrice)
        
        Portfolio.shared.positions += newPosition
        isBeingPresented = false
    }
    
    @Binding private(set) var isBeingPresented: Bool
    
    @State private var positionName: String = ""
    @State private var amountString: String = ""
    @State private var buyingPriceString: String = ""
    @State private var currentPriceString: String = ""
}

class Portfolio: ObservableObject {
    static let shared = Portfolio()
    private init() {}
    
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
                     buyingPrice: $0.buyingPrice,
                     currentPrice: $0.currentPrice)
        }
    }
}

extension Position {
    
    var profitPercentageDisplayString: String {
        let percentage = ((currentPrice / buyingPrice) - 1.0) * 100.0
        return (percentage > 0 ? "+" : "") + String(format: "%.2f", percentage) + " %"
    }
    
    var profitDisplayString: String {
        let p = profit
        return (p > 0 ? "+" : "") + String(format: "%.2f", p)
    }
    
    var valueDisplayString: String {
        String(format: "%.2f", value)
    }
}

class Position: Identifiable, ObservableObject {
    internal init(id: UUID = UUID(),
                  name: String,
                  amount: Int,
                  buyingPrice: Double,
                  currentPrice: Double) {
        self.id = id
        self.name = name
        self.amount = amount
        self.buyingPrice = buyingPrice
        self.currentPrice = currentPrice
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
              buyingPrice: buyingPrice,
              currentPrice: currentPrice)
    }
    
    struct Record: Codable {
        let id: UUID
        let name: String
        let amount: Int
        let buyingPrice: Double
        let currentPrice: Double
    }

    private(set) var id: UUID
    @Published var name: String
    @Published var amount: Int
    @Published var buyingPrice: Double
    @Published var currentPrice: Double
}
