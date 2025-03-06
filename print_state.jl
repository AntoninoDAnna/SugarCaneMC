function print_state(io::Core.IO ,sc::Vector{Sugar_cane},p::Vector{Piston},o::Vector{Observer})
  obs_pos = getfield.(o,:position)
  Obs = Any[0 for i in 1:Ns]
  Obs[obs_pos]=o;
  for i in 1:Ns
    @printf io "i %d: [%d,%d] \t [%d, %d, %d] " i sc[i].height sc[i].random_tick p[i].extended p[i].powered p[i].depowered
    if Obs[i] ==0 
      print(io,"\n")
    else
      @printf io "\t [%d,%d] \n" Obs[i].triggered Obs[i].active
    end
  end
end
