const seed = 1234
const Ns = 5; #number of sugarcanes
const No = 1; #numbers of observers
const mode = 1; #how to organize observers: 1 = randomly, 2 =optimized
const range_mode = 1;
MC_length = 100 # 20*60*60*2 #2h simulation 
## sugar cane constants
const prob::Float64 = 0.5 #3.0/4096.0 # assuming RandomTickSpeed is 3
const max_random_tick::Int64 = 3;
const max_height::Int64 = 3

## Observer constants
const max_obs_capacity = 29 # 14 per side plus the one below 
