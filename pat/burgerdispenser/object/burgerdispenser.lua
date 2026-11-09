local id
local spawnTime

function init()
  id = entity.id()

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
