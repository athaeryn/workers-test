type t

@module @new
external make: {"filename": string} => t = "piscina"

@send
external run: (t, 'input, {..}) => Promise.t<'output> = "run"

let run = (pool: t, ~name: string, input: 'input): Promise.t<'output> => {
  run(pool, input, {"name": name})
}

type run<'input, 'output> = (t, 'input) => Promise.t<'output>
