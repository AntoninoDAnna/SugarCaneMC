## sugar cane
mutable struct Sugar_cane
  height::Int64 
  random_tick::Int64 
  Sugar_cane() = new(1,0)
end

function break_sugar_cane(sc::Sugar_cane)
  sc.height = 1;
  sc.random_tick = 0;
end

function random_tick(sc::Sugar_cane)
  sc.random_tick+=1;
  if sc.random_tick >= max_random_tick
    return true;
  end
  return false;
end

function grow(sc::Sugar_cane)
  if sc.height == 3
    return false
  end
  sc.height+=1; 
  return sc.height == max_height ## if it gets to max_heigth return true and trigger the observe (if present)
end

## Observer 
mutable struct Observer
  triggered::Bool 
  active::Bool 
  tick_since_active::Int64 
  position::Int64;
  n_repeater_l::Int64;
  n_repeater_r::Int64;
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

function apply_tick(p::Piston)
  if p.powered
    extend(p)
  elseif p.depowered
    retract(p)
  end
end

