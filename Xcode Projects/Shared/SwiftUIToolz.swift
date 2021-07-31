import SwiftUI

/// NavigationLink without chevron. It fades out/in the highlight color during navigation animations, like in the email list in Apple Mail.
struct PlainNavigationLink<Label: View, Destination: View>: View {
    var body: some View {
        ZStack(alignment: .leading) {
            label()
            NavigationLink(destination: destination) { EmptyView() }
                .opacity(0)
        }
    }
    
    let destination: Destination
    @ViewBuilder let label: () -> Label
}

/// Place navigation chevron at any custom place
struct NavigationChevron: View {
    var body: some View {
        Image(systemName: "chevron.forward")
            .imageScale(.small)
            .foregroundColor(Color(UIColor.systemGray3))
            .font(.body.weight(.semibold))
    }
}
