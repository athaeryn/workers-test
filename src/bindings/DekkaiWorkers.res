module TaskExecutor = {
  type executorFn
  type t = Js.Dict.t<executorFn>

  let make = () => Js.Dict.empty()

  let add = (t, id, fn) => {
    t->Js.Dict.set(id, fn->Obj.magic)
    t
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
  type t

  @module("@dekkai/workers") @new
  external make: array<WorkerThreads.t> => t = "WorkerPool"

  type task

  @send
  external makeTask: (t, string, array<'input>) => task = "makeTask"

  @send
  external scheduleTask: (t, task) => Promise.t<'result> = "scheduleTask"
}
