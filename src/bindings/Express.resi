type request
type response = {send: (. string) => unit}

let status: (response, int) => response

type handler = (. request, response) => unit

type middleware

module App: {
  type t = {
    get: (. string, handler) => unit,
    listen: (. int, unit => unit) => unit,
    use: (. middleware) => unit,
  }

  let make: unit => t
}

let static: string => middleware
