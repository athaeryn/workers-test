module Pause: {
  @decco
  type input = {howLongMs: int}

  @decco
  type output = {pausedFor: int}
}

module Fibonacci: {
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

let createPool: unit => pool
