
import SwiftUI
import Combine
import Foundation

class AppState: ObservableObject {
    
    @Published var moveToRootView: Bool = false
    
}

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State var isActive : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("ContentView")
                NavigationLink(destination: ContentView2(), isActive: $isActive) {
                    Text("letsssss go")
                }.isDetailLink(false)
            }
            .navigationBarTitle("Root")
        }
        .onReceive(appState.$moveToRootView) { output in
            if output {
                self.isActive = false
            }
        }
    }
}


struct ContentView2: View {
    
    var body: some View {
        VStack {
            NavigationLink(destination: ContentView3()) {
                Text("ContentView 3")
            }
            .navigationBarTitle("ContentView2")
        }
    }
}

struct ContentView3: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("ContentView3")
            Button (action: {
                self.appState.moveToRootView = true
            }) {
                Text("Pop to root")
            }
        }.navigationBarTitle("ContentView3")
    }
}

struct SO_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
