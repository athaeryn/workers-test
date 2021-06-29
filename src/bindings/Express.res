type request
type response = {send: (. string) => unit}

@send
external status: (response, int) => response = "status"

type handler = (. request, response) => unit

type middleware

module App = {
  type t = {
    get: (. string, handler) => unit,
    listen: (. int, unit => unit) => unit,
    use: (. middleware) => unit,
  }
  @module("express")
  external make: unit => t = "default"
}

@module("express") @scope("default")
external static: string => middleware = "static"
