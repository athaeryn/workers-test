let app = Express.App.make()

let init = Js.Date.now()
let now = () => {
  Js.Date.now() -. init
}

let taskPool = {
  open DekkaiWorkers
  let workerPath = Path.fromRoot(["src", "Worker.mjs"])

  let workerCount = Os.cpuCount()

  Array.makeBy(workerCount, _ => WorkerWrapper.createWorker(workerPath, {"type": "module"}))
  ->Promise.all
  ->Promise.thenResolve(WorkerPool.make)
  ->Promise.thenResolve(pool => {
    Js.log(j`Task pool workers: $workerCount`)
    pool
  })
}

app.get(."/pause", (. _req, res) => {
  let start = now()
  Js.log2("REQUEST Pause @", start)
  let _ =
    taskPool
    ->Promise.then(pool => {
      Tasks.Pause.run(pool, {delay: 2000})
    })
    ->Promise.thenResolve(output => {
      let finish = now()
      let time = Float.toString(finish -. start)
      Js.log(`COMPLETE Pause in ${time}ms`)
      res.send(. output->Tasks.Pause.output_encode->Js.Json.stringify)
    })
})

app.get(."/fibonacci", (. _req, res) => {
  let start = now()
  Js.log2("REQUEST Fibonacci @", start)
  let _ =
    taskPool
    ->Promise.then(pool => {
      Tasks.Fibonacci.run(pool, {n: 42})
    })
    ->Promise.thenResolve(output => {
      let finish = now()
      let time = Float.toString(finish -. start)
      Js.log(`COMPLETE Fibonacci in ${time}ms`)
      res.send(. output->Tasks.Fibonacci.output_encode->Js.Json.stringify)
    })
})

app.use(. Express.static(Path.fromRoot(["static"])))

let port = 3030

app.listen(.port, () => {
  Js.log(j`Listening on port $port`)
})
