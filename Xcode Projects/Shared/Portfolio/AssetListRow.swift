import SwiftUI

struct AssetListRow: View {
    var body: some View {
        NavigationLink(destination: EditPositionView(position)) {
            VStack {
                HStack {
//                    Image(systemName: position.currency.symbolName)
//                        .foregroundColor(.accentColor)
                    Text(position.name)
                        .fontWeight(.medium)
                    Spacer()
                    Text(position.profitPercentageDisplayString)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(position.isLoss ? .red : .green)
                    
                }
//                HStack {
//                    Spacer()
//                    Text(position.profitDisplayString(in: displayCurrency))
//                        .font(.system(.body, design: .monospaced))
//                        .foregroundColor(.secondary)
//                }
                HStack {
                    Spacer()
                    Text("\(position.valueDisplayString(in: displayCurrency))")
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    @Binding private(set) var displayCurrency: Currency
    @ObservedObject private(set) var position: Asset
}
