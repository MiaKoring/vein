import SQLite

@MainActor
@propertyWrapper
public class Query<M: PersistentModel> {
    public typealias WrappedType = [M]
    
    private var cachedItems: [M]?
    
    public var wrappedValue: [M] {
        if let cached = cachedItems {
            return cached
        }
        do {
            let items = try ManagedObjectContext.instance.fetchAll(M.self)
            self.cachedItems = items
            return items
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public init() { }
}
