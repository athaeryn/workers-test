type taskResult<'a> = {result: 'a}
type runTask<'input, 'output> = (DekkaiWorkers.WorkerPool.t, 'input) => Promise.t<'output>

module Tasks = {
  module Fibonacci = {
    type input = {n: int}

    @decco.encode
    type output = {fib: int}

    let run: runTask<input, output> = (pool, input) => {
      let task = DekkaiWorkers.WorkerPool.makeTask(pool, "fibonacci", [input])
      pool->DekkaiWorkers.WorkerPool.scheduleTask(task)
    }

    module Worker: {
      let run: input => taskResult<output>
    } = {
      let rec getFib = n => {
        switch n {
        | 0 => 0
        | 1 => 1
        | n => getFib(n - 1) + getFib(n - 2)
        }
      }

      let run = ({n}) => {result: {fib: getFib(n)}}
    }
  }

  module Pause = {
    type input = {delay: int}

    @decco
    type output = {pausedForMs: int}

    let run: runTask<input, output> = (pool, input) => {
      let task = DekkaiWorkers.WorkerPool.makeTask(pool, "pause", [input])
      pool->DekkaiWorkers.WorkerPool.scheduleTask(task)
    }

    module Worker: {
      let run: input => Promise.t<taskResult<output>>
    } = {
      let setTimeout = delay => {
        Promise.make((resolve, _) => {
          let _ = Js.Global.setTimeout(() => {
            resolve(. delay)
          }, delay)
        })
      }
      let run = ({delay}) => setTimeout(delay)->Promise.thenResolve(d => {result: {pausedForMs: d}})
    }
  }
}

DekkaiWorkers.WorkerInterface.addTaskExecutor({
  "fibonacci": Tasks.Fibonacci.Worker.run,
  "pause": Tasks.Pause.Worker.run,
})
