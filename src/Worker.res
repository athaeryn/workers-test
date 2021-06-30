DekkaiWorkers.WorkerInterface.addTaskExecutor({
  open DekkaiWorkers.TaskExecutor
  make()
  ->add(Tasks.Pause.id, Tasks.Pause.Worker.run)
  ->add(Tasks.Fibonacci.id, Tasks.Fibonacci.Worker.run)
})
