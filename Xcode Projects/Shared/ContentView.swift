import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: PortfolioSimulatorView()) {
                    Label {
                        VStack(alignment: .leading) {
                            HStack {
                            Text("\(Portfolio.shared.positions.count) Assets")
                                .font(.body.weight(.medium))
                                Spacer()
                                Text(Portfolio.shared.returnPercentageString)
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(Portfolio.shared.isAtALoss ? .red : .green)
                            }
//                            HStack(alignment: .firstTextBaseline) {
//                                Text("Profit / Loss")
//                                Spacer()
//
//                            }
//                            .foregroundColor(Portfolio.shared.isAtALoss ? .red : .green)
                            HStack(alignment: .firstTextBaseline) {
                                Text("Balance")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(Portfolio.shared.valueDisplayString)
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text("Cash Flow")
                                Spacer()
                                
                                    Text("+" + (Portfolio.shared.value * cashflow.input.monthProfitFactor).decimalString(fractionDigits: 0))
                                        .font(.system(.title2, design: .monospaced))
                            }
                            .foregroundColor(.green)
                        }
                    } icon: {
                        Image(systemName: "chart.pie")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    }
                }
                NavigationLink(destination: CashflowCalculatorView()) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("\(cashflow.input.years) Year Vision")
                                .font(.body.weight(.medium))
                            HStack(alignment: .firstTextBaseline) {
                                Text("Balance")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(cashflow.output.cash.decimalString(fractionDigits: 0))
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text("Cash Flow")
                                Spacer()
                                Text("+" + cashflow.output.cashflow.decimalString(fractionDigits: 0))
                                    .font(.system(.title2, design: .monospaced))
                            }
                            .foregroundColor(.green)
                        }
                    } icon: {
                        Image(systemName: "face.smiling")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    }
                }
            }
//            .listStyle(InsetGroupedListStyle())
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


