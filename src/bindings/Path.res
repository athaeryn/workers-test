@module("path") @variadic
external join: array<string> => string = "join"

@module("path")
external dirname: string => string = "dirname"

let fromRoot = paths =>
  join([dirname(URL.make(Import.Meta.url).pathname), "..", ".."]->Array.concat(paths))
