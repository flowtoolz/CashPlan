import SwiftUIToolz
import SwiftUI

struct FutureVisionOverView: View {
    
    var body: some View {
        Label {
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(futureVision.input.years) Year Target")
                        .font(.body.weight(.medium))
                    Spacer()
                    NavigationChevron()
                }
                HStack(alignment: .firstTextBaseline) {
                    Text("Balance")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(futureVision.output.cash.decimalString(fractionDigits: 0))
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                HStack(alignment: .firstTextBaseline) {
                    Text("Cash Flow")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("+" + futureVision.output.cashflow.decimalString(fractionDigits: 0))
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.trademateGreen)
                }
            }
        } icon: {
            Image(systemName: "target")
                .imageScale(.large)
        }
    }
    
    @ObservedObject private(set) var futureVision = FutureVision.shared
}
