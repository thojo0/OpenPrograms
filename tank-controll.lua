components = require("component")
term = require("term")
tank = components.tinker_tank
gpu = components.gpu
args = {...}

-- runden
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- getFluids to array
function getFluids()
  fluids = {}
  for _, fluid in pairs(tank.getFluids()) do
    fluids[#fluids + 1] = fluid
  end
  table.remove(fluids)
  return fluids
end
-- search for fluid with string
function fluidSearch(fluids, search)
  gefunden = {}
  for i=1, #fluids do
    if string.find(string.lower(fluids[i].label .. fluids[i].name), string.lower(search)) then
      gefunden[#gefunden + 1] = i
    end
  end
  return gefunden
end
-- Prozent
function percent(percent,maxvalue)
  p = round(percent / maxvalue * 100, 2)
  leer = ""
  for i=0, 3 - string.len(math.floor(p)) do
    leer = leer .. " "
  end
  return leer .. p
end

-- Subcommands
if string.lower(args[1]) == "get" then  -- GET befehl
  resX,resY = gpu.getResolution()
  grafiksize = 12
  fluids = getFluids()
  term.clear()
  colSpace = 8
  col1 = 1
  for i=1, #fluids do
    term.setCursor(1, i)
    io.write(i)
    tmplen = string.len(string.format(i))
    if tmplen > col1 then
      col1 = tmplen
    end
  end
  col1 = col1 + colSpace
  col2 = col1
  for i=1, #fluids do
    term.setCursor(col1, i)
    io.write(fluids[i].label)
    tmplen = string.len(fluids[i].label)
    if tmplen > col2 then
      col2 = tmplen
    end
  end
  col2 = col1 + col2 + colSpace
  cap = tank.getFillLevel()
  for i=1, #fluids do
    term.setCursor(col2, i)
    io.write(percent(fluids[i].amount,cap) .. "%")
  end
  stand = cap / tank.getCapacity()
  standR = round((resY - 2) * stand)
  color = gpu.getBackground()
  gpu.setBackground(0xCCCCCC)
  gpu.fill(resX - grafiksize + 1, 1, grafiksize, resY, " ")
  gpu.setBackground(0x0000FF)
  gpu.fill(resX - grafiksize + 2, 2, grafiksize - 2, resY - standR - 2, " ")
  gpu.setBackground(color)
  gpu.fill(resX - grafiksize + 2, standR + 2, grafiksize - 2, standR, " ")
  io.read()
end
if string.lower(args[1]) == "set" then  -- SET befehl
  fluids = getFluids()
  print("Welchen Fluid willst du?")
  search = io.read()
  
  gefunden = fluidSearch(fluids, search)
  if #gefunden > 0 then
    for i=1, #gefunden do
      print(gefunden[i] .. "\t" .. fluids[gefunden[i]].label)
    end
    print("Bitte Index-Nummer eingeben:")
    idx = tonumber(io.read())
    tank.moveFluidToBottom(idx)
  else
    print("Fluid nicht gefunden!")
  end
end
