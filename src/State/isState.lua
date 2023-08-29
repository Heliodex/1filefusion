--!strict

--[[
	Returns true if the given value can be assumed to be a valid state object.
]]

local typeof = require "../typeof"

local function isState(target: any): boolean
	return typeof(target) == "table" and typeof(target._peek) == "function"
end

return isState
