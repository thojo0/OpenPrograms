tank = require("component").tinker_tank

-- getFluids to array
fluids = {}
anzahl = 0
for _, fluid in pairs(tank.getFluids()) do
  fluids[anzahl] = fluid
  anzahl = anzahl + 1
end

print("Welchen Fluid willst du?")
search = io.read()

gefunden = false
for i=0, anzahl do
  if i < anzahl - 1 then
    if string.find(string.lower(fluid.label .. fluid.name), string.lower(search)) then
      print(i + 1 .. "\t" .. fluid.label)
      gefunden = true
    end
  end
end

idx = 0
if gefunden then
  print("Bitte Index-Nummer eingeben:")
  idx = io.read()
  tank.moveFluidToBottom(tonumber(idx))
else
  print("Fluid nicht gefunden!")
end
