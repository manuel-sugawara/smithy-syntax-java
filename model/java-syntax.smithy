$version: "2.0"

namespace mx.sugus.syntax.java

use mx.sugus.syntax.java#const
use mx.sugus.syntax.java#interface
use mx.sugus.syntax.java#isa
use mx.sugus.syntax.java#java
use mx.sugus.syntax.java#optional

// -- Util
@java("java.lang.Object")
structure JavaObject {}

// -- Syntax Format
@interface
structure SyntaxNode {}

enum SyntaxFormatterNodeKind {
    LITERAL
    STRING
    TYPE_NAME
    NAME
}

@interface
structure FormatterNode {
    kind: SyntaxFormatterNodeKind
}

@isa(FormatterNode)
structure FormatterLiteral {
    @const("mx.sugus.syntax.java#SyntaxFormatterNodeKind$LITERAL")
    kind: SyntaxFormatterNodeKind

    value: String
}

@isa(FormatterNode)
structure FormatterString {
    @const("mx.sugus.syntax.java#SyntaxFormatterNodeKind$STRING")
    kind: SyntaxFormatterNodeKind

    value: String
}

@java("mx.sugus.javapoet.TypeName")
structure TypeName {}

@isa(FormatterNode)
structure FormatterTypeName {
    @const("mx.sugus.syntax.java#SyntaxFormatterNodeKind$TYPE_NAME")
    kind: SyntaxFormatterNodeKind

    value: TypeName
}

@isa(FormatterNode)
structure FormatterName {
    @const("mx.sugus.syntax.java#SyntaxFormatterNodeKind$NAME")
    kind: SyntaxFormatterNodeKind

    value: JavaObject
}

list FormatterNameList {
    member: FormatterNode
}

@isa(SyntaxNode)
structure SyntaxFormatter {
    parts: FormatterNameList
}

// -- Expression
@isa(SyntaxNode)
@interface
structure Expression {}

@isa(Expression)
structure ExpressionFormatter {
    parts: FormatterNameList
}

// --- Statements
@isa(SyntaxNode)
@interface
structure Statement {}

@isa(Statement)
structure StatementFormatter {
    parts: FormatterNameList
}

list StatementList {
    member: Statement
}

@isa(Statement)
structure Block {
    statements: StatementList
}

@isa(Statement)
structure IfStatement {
    expression: Expression

    statement: Block

    @optional
    elseStatement: Statement
}

@isa(Statement)
structure ForStatement {
    initializer: SyntaxNode
    statement: Block
}

@isa(SyntaxNode)
structure CatchClause {
    parameter: SyntaxNode
    statement: Block
}

@length(min: 1)
list CatchClauseList {
    member: CatchClause
}

@isa(SyntaxNode)
structure FinallyClause {
    statement: Block
}

@isa(Statement)
structure TryStatement {
    @optional
    resources: SyntaxNode

    statement: Block

    catchClauses: CatchClauseList

    @optional
    finallyClause: FinallyClause
}

list LabelList {
    member: SyntaxNode
}

@isa(SyntaxNode)
structure CaseClause {
    label: LabelList
    body: Block
}

list CaseClauseList {
    member: CaseClause
}

structure DefaultCaseClause {
    label: SyntaxNode
    body: Block
}

@isa(Statement)
structure SwitchStatement {
    expression: Expression

    cases: CaseClauseList

    @optional
    defaultCase: DefaultCaseClause
}

@java("javax.lang.model.element.Modifier")
structure Modifier {}

@uniqueItems
list ModifierList {
    member: Modifier
}

@isa(SyntaxNode)
structure Annotation {
    member: String
    value: SyntaxNode
}

list AnnotationList {
    member: Annotation
}

@isa(SyntaxNode)
structure Parameter {
    name: String
    type: TypeName
}

list ParameterList {
    member: Parameter
}

@isa(SyntaxNode)
structure MethodSyntax {
    name: String

    returnType: TypeName

    annotations: AnnotationList

    modifiers: ModifierList

    parameters: ParameterList

    @optional
    body: Block
}

@isa(SyntaxNode)
structure FieldSyntax {
    name: String
    type: TypeName
    modifiers: ModifierList
    annotations: AnnotationList
}

list FieldSyntaxList {
    member: FieldSyntax
}

list MethodSyntaxList {
    member: MethodSyntax
}


// -- Class Syntax
@isa(SyntaxNode)
@interface
structure TypeSyntax {
    name: String
    modifiers: ModifierList
    annotations: AnnotationList
    fields: FieldSyntaxList
    methods: MethodSyntaxList
    innerTypes: TypeSyntaxList
}

list TypeSyntaxList {
    member: TypeSyntax
}


@isa(TypeSyntax)
structure ClassSyntax {
}

@isa(TypeSyntax)
structure InterfaceSyntax {
}

// --- Enum Syntax
@isa(SyntaxNode)
structure EnumConstant {
    name: String
    value: String
}

list EnumConstantList {
    member: EnumConstant
}

@isa(TypeSyntax)
structure EnumSyntax {
    enumConstants: EnumConstantList
}
