using Random, Printf
include("parameters.jl")
include("types.jl")
include("initializing.jl")
include("print_state.jl")
include("save_and_read_data.jl")


rng = Random.MersenneTwister();


for (prob,Ns,No) in parameters

  @info "starting simulation at prob =$prob, Ns = $Ns, No = $No"
  sugar_canes = [Sugar_cane() for _ in 1:Ns];
  pistons     = [Piston() for _ in 1:Ns];
  observers   = [Observer() for _ in 1:No];
  harvest     = zeros(UInt32,MC_length);

  set_observers(observers, mode,range_mode, Ns=Ns, No=No);
  obs_positions = getfield.(observers,:position)

  sc_data       = open("data/SugarCane_Ns_$(Ns)_No_$(No)_p_$(round(prob,digits=6))_length_$(MC_length).dat","w")
  harverst_data = open("data/Harvest_Ns_$(Ns)_No_$(No)_p_$(round(prob,digits=6))_length_$(MC_length).dat","w") 
  LOG           = open("log/SugarCaneMC_Ns_$(Ns)_No_$(No)_p_$(round(prob,digits=6))_length_$(MC_length).log","w")
  for tick in 1:MC_length
    if tick%2 ==0 ## 1 redstone tick = 2 game ticks
      for i in 1:Ns
        if apply_tick(pistons[i])
          harvest[tick] += break_sugar_cane(sugar_canes[i])
        end
      end
      for i in 1:No
        if apply_tick(observers[i])
          powered.(pistons[observer_range(observers[i])])
        end
      end
      for i in 1:Ns
        if !pistons[i].powered
          continue
        end
        j = findall(o->o.range[1] <= i <=o.range[2], observers)
        if any(getfield.(observers[j],:active))
          continue;
        end
        depowered(pistons[i])
      end
    end

    for i in 1:Ns ## for all sugar canes
      if rand(rng)> prob;
        continue;
      end
      if !random_tick(sugar_canes[i],p=prob)
        continue;
      end
      if pistons[i].extended 
        continue;
      end
      if !grow(sugar_canes[i]) ## grow the sugarcane and if height ==max_height return true
        continue;
      end
      if i in obs_positions
        trigger(observers[findfirst(obs_positions.==i)])
      end
    end  
    @printf LOG "sugar cane harvested: %d \n" harvest[tick] 
    @printf LOG "tick: %d\n" tick
    print_state(LOG,sugar_canes,pistons,observers, Ns=Ns, No=No)
    ##saving data
    save(sc_data,sugar_canes)
  end

  write(harverst_data,harvest)
  close(harverst_data)
  close(LOG)
  close(sc_data)

end