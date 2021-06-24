@module("path") @variadic
external join: array<string> => string = "join"

@val
external dirname: string = "__dirname"

let projectRoot = join([dirname, "..", ".."])

let fromRoot = paths => join([projectRoot]->Array.concat(paths))
