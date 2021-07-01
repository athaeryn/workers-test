module type Task = {
  let id: string
  type input
  type output
  module Worker: {
    let run: input => Promise.t<Types.taskResult<output>>
  }
}

module TaskExecutor = {
  type executorFn
  type t = Js.Dict.t<executorFn>

  let make = (tasks: array<module(Task)>) => {
    tasks
    ->Array.map(task => {
      let module(T) = task
      (T.id, T.Worker.run->Obj.magic)
    })
    ->Js.Dict.fromArray
  }
}

module WorkerInterface = {
  @module("@dekkai/workers") @scope("WorkerInterface")
  external addTaskExecutor: TaskExecutor.t => unit = "addTaskExecutor"
}

module WorkerWrapper = {
  @module("@dekkai/workers") @scope("WorkerWrapper")
  external createWorker: (string, {"type": string}) => Promise.t<WorkerThreads.t> = "createWorker"
}

module WorkerPool = {
  type t = Types.Dekkai.workerPool

  @module("@dekkai/workers") @new
  external make: array<WorkerThreads.t> => t = "WorkerPool"

  type task

  @send
  external makeTask: (t, string, array<'input>) => task = "makeTask"

  @send
  external scheduleTask: (t, task) => Promise.t<'result> = "scheduleTask"
}
