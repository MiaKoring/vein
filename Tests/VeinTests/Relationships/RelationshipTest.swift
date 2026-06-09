import Foundation
import Testing
import Logging
@testable import Vein
@testable import VeinCore

@MainActor
@Suite struct RelationshipTest {
    static let logger = Logger(label: "de.amethystsoft.vein.test.migration")
    
    @Test func testPersist() async throws {
        let dbPath = try prepareContainerLocation(name: "RelationshipMigration")
        
        Self.logger.info(
            "Relationship migration test started with db location: \(dbPath)"
        )
        
        let container = try ModelContainer(
            V0_0_1.self,
            migration: Migration.self,
            at: dbPath,
            appID: "de.amethystsoft.vein.RelationshipTests",
            encryptionEnabled: ProcessInfo.shouldEnableEncryption
        )
        
        let user = V0_0_1.User(name: "Mia")
        let comment = V0_0_1.Comment(text: "Heyho")
        user.comments.append(comment)
        
        try container.context.insert(user)
        try container.context.save()
        
        let oldUsers = try container.context.fetchAll(V0_0_1.User.self)
        
        #expect(oldUsers.count == 1 && oldUsers.first?.id == user.id)
        
        let storedSchemas = try container.context.getAllStoredSchemas()
        
        #expect(
            storedSchemas.sorted() == [
                V0_0_1.User.schema,
                V0_0_1.Comment.schema
            ].sorted()
        )
        
        // Create new container & trigger migration
        let newContainer = try ModelContainer(
            V0_0_2.self,
            migration: Migration.self,
            at: dbPath,
            appID: "de.amethystsoft.vein.RelationshipTests",
            encryptionEnabled: ProcessInfo.shouldEnableEncryption
        )
        try newContainer.migrate()
        
        let first = try newContainer.context.fetchAll(V0_0_2.User._PredicateHelper()._builder()).first
        
        #expect(first?.is2faEnabled == false)
        #expect(first?.name == "Mia")
        #expect(first?.comments.contains(where: { $0.id == comment.id }) == true)
        
        let newStoredSchemas = try newContainer.context.getAllStoredSchemas()
        #expect(newStoredSchemas.sorted() == [V0_0_2.User.schema, V0_0_2.Comment.schema].sorted())
    }
    
    func prepareContainerLocation(name: String) throws -> String {
#if os(Linux)
        Keyring.appIdentifier.withLock { identifier in
            identifier = "de.amethystsoft.vein.tests"
        }
#endif
        
        let containerPath = FileManager.default.temporaryDirectory
        
        let dbDir = containerPath.relativePath.appending("/veinTests/\(testID.uuidString)")
        
        let dbPath = dbDir.appending("/\(name).sqlite3")
        
        try FileManager.default.createDirectory(
            atPath: dbDir,
            withIntermediateDirectories: true
        )
        
        if !FileManager.default.fileExists(atPath: dbPath) {
            FileManager.default.createFile(
                atPath: dbPath,
                contents: nil
            )
        }
        
        return dbPath
    }
}

fileprivate enum V0_0_1: VersionedSchema {
    static let version = ModelVersion(0, 0, 1)
    static let models: [any Vein.PersistentModel.Type] = [User.self, Comment.self]
    
    @Model
    final class User: Identifiable {
        @Field
        var name: String
        
        @Relationship
        var comments: [Comment]
        
        init(name: String) {
            self.name = name
            self.comments = []
        }
    }
    
    @Model
    final class Comment: Identifiable {
        @Relationship(inverse: \User.comments, deleteRule: .cascade)
        var author: User?
        
        @Field
        var text: String
        
        init(text: String) {
            self.text = text
            self.author = nil
        }
    }
}

fileprivate enum V0_0_2: VersionedSchema {
    static let version = ModelVersion(0, 0, 2)
    static let models: [any Vein.PersistentModel.Type] = [User.self, Comment.self]
    
    @Model
    final class User: Identifiable {
        @Field
        var name: String
        
        @Relationship
        var comments: [Comment]
        
        @Field
        var is2faEnabled: Bool = false
        
        init(name: String) {
            self.name = name
            self.comments = []
        }
    }
    
    @Model
    final class Comment: Identifiable {
        @Relationship(inverse: \User.comments)
        var author: User?
        
        @Field
        var text: String
        
        init(text: String) {
            self.text = text
            self.author = nil
        }
    }
}

fileprivate enum Migration: SchemaMigrationPlan {
    static var schemas: [any Vein.VersionedSchema.Type] {
        [V0_0_1.self, V0_0_2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.complex(
        fromVersion: V0_0_1.self,
        toVersion: V0_0_2.self,
        willMigrate: { context in
            // 1. Fetch all old models independently to avoid dynamic graph changes
            let oldUsers = try context.fetchAll(V0_0_1.User.self)
            let oldComments = try context.fetchAll(V0_0_1.Comment.self)
            
            // 2. Map old comments to new comments
            var newCommentsMap: [ULID: V0_0_2.Comment] = [:]
            for oldComment in oldComments {
                let newComment = V0_0_2.Comment(text: oldComment.text)
                newComment.id = oldComment.id
                newCommentsMap[oldComment.id] = newComment
            }
            
            // 3. Map users and link their comments
            for oldUser in oldUsers {
                let newUser = V0_0_2.User(name: oldUser.name)
                newUser.comments = oldUser.comments.compactMap { oldComment in
                    newCommentsMap[oldComment.id]
                }
                try context.insert(newUser)
            }
            
            // 4. Safely delete all old records
            for oldComment in oldComments {
                try context.delete(oldComment)
            }
            for oldUser in oldUsers {
                try context.delete(oldUser)
            }
        },
        didMigrate: nil
    )
}
