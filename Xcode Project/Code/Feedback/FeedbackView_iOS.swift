import SwiftUI

struct FeedbackView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Trademate is at the earliest stage 🚀\nHere are some of my plans:")) {
                    FeatureLabels()
                }
                Section(header: Text("Shape the app with your ideas:")) {
                    FeedbackLink()
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("About Trademate")
            .toolbar {
                FeedbackLink()
            }
        }
    }
}


