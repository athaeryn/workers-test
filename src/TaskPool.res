type t = {run: Tasks.input => Promise.t<result<Tasks.output, string>>}

let make = () => {
  let workerCount = Os.cpuCount()

  Js.log(j`creating pool of $workerCount workers...`)

  // TODO create multiple (workerCount) workers
  let workerPath = Path.fromRoot(["src", "TaskRunner.bs.js"])

  let worker = WorkerThreads.make(workerPath)

  {
    run: input => {
      Promise.make((resolve, _reject) => {
        worker->WorkerThreads.postMessage(input->Tasks.input_encode)
        worker->WorkerThreads.once(
          #message(
            json => {
              Js.log(json)
              let output = switch Tasks.output_decode(json) {
              | Ok(output) => Ok(output)
              | Error({message}) => Error(message)
              }
              resolve(. output)
            },
          ),
        )
      })
    },
  }
}
