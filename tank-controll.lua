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

-- Subcommands
if string.lower(args[1]) == "get" then  -- GET befehl
  resX,resY = gpu.getResolution()
  grafiksize = 12
  fluids = getFluids()
  term.clear()
  for i=1, #fluids do
    print(i .. "\t" .. fluids[i].label)
  end
  stand = (resY - 2) * tank.getFillLevel() / tank.getCapacity()
  color = gpu.getBackground()
  gpu.setBackground(0xCCCCCC)
  gpu.fill(resX - grafiksize + 1, 1, grafiksize, resY, " ")
  gpu.setBackground(0x0000FF)
  gpu.fill(resX - grafiksize + 2, stand, grafiksize - 2, round(resY - stand), " ")
  gpu.setBackground(color)
  gpu.fill(resX - grafiksize + 2, 2, grafiksize - 2, stand - 2, " ")
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
