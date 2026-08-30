--==================================================
-- CH3A5 PREMIUM UI v6.2
-- UI ONLY
-- Drag + Resize + Mobile + FPS + Ping
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- CONFIG
local MIN_SIZE = Vector2.new(320, 240)
local MAX_SIZE = Vector2.new(750, 560)
local START_SIZE = Vector2.new(440, 340)

local GUI = Instance.new("ScreenGui")
GUI.Name = "CH3A5_v62"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = PlayerGui

-- MAIN
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(START_SIZE.X, START_SIZE.Y)
Main.Position = UDim2.new(.5, -START_SIZE.X/2, .5, -START_SIZE.Y/2)
Main.BackgroundColor3 = Color3.fromRGB(13,14,18)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = GUI

local MC = Instance.new("UICorner", Main)
MC.CornerRadius = UDim.new(0,16)

local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(70,70,85)
MS.Transparency = .25

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,65)
Header.BackgroundColor3 = Color3.fromRGB(21,22,28)
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Main

local HC = Instance.new("UICorner", Header)
HC.CornerRadius = UDim.new(0,16)

local Brand = Instance.new("TextLabel")
Brand.BackgroundTransparency = 1
Brand.Position = UDim2.fromOffset(18,7)
Brand.Size = UDim2.new(1,-80,0,25)
Brand.Text = "CH3A5"
Brand.TextColor3 = Color3.new(1,1,1)
Brand.TextSize = 20
Brand.Font = Enum.Font.GothamBold
Brand.TextXAlignment = Enum.TextXAlignment.Left
Brand.Parent = Header

local Version = Instance.new("TextLabel")
Version.BackgroundTransparency = 1
Version.Position = UDim2.fromOffset(19,34)
Version.Size = UDim2.new(1,-100,0,20)
Version.Text = "Premium Dashboard  •  v6.2"
Version.TextColor3 = Color3.fromRGB(155,158,170)
Version.TextSize = 12
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = Header

-- CLOSE
local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(36,36)
Close.Position = UDim2.new(1,-48,.5,-18)
Close.BackgroundColor3 = Color3.fromRGB(42,43,50)
Close.Text = "×"
Close.TextColor3 = Color3.new(1,1,1)
Close.TextSize = 22
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.Parent = Header

local CC = Instance.new("UICorner", Close)
CC.CornerRadius = UDim.new(0,9)

-- STATUS
local Status = Instance.new("Frame")
Status.Position = UDim2.fromOffset(20,80)
Status.Size = UDim2.new(1,-40,0,38)
Status.BackgroundColor3 = Color3.fromRGB(20,22,28)
Status.BorderSizePixel = 0
Status.Parent = Main

local SC = Instance.new("UICorner", Status)
SC.CornerRadius = UDim.new(0,10)

local Dot = Instance.new("Frame")
Dot.Size = UDim2.fromOffset(9,9)
Dot.Position = UDim2.new(0,14,.5,-4)
Dot.BackgroundColor3 = Color3.fromRGB(80,210,130)
Dot.BorderSizePixel = 0
Dot.Parent = Status

local DC = Instance.new("UICorner", Dot)
DC.CornerRadius = UDim.new(1,0)

local StatusText = Instance.new("TextLabel")
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.fromOffset(32,0)
StatusText.Size = UDim2.new(1,-40,1,0)
StatusText.Text = "●  System Ready"
StatusText.TextColor3 = Color3.fromRGB(165,168,178)
StatusText.TextSize = 12
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = Status

-- INFO PANEL
local Panel = Instance.new("Frame")
Panel.Position = UDim2.fromOffset(20,130)
Panel.Size = UDim2.new(1,-40,1,-195)
Panel.BackgroundColor3 = Color3.fromRGB(20,22,28)
Panel.BorderSizePixel = 0
Panel.Parent = Main

local PC = Instance.new("UICorner", Panel)
PC.CornerRadius = UDim.new(0,12)

local Info = Instance.new("TextLabel")
Info.Position = UDim2.fromOffset(16,14)
Info.Size = UDim2.new(1,-32,1,-28)
Info.BackgroundTransparency = 1
Info.TextColor3 = Color3.fromRGB(220,222,228)
Info.TextSize = 14
Info.Font = Enum.Font.Gotham
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top
Info.Parent = Panel

-- REFRESH
local Refresh = Instance.new("TextButton")
Refresh.Size = UDim2.fromOffset(125,40)
Refresh.Position = UDim2.fromOffset(20,-55)
Refresh.BackgroundColor3 = Color3.fromRGB(110,82,235)
Refresh.Text = "↻  Refresh"
Refresh.TextColor3 = Color3.new(1,1,1)
Refresh.TextSize = 14
Refresh.Font = Enum.Font.GothamBold
Refresh.AutoButtonColor = false
Refresh.Parent = Main

local RC = Instance.new("UICorner", Refresh)
RC.CornerRadius = UDim.new(0,10)

-- FOOTER
local Footer = Instance.new("TextLabel")
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(1,-220,1,-55)
Footer.Size = UDim2.fromOffset(200,20)
Footer.Text = "Created by CH3A5  •  v6.2"
Footer.TextColor3 = Color3.fromRGB(120,123,135)
Footer.TextSize = 10
Footer.Font = Enum.Font.Gotham
Footer.TextXAlignment = Enum.TextXAlignment.Right
Footer.Parent = Main

