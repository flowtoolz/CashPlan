import SwiftUIToolzOLD
import SwiftUI

struct FutureVisionOverView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            Label {
                VStack {
                    HStack {
                        Text("\(futureVision.input.years) Year Target")
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
                        Text("Cash Flow")
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
}
