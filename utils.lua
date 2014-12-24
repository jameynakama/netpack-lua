function read_all(file)
  local f = io.open(file, "rb")
  local content = f:read("*all")
  f:close()
  return content
end
