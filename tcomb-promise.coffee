T = require 'tcomb'


resolve = T.func T.Type, T.Type, 'resolve'
.of (type) ->
  T.func type, T.Any, "resolve(#{T.getTypeName type})"

Reject = T.func T.Error, T.Any, 'Reject'

Thenable = T.interface
  then: T.Function
, "Thenable"

_then = T.func T.Type, T.Type, 'then'
.of (type) ->
  T.func [resolve(type), T.maybe(Reject)], Thenable, "then(#{T.getTypeName type})"


promise = T.func T.Type, T.Type, 'promise'
.of (type) ->
  Then = _then type

  class PromiseType
    @displayName: "promise(#{T.getTypeName type})"
    @meta:
      kind: 'promise'
      type: type

    @is: (x) -> Thenable.is(x) and x.type == type

    constructor: (x) ->
      p = Thenable x
      p.then = Then p.then
      return p

T.promise = promise


module.exports = T
