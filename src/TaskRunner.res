open Tasks
open WorkerThreads

Js.log(j`Worker $threadId | start`)

let pause = Pause.execute
let fibonacci = Fibonacci.execute
