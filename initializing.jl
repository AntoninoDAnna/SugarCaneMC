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
function set_observers(obs::Vector{Observer}, mode::Int64,range_mode::Int64; Ns::Int64, No::Int64)
  if mode ==1
    aux = sort(Random.shuffle(1:Ns)[1:No]);
    @inbounds for i in 1:No
      obs[i].position = aux[i]  
      obs[i].range = [aux[i]>14 ? aux[i]-14 : 0,aux[i]<Ns-14 ? aux[i]+14 : Ns]
    end
  elseif mode ==2
    n  = div(Ns,No); # number of sugarcanes for each observers
    aux = range(start = div(n-1,2)+1, length = No, step = n)
    @inbounds for i in 1:10 
      obs[i].position = aux[i]
      obs[i].range = [aux[i]>14 ? aux[i]-14 : 0,aux[i]<Ns-14 ? aux[i]+14 : Ns]
    end   
  end 
  if range_mode ==1
    @inbounds for i in 2:No
      r = range(obs[i-1].position,obs[i].position)
      while true
        covered = [range(obs[i-1].range...)...;range(obs[i].range...)...]
        if all(x-> x in covered, r)
          break;
        end
        obs[i-1].range[2] +=15
        obs[i].range[1] -=15
      end
    end
    # left of first obs
    obs[1].range[1] =1
    obs[end].range[2]=Ns
  elseif range_mode ==2
    [o.range=[1,Ns] for o in obs]
  end

end
