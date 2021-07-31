import SwiftUI

struct HomeView: View {
    var body: some View {
        
        TabView {
            NavigationView {
                List {
                    PlainNavigationLink(destination: AssetList(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)) {
                        Label {
                            VStack(alignment: .leading) {
                                HStack(alignment: .firstTextBaseline) {
                                    Text("\(portfolio.assets.count) Assets")
                                        .font(.body.weight(.medium))
                                    Spacer()
                                    NavigationChevron()
                                }
                                HStack(alignment: .firstTextBaseline) {
                                    Text("Profit / Loss")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(portfolio.returnPercentageString)
                                        .font(.system(.title2, design: .monospaced))
                                        .foregroundColor(portfolio.isAtALoss ? trademateRed : trademateGreen)
                                }
                                HStack(alignment: .firstTextBaseline) {
                                    Text("Balance")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(portfolio.valueDisplayString)
                                        .font(.system(.title2, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }
                            }
                        } icon: {
                            Image(systemName: "building.2")
                                .imageScale(.large)
                        }
                    }
                    
                    /*
                     PlainNavigationLink(destination: Text("Alerts")) {
                     Label {
                     VStack(alignment: .leading) {
                     HStack(alignment: .firstTextBaseline) {
                     Text("Alerts")
                     .font(.body.weight(.medium))
                     Spacer()
                     NavigationChevron()
                     }
                     Group {
                     HStack {
                     Text("Unread")
                     Spacer()
                     Text("10")
                     .font(.system(.title2, design: .monospaced))
                     .foregroundColor(.secondary)
                     }
                     HStack {
                     Text("Total")
                     Spacer()
                     Text("123")
                     .font(.system(.title2, design: .monospaced))
                     .foregroundColor(.secondary)
                     }
                     }
                     .foregroundColor(.secondary)
                     }
                     } icon: {
                     Image(systemName: "message")
                     .imageScale(.large)
                     }
                     }
                     */
                    
                    PlainNavigationLink(destination: FutureVisionView(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)) {
                        Label {
                            VStack(alignment: .leading) {
                                HStack(alignment: .firstTextBaseline) {
                                    Text("\(futureVision.input.years) Year Target")
                                        .font(.body.weight(.medium))
                                    Spacer()
                                    NavigationChevron()
                                }
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
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("+" + futureVision.output.cashflow.decimalString(fractionDigits: 0))
                                        .font(.system(.title2, design: .monospaced))
                                        .foregroundColor(trademateGreen)
                                }
                            }
                        } icon: {
                            Image(systemName: "target")
                                .imageScale(.large)
                        }
                    }
                }
                .navigationTitle("Portfolio")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isPresentingCurrencyPicker = true
                        } label: {
                            CurrencyView(currency: settings.currency)
                        }
                    }
                }
            }
            .popover(isPresented: $isPresentingCurrencyPicker) {
                NavigationView {
                    CurrencyPicker(title: userCurrencyTitle,
                                   subtitle: userCurrencySubtitle,
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
                .accentColor(trademateAccentColor)
            }
            .tabItem {
                Image(systemName: "chart.pie.fill")
                Text("Portfolio")
            }
            Text("Watchlist")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Watchlist")
                }
            Text("Alerts")
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Alerts")
                }
        }
    }
    
    @State private var isPresentingCurrencyPicker = false
    
    @ObservedObject private var futureVision = FutureVision.shared
    @ObservedObject private(set) var portfolio = Portfolio.shared
    @ObservedObject private(set) var settings = AppSettings.shared
}
