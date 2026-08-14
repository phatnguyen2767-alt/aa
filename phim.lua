local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local keys = {
    forward = false,
    left = false,
    back = false,
    right = false
}

local autoClick = false
local clickTimer = 0

local function updateKey(key, state)
    if key == Enum.KeyCode.A then
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift)
        or UIS:IsKeyDown(Enum.KeyCode.RightShift) then
            keys.left = state
        else
            keys.forward = state
        end

    elseif key == Enum.KeyCode.Z then
        keys.back = state

    elseif key == Enum.KeyCode.X then
        keys.right = state
    end
end

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.L then
        autoClick = not autoClick
        print("Auto Click:", autoClick and "ON" or "OFF")
        return
    end

    updateKey(input.KeyCode, true)
end)

UIS.InputEnded:Connect(function(input)
    updateKey(input.KeyCode, false)
end)

-- Xử lý trường hợp đang giữ A rồi mới nhấn Shift
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift
    or input.KeyCode == Enum.KeyCode.RightShift then

        if UIS:IsKeyDown(Enum.KeyCode.A) then
            keys.forward = false
            keys.left = true
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftShift
    or input.KeyCode == Enum.KeyCode.RightShift then

        if UIS:IsKeyDown(Enum.KeyCode.A) then
            keys.left = false
            keys.forward = true
        end
    end
end)

RunService.RenderStepped:Connect(function(dt)
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local camera = workspace.CurrentCamera
    if not camera then return end

    local direction = Vector3.zero

    if keys.forward then
        direction += camera.CFrame.LookVector
    end

    if keys.back then
        direction -= camera.CFrame.LookVector
    end

    if keys.left then
        direction -= camera.CFrame.RightVector
    end

    if keys.right then
        direction += camera.CFrame.RightVector
    end

    direction = Vector3.new(direction.X, 0, direction.Z)

    if direction.Magnitude > 0 then
        humanoid:Move(direction.Unit, false)
    else
        humanoid:Move(Vector3.zero, false)
    end

    -- Auto click 0.1 giây
    if autoClick then
        clickTimer += dt

        if clickTimer >= 0.1 then
            clickTimer = 0

            -- Chỉ báo trạng thái; Roblox Lua không thể tự phát
            -- click chuột hệ thống từ LocalScript thông thường.
            print("CLICK")
        end
    end
end)
