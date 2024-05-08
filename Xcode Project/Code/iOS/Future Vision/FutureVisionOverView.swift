import SwiftUIToolzOLD
import SwiftUI

struct FutureVisionOverView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            Label {
                VStack {
                    HStack {
                        let years = futureVision.input.investmentAssumption.years
                        let yearsText = Self.makeDisplayText(forNumberOfYears: years)
                        
                        Text(yearsText + " Year Target")
                            .font(.body.weight(.medium))
                        Spacer()
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Balance")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(futureVision.output.cash.decimalString(fractionDigits: 0))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Monthly Return")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("+" + futureVision.output.cashflow.decimalString(fractionDigits: 0))
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.systemGreen)
                    }
                }
            } icon: {
                Image(systemName: symbolName)
                    .imageScale(.large)
            }
            
            NavigationLink(destination: FutureVisionView(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)) {
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
    
    private let symbolName = "target"
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    
    @ObservedObject private(set) var futureVision = FutureVision.shared
    
    private static func makeDisplayText(forNumberOfYears years: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0 // No minimum fraction digits
        
        if years.truncatingRemainder(dividingBy: 1) == 0 {
            formatter.maximumFractionDigits = 0 // No digits after decimal if round
        } else {
            formatter.maximumFractionDigits = 1 // One digit after decimal if not round
        }
        
        return formatter.string(from: NSNumber(value: years)) ?? "\(years)"
    }
}
