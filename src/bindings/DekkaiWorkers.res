module WorkerInterface = {
  @module("@dekkai/workers") @scope("WorkerInterface")
  external addTaskExecutor: {..} => unit = "addTaskExecutor"
}

module WorkerWrapper = {
  @module("@dekkai/workers") @scope("WorkerWrapper")
  external createWorker: (string, {"type": string}) => Promise.t<WorkerThreads.t> = "createWorker"
}

module WorkerPool = {
  type t

  type task

  @module("@dekkai/workers") @new
  external make: array<WorkerThreads.t> => t = "WorkerPool"

  @send
  external makeTask: (t, string, array<'input>) => task = "makeTask"

  @send
  external scheduleTask: (t, task) => Promise.t<'result> = "scheduleTask"
}
