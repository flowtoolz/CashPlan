import SwiftUIToolzOLD
import SwiftUI

struct AssetListRow: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                VStack {
                    HStack {
                        UpdatingText(viewModel.assetName) {
                            $0.fontWeight(.medium)
                        }
                        Spacer()
                        UpdatingText(viewModel.profitPercentageString) { text in
                            text
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(viewModel.isLoss ? .systemRed : .systemGreen)
                        }
                    }
                    HStack {
                        Spacer()
                        UpdatingText(viewModel.balanceNumericalValueString) { text in
                            text
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                NavigationChevron().hidden()
            }
            NavigationLink {
                AssetEditingView(.init(viewModel.asset))
            } label: {
                // TODO: Instead of using this dummy Text for layouting, vertically align the link with the first base line of the title text, using some SwiftUI alignment magic with GeometryReader or so
                Text("Dummy")
                    .hidden()
            }  
        }
    }
    
    let viewModel: AssetListRowModel
}
