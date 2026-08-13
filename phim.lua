local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local keys = {
    A = false,
    Z = false,
    X = false,
    LeftShift = false
}

local shiftLock = false

-- =========================
-- INPUT
-- =========================

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.A then
        keys.A = true

    elseif input.KeyCode == Enum.KeyCode.Z then
        keys.Z = true

    elseif input.KeyCode == Enum.KeyCode.X then
        keys.X = true

    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        keys.LeftShift = true

    elseif input.KeyCode == Enum.KeyCode.RightShift then
        shiftLock = not shiftLock
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.A then
        keys.A = false

    elseif input.KeyCode == Enum.KeyCode.Z then
        keys.Z = false

    elseif input.KeyCode == Enum.KeyCode.X then
        keys.X = false

    elseif input.KeyCode == Enum.KeyCode.LeftShift then
        keys.LeftShift = false
    end
end)

-- =========================
-- MOVEMENT
-- =========================

RunService.RenderStepped:Connect(function()
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")

    if not humanoid or not root then return end

    local cam = workspace.CurrentCamera
    if not cam then return end

    local forward = Vector3.new(
        cam.CFrame.LookVector.X,
        0,
        cam.CFrame.LookVector.Z
    )

    local right = Vector3.new(
        cam.CFrame.RightVector.X,
        0,
        cam.CFrame.RightVector.Z
    )

    if forward.Magnitude > 0 then
        forward = forward.Unit
    end

    if right.Magnitude > 0 then
        right = right.Unit
    end

    local moveDirection = Vector3.zero

    -- A
    -- Không giữ Shift trái = đi tới
    -- Giữ Shift trái = đi trái
    if keys.A then
        if keys.LeftShift then
            moveDirection -= right
        else
            moveDirection += forward
        end
    end

    -- Z = đi lùi
    if keys.Z then
        moveDirection -= forward
    end

    -- X = sang phải
    if keys.X then
        moveDirection += right
    end

    if moveDirection.Magnitude > 0 then
        humanoid:Move(moveDirection.Unit, false)
    else
        humanoid:Move(Vector3.zero, false)
    end

    -- =========================
    -- SHIFT LOCK - RIGHT SHIFT
    -- =========================

    if shiftLock then
        humanoid.AutoRotate = false

        local look = Vector3.new(
            cam.CFrame.LookVector.X,
            0,
            cam.CFrame.LookVector.Z
        )

        if look.Magnitude > 0 then
            root.CFrame = CFrame.lookAt(
                root.Position,
                root.Position + look.Unit
            )
        end
    else
        humanoid.AutoRotate = true
    end
end)
