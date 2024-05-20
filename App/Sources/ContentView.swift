import HomeAPI
import SwiftUI

public struct ContentView: View {
    let viewModel = ContentViewModel()

    public var body: some View {
        Text("Hello, World!")
            .padding()
            .onAppear {
                viewModel.getCurrency()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
