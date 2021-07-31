import SwiftUI

struct AssetListRow: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack {
                HStack {
                    Text(asset.name)
                        .fontWeight(.medium)
                    Spacer()
                    Text(asset.profitPercentageDisplayString)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(asset.isLoss ? .red : .green)
                }
                HStack {
                    Spacer()
                    Text("\(asset.valueDisplayString(in: displayCurrency))")
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.secondary)
                }
            }
            NavigationChevron()
        }
    }
    
    @Binding private(set) var displayCurrency: Currency
    @ObservedObject private(set) var asset: Asset
}
