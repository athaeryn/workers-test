type task<'input, 'output> = 'input => Promise.t<'output>

module Pause = Tasks_Pause
module Fibonacci = Tasks_Fibonacci
