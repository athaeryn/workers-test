type input = {n: int}

@decco.encode
type output = {fib: int}

let run: Types.runTask<input, output> = (pool, input) => {
  let task = DekkaiWorkers.WorkerPool.makeTask(pool, "fibonacci", [input])
  pool->DekkaiWorkers.WorkerPool.scheduleTask(task)
}

module Worker = {
  let rec getFib = n => {
    switch n {
    | 0 => 0
    | 1 => 1
    | n => getFib(n - 1) + getFib(n - 2)
    }
  }

  let run = ({n}) => {Types.result: {fib: getFib(n)}}
}
