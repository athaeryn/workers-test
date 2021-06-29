# Workers test

Prototyping a system for running CPU-intensive tasks without blocking an express
server from responding to new requests.

Run both of these processes:

```sh
# Compile ReScript (and watch for changes)
npm run res:watch

# Run the server
npm run start
```

Open http://localhost:3030 and click the buttons. Observe the logs in the
browser and from the server process.
