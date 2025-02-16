@_exported import ActAPIXCFramework

@attached(member, names: named(desc))
@attached(extension, conformances: BaseAction)
public macro BaseActionMacro() = #externalMacro(module: "ActAPIMacros", type: "BaseActionMacro")
