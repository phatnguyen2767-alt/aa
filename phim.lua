local UserInputService = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")

local keyMap = {
    [Enum.KeyCode.S] = Enum.KeyCode.W,
    [Enum.KeyCode.Z] = Enum.KeyCode.A,
    [Enum.KeyCode.X] = Enum.KeyCode.S,
    [Enum.KeyCode.C] = Enum.KeyCode.D,
    [Enum.KeyCode.A] = Enum.KeyCode.Q,
}

-- Lưu trạng thái phím
local held = {}

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    local mapped = keyMap[input.KeyCode]
    if mapped then
        held[mapped] = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    local mapped = keyMap[input.KeyCode]
    if mapped then
        held[mapped] = false
    end
end)

-- Điều khiển nhân vật
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

RunService.RenderStepped:Connect(function()
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local camera = workspace.CurrentCamera
    if not camera then return end

    local dir = Vector3.zero

    if held[Enum.KeyCode.W] then
        dir += camera.CFrame.LookVector
    end

    if held[Enum.KeyCode.S] then
        dir -= camera.CFrame.LookVector
    end

    if held[Enum.KeyCode.A] then
        dir -= camera.CFrame.RightVector
    end

    if held[Enum.KeyCode.D] then
        dir += camera.CFrame.RightVector
    end

    dir = Vector3.new(dir.X, 0, dir.Z)

    if dir.Magnitude > 0 then
        humanoid:Move(dir.Unit, false)
    else
        humanoid:Move(Vector3.zero, false)
    end
end)
