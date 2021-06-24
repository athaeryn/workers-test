type cpuInfo = {
  model: string,
  speed: int,
}

@module("os")
external cpus: unit => array<cpuInfo> = "cpus"

let cpuCount = () => cpus()->Array.length
