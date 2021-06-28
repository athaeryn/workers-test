open Tasks
open WorkerThreads

Js.log(j`Worker $threadId started`)

type task<'input, 'output> = 'input => Promise.t<'output>

let pause = Pause.execute
let fibonacci = Fibonacci.execute
