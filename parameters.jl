const seed = 1234
# Ns = 5; #number of sugarcanes
# No = 1; #numbers of observers
const mode = 1; #how to organize observers: 1 = randomly, 2 =optimized
const range_mode = 2; # 1 => minimal number of repeaters, 2=> every observer triggers all the pistons
const MC_length = 100 # 20*60*60*2 #2h simulation 
## sugar cane constants
# prob::Float64 = 0.5 #3.0/4096.0 # assuming RandomTickSpeed is 3
const max_random_tick::Int64 = 3;
const max_height::Int64 = 3

## Observer constants
const max_obs_capacity = 29 # 14 per side plus the one below 


# simulation parameters
parameters = [
  # prob               Ns    No
  (0.000732421875    , 10  , 1   ),
  (0.000732421875    , 10  , 2   ),
  (0.000732421875    , 10  , 3   ),
  (0.000732421875    , 10  , 5   ),
  (0.001             , 10  , 5   ),
  (0.01              , 10  , 5   ),
  (0.1               , 10  , 5   ),
  (0.000732421875    , 10  , 7   ),
  (0.000732421875    , 10  , 8   ),
  (0.000732421875    , 10  , 9   ),
  (0.000732421875    , 10  , 10  ),
  (0.000732421875    , 20  , 1   ),
  (0.000732421875    , 20  , 5   ),
  (0.000732421875    , 20  , 8   ),
  (0.000732421875    , 20  , 9   ),
  (0.000732421875    , 20  , 10  ),
  (0.001             , 20  , 10  ),
  (0.01              , 20  , 10  ),
  (0.1               , 20  , 10  ),
  (0.000732421875    , 20  , 15  ),
  (0.000732421875    , 20  , 20  ),
  (0.000732421875    , 40  , 1   ),
  (0.000732421875    , 40  , 8   ),
  (0.000732421875    , 40  , 9   ),
  (0.000732421875    , 40  , 10  ),
  (0.000732421875    , 40  , 20  ),
  (0.001             , 40  , 20  ),
  (0.01              , 40  , 20  ),
  (0.1               , 40  , 20  ),
  (0.000732421875    , 40  , 30  ),
  (0.000732421875    , 40  , 50  ),
  (0.000732421875    , 60  , 1   ),
  (0.000732421875    , 60  , 8   ),
  (0.000732421875    , 60  , 9   ),
  (0.000732421875    , 60  , 10  ),
  (0.000732421875    , 60  , 15  ),
  (0.000732421875    , 60  , 30  ),
  (0.000732421875    , 60  , 45  ),
  (0.000732421875    , 60  , 60  ),
  (0.000732421875    , 80  , 1   ),
  (0.000732421875    , 80  , 8   ),
  (0.000732421875    , 80  , 9   ),
  (0.000732421875    , 80  , 10  ),
  (0.000732421875    , 80  , 20  ),
  (0.000732421875    , 80  , 40  ),
  (0.000732421875    , 80  , 60  ),
  (0.000732421875    , 80  , 80  ),
  (0.000732421875    , 100 , 1   ),
  (0.000732421875    , 100 , 8   ),
  (0.000732421875    , 100 , 9   ),
  (0.000732421875    , 100 , 10  ),
  (0.000732421875    , 100 , 25  ),
  (0.000732421875    , 100 , 50  ),
  (0.000732421875    , 100 , 75  ),
  (0.000732421875    , 100 , 10  ),
]