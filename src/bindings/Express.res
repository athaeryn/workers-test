type request
type response = {send: (. string) => unit}

@send
external status: (response, int) => response = "status"

type handler = (. request, response) => unit

type middleware

type app = {
  get: (. string, handler) => unit,
  listen: (. int, unit => unit) => unit,
  use: (. middleware) => unit,
}

@module
external createApp: unit => app = "express"

@module("express")
external static: string => middleware = "static"
