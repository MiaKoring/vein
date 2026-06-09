import ULID

extension ManagedObjectContext {
    public nonisolated func getModel<T: PersistentModel>(id: ULID, type: T.Type) throws(MOCError) -> T? {
        if let model = identityMap.getTracked(type, id: id) {
            return model
        }
        
        return try self.fetchAll(PredicateBuilder<T>().addCheck(.isEqualTo, "id", id)).first
    }
    
    public nonisolated func getModels<T: PersistentModel>(ids: [ULID], type: T.Type) throws(MOCError) -> [T] {
        var models = [T]()
        
        for id in ids {
            guard let model = identityMap.getTracked(type, id: id) else {
                if let model = try self.fetchAll(PredicateBuilder<T>().addCheck(.isEqualTo, "id", id)).first {
                    models.append(model)
                }
                continue
            }
            models.append(model)
        }
        
        return models
    }
}
