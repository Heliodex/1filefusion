--!strict

--[[
	Returns true if the given value can be assumed to be a valid state object.
]]

local typeof = require "../typeof"

local function isState(target: any): boolean
	return type(target) == "table" and type(target._peek) == "function"
end

return isState
