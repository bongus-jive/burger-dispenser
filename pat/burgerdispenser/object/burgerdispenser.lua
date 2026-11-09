local id, center
local spawnTime

function init()
  id = entity.id()

  local b = object.boundBox()
  center = {
    b[1] + (b[3] - b[1]) / 2,
    b[2] + (b[4] - b[2]) / 2
  }

  local time = world.time()
  if not storage.startTime or storage.startTime > time then
    storage.startTime = time
  end

  spawnTime = config.getParameter("burgerTime", 1000)
end

function update()
  local time = world.time()
  local diff = time - storage.startTime

  if diff > spawnTime then
    storage.startTime = time

    while diff > spawnTime do
      diff = diff - spawnTime
      local leftover = world.containerAddItems(id, "hamburger")
      if leftover then break end
    end
  end
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
