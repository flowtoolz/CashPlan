import SwiftUIToolz
import SwiftUI

struct AssetsOverView: View {
    
    var body: some View {
            Label {
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(portfolio.assets.count) Asset" + (portfolio.assets.count > 1 ? "s" : ""))
                            .font(.body.weight(.medium))
                        Spacer()
                        NavigationChevron()
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Profit / Loss")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(portfolio.returnPercentageString)
                            .font(.system(.title2, design: .monospaced))
                            .foregroundColor(portfolio.isAtALoss ? .trademateRed : .trademateGreen)
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Balance")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(portfolio.valueDisplayString)
                            .font(.system(.title2, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                }
            } icon: {
                Image(systemName: "building.2")
                    .imageScale(.large)
            }
    }
    
    @ObservedObject private(set) var portfolio = Portfolio.shared
}
