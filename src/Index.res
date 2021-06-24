let app = Express.App.make()

let taskPool = TaskPool.make()

app.get(."/pause", (. _req, res) => {
  taskPool.run(Pause({howLongMs: 4200}))
  ->Promise.thenResolve(result => {
    switch result {
    | Ok(output) => res.send(. output->Tasks.output_encode->Js.Json.stringify)
    | Error(message) => Express.status(res, 500).send(. message)
    }
  })
  ->ignore
})

app.get(."/fibonacci", (. _req, res) => {
  taskPool.run(Fibonacci({n: 45}))
  ->Promise.thenResolve(result => {
    switch result {
    | Ok(output) => res.send(. output->Tasks.output_encode->Js.Json.stringify)
    | Error(message) => Express.status(res, 500).send(. message)
    }
  })
  ->ignore
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
