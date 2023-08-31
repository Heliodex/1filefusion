local ReplicatedStorage = game:GetService "ReplicatedStorage"
local Players = game:GetService "Players"
local Fusion = require(ReplicatedStorage.Fusion)

local Value = Fusion.Value
local peek = Fusion.peek
local ForPairs = Fusion.ForPairs

local function tprint(tbl)
	for i, v in pairs(peek(tbl)) do
		print(i, "=", v)
	end
	print "---"
end

local itemColours = Value { shoes = "red", socks = "blue" }
local owner = Value "Taskmanager"

local manipulated = ForPairs(itemColours, function(use, thing, colour)
	local newKey = colour
	local newValue = use(owner) .. "'s " .. thing
	return newKey, newValue
end)

tprint(manipulated) --> {red = "Taskmanager's shoes", blue = "Taskmanager's socks"}

owner:set "Heliodex"
tprint(manipulated) --> {red = "Heliodex's shoes", blue = "Heliodex's socks"}

itemColours:set { shoes = "green", socks = "yellow" }
tprint(manipulated) --> {green = "Heliodex's shoes", yellow = "Heliodex's socks"}

owner:set "Shedletsky"
itemColours:set { shirt = "shirts", pants = "pants" }
tprint(manipulated) --> {shirts = "Shedletsky's shirt", pants = "Shedletsky's pants"}

itemColours:set { key = "value", key2 = "value2", key3 = "value" } --> Error, as two keys are the same
