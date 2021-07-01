module Dekkai: {
  type workerPool
}

type taskResult<'a> = {result: 'a}
type runTask<'input, 'output> = (Dekkai.workerPool, 'input) => Promise.t<'output>
