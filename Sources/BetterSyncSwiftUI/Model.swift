import Combine
import BetterSync

@attached(member, names: named(init), named(id), named(setupFields), named(context), named(getSchema), named(fields), named(fieldInformation), named(objectWillChange))
@attached(extension, conformances: PersistentModel, Sendable, ObservableObject)
public macro Model() = #externalMacro(
    module: "BetterSyncMacros",
    type: "ModelMacro"
)
