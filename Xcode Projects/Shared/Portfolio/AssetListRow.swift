import SwiftUIToolz
import SwiftUI

struct AssetListRow: View {
    
    init(asset: Asset) {
        _viewModel = StateObject(wrappedValue: AssetListRowModel(asset: asset))
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack {
                HStack {
                    Text(viewModel.assetName)
                        .fontWeight(.medium)
                    Spacer()
                    Text(viewModel.profitPercentageDisplayString)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(viewModel.isLoss ? trademateRed : trademateGreen)
                }
                HStack {
                    Spacer()
                    Text(viewModel.valueDisplayString)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.secondary)
                }
            }
            NavigationChevron()
        }
    }
    
    @StateObject private var viewModel: AssetListRowModel
}
