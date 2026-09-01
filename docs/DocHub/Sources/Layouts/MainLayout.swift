import Foundation
import Raptor

struct MainLayout: Layout {

    var body: some Document {
        Navigation {
            HStack {
                Image("/images/logo.svg", description: "Amethyst Logo")
                .resizable()
                .frame(width: 40, height: 40)
                
                Text("Amethyst Vein")
            }.font(.title3).navigationItemRole(.logo)
            Spacer()
            HStack {
                Link("Tutorials", destination: "#Tutorials")
                Divider()
                Link("Docs", destination: "#Documentation")
                Divider()
            }.hiddenOnMobile()
            SegmentedControl {
                InlineForEach(ColorScheme.allCases) { scheme in
                    Button(
                        scheme.name,
                        action: .switchColorScheme(scheme)
                    )
                }
            }
            .selectionPersisted()
            .hiddenOnMobile()
        }
        Main {
            content
            RaptorFooter()
        }
    }
}
