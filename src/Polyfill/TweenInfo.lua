-- A basic polyfill for the TweenInfo.new function

local TweenInfo = {}

function TweenInfo.new(
	time: number?,
	easingStyle: Enum.EasingStyle?,
	easingDirection: Enum.EasingDirection?,
	repeatCount: number?,
	reverses: boolean?,
	delayTime: number?
)
	local proxy = newproxy(true)
	local mt = getmetatable(proxy)

	time = time or 1
	easingStyle = easingStyle or Enum.EasingStyle.Quad
	easingDirection = easingDirection or Enum.EasingDirection.Out
	repeatCount = repeatCount or 0
	reverses = reverses or false
	delayTime = delayTime or 0

	mt.__index = {
		Time = time,
		EasingStyle = easingStyle,
		EasingDirection = easingDirection,
		RepeatCount = repeatCount,
		Reverses = reverses,
		DelayTime = delayTime,
	}

	-- When attempting to assign to properties, throw an error
	mt.__newindex = function(_, prop)
		error(prop .. " cannot be assigned to", math.huge) -- lmfao
	end

	mt.__tostring = function()
		return "Time:"
			.. tostring(time)
			.. " DelayTime:"
			.. tostring(delayTime)
			.. " RepeatCount:"
			.. tostring(repeatCount)
			.. " Reverses:"
			.. (reverses and "True" or "False")
			.. " EasingDirection:"
			.. tostring(easingDirection):split(".")[3]
			.. " EasingStyle:"
			.. tostring(easingStyle):split(".")[3]
	end

	mt.__metatable = "The metatable is locked"

	return proxy
end

return TweenInfo
