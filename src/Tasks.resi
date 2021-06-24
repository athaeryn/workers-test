module Pause: {
  @decco
  type input = {howLongMs: int}

  @decco
  type output = {pausedFor: int}

  let run: input => Promise.t<output>
}

module Fibonacci: {
  @decco
  type input = {n: int}

  @decco
  type output = {result: int}

  let run: input => Promise.t<output>
}

@decco
type input = Pause(Pause.input) | Fibonacci(Fibonacci.input)

@decco
type output = Pause(Pause.output) | Fibonacci(Fibonacci.output)
