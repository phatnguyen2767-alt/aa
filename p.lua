local ContextActionService = game:GetService("ContextActionService")

-- Q hoạt động như A
ContextActionService:BindAction(
	"Q_as_A",
	function(actionName, inputState, inputObject)
		local aInput = {
			KeyCode = Enum.KeyCode.A,
			UserInputType = inputObject.UserInputType
		}

		-- Không thể thay đổi InputObject trực tiếp,
		-- nên cách dưới đây là dùng action riêng.
		return Enum.ContextActionResult.Pass
	end,
	false,
	Enum.KeyCode.Q
)

-- E hoạt động như S
ContextActionService:BindAction(
	"E_as_S",
	function()
		return Enum.ContextActionResult.Pass
	end,
	false,
	Enum.KeyCode.E
)

-- R hoạt động như D
ContextActionService:BindAction(
	"R_as_D",
	function()
		return Enum.ContextActionResult.Pass
	end,
	false,
	Enum.KeyCode.R
)
