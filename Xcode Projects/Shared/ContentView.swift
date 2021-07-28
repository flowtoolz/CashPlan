import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Portfolio")) {
                    NavigationLink(destination: PortfolioSimulatorView()) {
                        HStack(alignment: .center) {
                            Image(systemName: "chart.pie")
                                .font(.largeTitle.weight(.thin))
                                .foregroundColor(.accentColor)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("\(Portfolio.shared.positions.count) Positions")
                                    Spacer()
                                    Text(Portfolio.shared.valueDisplayString)
                                        .font(.system(.body, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }
                                HStack {
                                    Text(Portfolio.shared.returnPercentageString)
                                        .foregroundColor(Portfolio.shared.isAtALoss ? .red : .green)
                                    Spacer()
                                    Text(Portfolio.shared.profitDisplayString)
                                        .font(.system(.body, design: .monospaced))
                                        .foregroundColor(Portfolio.shared.isAtALoss ? .red : .green)
                                }
                            }
                        }
                    }
                }
                Section(header: Text("\(cashflow.input.years) Year Vision")) {
                    NavigationLink(destination: CashflowCalculatorView()) {
                        HStack(alignment: .center) {
                            Image(systemName: "face.smiling")
                                .font(.largeTitle.weight(.thin))
                                .foregroundColor(.accentColor)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Cash")
                                    Spacer()
                                    Text(cashflow.output.cash.decimalString(fractionDigits: 0))
                                        .font(.system(.body, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }
                                HStack {
                                    Text("Cashflow")
                                    Spacer()
                                    // TODO: add plus sign
                                    Text(cashflow.output.cashflow.decimalString())
                                        .font(.system(.body, design: .monospaced))
                                }
                                .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tools")
            .listStyle(GroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        print("❗️select currency")
                    } label: {
                        Image(systemName: Portfolio.shared.currency.symbolName)
                    }
                }
            }
        }
    }
    
    @ObservedObject private var cashflow = CashFlow.shared
}

struct LabelImage: View {
    var body: some View {
        ZStack(alignment: .center) {
            Image(systemName: "rectangle").hidden()
            Image(systemName: "rectangle.portrait").hidden()
            Image(systemName: systemName)
        }
    }
    
    let systemName: String
}


