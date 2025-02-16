import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros

public struct BaseActionMacro: MemberMacro, ExtensionMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo protocols: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        return [try SwiftSyntax.ExtensionDeclSyntax("""
        extension \(type): BaseAction {
        }
        """)]
    }
    
    public static var supportedDeclarations: [SwiftSyntax.DeclSyntaxProtocol.Type] {
        [EnumDeclSyntax.self]
    }
    
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        [SwiftSyntax.DeclSyntax(stringLiteral: """
        static public var desc: String {
        \"\"\"
        \(declaration.description)
        \"\"\"\
        }
        """)]
    }
}

@main
struct ActAPIFrameworkPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [BaseActionMacro.self]
}
