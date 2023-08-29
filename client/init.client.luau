local ReplicatedStorage = game:GetService "ReplicatedStorage"
local Players = game:GetService "Players"
local Fusion = require(ReplicatedStorage.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Tween = Fusion.Tween
local Spring = Fusion.Spring
local Value = Fusion.Value
local Computed = Fusion.Computed
local peek = Fusion.peek
local TweenInfo = Fusion.TweenInfo

local numClicks = Value(0)
local position = Value(UDim2.new(0.25, 0, 0.25, 0))
local rotation = Value(0)
local colour = Value(Color3.new(1, 1, 1))

New "ScreenGui" {
	Parent = Players.LocalPlayer.PlayerGui,
	Name = "CountingGui",

	[Children] = {
		New "TextButton" {
			Name = "ClickButton",
			Position = UDim2.new(0.5, -100, 0.75, -25),
			Size = UDim2.new(0, 200, 0, 50),

			FontSize = Enum.FontSize.Size36,
			Font = Enum.Font.SourceSansBold,
			BackgroundColor3 = Color3.new(0.3, 1, 0),

			Text = "Fusion is fun!",

			[OnEvent "MouseButton1Click"] = function()
				-- the button was clicked!
				numClicks:set(peek(numClicks) + 1)
				position:set(UDim2.new(math.random(), 0, math.random(), 0))
				rotation:set(math.random() * 720 - 360)
				wait(0.5)
				colour:set(
					Color3.new(math.random(), math.random(), math.random())
				)
			end,
		},

		New "TextLabel" {
			Name = "Message",
			Position = Tween(position, TweenInfo.new(2.5, "Exponential")),
			Rotation = Spring(rotation, 5, 0.5),
			Size = UDim2.new(0, 200, 0, 50),

			FontSize = Enum.FontSize.Size24,

			BackgroundColor3 = Spring(colour, 5, 0.2),

			Text = Computed(function(use)
				return "You clicked " .. use(numClicks) .. " times."
			end),
		},
	},
}
