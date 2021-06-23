let app = Express.createApp()

app.get(."/fake_api", (. _req, res) => {
  res.send(. "Hello from the fake API!")
})

app.use(. Express.static(Path.join([Path.dirname, "..", "static"])))

let port = 3030

app.listen(.port, () => {
  Js.log(j`listening on port $port`)
})
