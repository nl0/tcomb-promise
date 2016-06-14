# tcomb-promise

[tcomb](https://github.com/gcanti/tcomb) combinator for promises / thenables.


## Installation

```shell
npm install tcomb-promise
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
  .then ({data}) -> data

fetchUser('someId').then (u) ->
  # result is automatically hydrated
  User.is(u) == true
```

## API

The `promise(type)` combinator is added to the `tcomb` namespace.
