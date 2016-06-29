T = require 'tcomb'


Thenable = T.irreducible 'Thenable', (x) -> T.Function.is x?.then


promise = T.func T.Type, T.Type, 'promise'
.of (type) ->
  class PromiseType
    @displayName: "promise(#{T.getTypeName type})"
    @meta:
      kind: 'promise'
      type: type

    @is: (x) -> Thenable.is(x) and x.type == type

    constructor: (x) ->
      return Thenable(x).then type

T.promise = promise


module.exports = T
