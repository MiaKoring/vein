enum Resources {
    static var firstExampleCode: String {
        #"""
        enum V0_0_1: VersionedSchema {
            static let version = ModelVersion(0, 0, 1)
            static let models: [any PersistentModel.Type] = [Post.self]
        
            @Model
            final class Post {
                var title: String
                @LazyField
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
}
