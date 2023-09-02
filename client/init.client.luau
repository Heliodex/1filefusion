local Players = game:GetService "Players"
local playerGui = Players.LocalPlayer:WaitForChild "PlayerGui"
local Fusion = LoadLibrary "Fusion"

local New = Fusion.New
local Children = Fusion.Children
local Value = Fusion.Value
local Computed = Fusion.Computed
local Spring = Fusion.Spring
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek

local function VectorFromCentre(distance)
	-- Returns a random direction vector with a length of distance
	local x = math.random() * 2 - 1
	local y = math.random() * 2 - 1
	local magnitude = math.sqrt(x * x + y * y)
	return UDim2.new(0, x / magnitude * distance, 0, y / magnitude * distance)
end

local Clicks = Value(0)
local debounce = false
local Position = Value(UDim2.new(0.5, -50, 0.5, -50))
local PositionSpring = Spring(Position, 25, 0.5)

New "ScreenGui" {
	Parent = playerGui,
	[Children] = {
		New "TextButton" {
			BackgroundColor3 = Color3.new(1, 0, 0),
			Size = UDim2.new(0, 100, 0, 100),
			Position = PositionSpring,

			FontSize = Enum.FontSize.Size48,
			Text = Computed(function(use)
				return use(Clicks) .. "!"
			end),

			[OnEvent "MouseButton1Click"] = function()
				if debounce then
					return
				end
				debounce = true
				Clicks:set(peek(Clicks) + 1)
				PositionSpring:addVelocity(VectorFromCentre(peek(Clicks) * 10))
				-- wait(0.1)mag
				debounce = false
			end,
		},
	},
}
