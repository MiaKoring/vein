import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

@MainActor
@propertyWrapper
public class LazyField<T: Persistable>: PersistedField {
    public typealias WrappedType = T
    
    public var key: String?
    public weak var model: PersistentModel?
    
    package var store: T?
    
    public var isLazy: Bool {
        true
    }
    
    public static var sqliteTypeName: SQLiteTypeName {
        T.sqliteTypeName
    }
    
    #if canImport(SwiftUI)
    public var projectedValue: Binding<WrappedType> {
        Binding<WrappedType> (
            get: {
                self.wrappedValue
            },
            set: { newValue in
                self.wrappedValue = newValue
            }
        )
    }
    #endif
    
    public var isPopulated: Bool {
        store != nil
    }
    
    public var wrappedValue: T {
        get {
            if let store {
                return store
            }
            if let context = model?.context {
                do {
                    let result = try context.fetchSingleProperty(field: self)
                    store = result
                    return result
                } catch { fatalError(error.localizedDescription) }
            }
            fatalError()
        }
        set {
            if let context = model?.context {
                do {
                    try context.update(field: self, newValue: newValue)
                } catch {
                    fatalError(error.localizedDescription)
                }
                store = newValue
            } else {
                store = newValue
            }
        }
    }
    
    public init(wrappedValue: T) {
        self.store = wrappedValue
        self.key = nil
    }
}
