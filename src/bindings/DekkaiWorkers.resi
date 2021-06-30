module WorkerInterface: {
  let addTaskExecutor: {..} => unit
}

module WorkerWrapper: {
  let createWorker: (string, {"type": string}) => Promise.t<WorkerThreads.t>
}

module WorkerPool: {
  type t
  let make: array<WorkerThreads.t> => t

  type task
  let makeTask: (t, string, array<'input>) => task
  let scheduleTask: (t, task) => Promise.t<'result>
}
