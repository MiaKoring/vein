import SwiftUI
import BetterSync
import os.log

@available(macOS 14.0, *)
@Observable
@MainActor
@propertyWrapper
public class Query<M: PersistentModel>: DynamicProperty {
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
