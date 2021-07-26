import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: PortfolioSimulatorView()) {
                    Label("Portfolio Positions", systemImage: "chart.pie")
                }
                NavigationLink(destination: CashflowCalculatorView()) {
                    Label("Future Cashflow", systemImage: "banknote")
                }
            }
            .navigationTitle("CashPlan")
        }
    }
}
