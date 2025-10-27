import SwiftUI
import BetterSync
import os.log

@MainActor
@propertyWrapper
public struct Query<M: PersistentModel>: DynamicProperty {
    public typealias WrappedType = [M]
    @ObservedObject var queryObserver: QueryObserver<M>
    @Environment(\.modelContext) var context
    
    public var wrappedValue: [M] {
        if let results = queryObserver.results {
            return results
        }
        do {
            let start = DispatchTime.now()
            let initialResults = try context.fetchAll(M.self)
            print("fetched and parsed in \((DispatchTime.now().uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000)")
            queryObserver.results = initialResults
            context.registerQuery(queryObserver)
            return initialResults
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public init() {
        self._queryObserver = ObservedObject(wrappedValue: QueryObserver<M>())
    }
}

public struct ContainerKey: EnvironmentKey {
    public static let defaultValue: BetterSync.ModelContainer? = nil
}

extension EnvironmentValues {
    public var modelContainer: BetterSync.ModelContainer? {
        get {
            self[ContainerKey.self]
        }
        set { self[ContainerKey.self] = newValue }
    }
}

extension EnvironmentValues {
    public var modelContext: ManagedObjectContext {
        guard let container = modelContainer else {
            fatalError("Tried to access 'EnvironmentValues.modelContainer' without it being set in the environment.")
        }
        return container.context
    }
}

extension BetterSyncContainer {
    public func modelContainer(_ container: BetterSync.ModelContainer) -> some View {
        self.environment(\.modelContainer, container)
    }
}

public struct BetterSyncContainer<Content: View>: View {
    @Environment(\.modelContainer) private var container
    @State private var isInitialized: Bool = false
    private let content: () -> Content
    
    public init(content: @escaping () -> Content ) {
        self.content = content
    }
    
    public var body: some View {
        if let container, isInitialized {
            content()
        } else if let container = container {
            ProgressView()
                .task {
                    do {
                        try await container.migrate()
                    } catch {
                        print(error.localizedDescription)
                    }
                    isInitialized = true
                }
        } else {
            ProgressView()
        }
    }
}
