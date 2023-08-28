--!strict

--[[
	An xpcall() error handler to collect and parse useful information about
	errors, such as clean messages and stack traces.
]]

local Types = require("../Types")

local function parseError(err: string): Types.Error
	return {
		type = "Error",
		raw = err,
		message = err:gsub("^.+:%d+:%s*", ""),
		trace = debug.traceback(nil, 2),
	}
end

return parseError
