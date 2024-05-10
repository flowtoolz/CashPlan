import SwiftUI

struct ProjectionView: View {
    var body: some View {
        List {
            Section(header: Text("Portfolio in " + makeYearsString() + " years")) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .firstTextBaseline) {
                        Label("Portfolio Balance", systemImage: "banknote")
                            .fixedSize(horizontal: true, vertical: false)
                            .accentColor(.secondary)
                        Spacer()
                        Text(cashString)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Label {
                            Text("Monthly Return")
                        } icon: {
                            Image(systemName: "calendar.badge.plus")
                        }
                        Spacer()
                        Text(cashflowString)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.systemGreen)
                    }
                    .padding(.top, 12)
                }.padding([.top, .bottom], 6)
            }
            Section(header: Text("Assumptions")) {
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
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(Text(makeYearsString() + " Year Projection"))
        .toolbar {
            Button {
                isPresentingCurrencyPicker = true
            } label: {
                CurrencyView(currency: currency)
            }
        }
        .onChange(of: inputStrings) { inputStrings in
            inputStrings.projectionInput.forSome {
                projection.input = $0
            }
        }
        .bind($currency, to: AppSettings.shared.$currency.new())
        .refreshable {
            print("✅ REFRESH Projection")
        }
    }
    
    private func makeYearsString() -> String {
        makeDisplayText(forNumberOfYears: projection.input.investmentAssumption.years)
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
    String(double(from: doubleString) ?? 0.0)
}

private struct ProjectionInputStrings: Equatable {
    init(_ input: Projection.Input) {
        startCashString = input.startCash.decimalString(separator: "")
        monthlyInvestmentString = String(input.investmentAssumption.monthlyInvestment)
        growthPercentString = String(input.investmentAssumption.annualReturnPercent)
        yearsString = String(input.investmentAssumption.years)
    }
    
    var projectionInput: Projection.Input? {
        guard let growthPerYearInPercent = double(from: growthPercentString),
              let startCapital = double(from: startCashString),
              let investmentPerMonth = double(from: monthlyInvestmentString),
              let years = double(from: yearsString) else {
            return nil
        }
        
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
