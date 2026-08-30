--==================================================
-- PERSONAL DATA UI
-- Roblox Studio - LocalScript
-- Put inside StarterGui
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
	Title = "My Roblox Data",

	MinSize = Vector2.new(300, 220),
	MaxSize = Vector2.new(650, 500),

	StartSize = Vector2.new(420, 320),

	Background = Color3.fromRGB(25, 25, 25),
	Header = Color3.fromRGB(35, 35, 35),

	-- Set true if you want the window movable
	Draggable = true,

	-- Set true if you want resizing
Resizable = true,
}

--==================================================
-- SCREEN GUI
--==================================================

local GUI = Instance.new("ScreenGui")

GUI.Name = "PersonalDataUI"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

GUI.Parent = Player:WaitForChild("PlayerGui")

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"
Main.Size = UDim2.fromOffset(
	CONFIG.StartSize.X,
	CONFIG.StartSize.Y
)

Main.Position = UDim2.new(
	0.5,
	-CONFIG.StartSize.X / 2,
	0.5,
	-CONFIG.StartSize.Y / 2
)

Main.BackgroundColor3 = CONFIG.Background
Main.BorderSizePixel = 0
Main.Active = true

Main.Parent = GUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")

Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 45)

Header.BackgroundColor3 = CONFIG.Header
Header.BorderSizePixel = 0
Header.Active = true

Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")

Title.Name = "Title"

Title.Position = UDim2.fromOffset(15, 0)
Title.Size = UDim2.new(1, -60, 1, 0)

Title.BackgroundTransparency = 1

Title.Text = CONFIG.Title
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

Title.TextSize = 18
Title.Font = Enum.Font.GothamBold

Title.TextXAlignment = Enum.TextXAlignment.Left

Title.Parent = Header

--==================================================
-- CLOSE BUTTON
--==================================================

local Close = Instance.new("TextButton")

Close.Name = "Close"

Close.Size = UDim2.fromOffset(40, 40)
Close.Position = UDim2.new(1, -42, 0, 2)

Close.BackgroundTransparency = 1

Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)

Close.TextSize = 26
Close.Font = Enum.Font.GothamBold

Close.Parent = Header

--==================================================
-- DATA CONTAINER
--==================================================

local DataFrame = Instance.new("Frame")

DataFrame.Name = "Data"

DataFrame.Position = UDim2.fromOffset(20, 60)

DataFrame.Size = UDim2.new(
	1,
	-40,
	1,
	-125
)

DataFrame.BackgroundTransparency = 1

DataFrame.Parent = Main

--==================================================
-- DATA TEXT
--==================================================

local DataText = Instance.new("TextLabel")

DataText.Name = "DataText"

DataText.Size = UDim2.new(1, 0, 1, 0)

DataText.BackgroundTransparency = 1

DataText.Text = "Loading..."

DataText.TextColor3 = Color3.fromRGB(220, 220, 220)

DataText.TextSize = 15
DataText.Font = Enum.Font.Gotham

DataText.TextXAlignment = Enum.TextXAlignment.Left
DataText.TextYAlignment = Enum.TextYAlignment.Top

DataText.TextWrapped = true

DataText.Parent = DataFrame

--==================================================
-- REFRESH BUTTON
--==================================================

local Refresh = Instance.new("TextButton")

Refresh.Name = "Refresh"

Refresh.Size = UDim2.fromOffset(120, 40)

Refresh.Position = UDim2.new(
	0,
	20,
	1,
	-55
)

Refresh.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

Refresh.Text = "Refresh"

Refresh.TextColor3 = Color3.fromRGB(255, 255, 255)

Refresh.TextSize = 15
Refresh.Font = Enum.Font.GothamBold

Refresh.Parent = Main

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 8)
RefreshCorner.Parent = Refresh

--==================================================
-- RESIZE HANDLE
--==================================================

local Resize = Instance.new("TextButton")

Resize.Name = "Resize"

Resize.Size = UDim2.fromOffset(40, 40)

Resize.AnchorPoint = Vector2.new(1, 1)

Resize.Position = UDim2.new(
	1,
	-4,
	1,
	-4
)

Resize.BackgroundTransparency = 1

Resize.Text = "↘"

Resize.TextColor3 = Color3.fromRGB(180, 180, 180)

