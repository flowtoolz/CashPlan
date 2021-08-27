import SwiftUI
import FoundationToolz
import CombineObserver
import SwiftObserver
import SwiftyToolz

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationView {
                Text("Hello, world!")
                    .navigationTitle("Nav Title")
            }
            .padding()
            .tabItem { Text("Tab 1") }
            Text("Hello, world!")
                .padding()
                .tabItem { Text("Tab 2") }
            Text("Hello, world!")
                .padding()
                .tabItem { Text("Tab 3") }
        }
    }
}
