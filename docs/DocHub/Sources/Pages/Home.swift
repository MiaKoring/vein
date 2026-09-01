import Foundation
import Raptor

struct Home: Page {
    var title = "Document Hub"
    @Environment(\.themes) var themes

    var body: some HTML {
        VStack(alignment: .center) {
            VStack{}
            .frame(height: 1000)
            Text("Documentation").id("Documentation")
            .font(.title1)
        }
    }
}
