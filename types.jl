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
  if sc.height <= 3
    sc.height+=1; 
  end
  return sc.height == max_height ## if it gets to max_heigth return true and trigger the observe (if present)
end

## Observer 
mutable struct Observer
  triggered::Bool 
  active::Bool 
  tick_since_active::UInt8
  position::UInt64;
  n_repeater_l::UInt64;
  n_repeater_r::UInt64;
  Observer() = new(false,false,0,0,0,0)
end

function trigger(o::Observer)
  o.triggerd = true;
end

function activate(o::Observer)
  o.active = true;
  o.trigger = false;
end

function deactivate(o::Observer)
  o.active = false;
end

function action(o::Observer)
  tick_since_active +=1
  if tick_since_active == 2
    deactivate(o)
  end
end

function apply_tick(o::Observer)
  if o.triggered 
    activate(o)
  elseif o.active
    action(o::Observer)
  end
end

function observer_range(o::Observer)
  left  =o.position - (14 + 15*o.n_repeater_l)
  right =o.position + (14 + 15*o.n_repeater_r)
  left = left<1 ? 1 : left
  right = right>Ns ? Ns : right
  return left:right
end

mutable struct Piston
  powered::Bool 
  depowered::Bool 
  extended::Bool 
  Piston() = new(false,false,false)
end

function powered(p::Piston)
  p.powered = true;
end

function extend(p::Piston)
  p.extended = true;
end

function retract(p::Piston)
  p.extend = false
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



