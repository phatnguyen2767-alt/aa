local UserInputService = game:GetService("UserInputService")

local keyMap = {
	[Enum.KeyCode.Z] = Enum.KeyCode.A,
	[Enum.KeyCode.X] = Enum.KeyCode.S,
	[Enum.KeyCode.C] = Enum.KeyCode.D
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	local newKey = keyMap[input.KeyCode]

	if newKey then
		-- giả lập phím tương ứng
		keybd_event(newKey.Value, 0, 0, 0)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	local newKey = keyMap[input.KeyCode]

	if newKey then
		keybd_event(newKey.Value, 0, 2, 0)
	end
end)
