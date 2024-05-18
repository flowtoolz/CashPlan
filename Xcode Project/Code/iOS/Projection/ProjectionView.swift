import SwiftUI

struct ProjectionView: View {
    var body: some View {
        Form {
            Section(header: Text("Portfolio in " + makeYearsString() + " years")) {
                HStack(alignment: .firstTextBaseline) {
                    Label("Balance", systemImage: "banknote")
                    Spacer()
                    Text(cashString)
                        .foregroundStyle(.secondary)
                        .font(.system(.body, design: .monospaced))
                }
                HStack(alignment: .firstTextBaseline) {
                    Label("Monthly Return", systemImage: "calendar.badge.plus")
                    Spacer()
                    Text(cashflowString)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.systemGreen)
                }
            }
            Section(header: Text("Assumptions")) {
                HStack {
                    Label {
                        Text("Years")
                            .fixedSize(horizontal: true, vertical: false)
                    } icon: {
                        Image(systemName: "hourglass")
                    }
                    TextField("", text: $inputStrings.yearsString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
                HStack {
                    Label {
                        Text("Annual Return")
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
                        Text("Monthly Investment")
                            .fixedSize(horizontal: true, vertical: false)
                    } icon: {
                        Image(systemName: "calendar.badge.minus")
                    }
                    TextField("", text: $inputStrings.monthlyInvestmentString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                }
            }
        }
        .navigationTitle(Text(makeYearsString() + " Year Target"))
        .toolbar {
            Button {
                isPresentingCurrencyPicker = true
            } label: {
                CurrencyView(currency: currency)
            }
        }
        .onChange(of: inputStrings) { _, newInputStrings in
            projection.input = newInputStrings.projectionInput
        }
        .bind($currency, to: AppSettings.shared.$currency.new())
//        .refreshable {
//            print("✅ REFRESH Target")
//        }
    }
    
    private func makeYearsString() -> String {
        projection.input.investmentAssumption.years.displayText
    }
    
    @State private var inputStrings = ProjectionInputStrings(Projection.shared.input)
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    @State private var currency = AppSettings.shared.currency
    
    private var cashString: String { projection.output.cash.decimalString(fractionDigits: 0) }
    private var cashflowString: String {
        "+" + projection.output.cashflow.decimalString(fractionDigits: 0)
    }
    
    @ObservedObject private var projection = Projection.shared
}

private func integerString(fromDoubleString doubleString: String) -> String {
    String(double(from: doubleString))
}

private struct ProjectionInputStrings: Equatable {
    init(_ input: Projection.Input) {
        startCashString = input.startCash.decimalString(separator: "")
        monthlyInvestmentString = String(input.investmentAssumption.monthlyInvestment)
        growthPercentString = String(input.investmentAssumption.annualReturnPercent)
        yearsString = String(input.investmentAssumption.years)
    }
    
    var projectionInput: Projection.Input {
        let growthPerYearInPercent = double(from: growthPercentString)
        let startCapital = double(from: startCashString)
        let investmentPerMonth = double(from: monthlyInvestmentString)
        let years = double(from: yearsString)
        
        return .init(startCash: startCapital,
                     investmentAssumption: .init(monthlyInvestment: investmentPerMonth,
                                                 annualReturnPercent: growthPerYearInPercent,
                                                 years: years))
    }
    
    var startCashString: String
    var monthlyInvestmentString: String
    var growthPercentString: String
    var yearsString: String
}
