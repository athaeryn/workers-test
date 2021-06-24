module Pause = {
  @decco
  type input = {howLongMs: int}

  @decco
  type output = {pausedFor: int}

  let run = input => {
    Promise.make((resolve, _) => {
      Js.Global.setTimeout(() => {
        resolve(. {pausedFor: input.howLongMs})
      }, input.howLongMs)->ignore
    })
  }
}

module Fibonacci = {
  @decco
  type input = {n: int}

  @decco
  type output = {result: int}

  let rec getFib = n => {
    switch n {
    | 0 => 0
    | 1 => 1
    | n => getFib(n - 1) + getFib(n - 2)
    }
  }

  let run = input => {
    Promise.make((resolve, _reject) => {
      resolve(. {result: getFib(input.n)})
    })
  }
}

@decco
type input = Pause(Pause.input) | Fibonacci(Fibonacci.input)

@decco
type output = Pause(Pause.output) | Fibonacci(Fibonacci.output)
