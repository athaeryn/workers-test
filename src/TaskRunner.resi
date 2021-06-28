open Tasks
type task<'input, 'output> = 'input => Promise.t<'output>

let pause: task<Pause.input, Pause.output>
let fibonacci: task<Fibonacci.input, Fibonacci.output>
