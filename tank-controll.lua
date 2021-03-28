tank = require("component").tinker_tank
fluids = tank.getFluids()
anzahl = 0
idx = 0

for _, fluid in pairs(fluids) do
  anzahl = anzahl + 1
end

print("Welchen Fluid willst du?")
search = io.read()

gefunden = false
for _, fluid in pairs(fluids) do
  anzahl = anzahl - 1
  idx = idx + 1
  if anzahl > 0 then
    if string.find(string.lower(fluid.label .. fluid.name), string.lower(search)) then
      print(idx .. "\t" .. fluid.label)
      gefunden = true
    end
  end
end

if gefunden then
  print("Index plz:")
  idx = io.read()
  tank.moveFluidToBottom(tonumber(idx))
else
  print("Fluid nicht gefunden!")
end
