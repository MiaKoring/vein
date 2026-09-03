import Foundation
import Raptor

struct MainLayout: Layout {

    var body: some Document {
        Main {
            content
            RaptorFooter()
        }
        Footer {
            Text("Amethyst Vein is an independent open-source project and is not affiliated with, sponsored, or endorsed by Apple Inc. SwiftUI, SwiftData, @Model and @Query are trademarks of Apple Inc., registered in the U.S. and other countries.")
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
        }
    }
}
