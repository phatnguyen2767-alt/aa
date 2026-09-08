local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")

local player = Players.LocalPlayer

local function getHumanoid()
	local character = player.Character or player.CharacterAdded:Wait()
	return character:WaitForChild("Humanoid")
end

local function moveAction(actionName, inputState)
	local humanoid = getHumanoid()

	if inputState == Enum.UserInputState.Begin
		or inputState == Enum.UserInputState.Change then

		if actionName == "MoveForward" then
			humanoid:Move(Vector3.new(0, 0, -1), true)
		elseif actionName == "MoveLeft" then
			humanoid:Move(Vector3.new(-1, 0, 0), true)
		elseif actionName == "MoveBack" then
			humanoid:Move(Vector3.new(0, 0, 1), true)
		elseif actionName == "MoveRight" then
			humanoid:Move(Vector3.new(1, 0, 0), true)
		end

	elseif inputState == Enum.UserInputState.End then
		humanoid:Move(Vector3.zero, true)
	end

	return Enum.ContextActionResult.Sink
end

ContextActionService:BindAction(
	"MoveForward",
	moveAction,
	false,
	Enum.KeyCode.S
)

ContextActionService:BindAction(
	"MoveLeft",
	moveAction,
	false,
	Enum.KeyCode.Z
)

ContextActionService:BindAction(
	"MoveBack",
	moveAction,
	false,
	Enum.KeyCode.X
)

ContextActionService:BindAction(
	"MoveRight",
	moveAction,
	false,
	Enum.KeyCode.C
)

player.CharacterAdded:Connect(function()
	task.wait(0.2)
	getHumanoid()
end)
