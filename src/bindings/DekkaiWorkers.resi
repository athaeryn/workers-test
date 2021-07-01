module type Task = {
  let id: string
  type input
  type output
  module Worker: {
    let run: input => Promise.t<Types.taskResult<output>>
  }
}

module TaskExecutor: {
  type t
  type executorFn
  let make: array<module(Task)> => t
}

module WorkerInterface: {
  let addTaskExecutor: TaskExecutor.t => unit
}

module WorkerWrapper: {
  let createWorker: (string, {"type": string}) => Promise.t<WorkerThreads.t>
}

module WorkerPool: {
  type t = Types.Dekkai.workerPool
  let make: array<WorkerThreads.t> => t

  type task
  let makeTask: (t, string, array<'input>) => task
  let scheduleTask: (t, task) => Promise.t<'result>
}
