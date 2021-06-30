type input = {delay: int}

@decco.encode
type output = {pausedForMs: int}

let run: Types.runTask<input, output>

module Worker: {
  let run: input => Promise.t<Types.taskResult<output>>
}
