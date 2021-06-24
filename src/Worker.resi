type t
type parentPort

let make: string => t
let parentPort: parentPort
let threadId: int

let on: (parentPort, @string [#message(Js.Json.t => unit)]) => unit

let postMessage: (t, {..}) => unit
