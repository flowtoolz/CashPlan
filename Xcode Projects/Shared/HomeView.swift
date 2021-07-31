import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: AssetList(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)) {
                    Label {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(portfolio.assets.count) Assets")
                                    .font(.body.weight(.medium))
                                Spacer()
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text("Profit / Loss")
                                Spacer()
                                Text(portfolio.returnPercentageString)
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(portfolio.isAtALoss ? .red : .green)
                            }
                            .foregroundColor(portfolio.isAtALoss ? .red : .green)
                            HStack(alignment: .firstTextBaseline) {
                                Text("Balance")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(portfolio.valueDisplayString)
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
                NavigationLink(destination: FutureVisionView(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)) {
                    Label {
                        VStack(alignment: .leading) {
                            Text("\(futureVision.input.years) Year Vision")
                                .font(.body.weight(.medium))
                            HStack(alignment: .firstTextBaseline) {
                                Text("Balance")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(futureVision.output.cash.decimalString(fractionDigits: 0))
                                    .font(.system(.title2, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text("Cash Flow")
                                Spacer()
                                Text("+" + futureVision.output.cashflow.decimalString(fractionDigits: 0))
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
                        isPresentingCurrencyPicker = true
                    } label: {
                        Image(systemName: settings.currency.symbolName)
                    }
                }
            }
        }
        .popover(isPresented: $isPresentingCurrencyPicker) {
            NavigationView {
                CurrencyPicker(title: appCurrencyTitle,
                               subtitle: appCurrencySubtitle,
                               selectedCurrency: $settings.currency,
                               isBeingPresented: $isPresentingCurrencyPicker)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                isPresentingCurrencyPicker = false
                            } label: {
                                Text("Cancel")
                            }
                        }
                    }
            }
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    
    @ObservedObject private var futureVision = FutureVision.shared
    @ObservedObject private(set) var portfolio = Portfolio.shared
    @ObservedObject private(set) var settings = AppSettings.shared
}
