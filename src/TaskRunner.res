open WorkerThreads

Js.log2("hello from worker", threadId)

let runPause: Tasks.Pause.input => Promise.t<Tasks.Pause.output> = input => {
  Promise.make((resolve, _reject) => {
    Js.Global.setTimeout(() => {
      resolve(. {Tasks.Pause.pausedFor: input.howLongMs})
    }, input.howLongMs)->ignore
  })
}

let rec getFib = n => {
  switch n {
  | 0 => 0
  | 1 => 1
  | n => getFib(n - 1) + getFib(n - 2)
  }
}

let runFibonacci: Tasks.Fibonacci.input => Promise.t<Tasks.Fibonacci.output> = input => {
  Promise.make((resolve, _reject) => {
    resolve(. {Tasks.Fibonacci.result: getFib(input.n)})
  })
}

Parent.port->Parent.on(
  #message(
    json => {
      switch json->Tasks.input_decode {
      | Ok(input) =>
        switch input {
        | Pause(input) =>
          runPause(input)
          ->Promise.thenResolve(output => {
            Parent.port->Parent.postMessage(Pause(output)->Tasks.output_encode)
          })
          ->ignore
        | Fibonacci(input) =>
          runFibonacci(input)
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
