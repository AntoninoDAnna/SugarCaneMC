"""
    to_binary

convert to compact binary form in little endian format
"""
function to_binary(sc::Sugar_cane)
  ## 2 bit for max height plus 4 for random tick
  rt = sc.random_tick == max_random_tick ? 0x00 : sc.random_tick
  x = sc.height + rt << 2
  if x>0b00111111 ## this correspond to height = 3, random_tick = 15
    @warn "sugar cane $sc is in overflow!"
  end
  return x;
end

function to_binary(o::Observer)
  x = 0b0
  if o.triggered
    x+=0b1
  end
  if o.active
    x+=0b10
  end
  x+=UInt8(o.tick_since_active<<2) 
  return Union{UInt8,UInt64}[x o.position o.n_repeater_l o.n_repeater_r] 
end

function to_binary(p::Piston)
  x = 0b0
  if p.powered
    x+=0b1
  end
  if p.depowered 
    x+=0b10
  end
  if p.extended
    x+=0b100
  end
  return x;
end

save(f::Core.IO,sc::Vector{Sugar_cane}) = write(f,htol.(to_binary.(sc)))

save(f::Core.IO,p::Vector{Piston}) = write(f,htol.(to_binary.(p)))

function save(f::Core.IO,o::Vector{Observer})
  data = vcat(to_binary.(o)...)
  write(f,htol.(UInt8.(data[:,1]))) ## bools and tick since active
  write(f,htol.(UInt64.(data[:,2]))) ## positions
  write(f,htol.(UInt64.(data[:,3]))) ## repeaters_l
  write(f,htol.(UInt64.(data[:,4]))) ## repeaters_r
end

function save(f,sc::Vector{Sugar_cane},p::Vector{Piston},obs::Vector{Observer})
  save(f,sc)
  save(f,p)
  save(f,obs)
end
