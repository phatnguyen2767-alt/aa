local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local keys = {
    Forward = false, -- S
    Left = false,    -- Z
    Back = false,    -- X
    Right = false    -- C
}

local function updateKey(keyCode, state)
    if keyCode == Enum.KeyCode.S then
        keys.Forward = state

    elseif keyCode == Enum.KeyCode.Z then
        keys.Left = state

    elseif keyCode == Enum.KeyCode.X then
        keys.Back = state

    elseif keyCode == Enum.KeyCode.C then
        keys.Right = state
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    updateKey(input.KeyCode, true)
end)

UserInputService.InputEnded:Connect(function(input)
    updateKey(input.KeyCode, false)
end)

RunService.RenderStepped:Connect(function()
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root then return end

    local camera = workspace.CurrentCamera
    if not camera then return end

    local direction = Vector3.zero

    -- S = tới
    if keys.Forward then
        direction += camera.CFrame.LookVector
    end

    -- X = lùi
    if keys.Back then
        direction -= camera.CFrame.LookVector
    end

    -- Z = trái
    if keys.Left then
        direction -= camera.CFrame.RightVector
    end

    -- C = phải
    if keys.Right then
        direction += camera.CFrame.RightVector
    end

    -- Bỏ thành phần Y để nhân vật không bị ảnh hưởng bởi hướng camera lên/xuống
    direction = Vector3.new(direction.X, 0, direction.Z)

    if direction.Magnitude > 0 then
        humanoid:Move(direction.Unit, false)
    else
        humanoid:Move(Vector3.zero, false)
    end
end)
