import Combine
import BetterSync

@attached(member, names: named(init), named(id), named(setupFields), named(context), named(_getSchema), named(_fields), named(_fieldInformation), named(objectWillChange), named(_key))
@attached(extension, conformances: PersistentModel, Sendable, ObservableObject)
public macro Model() = #externalMacro(
    module: "BetterSyncMacros",
    type: "ModelMacro"
)
