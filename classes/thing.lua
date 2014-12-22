Thing = {}

function Thing:new (o)
  local o = o or {}
  setmetatable(o, self)
  self.__index = self

  self.character = o.character or ' '
  self.xpos = o.xpos or 1
  self.ypos = o.ypos or 1

  return o
end
