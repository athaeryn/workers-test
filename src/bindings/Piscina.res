type t

@module("piscina") @new
external make: {"filename": string} => t = "default"

@send
external run: (t, 'input, {..}) => Promise.t<'output> = "run"

let run = (pool: t, ~name: string, input: 'input): Promise.t<'output> => {
  run(pool, input, {"name": name})
}

type run<'input, 'output> = (t, 'input) => Promise.t<'output>
