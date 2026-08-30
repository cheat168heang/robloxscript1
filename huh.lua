--========================================================--
--                 CH3A5 PERSONAL DATA                   --
--                         v6.1                           --
--========================================================--
--  Premium UI / Mobile / Drag / Resize / Refresh
--  Created by CH3A5
--
--  USE:
--  Roblox Studio -> StarterGui -> LocalScript
--
--  IMPORTANT:
--  This client UI only displays data available to the
--  current player. Private/server-side data must be
--  supplied by a server script that you control.
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--========================================================--
-- CONFIG
--========================================================--

local CONFIG = {

	Version = "6.1",
	Creator = "CH3A5",

	Title = "Personal Data",
	Subtitle = "Secure Player Dashboard",

	StartSize = Vector2.new(460, 360),

	MinSize = Vector2.new(320, 260),
	MaxSize = Vector2.new(760, 600),

	AnimationTime = 0.25,

	Draggable = true,
	Resizable = true,

}

--========================================================--
-- COLORS
--========================================================--

local COLORS = {

	Background = Color3.fromRGB(13, 14, 18),
	Surface = Color3.fromRGB(20, 22, 28),
	Surface2 = Color3.fromRGB(27, 29, 36),

	Border = Color3.fromRGB(55, 58, 68),

	Text = Color3.fromRGB(245, 245, 248),
	SubText = Color3.fromRGB(160, 164, 175),

	Accent = Color3.fromRGB(125, 95, 255),
	Accent2 = Color3.fromRGB(92, 72, 210),

	Success = Color3.fromRGB(80, 210, 130),
	Danger = Color3.fromRGB(240, 85, 95),

}

--========================================================--
-- SCREEN GUI
--========================================================--

local GUI = Instance.new("ScreenGui")

GUI.Name = "CH3A5_PersonalData_v61"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

GUI.Parent = Player:WaitForChild("PlayerGui")

--========================================================--
-- MAIN WINDOW
--========================================================--

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

Main.BackgroundColor3 = COLORS.Background
Main.BorderSizePixel = 0
Main.Active = true

Main.Parent = GUI

-- Corner

local MainCorner = Instance.new("UICorner")

MainCorner.CornerRadius = UDim.new(0, 16)

MainCorner.Parent = Main

-- Stroke

local MainStroke = Instance.new("UIStroke")

MainStroke.Color = COLORS.Border
MainStroke.Thickness = 1
MainStroke.Transparency = 0.25

MainStroke.Parent = Main

--========================================================--
-- HEADER
--========================================================--

local Header = Instance.new("Frame")

Header.Name = "Header"

Header.Size = UDim2.new(
	1,
	0,
	0,
	65
)

Header.BackgroundColor3 = COLORS.Surface

Header.BorderSizePixel = 0
Header.Active = true

Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")

HeaderCorner.CornerRadius = UDim.new(0, 16)

HeaderCorner.Parent = Header

--========================================================--
-- BRAND
--========================================================--

local Brand = Instance.new("TextLabel")

Brand.BackgroundTransparency = 1

Brand.Position = UDim2.fromOffset(
	18,
	8
)

Brand.Size = UDim2.new(
	1,
	-90,
	0,
	25
)

Brand.Text = "CH3A5"

Brand.TextColor3 = COLORS.Text

Brand.TextSize = 19

Brand.Font = Enum.Font.GothamBold

Brand.TextXAlignment = Enum.TextXAlignment.Left

Brand.Parent = Header

--========================================================--
-- SUBTITLE
--========================================================--

local Subtitle = Instance.new("TextLabel")

Subtitle.BackgroundTransparency = 1

Subtitle.Position = UDim2.fromOffset(
	19,
	34
)

Subtitle.Size = UDim2.new(
	1,
	-100,
	0,
	20
)

Subtitle.Text = CONFIG.Title .. "  •  v" .. CONFIG.Version

Subtitle.TextColor3 = COLORS.SubText

Subtitle.TextSize = 12

Subtitle.Font = Enum.Font.Gotham

Subtitle.TextXAlignment = Enum.TextXAlignment.Left

Subtitle.Parent = Header

--========================================================--
-- CLOSE BUTTON
--========================================================--

local Close = Instance.new("TextButton")

Close.Name = "Close"

Close.AnchorPoint = Vector2.new(
	1,
	0.5
)

Close.Position = UDim2.new(
	1,
	-15,
	0.5,
	0
)

Close.Size = UDim2.fromOffset(
	36,
	36
)

Close.BackgroundColor3 = Color3.fromRGB(
	40,
	41,
	48
)

Close.Text = "×"

Close.TextColor3 = COLORS.Text

Close.TextSize = 22

Close.Font = Enum.Font.GothamBold

Close.AutoButtonColor = false

Close.Parent = Header

local CloseCorner = Instance.new("UICorner")

CloseCorner.CornerRadius = UDim.new(
	0,
	9
)

