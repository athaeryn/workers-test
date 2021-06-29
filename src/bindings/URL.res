type t = {pathname: string, href: string}

@new
external make: string => t = "URL"

@new
external makeWithBase: (string, string) => t = "URL"
