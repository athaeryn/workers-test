@decco
type input = {howLongMs: int}

@decco
type output = {pausedFor: int}

let run = Piscina.run(~name="pause")

let execute = (input): Promise.t<output> => {
  Promise.make((resolve, _) => {
    Js.Global.setTimeout(() => {
      resolve(. {pausedFor: input.howLongMs})
    }, input.howLongMs)->ignore
  })
}
