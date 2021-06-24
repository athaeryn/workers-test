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
  @module
  external make: unit => t = "express"
}

@module("express")
external static: string => middleware = "static"
