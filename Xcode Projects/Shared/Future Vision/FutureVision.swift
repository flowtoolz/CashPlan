import Foundation

class FutureVision: ObservableObject {
    static let shared = FutureVision()
    private init() {}
    
    var output: Output { Self.output(from: input) }
    
    static func output(from input: Input) -> Output {
        let months = input.years * 12
        let growthPerMonth = pow(input.annualGrowthFactor, 1.0 / 12.0)
        
        var resultingCapital = input.startCash
        
        for _ in 0 ..< months {
            resultingCapital *= growthPerMonth
            resultingCapital += input.monthlyInvestment
        }
        
        let resultingCashFlowPerMonth = resultingCapital * (growthPerMonth - 1.0)
        
        return .init(cash: resultingCapital,
                     cashflow: resultingCashFlowPerMonth)
    }
    
    @Published var input = Input(startCash: Portfolio.shared.value,
                                 monthlyInvestment: 1000,
                                 annualReturnPercent: 8.5,
                                 years: 5)
    
    struct Input {
        var annualGrowthFactor: Double { 1.0 + annualProfitFactor }
        var monthProfitFactor: Double { annualProfitFactor / 12.0 }
        var annualProfitFactor: Double { annualReturnPercent / 100.0 }
        
        let startCash: Double
        let monthlyInvestment: Double
        let annualReturnPercent: Double
        let years: Int
    }
    
    struct Output {
        let cash: Double
        let cashflow: Double
    }
}
