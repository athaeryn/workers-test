@decco
type input = {n: int}

@decco
type output = {result: int}

let run = Piscina.run(~name="fibonacci")

let rec getFib = n => {
  switch n {
  | 0 => 0
  | 1 => 1
  | n => getFib(n - 1) + getFib(n - 2)
  }
}

let execute = input => {
  Promise.make((resolve, _reject) => {
    resolve(. {result: getFib(input.n)})
  })
}
