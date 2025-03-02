"""
    set_observers(obs::Vector{Observers}, mode::Int64)
  
set the observers in their position according to `mode`.

## Modes:
  - `mode = 1`: the observers are set randomly
  - `mode = 2`: the observers are set in their optimal position, i.e each observer influences the `Ns ÷ No` sugarcanes. 

## Repeaters:

Once the observers are set, we check the distance between consecutive observers and check whether repeaters are needed.
We assume that each observer influence `14` sugarcanes on each side. Therefore if the distance is larger that 28 we add repeaters to extend the influence of the observers
We add a repeaters to both observers and then check again if there are uneffected sugarcanes. If so we add another repeater and so on.
WARNING: Repeaters are not simulated as in Minecraft, we assume they transfer power immediately.

"""
function set_observers(obs::Vector{Observer}, mode::Int64)
  if mode ==1
    aux = Random.shuffle(1:Ns)[1:No];
    @inbounds for i in 1:No
      obs[i].position = aux[i]
    end
  elseif mode ==2
    n  = div(Ns,No); # number of sugarcanes for each observers
    aux = range(start = div(n-1,2)+1, length = No, step = n)
    @inbounds for i in 1:10 
      obs[i].position = aux[i]
    end   
  end   
  @inbounds for i in 2:No
    d = obs[i].position -obs[i-1].position + 1
    while true
      max_cap = 2*14 + 15*(obs[i].n_repeater_l+obs[i].n_repeater_r)
      if d<= max_cap
        break;
      end
      obs[i].n_repeater_l+=1;
      obs[i-1].n_repeater_r+=1;
    end
  end
  # left of first obs
  d = obs[1].position-1
  while true
    max_cap = 14 + 15*obs[1].n_repeater_l
    if d<= max_cap
      break;
    end
    obs[1].n_repeater_l+=1;
  end

  ##right of last obs 
  d = obs[end].position-1
  while true
    max_cap = 14 + 15*obs[end].n_repeater_r
    if d<= max_cap
      break;
    end
    obs[end].n_repeater_r+=1;
  end

end
