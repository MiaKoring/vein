import Vein

@attached(peer)
public macro Relationship(
    inverse: String? = nil,
    deleteRule: DeleteRule = .nullify
) = #externalMacro(
    module: "VeinCoreMacros",
    type: "RelationshipMarkerMacro"
)
