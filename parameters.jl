const seed = 1234
const Ns = 100; #number of sugarcanes
const No = 10; #numbers of observers
const mode = 2; #how to organize observers: 1 = randomly, 2 =optimized
const MC_length = 10000
## sugar cane constants
const prob::Float64 = 3.0/4096.0 # assuming RandomTickSpeed is 3
const max_random_tick::Int64 = 16;
const max_height::Int64 = 3

## Observer constants
const max_obs_capacity = 29 # 14 per side plus the one below 