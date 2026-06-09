import ULID

public protocol PersistedRelationship: FieldBase {
    associatedtype Value
    var wrappedValue: Value { get set }
}

public protocol ManyRelationship {
    var persistableValue: [ULID] { get set }
}
public protocol OneRelationship {
    var persistableValue: ULID? { get set }
}
