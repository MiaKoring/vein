import Vein

public struct MigrationTester {
    private let migrationPlan: any SchemaMigrationPlan.Type
    private let container: ModelContainer
    
    init(migrationPlan: any SchemaMigrationPlan.Type) {
        self.migrationPlan = migrationPlan
        
        self.container = ModelContainer(models: migrationPlan., migration: <#T##any SchemaMigrationPlan.Type#>, at: <#T##String#>)
    }
}
