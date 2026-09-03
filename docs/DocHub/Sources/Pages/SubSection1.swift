import Raptor

struct SubSection1: HTML {
    var body: some HTML {
        Text("Build your persistence layer in a familiar way, shared across all platforms.")
            .font(.title1)
            .fontWeight(.regular)
            .frame(maxWidth: 768)
        Spacer(size: .large)
        Text("No need to learn new tools from scratch or integrate with SQLite directly. Vein's high level abstraction offers simplicity, control and safety. SwiftUI, SwiftCrossUI or CLI tool, your models are always the same.")
            .font(.system(size: 20))
            .foregroundStyle(.secondary)
            .fontWeight(.medium)
            .frame(maxWidth: 768)
        
        Spacer(size: .xLarge)
        
        Grid(spacing: .xLarge) {
            GridRow {
                Card(
                    image: .other("/images/vein-crystals.svg"),
                    title: "Vein",
                    description: "The shared engine below all surface targets. Contains the majority of API surface and interesting docs.",
                    link: "/"
                )
                Card(
                    image: .system("layers-half"),
                    title: "VeinSwiftUI",
                    description: "Support for SwiftUI: the @Model macro, automatic UI updates for models, @Query for use in views and VeinContainer.",
                    link: "/"
                )
            }
            GridRow {
                Card(
                    image: .system("aspect-ratio"),
                    title: "VeinSCUI",
                    description: "Support for SwiftCrossUI: the @Model macro, automatic UI updates for models, @Query for use in views and VeinContainer.",
                    link: "/"
                )
                Card(
                    image: .system("terminal"),
                    title: "VeinCore",
                    description: "UI-framwork agnostic surface for use in CLI tools and not explicitly supported UI Frameworks: the @Model macro.",
                    link: "/"
                )
            }
        }
    }
}
