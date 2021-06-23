type request
type response = {send: (. string) => unit}

type handler = (. request, response) => unit

type app = {
  get: (. string, handler) => unit,
  listen: (. int, unit => unit) => unit,
}

@module
external createApp: unit => app = "express"
