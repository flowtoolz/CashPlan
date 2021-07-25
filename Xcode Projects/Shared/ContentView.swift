import SwiftUI
import Foundation

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Investment")) {
                    HStack {
                        Label("Initial Investment", systemImage: "banknote")
                            .fixedSize(horizontal: true, vertical: false)
                        TextField("Cash", text: $startCashString)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(.body, design: .monospaced))
                    }
                    HStack {
                        Label("Monthly Investment", systemImage: "calendar")
                            .fixedSize(horizontal: true, vertical: false)
                        TextField("Monthly Investment", text: $monthlyInvestmentString)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(.body, design: .monospaced))
                    }
                    HStack {
                        Label("Annual Growth", systemImage: "percent")
                            .fixedSize(horizontal: true, vertical: false)
                        TextField("Annual Growth ", text: $growthPercentString)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(.body, design: .monospaced))
                        
                    }
                    HStack {
                        Label("Years", systemImage: "hourglass")
                            .fixedSize(horizontal: true, vertical: false)
                        TextField("Years", text: $yearsString)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.system(.body, design: .monospaced))
                    }
                }
                Section(header: Text("Result in \(yearsString) years")) {
                    HStack {
                        Label("Cash", systemImage: "banknote")
                        Spacer()
                        Text(cashString)
                            .font(.system(.body, design: .monospaced))
                    }
                    HStack {
                        Label("Monthly Cashflow", systemImage: "calendar")
                        Spacer()
                        Text(cashflowString)
                            .font(.system(.body, design: .monospaced))
                    }
                }
                .accentColor(.green)
            }
            .navigationTitle("CashPlan")
        }
    }
    
    var cashString: String {
        guard let result = result else { return "Invalid input format" }
        return String(format: "%.2f", result.cash)
    }
    
    var cashflowString: String {
        guard let result = result else { return "Invalid input format" }
        return String(format: "%.2f", result.cashflow)
    }
    
    private var result: CashAndCashFlow? {
        guard let growthPerYearInPercent = double(from: growthPercentString),
              let startCapital = double(from: startCashString),
              let investmentPerMonth = double(from: monthlyInvestmentString),
              let years = Int(yearsString) else {
            return nil
        }
        
        let growthPerYear = 1.0 + (growthPerYearInPercent / 100.0)
        
        let months = years * 12
        let growthPerMonth = pow(growthPerYear, 1.0 / 12.0)
        
        var resultingCapital = startCapital
        
        for _ in 1 ... months {
            resultingCapital *= growthPerMonth
            resultingCapital += investmentPerMonth
        }
        
        print("after \(years) years:")
        
//        print(String(format: "%.3f", resultingCapital / 1000000) + " million cash")
        
        let resultingCashFlowPerMonth = resultingCapital * (growthPerMonth - 1.0)
        
//        print("\(Int(resultingCashFlowPerMonth)) monthly cash flow")
        
        return .init(cash: resultingCapital,
                     cashflow: resultingCashFlowPerMonth)
    }
    
    struct CashAndCashFlow {
        let cash: Double
        let cashflow: Double
    }
    
    @State private var startCashString: String = "10000"
    @State private var monthlyInvestmentString: String = "1000"
    @State private var growthPercentString: String = "8.5"
    @State private var yearsString: String = "5"
    
    private func double(from string: String) -> Double? {
        string.isEmpty ? 0.0 : Double(string.replacingOccurrences(of: ",", with: "."))
    }
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
