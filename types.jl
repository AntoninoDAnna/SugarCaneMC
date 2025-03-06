## sugar cane
mutable struct Sugar_cane
  height::UInt8 
  random_tick::UInt8 
  Sugar_cane() = new(1,0)
end

function Base.show(io::Core.IO,sc::Sugar_cane)
  print(io,"height = ", Int64(sc.height)," ")
  print(io,"random tick = ", Int64(sc.random_tick))
end

"""
    break_sugar_cane(sc::Sugar_cane)

It check if the sugar cane can be broken. If so, it break the sugar_cane.
when it break the sugar cane it also reset the random tick counter

Return the number of sugarcane harvested

"""
function break_sugar_cane(sc::Sugar_cane)
  aux = sc.height-1;
  if sc.height >1
    sc.height = 1;
    sc.random_tick = 0;
  end
  return aux;
end

function random_tick(sc::Sugar_cane)
  sc.random_tick+=1;
  if sc.random_tick >= max_random_tick
    sc.random_tick=max_random_tick
    return true;
  end
  return false;
end

function grow(sc::Sugar_cane)
  if sc.height < 3
    sc.height+=1; 
  end
  sc.random_tick = 0;
  return sc.height == max_height ## if it gets to max_heigth return true and trigger the observe (if present)
end

## Observer 
mutable struct Observer
  triggered::Bool 
  active::Bool 
  tick_since_active::UInt8
  position::UInt64;
  range::Vector{UInt64}
  Observer() = new(false,false,0,0,[0,0])
end

function Base.show(io::Core.IO,o::Observer)
  println(io,"Observer:")
  println(io," triggered          = ",o.triggered ? "true, " : "false, ")
  println(io," active             = ", o.active ? "true, " : "false, ")
  println(io," trick since active = $(Int64(o.tick_since_active)) ")
  println(io," position           = $(Int64(o.position)) ")
  println(io," range              = $(Int64.(range))")
end

function trigger(o::Observer)
  o.triggered = true;
end

function activate(o::Observer)
  o.active = true;
  o.triggered = false;
end

function deactivate(o::Observer)
  o.active = false;
  o.tick_since_active = 0;
end

function action(o::Observer)
  o.tick_since_active +=1
  if o.tick_since_active == 2
    deactivate(o)
    return false
  end
  return true
end

function apply_tick(o::Observer)
  if o.triggered 
    activate(o)
    return true
  elseif o.active
    return action(o::Observer)
  end
  return false
end

observer_range(o::Observer) = range(o.range...)

mutable struct Piston
  powered::Bool 
  depowered::Bool 
  extended::Bool 
  Piston() = new(false,false,false)
end

function Base.show(io::Core.IO,p::Piston)
  print(io,"Piston: ")
  print(io,"powered =",  p.powered   ? "true  " : "false ") 
  print(io,"depowered =",p.depowered ? "true  " : "false ") 
  print(io,"extended =", p.extended  ? "true  " : "false ")
end

function depowered(p::Piston)
  if !p.powered
    return
  end
  p.powered = false
  p.depowered =true 
end

function powered(p::Piston)
  p.powered = true;
end

function extend(p::Piston)
  p.extended = true;
end

function retract(p::Piston)
  p.extended = false
  p.depowered = false
end

"""
    apply_tick(p::Piston)

Applies tick to the piston. If is powered but not extended, then it extends. If it was depowered, it retracts

return true when extends to indicate that can break a sugar cane
"""
function apply_tick(p::Piston)
  if p.powered && !p.extended
    extend(p)
    return true;
  end
  if p.depowered
    retract(p)
  end
  return false
end



