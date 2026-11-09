local id

function init()
  id = entity.id()

  local time = world.time()
  if not storage.startTime or storage.startTime > time then
    storage.startTime = time
  end

  self.spawnTime = config.getParameter("burgerTime", 1000)
end

function update()
  local time = world.time()
  local diff = time - storage.startTime

  if diff > self.spawnTime then
    storage.startTime = time

    while diff > self.spawnTime do
      diff = diff - self.spawnTime
      local leftover = world.containerAddItems(id, "hamburger")
      if leftover then break end
    end
  end
end
