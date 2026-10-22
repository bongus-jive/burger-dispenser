local id, center

function init()
  id = entity.id()

  local b = object.boundBox()
  center = {
    b[1] + (b[3] - b[1]) / 2,
    b[2] + (b[4] - b[2]) / 2
  }
end

function update()
  world.containerAddItems(id, "hamburger")
end

function containerCallback()
  filterItems()
end

function die()
  filterItems()
  world.containerTakeAll(id)
end

local slots
function filterItems()
  if not slots then slots = world.containerSize(id) - 1 end

  for i = 0, slots do
    local item = world.containerItemAt(id, i)
    if item and item.name ~= "hamburger" then
      world.containerTakeAt(id, i)
      world.spawnItem(item, center, nil, nil, nil, 0.25)
    end
  end
end
