local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == Enum.KeyCode.Q then
        VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
    end
end)

UIS.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Q then
        VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
    end
end)
