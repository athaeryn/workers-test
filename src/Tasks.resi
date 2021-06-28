module Pause: {
  @decco
  type input = {howLongMs: int}

  @decco
  type output = {pausedFor: int}

  let run: Piscina.run<input, output>
  let execute: input => Promise.t<output>
}

module Fibonacci: {
  @decco
  type input = {n: int}

  @decco
  type output = {result: int}

  let run: Piscina.run<input, output>
  let execute: input => Promise.t<output>
}
