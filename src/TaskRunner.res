open WorkerThreads

Js.log(j`Worker $threadId started`)

Parent.port->Parent.on(
  #message(
    json => {
      switch json->Tasks.input_decode {
      | Ok(input) =>
        switch input {
        | Pause(input) =>
          Tasks.Pause.run(input)
          ->Promise.thenResolve(output => {
            Parent.port->Parent.postMessage(Pause(output)->Tasks.output_encode)
          })
          ->ignore
        | Fibonacci(input) =>
          Tasks.Fibonacci.run(input)
          ->Promise.thenResolve(output => {
            Parent.port->Parent.postMessage(Fibonacci(output)->Tasks.output_encode)
          })
          ->ignore
        }
      | Error({message}) => Parent.port->Parent.postMessage(Js.Json.string(message))
      }
    },
  ),
)
