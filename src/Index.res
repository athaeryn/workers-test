let app = Express.createApp()

let worker = Worker.make(Path.join([Path.dirname, "Worker_Entry.bs.js"]))
let _worker2 = Worker.make(Path.join([Path.dirname, "Worker_Entry.bs.js"]))

app.get(."/fake_api", (. _req, res) => {
  res.send(. "Hello from the fake API!")
})

app.use(. Express.static(Path.join([Path.dirname, "..", "static"])))

let port = 3030

app.listen(.port, () => {
  Js.log(j`listening on port $port`)
  worker->Worker.postMessage({"data": "test123"})
})
