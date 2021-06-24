type t

let make: string => t

let threadId: int

let on: (t, @string [#message(Js.Json.t => unit)]) => unit
let postMessage: (t, Js.Json.t) => unit

module Parent: {
  type t

  let port: t

  let on: (t, @string [#message(Js.Json.t => unit)]) => unit
  let postMessage: (t, Js.Json.t) => unit
}
