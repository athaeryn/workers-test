type cpuInfo = {
  model: string,
  speed: int,
}

let cpus: unit => array<cpuInfo>

let cpuCount: unit => int
