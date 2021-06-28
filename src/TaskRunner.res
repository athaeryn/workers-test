open WorkerThreads

Js.log(j`Worker $threadId started`)

let pause = Tasks.Pause.execute
let fibonacci = Tasks.Fibonacci.execute
