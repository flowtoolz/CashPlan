import SwiftUI

struct FutureVisionView: View {
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Portfolio in \(inputStrings.yearsString) years")) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .firstTextBaseline) {
                            Label("Balance", systemImage: "banknote")
                                .fixedSize(horizontal: true, vertical: false)
                                .accentColor(.secondary)
                            Spacer()
                            Text(cashString)
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        HStack(alignment: .firstTextBaseline) {
                            Label {
                                Text("Cash Flow")
                            } icon: {
                                Image(systemName: "calendar.badge.plus")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(cashflowString)
                                    .font(.system(.body, design: .monospaced))
                                    .foregroundColor(.trademateGreen)
                                Text("per month")
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                            }
                        }
                    }.padding([.top, .bottom], 6)
                }
                Section(header: Text("Trading Target")) {
                    HStack {
                        Label {
                            Text("Monthly Investment:")
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: true, vertical: false)
                        } icon: {
                            Image(systemName: "calendar.badge.minus")
                        }
                        TextField("", text: $inputStrings.monthlyInvestmentString)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(.body, design: .monospaced))
                    }
                    HStack {
                        Label {
                            Text("Annual Return:")
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: true, vertical: false)
                        } icon: {
                            Image(systemName: "percent")
                        }
                        
                        TextField("", text: $inputStrings.growthPercentString)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(.body, design: .monospaced))
                    }
                    HStack {
                        Label {
                            Text("Years:")
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: true, vertical: false)
                        } icon: {
                            Image(systemName: "hourglass")
                        }
                        TextField("", text: $inputStrings.yearsString)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(.body, design: .monospaced))
                    }
                }
            }
        }
        .navigationTitle("Target")
        .navigationBarItems(trailing: Button {
            isPresentingCurrencyPicker = true
        } label: {
            CurrencyView(currency: currency)
        })
        .onChange(of: inputStrings) { inputStrings in
            inputStrings.input.forSome {
                cashflow.input = $0
            }
        }
        .bind($currency, to: AppSettings.shared.$currency.new())
    }
    
    @State private var inputStrings = CashFlowInputStrings(FutureVision.shared.input)
    
    private struct CashFlowInputStrings: Equatable {
        init(_ input: FutureVision.Input) {
            startCashString = input.startCash.decimalString(separator: "")
            monthlyInvestmentString = String(input.monthlyInvestment)
            growthPercentString = String(input.annualReturnPercent)
            yearsString = String(input.years)
        }
        
        var input: FutureVision.Input? {
            guard let growthPerYearInPercent = double(from: growthPercentString),
                  let startCapital = double(from: startCashString),
                  let investmentPerMonth = double(from: monthlyInvestmentString),
                  let years = integer(from: yearsString) else {
                return nil
            }
            
            return .init(startCash: startCapital,
                         monthlyInvestment: investmentPerMonth,
                         annualReturnPercent: growthPerYearInPercent,
                         years: years)
        }
        
        var startCashString: String
        var monthlyInvestmentString: String
        var growthPercentString: String
        var yearsString: String
    }
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    @State private var currency = AppSettings.shared.currency
    
    private var cashString: String { cashflow.output.cash.decimalString(fractionDigits: 0) }
    private var cashflowString: String {
        "+" + cashflow.output.cashflow.decimalString(fractionDigits: 0)
    }
    
    @ObservedObject private var cashflow = FutureVision.shared
}
