import Random
include("parameters.jl")
include("types.jl")
include("initializing.jl")

rng = Random.MersenneTwister(seed);

sugar_canes = fill(Sugar_cane(),Ns);
pistons     = fill(Pistons(),Ns);
observers   = fill(Observer,No);

set_observers(observers, mode);