import SwiftUI

struct CashflowCalculatorView: View {
    var body: some View {
        Form {
            Section(header: Text("Result in \(inputStrings.yearsString) years")) {
                HStack {
                    Label("Cash", systemImage: "chart.pie")
                    Spacer()
                    Text(cashString)
                        .font(.system(.body, design: .monospaced))
                }
                HStack {
                    Label("Cash / Month", systemImage: "calendar")
                    Spacer()
                    Text(cashflowString)
                        .font(.system(.body, design: .monospaced))
                }
                .foregroundColor(.green)
            }
            .accentColor(.primary)
            Section(header: Text("Edit Investment Plan")) {
                HStack {
                    Label("Initial Investment", systemImage: "chart.pie")
                        .fixedSize(horizontal: true, vertical: false)
                    TextField("Initial", text: $inputStrings.startCashString)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Monthly Investment", systemImage: "calendar")
                        .fixedSize(horizontal: true, vertical: false)
                    TextField("Monthly", text: $inputStrings.monthlyInvestmentString)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Expected Return", systemImage: "percent")
                        .fixedSize(horizontal: true, vertical: false)
                    TextField("Return", text: $inputStrings.growthPercentString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.accentColor)
                    
                }
                HStack {
                    Label("Years", systemImage: "hourglass")
                        .fixedSize(horizontal: true, vertical: false)
                    TextField("Years", text: $inputStrings.yearsString)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.accentColor)
                }
            }
        }
        .navigationTitle("Vision")
        .onChange(of: inputStrings) { inputStrings in
            inputStrings.input.forSome {
                cashflow.input = $0
            }
        }
    }
    
    @State private var inputStrings = CashFlowInputStrings(CashFlow.shared.input)
    
    private struct CashFlowInputStrings: Equatable {
        init(_ input: CashFlow.Input) {
            startCashString = input.startCash.decimalString(separator: "")
            monthlyInvestmentString = String(input.monthlyInvestment)
            growthPercentString = String(input.growthPercent)
            yearsString = String(input.years)
        }
        
        var input: CashFlow.Input? {
            guard let growthPerYearInPercent = double(from: growthPercentString),
                  let startCapital = double(from: startCashString),
                  let investmentPerMonth = double(from: monthlyInvestmentString),
                  let years = integer(from: yearsString) else {
                return nil
            }
            
            return .init(startCash: startCapital,
                         monthlyInvestment: investmentPerMonth,
                         growthPercent: growthPerYearInPercent,
                         years: years)
        }
        
        var startCashString: String
        var monthlyInvestmentString: String
        var growthPercentString: String
        var yearsString: String
    }
    
    private var cashString: String { cashflow.output.cash.decimalString() }
    private var cashflowString: String { "+" + cashflow.output.cashflow.decimalString() }
    @ObservedObject private var cashflow = CashFlow.shared
}

/*
func calculateCashAndCashflow() {
    let workMonthsPerYear = 6.0
    let incomePerYear = workMonthsPerYear * 160 * 120 * 0.7
    let indispensableIncomePerYear = 12.0 * 2000
    
    let startCapital = 70000.0
    let growthPerYearInPercent = 10.0
    let growthPerYear = 1.0 + (growthPerYearInPercent / 100.0)
    let investmentPerYear = incomePerYear - indispensableIncomePerYear
    let years = 5
    
    let quarters = years * 4
    let growthPerQuarter = pow(growthPerYear, 0.25)
    let investmentPerQuarter = investmentPerYear / 4
    
    var resultingCapital = startCapital
    
    for _ in 1 ... quarters {
        resultingCapital *= growthPerQuarter
        resultingCapital += investmentPerQuarter
    }
    
    print("after \(years) years:")
    
    print(String(format: "%.3f", resultingCapital / 1000000) + " million cash")
    
    let growthPerMonth = pow(growthPerYear, 1.0 / 12.0)
    let resultingCashFlowPerMonth = resultingCapital * (growthPerMonth - 1.0)
    
    print("\(Int(resultingCashFlowPerMonth)) monthly cash flow")
}
*/
