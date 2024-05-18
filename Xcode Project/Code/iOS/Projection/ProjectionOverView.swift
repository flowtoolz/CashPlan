import SwiftUIToolzOLD
import SwiftUI

struct ProjectionOverView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            Label {
                VStack {
                    HStack {
                        let years = projection.input.investmentAssumption.years
                        let yearsText = years.displayText
                        
                        Text(yearsText + " Year Target")
                            .font(.body.weight(.medium))
                        Spacer()
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Balance")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(projection.output.cash.decimalString(fractionDigits: 0))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Monthly Return")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("+" + projection.output.cashflow.decimalString(fractionDigits: 0))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.systemGreen)
                    }
                }
            } icon: {
                Image(systemName: symbolName)
                    .imageScale(.large)
            }
            
            NavigationLink {
                ProjectionView(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)
            } label: {
                // TODO: Instead of using this dummy label for layouting, vertically align the link with the first base line of the title text, using some SwiftUI alignment magic with GeometryReader or so
                Label {
                    Text("Dummy")
                } icon: {
                    Image(systemName: symbolName)
                        .imageScale(.large)
                }
                .hidden()
            }
        }
    }
    
    private let symbolName = "chart.line.uptrend.xyaxis"
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    
    @ObservedObject private(set) var projection = Projection.shared
    
    
}
