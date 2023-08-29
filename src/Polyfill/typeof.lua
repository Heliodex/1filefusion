-- A basic polyfill for the typeof function

return function(value)
	local basicType = type(value)

	if
		basicType == "nil"
		or basicType == "boolean"
		or basicType == "number"
		or basicType == "string"
		or basicType == "function"
		or basicType == "thread"
		or basicType == "table"
	then
		return basicType
	end

	-- Will short-circuit
	--[[
		{
			name of type to check,
			{ list of required properties },
		}
	]]
	local tests = {
		{
			"Instance",
			{ "ClassName" },
		},
		{
			"Enum",
			{ "GetEnumItems" },
		},
		{
			"Enums",
			{ "MembershipType" }, -- lmao
		},
		{
			"RBXScriptSignal",
			{
				"connect",
				-- "connected",
				-- "connectFirst",
				-- "connectLast",
				"wait",
			},
		},
		{
			"RBXScriptConnection",
			{
				"connected",
				"disconnect",
			},
		},
		{
			"TweenInfo",
			{
				"EasingDirection",
				-- "Time",
				-- "DelayTime",
				"RepeatCount",
				"EasingStyle",
				-- "Reverses",
			},
		},
		{
			"CFrame",
			{
				"p",
				"x",
				"y",
				"z",
				"lookVector",
			},
		},
		{
			"Vector3",
			{
				"x",
				"y",
				"z",
				"Lerp",
				-- "Cross",
				-- "Dot",
				"unit",
				"magnitude",
			},
		},
		{
			"Vector3int16",
			{ "x", "y", "z" },
		},
		{
			"Vector2",
			{ "x", "y", "unit", "magnitude" },
		},
		{
			"Vector2int16",
			{ "x", "y" },
		},
		{
			"Region3",
			{ "CFrame", "Size" },
		},
		{
			"Region3int16",
			{ "Min", "Max" },
		},
		{
			"Ray",
			{
				"Origin",
				"Direction",
				"Unit",
				"ClosestPoint",
				"Distance",
			},
		},
		{
			"UDim",
			{ "Scale", "Offset" },
		},
		{
			"Axes",
			{ "X", "Y", "Z" },
		},
		{
			"UDim2",
			{ "X", "Y" },
		},
		{
			"BrickColor",
			{
				"Number",
				"Name",
				"Color",
				"r",
				"g",
				"b",
			},
		},
		{
			"Color3",
			{ "r", "g", "b" },
		},
		{
			"Faces",
			{
				"Right",
				"Top",
				"Back",
				-- "Left",
				-- "Bottom",
				-- "Front",
			},
		},
	}

	for _, v in ipairs(tests) do
		local t, test = v[1], v[2]

		local ok, result = pcall(function()
			for _, prop in ipairs(test) do
				if value[prop] == nil then
					return false
				end
				-- Cannot throw if the property does not exist,
				-- as userdatas may allow nil indexing
			end
			return true
		end)

		if ok and result then
			return t
		end
	end
end
