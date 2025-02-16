@_exported import ActAPIXCFramework

@attached(member, names: named(desc))
@attached(extension, conformances: BaseAction)
public macro BaseAction() = #externalMacro(module: "ActAPIMacros", type: "BaseAction")
