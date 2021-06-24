type t

@module("worker_threads") @new
external make: string => t = "Worker"

@module("worker_threads") @val
external threadId: int = "threadId"

@send
external on: (t, @string [#message(Js.Json.t => unit)]) => unit = "on"

@send
external postMessage: (t, Js.Json.t) => unit = "postMessage"

module Parent = {
  type t

  @module("worker_threads") @val
  external port: t = "parentPort"

  @send
  external on: (t, @string [#message(Js.Json.t => unit)]) => unit = "on"

  @send
  external postMessage: (t, Js.Json.t) => unit = "postMessage"
}
