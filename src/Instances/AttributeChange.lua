--!strict

--[[
	A special key for property tables, which allows users to connect to
    an attribute change on an instance.
]]

local PubTypes = require "../PubTypes"
local logError = require "../Logging/logError"
local xtypeof = require "../Utility/xtypeof"
local typeof = require "../Polyfill/typeof"

local function AttributeChange(attributeName: string): PubTypes.SpecialKey
	local attributeKey = {}
	attributeKey.type = "SpecialKey"
	attributeKey.kind = "AttributeChange"
	attributeKey.stage = "observer"

	if attributeName == nil then
		logError "attributeNameNil"
	end

	function attributeKey:apply(
		callback: any,
		applyTo: Instance,
		cleanupTasks: { PubTypes.Task }
	)
		if typeof(callback) ~= "function" then
			logError("invalidAttributeChangeHandler", nil, attributeName)
		end
		local ok, event =
			pcall(applyTo.GetAttributeChangedSignal, applyTo, attributeName)
		if not ok then
			logError(
				"cannotConnectAttributeChange",
				nil,
				applyTo.ClassName,
				attributeName
			)
		else
			callback((applyTo :: any):GetAttribute(attributeName))
			table.insert(
				cleanupTasks,
				event:connect(function()
					callback((applyTo :: any):GetAttribute(attributeName))
				end)
			)
		end
	end
	return attributeKey
end

return AttributeChange
