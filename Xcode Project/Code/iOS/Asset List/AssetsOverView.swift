import SwiftUIToolzOLD
import SwiftUI

struct AssetsOverView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            Label {
                VStack {
                    HStack {
                        Text("\(portfolio.assets.count) Asset" + (portfolio.assets.count != 1 ? "s" : ""))
                            .font(.body.weight(.medium))
                        Spacer()
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Profit / Loss")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(portfolio.returnPercentageString)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(portfolio.isAtALoss ? .systemRed : .systemGreen)
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("Balance")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(portfolio.valueDisplayString)
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                }
            } icon: {
                Image(systemName: symbolName)
                    .imageScale(.large)
            }
            NavigationLink(destination: AssetList(isPresentingCurrencyPicker: $isPresentingCurrencyPicker)) {
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
    
    private let symbolName = "building.2"
    
    @Binding private(set) var isPresentingCurrencyPicker: Bool
    
    @ObservedObject private(set) var portfolio = Portfolio.shared
}
