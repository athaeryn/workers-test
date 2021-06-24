type request
type response = {send: (. string) => unit}

let status: (response, int) => response

type handler = (. request, response) => unit

type middleware

type app = {
  get: (. string, handler) => unit,
  listen: (. int, unit => unit) => unit,
  use: (. middleware) => unit,
}

let createApp: unit => app

let static: string => middleware
