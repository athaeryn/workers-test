type t = {pathname: string, href: string}

let make: string => t

let makeWithBase: (string, string) => t
