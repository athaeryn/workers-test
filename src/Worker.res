type t

@module("worker_threads") @new
external make: string => t = "Worker"

type parentPort

@module("worker_threads") @val
external parentPort: parentPort = "parentPort"

@module("worker_threads") @val
external threadId: int = "threadId"

@send
external on: (parentPort, @string [#message(Js.Json.t => unit)]) => unit = "on"

@send
external postMessage: (t, {..}) => unit = "postMessage"
