tank = require("component").tinker_tank

if string.lower(args[0]) == "get" then  -- GET befehl
  fluids = getFluids()
  for i=0, table.getn(fluids) - 1 do
    print(i + 1 .. "\t" .. fluids[i].label)
  end
  goto exit
end

if string.lower(args[0]) == "set" then  -- SET befehl
  fluids = getFluids()
  print("Welchen Fluid willst du?")
  search = io.read()
  
  gefunden = search(fluids, search)
  if table.getn(gefunden) > 0 then
    for i=0, table.getn(gefunden) - 1 do
      print(i + 1 .. "\t" .. fluids[gefunden[i]].label)
    end
    print("Bitte Index-Nummer eingeben:")
    idx = tonumber(io.read())
    tank.moveFluidToBottom(idx)
  else
    print("Fluid nicht gefunden!")
  end
end

-- getFluids to array
function getfluids()
  fluids = {}
  for _, fluid in pairs(tank.getFluids()) do
    fluids[table.getn(fluids)] = fluid
  end
  return fluids
end

-- search for fluid with string
function search(fluids, search)
  gefunden = {}
  for i=0, table.getn(fluids) - 1 do
    if string.find(string.lower(fluids[i].label .. fluids[i].name), string.lower(search)) then
      gefunden[table.getn(gefunden)] = i
    end
  end
  return gefunden
end
