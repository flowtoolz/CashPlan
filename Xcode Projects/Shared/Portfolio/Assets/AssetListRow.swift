import SwiftUIToolz
import SwiftUI

struct AssetListRow: View {
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack {
                HStack {
                    UpdatingText(viewModel.assetName,
                                 initialText: viewModel.assetNameInitial) {
                        $0.fontWeight(.medium)
                    }
                    Spacer()
                    UpdatingText(viewModel.profitPercentageString,
                                 initialText: viewModel.profitPercentageStringInitial) { text in
                        text
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(viewModel.isLoss ? .trademateRed : .trademateGreen)
                    }
                }
                HStack {
                    Spacer()
                    UpdatingText(viewModel.valueString,
                                 initialText: viewModel.valueStringInitial) { text in
                        text
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                }
            }
            NavigationChevron()
        }
    }
    
    let viewModel: AssetListRowModel
}
