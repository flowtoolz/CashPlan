import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: PortfolioSimulatorView()) {
                    HStack(alignment: .center) {
                        Image(systemName: "chart.pie")
                            .font(.largeTitle.weight(.thin))
                            .foregroundColor(.accentColor)
                        VStack(alignment: .leading) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("\(Portfolio.shared.positions.count) Positions")
                                    .fontWeight(.medium)
                                Spacer()
                                Text(Portfolio.shared.valueDisplayString)
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text(Portfolio.shared.returnPercentageString)
                                    .foregroundColor(Portfolio.shared.isAtALoss ? .red : .green)
                                Spacer()
                                Text(Portfolio.shared.profitDisplayString)
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(Portfolio.shared.isAtALoss ? .red : .green)
                            }
                        }
                    }
                }
                NavigationLink(destination: CashflowCalculatorView()) {
                    HStack(alignment: .center) {
                        Image(systemName: "face.smiling")
                            .font(.largeTitle.weight(.thin))
                            .foregroundColor(.accentColor)
                        VStack(alignment: .leading) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("\(cashflow.input.years) Year Vision")
                                    .fontWeight(.medium)
                                Spacer()
                                Text(cashflow.output.cash.decimalString(fractionDigits: 0))
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text("Cashflow")
                                Spacer()
                                Text("+" + cashflow.output.cashflow.decimalString(fractionDigits: 0))
                                    .font(.system(.title2, design: .monospaced))
                            }
                            .foregroundColor(.green)
                        }
                    }
                }
            }
            .navigationTitle("Portfolio")
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


