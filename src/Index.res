let app = Express.App.make()

let init = Js.Date.now()
let now = () => {
  Js.Date.now() -. init
}

let taskPool = {
  open DekkaiWorkers
  let workerPath = Path.fromRoot(["src", "Worker.mjs"])

  Array.makeBy(Os.cpuCount(), _ => WorkerWrapper.createWorker(workerPath, {"type": "module"}))
  ->Promise.all
  ->Promise.thenResolve(WorkerPool.make)
}

app.get(."/pause", (. _req, res) => {
  let start = now()
  Js.log2("REQUEST Pause @", start)
  let _ =
    taskPool
    ->Promise.then(pool => {
      Worker.Tasks.Pause.run(pool, {delay: 2000})
    })
    ->Promise.thenResolve(output => {
      let finish = now()
      let time = Float.toString(finish -. start)
      Js.log(`COMPLETE Pause in ${time}ms`)
      res.send(. output->Worker.Tasks.Pause.output_encode->Js.Json.stringify)
    })
})

app.get(."/fibonacci", (. _req, res) => {
  let start = now()
  Js.log2("REQUEST Fibonacci @", start)
  let _ =
    taskPool
    ->Promise.then(pool => {
      Worker.Tasks.Fibonacci.run(pool, {n: 42})
    })
    ->Promise.thenResolve(output => {
      let finish = now()
      let time = Float.toString(finish -. start)
      Js.log(`COMPLETE Fibonacci in ${time}ms`)
      res.send(. output->Worker.Tasks.Fibonacci.output_encode->Js.Json.stringify)
    })
})

let staticPath = Path.fromRoot(["static"])
app.use(. Express.static(staticPath))

let port = 3030

app.listen(.port, () => {
  Js.log(j`Listening on port $port`)
  Js.log(j`Serving static resources from $staticPath`)

  Js.log(Os.cpuCount()->Int.toString ++ " CPUs")
  Js.log(Os.cpus()->Array.map(cpu => cpu.model))
})
