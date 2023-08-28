local RunService = game:GetService "RunService"

local TweenScheduler = require "./Animation/TweenScheduler"
local SpringScheduler = require "./Animation/SpringScheduler"

local function bindScheduler()
	-- if RunService:IsClient() then
	-- 	RunService:BindToRenderStep(
	-- 		"__FusionTweenScheduler",
	-- 		Enum.RenderPriority.First.Value,
	-- 		TweenScheduler.updateAllTweens
	-- 	)
	-- 	RunService:BindToRenderStep(
	-- 		"__FusionSpringScheduler",
	-- 		Enum.RenderPriority.First.Value,
	-- 		SpringScheduler.updateAllSprings
	-- 	)
	-- else
	RunService.Heartbeat:connect(TweenScheduler.updateAllTweens)
	RunService.Heartbeat:connect(SpringScheduler.updateAllSprings)
	-- end
end

return bindScheduler
