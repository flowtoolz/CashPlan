import FoundationToolz
import Foundation
import Combine

class FutureVision: ObservableObject {
    
    // MARK: - Singleton Instance
    
    static let shared = FutureVision()
    
    private init() {
        updateStartCashWheneverPortfolioBalanceChanges()
    }
    
    // MARK: - Calculate Output from Input (Whenever ouput is accessed)
    
    var output: Output { Self.output(from: input) }
    
    // TODO: write unit tests for simple base cases to ensure there is no "off by one" issue going on
    private static func output(from input: Input) -> Output {
        let months = Int(input.investmentAssumption.years * 12)
        let growthPerMonth = pow(input.investmentAssumption.annualGrowthFactor, 1.0 / 12.0)
        
        var resultingCapital = input.startCash
        
        for _ in 0 ..< months {
            resultingCapital *= growthPerMonth
            resultingCapital += input.investmentAssumption.monthlyInvestment
        }
        
        let resultingCashFlowPerMonth = resultingCapital * (growthPerMonth - 1.0)
        
        return .init(cash: resultingCapital,
                     cashflow: resultingCashFlowPerMonth)
    }
    
    struct Output {
        let cash: Double
        let cashflow: Double
    }
    
    // MARK: - Observable Input (Input = Start Cash + Investment Assumption)
    
    private func updateStartCashWheneverPortfolioBalanceChanges() {
        portfolioBalanceObservation = Portfolio.shared.$balanceNumericalValue.sink { [weak self] newBalance in
            self?.input.startCash = newBalance
        }
    }
    
    private var portfolioBalanceObservation: AnyCancellable?
    
    @Published var input = Input(startCash: Portfolio.shared.balanceNumericalValue,
                                 investmentAssumption: persistedInvestmentAssumption) {
        didSet {
            // when the input changes, we want to persist the investmentAssumption
            Self.persistedInvestmentAssumption = input.investmentAssumption
        }
    }
    
    struct Input {
        var startCash: Double
        var investmentAssumption: InvestmentAssumption
    }
    
    // MARK: - Persisted Investment Assumption
    
    private static var persistedInvestmentAssumption: InvestmentAssumption {
        get {
            guard let data = UserDefaults.standard.data(forKey: Self.investmentAssumptionUserDefaultsKey),
               let loadedIA = try? InvestmentAssumption(jsonData: data) else {
                return save(.default)
            }
            
            return loadedIA
        }
        
        set {
            save(newValue)
        }
    }
    
    @discardableResult
    private static func save(_ investmentAssumption: InvestmentAssumption) -> InvestmentAssumption {
        if let data = investmentAssumption.encode() {
            UserDefaults.standard.set(data, forKey: investmentAssumptionUserDefaultsKey)
        } else {
            print("Oh no 😱")
        }
        
        return investmentAssumption
    }
    
    private static let investmentAssumptionUserDefaultsKey = "InvestmentAssumptionUserDefaultsKey"
}

struct InvestmentAssumption: Codable {
    static var `default`: InvestmentAssumption {
        .init(monthlyInvestment: 1000,
              annualReturnPercent: 8.5,
              years: 5)
    }
    
    var annualGrowthFactor: Double { 1.0 + annualProfitFactor }
    var monthProfitFactor: Double { annualProfitFactor / 12.0 }
    var annualProfitFactor: Double { annualReturnPercent / 100.0 }
    
    let monthlyInvestment: Double
    let annualReturnPercent: Double
    let years: Double
}
