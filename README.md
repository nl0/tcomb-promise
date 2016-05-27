# tcomb-promise

[tcomb](https://github.com/gcanti/tcomb) combinator for promises / thenables.


## Installation

```shell
npm install nl0/tcomb-promise
```

## Usage

```coffeescript
T = require 'tcomb-promise'

User = T.struct
  name: T.String
  email: T.String
, 'User'

fetchUser = T.func T.String, T.promise(User)
.of (id) ->
  fetch "https://example.com/users/#{id}"

fetchUser('someId').then (u) ->
  # result is automatically hydrated
  User.is(u) == true
```

## API

The `promise(type)` combinator is added to the `tcomb` namespace.
