import SwiftUI

struct FeedbackView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("This app is at the earliest stage 🚀")) {
                    NavigationLink {
                        List {
                            FeatureLabels()
                        }
                        .navigationTitle("Ideas")
                    } label: {
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
            .navigationTitle("Feedback")
        }
    }
}