CloseCorner.Parent = Close

--========================================================--
-- STATUS
--========================================================--

local Status = Instance.new("Frame")

Status.Name = "Status"

Status.Position = UDim2.fromOffset(
	20,
	82
)

Status.Size = UDim2.new(
	1,
	-40,
	0,
	38
)

Status.BackgroundColor3 = COLORS.Surface

Status.BorderSizePixel = 0

Status.Parent = Main

local StatusCorner = Instance.new("UICorner")

StatusCorner.CornerRadius = UDim.new(
	0,
	10
)

StatusCorner.Parent = Status

-- Status dot

local StatusDot = Instance.new("Frame")

StatusDot.Size = UDim2.fromOffset(
	9,
	9
)

StatusDot.Position = UDim2.new(
	0,
	14,
	0.5,
	-4
)

StatusDot.BackgroundColor3 = COLORS.Success

StatusDot.BorderSizePixel = 0

StatusDot.Parent = Status

local DotCorner = Instance.new("UICorner")

DotCorner.CornerRadius = UDim.new(
	1,
	0
)

DotCorner.Parent = StatusDot

-- Status text

local StatusText = Instance.new("TextLabel")

StatusText.BackgroundTransparency = 1

StatusText.Position = UDim2.fromOffset(
	32,
	0
)

StatusText.Size = UDim2.new(
	1,
	-42,
	1,
	0
)

StatusText.Text = "Connected • Ready"

StatusText.TextColor3 = COLORS.SubText

StatusText.TextSize = 12

StatusText.Font = Enum.Font.GothamMedium

StatusText.TextXAlignment = Enum.TextXAlignment.Left

StatusText.Parent = Status

--========================================================--
-- DATA PANEL
--========================================================--

local DataPanel = Instance.new("Frame")

DataPanel.Name = "DataPanel"

DataPanel.Position = UDim2.fromOffset(
	20,
	132
)

DataPanel.Size = UDim2.new(
	1,
	-40,
	1,
	-195
)

DataPanel.BackgroundColor3 = COLORS.Surface

DataPanel.BorderSizePixel = 0

DataPanel.Parent = Main

local DataCorner = Instance.new("UICorner")

DataCorner.CornerRadius = UDim.new(
	0,
	12
)

DataCorner.Parent = DataPanel

--========================================================--
-- DATA TITLE
--========================================================--

local DataTitle = Instance.new("TextLabel")

DataTitle.BackgroundTransparency = 1

DataTitle.Position = UDim2.fromOffset(
	15,
	10
)

DataTitle.Size = UDim2.new(
	1,
	-30,
	0,
	25
)

DataTitle.Text = "PLAYER INFORMATION"

DataTitle.TextColor3 = COLORS.Text

DataTitle.TextSize = 12

DataTitle.Font = Enum.Font.GothamBold

DataTitle.TextXAlignment = Enum.TextXAlignment.Left

DataTitle.Parent = DataPanel

--========================================================--
-- DATA TEXT
--========================================================--

local DataText = Instance.new("TextLabel")

DataText.BackgroundTransparency = 1

DataText.Position = UDim2.fromOffset(
	15,
	40
)

DataText.Size = UDim2.new(
	1,
	-30,
	1,
	-50
)

DataText.Text = "Loading..."

DataText.TextColor3 = COLORS.SubText

DataText.TextSize = 14

DataText.Font = Enum.Font.Gotham

DataText.TextXAlignment = Enum.TextXAlignment.Left

DataText.TextYAlignment = Enum.TextYAlignment.Top

DataText.TextWrapped = true

DataText.Parent = DataPanel

--========================================================--
-- REFRESH BUTTON
--========================================================--

local Refresh = Instance.new("TextButton")

Refresh.Name = "Refresh"

Refresh.Position = UDim2.fromOffset(
	20,
	-55
)

Refresh.Size = UDim2.fromOffset(
	125,
	42
)

Refresh.BackgroundColor3 = COLORS.Accent

Refresh.Text = "↻  Refresh"

Refresh.TextColor3 = COLORS.Text

Refresh.TextSize = 14

Refresh.Font = Enum.Font.GothamBold

Refresh.AutoButtonColor = false

Refresh.Parent = Main

local RefreshCorner = Instance.new("UICorner")

RefreshCorner.CornerRadius = UDim.new(
	0,
	10
)

RefreshCorner.Parent = Refresh

--========================================================--
-- FOOTER
--========================================================--

local Footer = Instance.new("TextLabel")

Footer.BackgroundTransparency = 1

Footer.AnchorPoint = Vector2.new(
	1,
	0
)

Footer.Position = UDim2.new(
	1,
	-20,
	1,
	-53
)

Footer.Size = UDim2.fromOffset(
	220,
	20
)

Footer.Text = "Created by CH3A5  •  v6.1"

Footer.TextColor3 = COLORS.SubText

