local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = script.Parent

--// CONFIG
local MIN_SIZE = Vector2.new(300, 200)
local MAX_SIZE = Vector2.new(700, 500)
local START_SIZE = Vector2.new(420, 300)

--// ScreenGui
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

--// Main Window
local main = Instance.new("Frame")
main.Name = "MainWindow"
main.Size = UDim2.fromOffset(START_SIZE.X, START_SIZE.Y)
main.Position = UDim2.new(0.5, -START_SIZE.X/2, 0.5, -START_SIZE.Y/2)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

--// Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundTransparency = 1
header.Active = true
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "Webhook Logger"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

--// Close Button
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(35, 35)
close.Position = UDim2.new(1, -40, 0, 3)
close.BackgroundTransparency = 1
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 25
close.Font = Enum.Font.GothamBold
close.Parent = header

--// Content
local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(15, 50)
content.Size = UDim2.new(1, -30, 1, -65)
content.BackgroundTransparency = 1
content.Parent = main

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, 0, 0, 50)
info.BackgroundTransparency = 1
info.Text = "Resize from the bottom-right corner"
info.TextColor3 = Color3.fromRGB(180, 180, 180)
info.TextSize = 14
info.Font = Enum.Font.Gotham
info.TextWrapped = true
info.Parent = content

--// Resize Handle
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "ResizeHandle"
resizeHandle.Size = UDim2.fromOffset(25, 25)
resizeHandle.Position = UDim2.new(1, -25, 1, -25)
resizeHandle.BackgroundTransparency = 1
resizeHandle.Text = "↘"
resizeHandle.TextColor3 = Color3.fromRGB(180, 180, 180)
resizeHandle.TextSize = 20
resizeHandle.Font = Enum.Font.GothamBold
resizeHandle.Parent = main

--==================================================
-- DRAG WINDOW
--==================================================

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

--==================================================
-- RESIZE WINDOW
--==================================================

local resizing = false
local resizeStart
local startSize

resizeHandle.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		resizing = true
		resizeStart = input.Position
		startSize = Vector2.new(
			main.AbsoluteSize.X,
			main.AbsoluteSize.Y
		)

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizing = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not resizing then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - resizeStart

		local newWidth = math.clamp(
			startSize.X + delta.X,
			MIN_SIZE.X,
			MAX_SIZE.X
		)

		local newHeight = math.clamp(
			startSize.Y + delta.Y,
			MIN_SIZE.Y,
			MAX_SIZE.Y
		)

		main.Size = UDim2.fromOffset(
			newWidth,
			newHeight
		)
	end
end)

--==================================================
-- CLOSE / OPEN
--==================================================

local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.fromOffset(55, 55)
openButton.Position = UDim2.new(0, 20, 0.5, -27)
openButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
openButton.Text = "☰"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextSize = 22
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openButton

close.MouseButton1Click:Connect(function()
	main.Visible = false
	openButton.Visible = true
end)

openButton.MouseButton1Click:Connect(function()
	main.Visible = true
	openButton.Visible = false
end)
