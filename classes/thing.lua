local colorHandler = ROT.Color:new()

Thing = {}

function Thing:new(options)
  local instance = {}
  setmetatable(instance, self)
  self.__index = self

  instance.character = options.character or ' '
  instance.xpos = options.xpos or 1
  instance.ypos = options.ypos or 1

  if options.color then
    instance.color = colorHandler:fromString(options.color)
  else
    instance.color = colorHandler:fromString("white")
  end

  return instance
end

function Thing:draw()
  display:write(self.character, self.xpos, self.ypos, self.color)
end
