import SwiftUIToolzOLD
import SwiftUI

struct AssetListRow: View {
    
    var body: some View {
        Button {
            isPresentingEditor = true
        } label: {
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
        }
        .sheet(isPresented: $isPresentingEditor) {
            NavigationStack {
                AssetEditingView(.init(viewModel.asset))
                    .toolbar {
                        Button("Done") {
                            isPresentingEditor = false
                        }
                    }
            }
        }
    }
    
    @State private var isPresentingEditor = false
    let viewModel: AssetListRowModel
}
