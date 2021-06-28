type t
let make: {"filename": string} => t
let run: (t, ~name: string, 'input) => Promise.t<'output>

type run<'input, 'output> = (t, 'input) => Promise.t<'output>
