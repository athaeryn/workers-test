type input = {n: int}

@decco.encode
type output = {result: int}

let run: Piscina.run<input, output>
let execute: input => Promise.t<output>
