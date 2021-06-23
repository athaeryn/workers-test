let app = Express.createApp()

app.get(."/", (. _req, res) => {
  res.send(. "Hello world")
})

let port = 3030

app.listen(.port, () => {
  Js.log(j`listening on port $port`)
})
