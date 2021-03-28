tank = require("component").tinker_tank
fluids = tank.getFluids()
anzahl = 0
idx = 0

for _, fluid in pairs(fluids) do
  anzahl = anzahl + 1
end

print("Was willste?")
search = io.read()

for _, fluid in pairs(fluids) do
  anzahl = anzahl - 1
  idx = idx + 1
  if anzahl > 0 then
    if string.find(string.lower(fluid.label .. fluid.name), search) then
      print(idx .. "\t" .. fluid.label)
    end
  end
end

print("Index plz:")
idx = io.read()

tank.moveFluidToBottom(idx)
