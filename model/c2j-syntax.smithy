$version: "2.0"

namespace mx.sugus.syntax.java

use mx.sugus.syntax.java#const
use mx.sugus.syntax.java#interface
use mx.sugus.syntax.java#isa
use mx.sugus.syntax.java#java
use mx.sugus.syntax.java#optional

// -- Syntax Format
@interface
structure SyntaxNode {}


// -- Service

@isa(SyntaxNode)
structure C2jService {
  version: String
  metadata: C2jMetadata
  operations: OperationMap
  shapes: ShapeMap
}

@isa(SyntaxNode)
structure C2jMetadata {
  apiVersion: String
  endpointPrefix: String
  signingName: String
  serviceAbbreviation: String
  serviceFullName: String
  serviceId: String
  xmlNamespace: String
  protocol: String
  jsonVersion: String
  awsQueryCompatible: StringToStringMap
  resultWrapped: Boolean
  signatureVersion: String
  targetPrefix: String
  uid: String
  auth: StringList
}

@isa(SyntaxNode)
structure C2jShapeReference {
  shape: String
}

list C2jShapeReferenceList {
  member: C2jShapeReference
}

enum C2jHttpMethod {
  POST, GET, PUT, OPTIONS, DELETE
}

@isa(SyntaxNode)
structure C2jHttp {
  method: C2jHttpMethod
  requestUri: String
  responseCode: Integer
}

list StringList {
  member: String
}

map StringToStringMap {
  key: String 
  value: String
}

@isa(SyntaxNode)
structure C2jStaticContextParam {

}

@isa(SyntaxNode)
structure C2jEndpointDiscovery {
}

@isa(SyntaxNode)
structure C2jRequestCompression {
  encodings: StringList
}

@isa(SyntaxNode)
structure C2jHttpChecksum {
  requestChecksumRequired: Boolean
  requestAlgorithmMember: String
  requestValidationModeMember: String
  responseAlgorithms: StringList
}

@isa(SyntaxNode)
structure C2jEndpointTrait {
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
  value: C2jStaticContextParam
}


@isa(SyntaxNode)
structure C2jOperation {
  name: String
  http: C2jHttp
  input: C2jShapeReference
  output: C2jShapeReference
  documentationUrl: String
  documentation: String
  idempotent: Boolean
  authorizer: String
  errors: C2jShapeReferenceList
  endpointdiscovery: C2jEndpointDiscovery
  endpointoperation: Boolean
  endpoint: C2jEndpointTrait
  authtype: AuthType
  auth: StringList
  httpChecksumRequired: Boolean
  httpChecksum: C2jHttpChecksum
  requestcompression: C2jRequestCompression
  staticContextParams: StaticContextParamMap
}

list OperationList {
  member: C2jOperation
}

map OperationMap {
  key: String
  value: C2jOperation
}


// --- C2jShapes ---
enum C2jShapeType {
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
structure C2jShape {
  type: C2jShapeType
}

list ShapeList {
  member: C2jShape
}

map ShapeMap {
  key: String
  value: C2jShape
}

@isa(C2jShape)
structure C2jBlobShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$BLOB")
  type: C2jShapeType
}

@isa(C2jShape)
structure C2jBooleanShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$BOOLEAN")
  type: C2jShapeType
}

@isa(C2jShape)
structure C2jDoubleShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$DOUBLE")
  type: C2jShapeType
  max: Long
  min: Long
}

@isa(C2jShape)
structure C2jFloatShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$FLOAT")
  type: C2jShapeType
}

@isa(C2jShape)
structure C2jIntegerShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$INTEGER")
  type: C2jShapeType
  box: Boolean
  max: Long
  min: Long
}

@isa(C2jShape)
structure C2jListShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$LIST")
  type: C2jShapeType
  member: C2jShapeReference 
  max: Long
  min: Long
}

@isa(C2jShape)
structure C2jMapShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$MAP")
  type: C2jShapeType
  key: C2jShapeReference
  value: C2jShapeReference   
  max: Long
  min: Long
}

@isa(C2jShape)
structure C2jLongShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$LONG")
  type: C2jShapeType
}

@isa(C2jShape)
structure C2jStringShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$STRING")
  type: C2jShapeType
  enum: StringList
  max: Long,
  min: Long,
  pattern: String
}

structure C2jXmlNamespace {
  prefix: String
  uri: String
}

structure C2jContextParam {
}

@isa(SyntaxNode)
structure C2jMember {
  shape: String
  location: String
  locationName: String
  payload: Boolean
  streaming: Boolean
  requiresLength: Boolean
  documentation: String
  queryName: String
  flattened: Boolean
  xmlNamespace: C2jXmlNamespace
  idempotencyToken: Boolean
  deprecated: Boolean
  deprecatedMessage: String
  jsonvalue: Boolean
  timestampFormat: String
  eventpayload: Boolean
  eventheader: Boolean
  endpointdiscoveryid: Boolean
  sensitive: Boolean
  xmlAttribute: Boolean
  deprecatedName: String
  contextParam: C2jContextParam
}


map C2jMemberMap {
  key: String
  value: C2jMember
}

@isa(C2jShape)
structure C2jStructureShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$STRUCTURE")
  type: C2jShapeType
  required: StringList
  members: C2jMemberMap
  documentation: String
  error: C2jErrorTrait
  exception: Boolean
  fault: Boolean
}

@isa(SyntaxNode)
structure C2jErrorTrait {
  httpStatusCode: Integer
  senderFault: Boolean
  code: String
}

@isa(C2jShape)
structure C2jTimestampShape  {
  @const("mx.sugus.syntax.java#C2jShapeType$TIMESTAMP")
  type: C2jShapeType
}

// ---
map C2jShapeMap {
  key: String
  value: C2jShape
}

map C2jOperationMap {
  key: String
  value: C2jOperation
}

@isa(SyntaxNode)
structure C2JModel {
   operations: C2jOperationMap
   shapes: C2jShapeMap
}
