Thing = {}

function Thing:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self

  character = ' '
  xpos = 1
  ypos = 1

  return o
end
