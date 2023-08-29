-- A basic polyfill for the typeof function

if typeof then
	return typeof
end

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
			"Vector3",
			{
				"x",
				"y",
				"z",
				"Lerp",
				"Cross",
				"Dot",
				"unit",
				"magnitude",
			},
		},
		{
			"Vector2",
			{ "x", "y", "unit", "magnitude" },
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
				"Left",
				"Bottom",
				"Front",
			},
		},
	}

	for _, v in ipairs(tests) do
		local t, test = v[1], v[2]

		local success = pcall(function()
			for _, prop in ipairs(test) do
				_ = value[prop]
				-- Throws if property does not exist
			end
		end)

		if success then
			return t
		end
	end
end
