tank = require("component").tinker_tank
args = {...}

-- getFluids to array
function getFluids()
  fluids = {}
  for _, fluid in pairs(tank.getFluids()) do
    fluids[table.getn(fluids) + 1] = fluid
  end
  return fluids
end
-- search for fluid with string
function search(fluids, search)
  gefunden = {}
  for i=1, table.getn(fluids) do
    if string.find(string.lower(fluids[i].label .. fluids[i].name), string.lower(search)) then
      gefunden[table.getn(gefunden) + 1] = i
    end
  end
  return gefunden
end

-- Subcommands
if string.lower(args[1]) == "get" then  -- GET befehl
  fluids = {getFluids()}
  for i=1, table.getn(fluids) do
    print(i .. "\t" .. fluids[i].label)
  end
end
if string.lower(args[1]) == "set" then  -- SET befehl
  fluids = {getFluids()}
  print("Welchen Fluid willst du?")
  search = io.read()
  
  gefunden = {search(fluids, search)}
  if table.getn(gefunden) > 0 then
    for i=1, table.getn(gefunden) do
      print(i .. "\t" .. fluids[gefunden[i]].label)
    end
    print("Bitte Index-Nummer eingeben:")
    idx = tonumber(io.read())
    tank.moveFluidToBottom(idx)
  else
    print("Fluid nicht gefunden!")
  end
end
