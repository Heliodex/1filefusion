local ReplicatedStorage = game:GetService "ReplicatedStorage"
local Fusion = require(ReplicatedStorage.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Value = Fusion.Value

local child1 = New "Folder" {
	Name = "Child one",
}
local child2 = New "Folder" {
	Name = "Child two",
}

local childState = Value(child1)

local parent = New "Folder" {
	[Children] = childState,
}

print(unpack(parent:GetChildren())) -- { Child one }

childState:set(child2)
wait(1) -- wait for deferred updates to run

print(unpack(parent:GetChildren())) -- { Child two }
