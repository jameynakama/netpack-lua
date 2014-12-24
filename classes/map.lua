Map = {}

function Map:new(options)
  local instance = {}
  setmetatable(instance, self)
  self.__index = self

  instance.matrix = {}
  for x=1, LEVEL_WIDTH do
    instance.matrix[x] = {}
    for y=1, LEVEL_HEIGHT do
      -- we need 'floor' objects since it's #unhappiness to have nil values in a table
      instance.matrix[x][y] = {Thing:new{character=" ", color="#333"}}
    end
  end

  return instance
end

function Map:draw()
  for x, col in ipairs(self.matrix) do
    for y, things in ipairs(col) do
      display:write(things[#things].character, x, y, things[#things].color)
    end
  end
end

function Map:is_blocked(position)
  local x = position[1]
  local y = position[2]

  -- invalid locations
  if (x < 1 or x > LEVEL_WIDTH) or (y < 1 or y > LEVEL_HEIGHT) then
    return true
  end

  -- solids
  things = self.matrix[x][y]
  for i, thing in ipairs(things) do
    if thing.solid then
      return thing
    end
  end

  return false
end

function Map:get_collectibles(position)
  local x = position[1]
  local y = position[2]

  local collectibles = {}
  for i, thing in ipairs(self.matrix[x][y]) do
    if thing.collectible then
      table.remove(self.matrix[x][y])
      table.insert(collectibles, thing)
    end
  end
  return collectibles
end
