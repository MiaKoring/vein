public protocol PersistedField: Sendable, FieldBase {
    var wrappedValue: WrappedType { get set }
}
