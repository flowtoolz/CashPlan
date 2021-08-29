import SwiftUI

struct FeedbackView: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Trademate is at the earliest stage 🚀")
                    .padding(.bottom)
                
                Text("Here are some of my plans:")
                    .padding(.bottom)
                
                VStack(alignment: .leading,
                       spacing: 10) {
                    FeatureLabels()
                }
                .padding(.bottom)
                
                Text("Shape the app with your ideas:")
                
                FeedbackLink()
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
