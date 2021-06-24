Js.log2("hello from worker", Worker.threadId)

Worker.parentPort->Worker.on(
  #message(
    json => {
      Js.log2("Worker got message", json)
    },
  ),
)