Resize.TextSize = 22
Resize.Font = Enum.Font.GothamBold

Resize.Visible = CONFIG.Resizable

Resize.Parent = Main

--==================================================
-- OPEN BUTTON
--==================================================

local Open = Instance.new("TextButton")

Open.Name = "OpenButton"

Open.Size = UDim2.fromOffset(55, 55)

Open.Position = UDim2.new(
	0,
	20,
	0.5,
	-27
)

Open.BackgroundColor3 = CONFIG.Background

Open.Text = "☰"

Open.TextColor3 = Color3.fromRGB(255, 255, 255)

Open.TextSize = 22
Open.Font = Enum.Font.GothamBold

Open.Visible = false

Open.Parent = GUI

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = Open

--==================================================
-- DATA
--==================================================

local function UpdateData()

	local username = Player.Name
	local displayName = Player.DisplayName
	local userId = Player.UserId

	local placeId = game.PlaceId

	local jobId = game.JobId

	if jobId == "" then
		jobId = "Studio"
	end

	DataText.Text =
		"PLAYER INFORMATION\n\n" ..

		"Username      : "
		.. username ..

		"\nDisplay Name  : "
		.. displayName ..

		"\nUser ID       : "
		.. tostring(userId) ..

		"\n\nGAME INFORMATION\n\n" ..

		"Place ID      : "
		.. tostring(placeId) ..

		"\nServer Job ID : "
		.. jobId
end

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false

local DragStart
local StartPosition

local DragInput

if CONFIG.Draggable then

	Header.InputBegan:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.MouseButton1
			or Input.UserInputType == Enum.UserInputType.Touch then

			Dragging = true

			DragStart = Input.Position

			StartPosition = Main.Position

			Input.Changed:Connect(function()

				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end

			end)

		end

	end)

	Header.InputChanged:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.MouseMovement
			or Input.UserInputType == Enum.UserInputType.Touch then

			DragInput = Input

		end

	end)

	UserInputService.InputChanged:Connect(function(Input)

		if not Dragging then
			return
		end

		if Input ~= DragInput then
			return
		end

		local Delta = Input.Position - DragStart

		Main.Position = UDim2.new(

			StartPosition.X.Scale,

			StartPosition.X.Offset + Delta.X,

			StartPosition.Y.Scale,

			StartPosition.Y.Offset + Delta.Y

		)

	end)

end

--==================================================
-- RESIZE SYSTEM
--==================================================

local Resizing = false

local ResizeStart
local StartSize

local ResizeInput

if CONFIG.Resizable then

	Resize.InputBegan:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.MouseButton1
			or Input.UserInputType == Enum.UserInputType.Touch then

			Resizing = true

			ResizeStart = Input.Position

			StartSize = Main.AbsoluteSize

			Input.Changed:Connect(function()

				if Input.UserInputState == Enum.UserInputState.End then
					Resizing = false
				end

			end)

		end

	end)

	Resize.InputChanged:Connect(function(Input)

		if Input.UserInputType == Enum.UserInputType.MouseMovement
			or Input.UserInputType == Enum.UserInputType.Touch then

			ResizeInput = Input

		end

	end)

	UserInputService.InputChanged:Connect(function(Input)

		if not Resizing then
			return
		end

		if Input ~= ResizeInput then
			return
		end

		local Delta = Input.Position - ResizeStart

		local NewWidth = math.clamp(

			StartSize.X + Delta.X,

			CONFIG.MinSize.X,

			CONFIG.MaxSize.X

		)

		local NewHeight = math.clamp(

			StartSize.Y + Delta.Y,

			CONFIG.MinSize.Y,

			CONFIG.MaxSize.Y

		)

		Main.Size = UDim2.fromOffset(
			NewWidth,
			NewHeight
		)

	end)

end

--==================================================
-- CLOSE
--==================================================

Close.Activated:Connect(function()

	Main.Visible = false

	Open.Visible = true

end)

--==================================================
-- OPEN
--==================================================

Open.Activated:Connect(function()

	Main.Visible = true

	Open.Visible = false

end)

--==================================================
-- REFRESH
--==================================================

Refresh.Activated:Connect(function()

	UpdateData()

end)

--==================================================
-- START
--==================================================

UpdateData()
