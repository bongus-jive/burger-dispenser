local id

function init()
  id = entity.id()

  local time = world.time()
  if not storage.startTime or storage.startTime > time then
    storage.startTime = time
  end

  self.spawnTime = config.getParameter("burgerTime", 1000)
  
  self.poolItems = {}
  self.totalWeight = 0

  for _, opt in ipairs(config.getParameter("burgerItems", {})) do
    if root.itemConfig(opt.item) then
      self.poolItems[#self.poolItems + 1] = opt
      self.totalWeight = self.totalWeight + opt.weight
    end
  end
end

function update()
  local time = world.time()
  local diff = time - storage.startTime

  if diff > self.spawnTime then
    storage.startTime = time

    while diff > self.spawnTime do
      diff = diff - self.spawnTime
      if not addItem() then break end
    end
  end
end

function addItem()
  local roll = math.random() * self.totalWeight
  for _, opt in ipairs(self.poolItems) do
    roll = roll - opt.weight
    if roll < 0 then
      return world.containerAddItems(id, opt.item) == nil
    end
  end
end
