import SwiftUI

struct FeedbackView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("This app is at the earliest stage 🚀")
                    .padding(.bottom)
                
                Text("Here are some of my ideas:")
                    .padding(.bottom)
                
                VStack(alignment: .leading,
                       spacing: 10) {
                    FeatureLabels()
                }
                .padding(.bottom)
                
                Text("I'd love to hear your ideas:")
                
                FeedbackLink()
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
