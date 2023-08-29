--!strict
--[[
    Returns true if A and B are 'similar' - i.e. any user of A would not need
    to recompute if it changed to B.
]]

local typeof = require "../typeof"

local function isSimilar(a: any, b: any): boolean
	-- HACK: because tables are mutable data structures, don't make assumptions
	-- about similarity from equality for now (see issue #44)
	if type(a) == "table" then
		return false
	else
		return a == b
	end
end

return isSimilar
