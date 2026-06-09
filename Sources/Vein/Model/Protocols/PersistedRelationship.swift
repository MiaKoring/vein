public protocol PersistedRelationship: FieldBase {
    associatedtype Value
    var wrappedValue: Value { get set }
}
