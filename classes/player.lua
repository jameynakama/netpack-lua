colorHandler = ROT.Color:new()

Player = Thing:new{
  character = '@',
  color = colorHandler:fromString("yellow"),
  xpos = 1,
  ypos = 1
}
