import SwiftUIToolz
import SwiftUI

struct AlertsView: View {
    var body: some View {
        NavigationView {
            List {
                PlainNavigationLink(destination: Text("Alerts")) {
                    Label {
                        VStack(alignment: .leading) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("Alerts")
                                    .font(.body.weight(.medium))
                                Spacer()
                                NavigationChevron()
                            }
                            Group {
                                HStack {
                                    Text("Unread")
                                    Spacer()
                                    Text("10")
                                        .font(.system(.title2, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }
                                HStack {
                                    Text("Total")
                                    Spacer()
                                    Text("123")
                                        .font(.system(.title2, design: .monospaced))
                                        .foregroundColor(.secondary)
                                }
                            }
                            .foregroundColor(.secondary)
                        }
                    } icon: {
                        Image(systemName: "message")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}
