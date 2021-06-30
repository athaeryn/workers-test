type taskResult<'a> = {result: 'a}
type runTask<'input, 'output> = (DekkaiWorkers.WorkerPool.t, 'input) => Promise.t<'output>
