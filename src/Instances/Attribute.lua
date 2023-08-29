--!strict

--[[
	A special key for property tables, which allows users to apply custom
    attributes to instances
]]

local PubTypes = require "../PubTypes"
local logError = require "../Logging/logError"
local xtypeof = require "../Utility/xtypeof"
local Observer = require "../State/Observer"
local peek = require "../State/peek"

local function setAttribute(instance: Instance, attribute: string, value: any)
	instance:SetAttribute(attribute, value)
end

local function bindAttribute(
	instance: Instance,
	attribute: string,
	value: any,
	cleanupTasks: { PubTypes.Task }
)
	if xtypeof(value) == "State" then
		local didDefer = false
		local function update()
			if not didDefer then
				didDefer = true
				-- task.defer(function()
				-- Delay(0, function()
				-- fuckj up
				coroutine.resume(coroutine.create(function()
					didDefer = false
					setAttribute(instance, attribute, peek(value))
				end))
			end
		end
		setAttribute(instance, attribute, peek(value))
		table.insert(cleanupTasks, Observer(value :: any):onChange(update))
	else
		setAttribute(instance, attribute, value)
	end
end

local function Attribute(attributeName: string): PubTypes.SpecialKey
	local AttributeKey = {}
	AttributeKey.type = "SpecialKey"
	AttributeKey.kind = "Attribute"
	AttributeKey.stage = "self"

	if attributeName == nil then
		logError "attributeNameNil"
	end

	function AttributeKey:apply(
		attributeValue: any,
		applyTo: Instance,
		cleanupTasks: { PubTypes.Task }
	)
		bindAttribute(applyTo, attributeName, attributeValue, cleanupTasks)
	end
	return AttributeKey
end

return Attribute
