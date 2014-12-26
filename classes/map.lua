Map = {}

function Map:new(filename)
  local instance = {}
  setmetatable(instance, self)
  self.__index = self

  self.items = {}
  self.things = {}
  self.matrix = self:load_from_file(filename)

  return instance
end

function Map:load_from_file(filename)
  local text_map = read_all(filename)
  text_map = text_map:gsub("\n", "")
  return self:create_matrix_from_string(text_map)
end

function Map:create_matrix_from_string(str)
  local matrix = {}
  local i = 1  -- for iterating through the map string

  for y=1, LEVEL_HEIGHT do
    for x=1, LEVEL_WIDTH do
      -- create new columns and rows
      if not matrix[x] then matrix[x] = {} end
      if not matrix[x][y] then matrix[x][y] = {Thing:new{name="floor"}} end

      local char = str:sub(i, i)
      if char == " " then
        table.insert(matrix[x][y], Thing:new{name="floor"})
      elseif char == "#" then
        table.insert(matrix[x][y], Thing:new{name="wall", character="#", color="orange", solid=true})
      elseif char == "." then
        local pellet = Thing:new{name="pellet", character=".", collectible=true, points=1}
        table.insert(matrix[x][y], pellet)
        table.insert(self.items, pellet)
      elseif char == "o" then
        local power_pellet = Thing:new{name="power pellet", character="o", collectible=true, points=5}
        table.insert(matrix[x][y], power_pellet)
        table.insert(self.items, power_pellet)
      elseif char == "@" then
        player:move{x, y}
      end
      i = i + 1
    end
  end
  return matrix
end

function Map:draw()
  for x, col in ipairs(self.matrix) do
    for y, things in ipairs(col) do
      -- show the topmost thing on that tile
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
      -- if solid, return the the thing (will evaluate to true)
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
      table.remove(self.matrix[x][y])  -- probably a bug, needs to remove THING, not always last element
      table.insert(collectibles, thing)
    end
  end
  return collectibles
end

function Map:get_tile(x, y)
  -- self.matrix[x][y][1] is always a floor ([2] may also be a floor)
  return self.matrix[x][y][2]
end