Footer.TextSize = 11

Footer.Font = Enum.Font.Gotham

Footer.TextXAlignment = Enum.TextXAlignment.Right

Footer.Parent = Main

--========================================================--
-- RESIZE HANDLE
--========================================================--

local Resize = Instance.new("TextButton")

Resize.Name = "ResizeHandle"

Resize.AnchorPoint = Vector2.new(
	1,
	1
)

Resize.Position = UDim2.new(
	1,
	-6,
	1,
	-6
)

Resize.Size = UDim2.fromOffset(
	35,
	35
)

Resize.BackgroundTransparency = 1

Resize.Text = "↘"

Resize.TextColor3 = COLORS.SubText

Resize.TextSize = 20

Resize.Font = Enum.Font.GothamBold

Resize.AutoButtonColor = false

Resize.Visible = CONFIG.Resizable

Resize.Parent = Main

--========================================================--
-- OPEN BUTTON
--========================================================--

local Open = Instance.new("TextButton")

Open.Name = "OpenButton"

Open.Size = UDim2.fromOffset(
	58,
	58
)

Open.Position = UDim2.new(
	0,
	20,
	0.5,
	-29
)

Open.BackgroundColor3 = COLORS.Background

Open.Text = "CH"

Open.TextColor3 = COLORS.Text

Open.TextSize = 16

Open.Font = Enum.Font.GothamBold

Open.Visible = false

Open.AutoButtonColor = false

Open.Parent = GUI

local OpenCorner = Instance.new("UICorner")

OpenCorner.CornerRadius = UDim.new(
	1,
	0
)

OpenCorner.Parent = Open

local OpenStroke = Instance.new("UIStroke")

OpenStroke.Color = COLORS.Accent

OpenStroke.Thickness = 1

OpenStroke.Parent = Open

--========================================================--
-- DATA UPDATE
--========================================================--

local function UpdateData()

	StatusText.Text = "Connected • Updating..."

	StatusDot.BackgroundColor3 = COLORS.Accent

	local username = Player.Name
	local displayName = Player.DisplayName

	local userId = Player.UserId

	local placeId = game.PlaceId

	local jobId = game.JobId

	if jobId == "" then
		jobId = "Studio"
	end

	local accountAge = Player.AccountAge

	DataText.Text =
		"Username\n" ..
		username ..

		"\n\nDisplay Name\n" ..
		displayName ..

		"\n\nUser ID\n" ..
		tostring(userId) ..

		"\n\nAccount Age\n" ..
		tostring(accountAge) ..
		" days" ..

		"\n\nPlace ID\n" ..
		tostring(placeId) ..

		"\n\nServer Job ID\n" ..
		jobId

	StatusText.Text = "Connected • Data updated"

	StatusDot.BackgroundColor3 = COLORS.Success

end

--========================================================--
-- BUTTON ANIMATION
--========================================================--

local function ButtonHover(Button, Normal, Hover)

	Button.MouseEnter:Connect(function()

		TweenService:Create(
			Button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Hover
			}
		):Play()

	end)

	Button.MouseLeave:Connect(function()

		TweenService:Create(
			Button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = Normal
			}
		):Play()

	end)

end

ButtonHover(
	Refresh,
	COLORS.Accent,
	COLORS.Accent2
)

ButtonHover(
	Close,
	Color3.fromRGB(40,41,48),
	Color3.fromRGB(65,45,50)
)

--========================================================--
-- DRAG SYSTEM
--========================================================--

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

--========================================================--
-- RESIZE SYSTEM
--========================================================--

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

--========================================================--
-- CLOSE ANIMATION
--========================================================--

Close.Activated:Connect(function()

	local Tween = TweenService:Create(

		Main,

		TweenInfo.new(
			CONFIG.AnimationTime,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		),

		{
			Size = UDim2.fromOffset(0,0)
		}

	)

	Tween:Play()

	Tween.Completed:Wait()

	Main.Visible = false

	Main.Size = UDim2.fromOffset(

		CONFIG.StartSize.X,
		CONFIG.StartSize.Y

	)

	Open.Visible = true

end)

--========================================================--
-- OPEN ANIMATION
--========================================================--

Open.Activated:Connect(function()

	Open.Visible = false

	Main.Visible = true

	Main.Size = UDim2.fromOffset(0,0)

	TweenService:Create(

		Main,

		TweenInfo.new(
			CONFIG.AnimationTime,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),

		{
			Size = UDim2.fromOffset(
				CONFIG.StartSize.X,
				CONFIG.StartSize.Y
			)
		}

	):Play()

end)

--========================================================--
-- REFRESH
--========================================================--

Refresh.Activated:Connect(function()

	UpdateData()

end)

--========================================================--
-- START
--========================================================--

UpdateData()

print(
	"[CH3A5] Personal Data UI v"
	.. CONFIG.Version
	.. " loaded successfully."
)
