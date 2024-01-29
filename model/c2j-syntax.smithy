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


@isa(SyntaxNode)
structure ShapeReference {
  shape: String
}

list ShapeReferenceList {
  member: ShapeReference
}

enum HttpMethod {
  POST, GET, PUT, OPTIONS, DELETE
}

@isa(SyntaxNode)
structure Http {
  method: HttpMethod
  requestUri: String
  responseCode: Integer
}

list StringList {
  member: String
}

@isa(SyntaxNode)
structure StaticContextParam {

}

@isa(SyntaxNode)
structure EndpointDiscovery {
}

@isa(SyntaxNode)
structure RequestCompression {
  encodings: StringList
}

@isa(SyntaxNode)
structure HttpChecksum {
  requestChecksumRequired: Boolean
  requestAlgorithmMember: String
  requestValidationModeMember: String
  responseAlgorithms: StringList
}

@isa(SyntaxNode)
structure EndpointTrait {
  hostPrefix: String
}

enum AuthType {
    NONE = "none"
    CUSTOM = "custom"
    IAM = "iam"
    V4 = "v4"
    V4_UNSIGNED_BODY = "v4-unsigned-body"
    S3 = "s3"
    S3V4 = "s3v4"
    BEARER = "bearer"
}

map StaticContextParamMap {
  key: String
  value: StaticContextParam
}


@isa(SyntaxNode)
structure Operation {
  name: String
  http: Http
  input: ShapeReference
  output: ShapeReference
  documentationUrl: String
  documentation: String
  authorizer: String
  errors: ShapeReferenceList
  endpointdiscovery: EndpointDiscovery
  endpointoperation: Boolean
  endpoint: EndpointTrait
  authtype: AuthType
  auth: StringList
  httpChecksumRequired: Boolean
  httpChecksum: HttpChecksum
  requestcompression: RequestCompression
  staticContextParams: StaticContextParamMap
}

// --- Shapes ---
enum ShapeType {
  BLOB      =  "blob"
  BOOLEAN   =  "boolean"
  DOUBLE    =  "double"
  FLOAT     =  "float"
  INTEGER   =  "integer"
  LIST      =  "list"
  LONG      =  "long"
  MAP       =  "map"
  STRING    =  "string"
  STRUCTURE =  "structure"
  TIMESTAMP =  "timestamp"
}

@isa(SyntaxNode)
@interface
structure Shape {
  type: ShapeType
}

@isa(Shape)
structure BlobShape  {
  @const("mx.sugus.syntax.java#ShapeType$BLOB")
  type: ShapeType
}

@isa(Shape)
structure BooleanShape  {
  @const("mx.sugus.syntax.java#ShapeType$BOOLEAN")
  type: ShapeType
}

@isa(Shape)
structure DoubleShape  {
  @const("mx.sugus.syntax.java#ShapeType$DOUBLE")
  type: ShapeType
}

@isa(Shape)
structure FloatShape  {
  @const("mx.sugus.syntax.java#ShapeType$FLOAT")
  type: ShapeType
}

@isa(Shape)
structure IntegerShape  {
  @const("mx.sugus.syntax.java#ShapeType$INTEGER")
  type: ShapeType
}

@isa(Shape)
structure ListShape  {
  @const("mx.sugus.syntax.java#ShapeType$LIST")
  type: ShapeType
}

@isa(Shape)
structure LongShape  {
  @const("mx.sugus.syntax.java#ShapeType$LONG")
  type: ShapeType
}

@isa(Shape)
structure MapShape  {
  @const("mx.sugus.syntax.java#ShapeType$MAP")
  type: ShapeType
}

@isa(Shape)
structure StringShape  {
  @const("mx.sugus.syntax.java#ShapeType$STRING")
  type: ShapeType
}

@isa(Shape)
structure StructureShape  {
  @const("mx.sugus.syntax.java#ShapeType$STRUCTURE")
  type: ShapeType
}

@isa(Shape)
structure TimestampShape  {
  @const("mx.sugus.syntax.java#ShapeType$TIMESTAMP")
  type: ShapeType
}

// ---
map ShapeMap {
  key: String
  value: Shape
}

map OperationMap {
  key: String
  value: Operation
}

@isa(SyntaxNode)
structure C2JModel {
   operations: OperationMap
   shapes: ShapeMap
}
