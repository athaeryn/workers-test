type input = {howLongMs: int}

@decco.encode
type output = {pausedFor: int}

let run: Piscina.run<input, output>
let execute: input => Promise.t<output>
