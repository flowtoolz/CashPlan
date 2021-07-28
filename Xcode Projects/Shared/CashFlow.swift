import Foundation

class CashFlow: ObservableObject {
    static let shared = CashFlow()
    private init() {}
    
    var output: Output { Self.calculate(input) }
    
    static func calculate(_ input: Input) -> Output {
        let growthPerYear = 1.0 + (input.growthPercent / 100.0)
        
        let months = input.years * 12
        let growthPerMonth = pow(growthPerYear, 1.0 / 12.0)
        
        var resultingCapital = input.startCash
        
        for _ in 0 ..< months {
            resultingCapital *= growthPerMonth
            resultingCapital += input.monthlyInvestment
        }

        let resultingCashFlowPerMonth = resultingCapital * (growthPerMonth - 1.0)
        
        return .init(cash: resultingCapital,
                     cashflow: resultingCashFlowPerMonth)
    }
    
    @Published var input = Input(startCash: 10000,
                                 monthlyInvestment: 1000,
                                 growthPercent: 8.5,
                                 years: 5)
    
    struct Input {
        let startCash: Double
        let monthlyInvestment: Double
        let growthPercent: Double
        let years: Int
    }
    
    struct Output {
        let cash: Double
        let cashflow: Double
    }
}
