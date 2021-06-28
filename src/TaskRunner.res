open Tasks
open WorkerThreads

Js.log(j`Worker $threadId started`)

let pause = Pause.execute
let fibonacci = Fibonacci.execute
