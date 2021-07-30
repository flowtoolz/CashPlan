import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: AssetList()) {
                    Label {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(Portfolio.shared.positions.count) Assets")
                                    .font(.body.weight(.medium))
                                Spacer()
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text("Profit / Loss")
                                Spacer()
                                Text(Portfolio.shared.returnPercentageString)
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(Portfolio.shared.isAtALoss ? .red : .green)
                            }
                            .foregroundColor(Portfolio.shared.isAtALoss ? .red : .green)
                            HStack(alignment: .firstTextBaseline) {
                                Text("Balance")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(Portfolio.shared.valueDisplayString)
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            //                            HStack(alignment: .firstTextBaseline) {
                            //                                Text("Cash Flow")
                            //                                Spacer()
                            //
                            //                                    Text("+" + (Portfolio.shared.value * cashflow.input.monthProfitFactor).decimalString(fractionDigits: 0))
                            //                                        .font(.system(.title2, design: .monospaced))
                            //                            }
                            //                            .foregroundColor(.green)
                        }
                    } icon: {
                        Image(systemName: "chart.pie")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    }
                }
                NavigationLink(destination: FutureVisionView()) {
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
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isPresentingCurrencySelector = true
                    } label: {
                        Image(systemName: Portfolio.shared.currency.symbolName)
                    }
                    .sheet(isPresented: $isPresentingCurrencySelector) {
                        NavigationView {
                            CurrencyPicker(subtitle: "In Which the Portfolio is Displayed",
                                           selectedCurrency: $portfolio.currency,
                                           isBeingPresented: $isPresentingCurrencySelector)
                        }
                    }
                }
            }
        }
    }
    
    @State private var isPresentingCurrencySelector = false
    @ObservedObject private var cashflow = FutureVision.shared
    @ObservedObject private(set) var portfolio = Portfolio.shared
}