-- RESIZE
local Resize = Instance.new("TextButton")
Resize.Size = UDim2.fromOffset(38,38)
Resize.AnchorPoint = Vector2.new(1,1)
Resize.Position = UDim2.new(1,-5,1,-5)
Resize.BackgroundTransparency = 1
Resize.Text = "↘"
Resize.TextColor3 = Color3.fromRGB(150,153,165)
Resize.TextSize = 20
Resize.Font = Enum.Font.GothamBold
Resize.Parent = Main

-- OPEN
local Open = Instance.new("TextButton")
Open.Size = UDim2.fromOffset(58,58)
Open.Position = UDim2.new(0,20,.5,-29)
Open.BackgroundColor3 = Color3.fromRGB(13,14,18)
Open.Text = "CH"
Open.TextColor3 = Color3.new(1,1,1)
Open.TextSize = 16
Open.Font = Enum.Font.GothamBold
Open.Visible = false
Open.Parent = GUI

local OC = Instance.new("UICorner", Open)
OC.CornerRadius = UDim.new(1,0)

local OS = Instance.new("UIStroke", Open)
OS.Color = Color3.fromRGB(110,82,235)

--==================================================
-- DATA
--==================================================

local function UpdateInfo()

	local ping = "N/A"

	pcall(function()
		local network = Stats.Network.ServerStatsItem["Data Ping"]
		ping = tostring(math.floor(network:GetValue())) .. " ms"
	end)

	local userId = Player.UserId

	Info.Text =
		"PLAYER\n\n" ..
		"Username       " .. Player.Name ..
		"\nDisplay Name   " .. Player.DisplayName ..
		"\nUser ID        " .. tostring(userId) ..

		"\n\nPERFORMANCE\n\n" ..
		"Ping           " .. ping ..
		"\nFPS            Calculating..." ..

		"\n\nSESSION\n\n" ..
		"Place ID       " .. tostring(game.PlaceId) ..
		"\nVersion        v6.2"

	StatusText.Text = "●  System Ready"
end

--==================================================
-- FPS
--==================================================

local Frames = 0
local LastTime = tick()
local FPS = 0

RunService.RenderStepped:Connect(function()

	Frames += 1

	local Now = tick()

	if Now - LastTime >= 1 then

		FPS = Frames
		Frames = 0
		LastTime = Now

		local ping = "N/A"

		pcall(function()
			local network = Stats.Network.ServerStatsItem["Data Ping"]
			ping = tostring(math.floor(network:GetValue())) .. " ms"
		end)

		Info.Text =
			"PLAYER\n\n" ..
			"Username       " .. Player.Name ..
			"\nDisplay Name   " .. Player.DisplayName ..
			"\nUser ID        " .. tostring(Player.UserId) ..

			"\n\nPERFORMANCE\n\n" ..
			"Ping           " .. ping ..
			"\nFPS            " .. tostring(FPS) ..

			"\n\nSESSION\n\n" ..
			"Place ID       " .. tostring(game.PlaceId) ..
			"\nVersion        v6.2"

	end
end)

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart
local startPos
local dragInput

Header.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end

		end)

	end

end)

Header.InputChanged:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then

		dragInput = input

	end

end)

UIS.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input ~= dragInput then
		return
	end

	local delta = input.Position - dragStart

	Main.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)

end)

--==================================================
-- RESIZE
--==================================================

local resizing = false
local resizeStart
local startSize
local resizeInput

Resize.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		resizing = true
		resizeStart = input.Position
		startSize = Main.AbsoluteSize

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then
				resizing = false
			end

		end)

	end

end)

Resize.InputChanged:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then

		resizeInput = input

	end

end)

UIS.InputChanged:Connect(function(input)

	if not resizing then
		return
	end

	if input ~= resizeInput then
		return
	end

	local delta = input.Position - resizeStart

	local width = math.clamp(
		startSize.X + delta.X,
		MIN_SIZE.X,
		MAX_SIZE.X
	)

	local height = math.clamp(
		startSize.Y + delta.Y,
		MIN_SIZE.Y,
		MAX_SIZE.Y
	)

	Main.Size = UDim2.fromOffset(
		width,
		height
	)

end)

--==================================================
-- CLOSE
--==================================================

Close.Activated:Connect(function()

	local tween = TweenService:Create(
		Main,
		TweenInfo.new(
			0.2,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		),
		{
			Size = UDim2.fromOffset(0,0)
		}
	)

	tween:Play()

	tween.Completed:Wait()

	Main.Visible = false
	Main.Size = UDim2.fromOffset(
		START_SIZE.X,
		START_SIZE.Y
	)

	Open.Visible = true

end)

--==================================================
-- OPEN
--==================================================

Open.Activated:Connect(function()

	Open.Visible = false
	Main.Visible = true

	Main.Size = UDim2.fromOffset(0,0)

	TweenService:Create(
		Main,
		TweenInfo.new(
			0.25,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		{
			Size = UDim2.fromOffset(
				START_SIZE.X,
				START_SIZE.Y
			)
		}
	):Play()

end)

--==================================================
-- REFRESH
--==================================================

Refresh.Activated:Connect(function()

	StatusText.Text = "●  Refreshing..."

	task.wait(0.15)

	UpdateInfo()

end)

--==================================================
-- START
--==================================================

UpdateInfo()

print("CH3A5 Premium UI v6.2 loaded.")
