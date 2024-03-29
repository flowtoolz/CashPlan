import SwiftUI

struct FeedbackView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Trademate is at the earliest stage 🚀")) {
                    NavigationLink(destination:
                                    List {
                                        FeatureLabels()
                                    }
                                    .navigationTitle("Ideas")
                    ) {
                        Label {
                            Text("See Some Feature Ideas")
                        } icon: {
                            Image(systemName: "lightbulb")
                        }
                    }
                    
                }
                Section(header: Text("I'd love to hear your ideas")) {
                    FeedbackLink()
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Feedback")
        }
    }
}


