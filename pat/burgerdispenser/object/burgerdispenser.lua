require "/scripts/vec2.lua"
require "/scripts/util.lua"

function init()
  slot = 0
end

function update(dt)
  for i = 0, 3 do
    local currentitem = world.containerItemAt(entity.id(), i)
    if (not currentitem or (currentitem.name ~= "hamburger" or (currentitem.name == "hamburger" and currentitem.count > 1))) and i ~= 3 then
      slot = i
      break
    end
    
    if i == 3 then
      slot = util.wrap(slot + 1, 0, 2)
      break
    end
  end
  
  local currentitem = world.containerItemAt(entity.id(), slot)
  if currentitem and (currentitem.name ~= "hamburger" or (currentitem.name == "hamburger" and currentitem.count > 1)) then
    if currentitem.name == "hamburger" then
      currentitem.count = currentitem.count - 1
    end
    world.spawnItem(currentitem, vec2.add(world.entityPosition(entity.id()), {0, 1}), 1, {}, vec2.rotate({0, 25}, util.toRadians(math.random(-45, 45))), 0.25)
  end
  world.containerSwapItemsNoCombine(entity.id(), {name = "hamburger"}, slot)
end