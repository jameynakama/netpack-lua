local colorHandler = ROT.Color:new()

Thing = {}

function Thing:new(options)
  local instance = {}
  setmetatable(instance, self)
  self.__index = self

  -- defaults
  instance.name = options.name or "thing"
  instance.solid = options.solid
  instance.collectible = options.collectible
  instance.points = options.points
  instance.character = options.character or ' '
  instance.xpos = options.xpos or 1
  instance.ypos = options.ypos or 1
  if options.color then
    instance.color = colorHandler:fromString(options.color)
  else
    instance.color = colorHandler:fromString("white")
  end

  instance.ai = nil

  return instance
end

function Thing:clear()
  display:write(' ', self.xpos, self.ypos)
end

function Thing:draw()
  display:write(self.character, self.xpos, self.ypos, self.color)
end

function Thing:move(position)
  -- TODO: Make this take a map?
  self.xpos = position[1]
  self.ypos = position[2]
end

function Thing:random_move(map)
  possible_moves = {}
  for x in {-1, 1} do
    for y in {-1, 1} do
      new_x = self.xpos + x
      new_y = self.ypos + y
      if not map.is_blocked({new_x, new_y}) then
        self.move({new_x, new_y})
        --table.insert(map.matrix[new_x][new_y], self)
      end
    end
  end
end
