let id: string

type input = {n: int}

@decco.encode
type output = {fib: int}

let run: Types.runTask<input, output>

module Worker: {
  let run: input => Promise.t<Types.taskResult<output>>
}
