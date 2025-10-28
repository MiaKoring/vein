import SQLite

public struct PredicateBuilder<T: PersistentModel>: Hashable {
    public static func == (lhs: PredicateBuilder<T>, rhs: PredicateBuilder<T>) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public private(set) var hashValue: Int
    private var conditions = [Expression<Bool?>]()
    
    public init() {
        self.hashValue = ObjectIdentifier(T.self).hashValue
    }
    
    public func filterTrueBools() -> Self {
        var old = self
        let next = Expression<Bool?>("someValue") == true
        old.conditions.append(next)
        old.hashValue = newHash(next, .integer(1))
        return old
    }
    /*
    @discardableResult
    public func equal<V: Persistable>(_ keyPath: KeyPath<T, V>,
                             _ value: V) -> Self {
        let key = T._key(forPath: keyPath as! KeyPath<T, V>)
        let sqliteValue = sqliteValue(from: value)
            
        let next = V.sqliteTypeName.fieldIsEqualToExpression(
            key: key,
            value: sqliteValue.underlyingValue(
                withTypeName: V.sqliteTypeName
            )
        )
        conditions.append(next)
        hashValue = newHash(next, sqliteValue)
        return self
    }
    
    @discardableResult
    public func bigger<V: Persistable>(_ keyPath: KeyPath<T, V>,
                               _ value: V) -> Self {
        let key = T._key(forPath: keyPath as! KeyPath<T, V>)
        let sqliteValue = sqliteValue(from: value)
        
        let next = V.sqliteTypeName.fieldIsBiggerToExpression(
            key: key,
            value: sqliteValue
                .underlyingValue(
                    withTypeName: V.sqliteTypeName
                )
        )
        conditions.append(next)
        hashValue = newHash(next, sqliteValue)
        return self
    }
    
    @discardableResult
    public func smaller<V: Persistable>(_ keyPath: KeyPath<T, V>,
                                   _ value: V) -> Self {
        let key = T._key(forPath: keyPath as! KeyPath<T, V>)
        let sqliteValue = sqliteValue(from: value)
        
        let next = V.sqliteTypeName.fieldIsSmallerToExpression(
            key: key,
            value: sqliteValue
                .underlyingValue(
                    withTypeName: V.sqliteTypeName
                )
        )
        conditions.append(next)
        hashValue = newHash(next, sqliteValue)
        return self
    }
    
    @discardableResult
    public func smallerOrEqual<V: Persistable>(_ keyPath: KeyPath<T, V>,
                                    _ value: V) -> Self {
        let key = T._key(forPath: keyPath as! KeyPath<T, V>)
        let sqliteValue = sqliteValue(from: value)
        
        let next = V.sqliteTypeName.fieldIsSmallerOrEqualToExpression(
            key: key,
            value: sqliteValue
                .underlyingValue(
                    withTypeName: V.sqliteTypeName
                )
        )
        conditions.append(next)
        hashValue = newHash(next, sqliteValue)
        return self
    }
    
    @discardableResult
    public func biggerOrEqual<V: Persistable>(_ keyPath: KeyPath<T, V>,
                                           _ value: V) -> Self {
        let key = T._key(forPath: keyPath as! KeyPath<T, V>)
        let sqliteValue = sqliteValue(from: value)
        
        let next = V.sqliteTypeName.fieldIsBiggerOrEqualToExpression(
            key: key,
            value: sqliteValue
                .underlyingValue(
                    withTypeName: V.sqliteTypeName
                )
        )
        conditions.append(next)
        hashValue = newHash(next, sqliteValue)
        return self
    }*/
    
    func finalize() -> Expression<Bool?> {
        var currentExpression = Expression<Bool?>(value: true)
        for condition in conditions {
            currentExpression = currentExpression && condition
        }
        return currentExpression
    }
    
    private func newHash(_ expression: Expression<Bool?>, _ value: SQLiteValue) -> Int {
        var hasher = Hasher()
        hasher.combine(hashValue)
        hasher.combine(expression.template.hashValue)
        value.hash(into: &hasher)
        return hasher.finalize()
    }
    
    private func sqliteValue<V: Persistable>(from value: V) -> SQLiteValue {
        value
            .asPersistentRepresentation
            .sqliteValue
    }
}
