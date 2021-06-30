type input = {delay: int}

@decco.encode
type output = {pausedForMs: int}

let run: Types.runTask<input, output> = (pool, input) => {
  let task = DekkaiWorkers.WorkerPool.makeTask(pool, "pause", [input])
  pool->DekkaiWorkers.WorkerPool.scheduleTask(task)
}

module Worker = {
  let setTimeout = delay => {
    Promise.make((resolve, _) => {
      let _ = Js.Global.setTimeout(() => {
        resolve(. delay)
      }, delay)
    })
  }
  let run = ({delay}) =>
    setTimeout(delay)->Promise.thenResolve(d => {Types.result: {pausedForMs: d}})
}
