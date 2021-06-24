module Pause = {
  @decco
  type input = {howLongMs: int}

  @decco
  type output = {pausedFor: int}
}

module Fibonacci = {
  @decco
  type input = {n: int}

  @decco
  type output = {result: int}
}

@decco
type input = Pause(Pause.input) | Fibonacci(Fibonacci.input)

@decco
type output = Pause(Pause.output) | Fibonacci(Fibonacci.output)

type pool = {run: input => Promise.t<result<output, string>>}

let createPool = () => {
  let workerCount = Os.cpuCount()

  Js.log(j`creating pool of $workerCount workers...`)

  // TODO create multiple (workerCount) workers
  let workerPath = Path.fromRoot(["src", "TasksEntry.bs.js"])

  let worker = WorkerThreads.make(workerPath)

  {
    run: input => {
      Promise.make((resolve, _reject) => {
        worker->WorkerThreads.postMessage(input->input_encode)
        worker->WorkerThreads.on(
          #message(
            json => {
              Js.log(json)
              let output = switch output_decode(json) {
              | Ok(output) => Ok(output)
              | Error({message}) => Error(message)
              }
              resolve(. output)
            },
          ),
        )
      })
    },
  }
}
