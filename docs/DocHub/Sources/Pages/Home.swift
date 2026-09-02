import Foundation
import Raptor

struct Home: Page {
    var title = "Document Hub"
    @Environment(\.themes) var themes
    
    var body: some HTML {
        Include("sitecss.html")
        HStack {
            Spacer()
            SegmentedControl {
                Button(
                    action: .switchColorScheme(.dark)
                ) {
                    Image(systemName: "circle")
                }
                .defaultSelection()
                Button(
                    action: .switchColorScheme(.light)
                ) {
                    Image(systemName: "circle-fill")
                }
                Button(
                    action: .switchColorScheme(.automatic)
                ) {
                    Image(systemName: "circle-half")
                }
            }
            .selectionPersisted()
        }
        .padding(.top, .small)
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                HStack(spacing: 0) {
                    Image("/images/vein-logo.svg", description: "Amethyst Vein Logo")
                        .resizable()
                        .logoWidth()
                    
                    Text("Vein")
                        .font(.xxLarge)
                        .fontWeight(.medium)
                }
                Spacer(size: .large)
                Text("Write once. Persist anywhere.")
                    .font(.xxxLarge)
                    .fontWeight(.medium)
                    .style(.width(.dvw(100)))
                    .style(.backgroundImage("linear-gradient(0deg, var(--bg-page) 0%, color-mix(in srgb, #DE69FF 50%, transparent) 50%, var(--bg-page) 100%)"))
                
                Text("Vein provides a safe, declarative and elegant foundation to handle data persistance for your Swift Apps on any major platform.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .fontWeight(.regular)
                    .frame(maxWidth: 700)
                
                Spacer(size: .medium)
                
                HStack {
                    Link("Get Started", destination: "#getting-started")
                        .primaryButton()
                    StarButton(owner: "amethystsoft", repo: "vein")
                }
            }
            .padding(.vertical, .xLarge)

            Spacer(size: .medium)
            
            ScrollView(.horizontal, id: "sample-code") {
                CodeBlock(.swift) {
                #"""
                import VeinCore
                
                enum V0_0_1: VersionedSchema {
                    static let version = ModelVersion(0, 0, 1)
                    static let models: [any PersistentModel.Type] = [Post.self]
                
                    @Model
                    final class Post {
                        var title: String
                        var content: String
                        @Relationship
                        var tags: [Tag]
                
                        init(title: String, content: String) { /* ... */ }
                    }
                }
                
                func setupAndUseVein() throws {
                    let container = try ModelContainer(
                        V0_0_1.self,
                        migration: Migration.self,
                        at: nil,
                        appID: "com.example.app"
                    )
                
                    try container.migrate()
                
                    let post = Post(title: "Hello, Vein!", content: "This is a test post.")
                    try container.context.insert(post)
                
                    let posts = try container.context.fetchAll(
                """#
                }
                .lineNumberVisibility(.hidden)
                .multilineTextAlignment(.leading)
                .style(.custom("mask-image", value: "linear-gradient(to bottom, black 80%, transparent 100%)"))
                .style(.custom("-webkit-mask-image", value: "linear-gradient(to bottom, black 80%, transparent 100%)"))
                .cornerRadius(15)
            }
            .frame(maxWidth: 780)
        }
        .multilineTextAlignment(.center)
    }
}
