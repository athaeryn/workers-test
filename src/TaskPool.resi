type t = {run: Tasks.input => Promise.t<result<Tasks.output, string>>}

let make: unit => t
