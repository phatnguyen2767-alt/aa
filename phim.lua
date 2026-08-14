local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local keys = {
    W = false,
    A = false,
    S = false,
    D = false
}

local function setKey(key, state)
    keys[key] = state
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.S then
        setKey("W", true)

    elseif input.KeyCode == Enum.KeyCode.Z then
        setKey("A", true)

    elseif input.KeyCode == Enum.KeyCode.X then
        setKey("S", true)

    elseif input.KeyCode == Enum.KeyCode.C then
        setKey("D", true)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.S then
        setKey("W", false)

    elseif input.KeyCode == Enum.KeyCode.Z then
        setKey("A", false)

    elseif input.KeyCode == Enum.KeyCode.X then
        setKey("S", false)

    elseif input.KeyCode == Enum.KeyCode.C then
        setKey("D", false)
    end
end)

RunService.RenderStepped:Connect(function()
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local camera = workspace.CurrentCamera
    if not camera then return end

    local direction = Vector3.zero

    if keys.W then
        direction += camera.CFrame.LookVector
    end

    if keys.S then
        direction -= camera.CFrame.LookVector
    end

    if keys.A then
        direction -= camera.CFrame.RightVector
    end

    if keys.D then
        direction += camera.CFrame.RightVector
    end

    direction = Vector3.new(direction.X, 0, direction.Z)

    if direction.Magnitude > 0 then
        humanoid:Move(direction.Unit, false)
    else
        humanoid:Move(Vector3.zero, false)
    end
end)
