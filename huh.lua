--========================================================--
--                 CH3A5 PREMIUM UI v10.0                 --
--========================================================--
-- Created by CH3A5
-- Premium Dashboard / KH + EN / Mobile / PC
-- Drag / Resize / FPS / Ping / Session / Settings
-- UI ONLY
--========================================================--

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local GuiService = game:GetService("GuiService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local VERSION = "10.0"
local CREATOR = "CH3A5"

local MIN_SIZE = Vector2.new(320, 260)
local MAX_SIZE = Vector2.new(760, 600)
local START_SIZE = Vector2.new(460, 380)

local DEFAULT_SCALE = 1
local DEFAULT_TRANSPARENCY = 0

local Language = "EN"
local Animations = true
local UIScaleValue = DEFAULT_SCALE
local Transparency = DEFAULT_TRANSPARENCY

local SessionStart = tick()

--========================================================--
-- COLORS
--========================================================--

local C = {
	Background = Color3.fromRGB(12, 13, 17),
	Surface = Color3.fromRGB(19, 21, 27),
	Surface2 = Color3.fromRGB(25, 27, 34),

	Accent = Color3.fromRGB(111, 82, 235),
	AccentDark = Color3.fromRGB(84, 60, 190),

	Text = Color3.fromRGB(245, 245, 248),
	SubText = Color3.fromRGB(155, 159, 171),

	Success = Color3.fromRGB(80, 210, 130),
	Warning = Color3.fromRGB(245, 190, 75),
	Danger = Color3.fromRGB(235, 80, 95),

	Border = Color3.fromRGB(60, 63, 75)
}

--========================================================--
-- TRANSLATIONS
--========================================================--

local T = {
	EN = {
		title = "Personal Dashboard",
		subtitle = "Premium Player Interface",
		dashboard = "DASHBOARD",
		player = "PLAYER",
		performance = "PERFORMANCE",
		session = "SESSION",
		username = "Username",
		display = "Display Name",
		userid = "User ID",
		account = "Account Age",
		ping = "Ping",
		fps = "FPS",
		place = "Place ID",
		job = "Server Job ID",
		time = "Session Time",
		refresh = "Refresh",
		settings = "Settings",
		language = "Language",
		animation = "Animations",
		scale = "UI Scale",
		transparency = "Transparency",
		reset = "Reset UI",
		copy = "Copy User ID",
		close = "Close",
		back = "Back",
		enabled = "ON",
		disabled = "OFF",
		ready = "System Ready",
		updated = "Data Updated",
		copied = "User ID copied",
		resetDone = "UI reset",
		created = "Created by CH3A5",
	},

	KH = {
		title = "ផ្ទាំងព័ត៌មានផ្ទាល់ខ្លួន",
		subtitle = "Premium Player Interface",
		dashboard = "ផ្ទាំងព័ត៌មាន",
		player = "ព័ត៌មានអ្នកលេង",
		performance = "ប្រសិទ្ធភាព",
		session = "Session",
		username = "ឈ្មោះអ្នកប្រើ",
		display = "ឈ្មោះបង្ហាញ",
		userid = "User ID",
		account = "អាយុគណនី",
		ping = "Ping",
		fps = "FPS",
		place = "Place ID",
		job = "Server Job ID",
		time = "ពេលវេលា Session",
		refresh = "ធ្វើឱ្យថ្មី",
		settings = "ការកំណត់",
		language = "ភាសា",
		animation = "Animation",
		scale = "ទំហំ UI",
		transparency = "ភាពថ្លា",
		reset = "កំណត់ UI ឡើងវិញ",
		copy = "ចម្លង User ID",
		close = "បិទ",
		back = "ត្រឡប់",
		enabled = "បើក",
		disabled = "បិទ",
		ready = "ប្រព័ន្ធរួចរាល់",
		updated = "ទិន្នន័យបានធ្វើថ្មី",
		copied = "បានចម្លង User ID",
		resetDone = "បាន Reset UI",
		created = "បង្កើតដោយ CH3A5",
	}
}

local function tr(key)
	return T[Language][key] or key
end

--========================================================--
-- GUI
--========================================================--

local GUI = Instance.new("ScreenGui")
GUI.Name = "CH3A5_Premium_v10"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = PlayerGui

--========================================================--
-- MAIN
--========================================================--

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(START_SIZE.X, START_SIZE.Y)
Main.Position = UDim2.new(.5, -START_SIZE.X/2, .5, -START_SIZE.Y/2)
Main.BackgroundColor3 = C.Background
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = GUI

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 17)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = C.Border
MainStroke.Thickness = 1
MainStroke.Transparency = .2

local UIScale = Instance.new("UIScale")
UIScale.Scale = UIScaleValue
UIScale.Parent = Main

--========================================================--
-- HEADER
--========================================================--

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,66)
Header.BackgroundColor3 = C.Surface
Header.BorderSizePixel = 0
Header.Active = true
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0,17)

local Brand = Instance.new("TextLabel")
Brand.BackgroundTransparency = 1
Brand.Position = UDim2.fromOffset(18,8)
Brand.Size = UDim2.new(1,-110,0,25)
Brand.Text = "CH3A5"
Brand.TextColor3 = C.Text
Brand.TextSize = 20
Brand.Font = Enum.Font.GothamBold
Brand.TextXAlignment = Enum.TextXAlignment.Left
Brand.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.fromOffset(19,36)
Subtitle.Size = UDim2.new(1,-110,0,20)
Subtitle.Text = tr("subtitle") .. "  •  v" .. VERSION
Subtitle.TextColor3 = C.SubText
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

--========================================================--
-- CLOSE
--========================================================--

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(36,36)
Close.Position = UDim2.new(1,-48,.5,-18)
Close.BackgroundColor3 = C.Surface2
Close.Text = "×"
Close.TextColor3 = C.Text
Close.TextSize = 22
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.Parent = Header

local CloseCorner = Instance.new("UICorner", Close)
CloseCorner.CornerRadius = UDim.new(0,9)

--========================================================--
-- STATUS
--========================================================--

local Status = Instance.new("Frame")
Status.Position = UDim2.fromOffset(20,80)
Status.Size = UDim2.new(1,-40,0,38)
Status.BackgroundColor3 = C.Surface
Status.BorderSizePixel = 0
Status.Parent = Main

local StatusCorner = Instance.new("UICorner", Status)
StatusCorner.CornerRadius = UDim.new(0,10)

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(9,9)
StatusDot.Position = UDim2.new(0,14,.5,-4)
StatusDot.BackgroundColor3 = C.Success
StatusDot.BorderSizePixel = 0
StatusDot.Parent = Status

local DotCorner = Instance.new("UICorner", StatusDot)
DotCorner.CornerRadius = UDim.new(1,0)

local StatusText = Instance.new("TextLabel")
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.fromOffset(32,0)
StatusText.Size = UDim2.new(1,-42,1,0)
StatusText.Text = "●  " .. tr("ready")
StatusText.TextColor3 = C.SubText
StatusText.TextSize = 12
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = Status

--========================================================--
-- CONTENT
--========================================================--

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(20,130)
Content.Size = UDim2.new(1,-40,1,-195)
Content.BackgroundTransparency = 1
Content.Parent = Main

--========================================================--
-- DASHBOARD PANEL
--========================================================--

local Dashboard = Instance.new("Frame")
Dashboard.Size = UDim2.fromScale(1,1)
Dashboard.BackgroundColor3 = C.Surface
Dashboard.BorderSizePixel = 0
Dashboard.Parent = Content

local DashboardCorner = Instance.new("UICorner", Dashboard)
DashboardCorner.CornerRadius = UDim.new(0,13)

local DataTitle = Instance.new("TextLabel")
DataTitle.BackgroundTransparency = 1
DataTitle.Position = UDim2.fromOffset(16,10)
DataTitle.Size = UDim2.new(1,-32,0,24)
DataTitle.Text = tr("dashboard")
DataTitle.TextColor3 = C.Text
DataTitle.TextSize = 12
DataTitle.Font = Enum.Font.GothamBold
DataTitle.TextXAlignment = Enum.TextXAlignment.Left
DataTitle.Parent = Dashboard

local DataText = Instance.new("TextLabel")
DataText.BackgroundTransparency = 1
DataText.Position = UDim2.fromOffset(16,39)
DataText.Size = UDim2.new(1,-32,1,-48)
DataText.TextColor3 = C.SubText
DataText.TextSize = 13
DataText.Font = Enum.Font.Gotham
DataText.TextXAlignment = Enum.TextXAlignment.Left
DataText.TextYAlignment = Enum.TextYAlignment.Top
DataText.TextWrapped = true
DataText.Parent = Dashboard

--========================================================--
-- SETTINGS PANEL
--========================================================--

local Settings = Instance.new("Frame")
Settings.Size = UDim2.fromScale(1,1)
Settings.BackgroundColor3 = C.Surface
Settings.BorderSizePixel = 0
Settings.Visible = false
Settings.Parent = Content

local SettingsCorner = Instance.new("UICorner", Settings)
SettingsCorner.CornerRadius = UDim.new(0,13)

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Position = UDim2.fromOffset(16,10)
SettingsTitle.Size = UDim2.new(1,-32,0,24)
SettingsTitle.Text = tr("settings")
SettingsTitle.TextColor3 = C.Text
SettingsTitle.TextSize = 15
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.Parent = Settings

--========================================================--
-- SETTINGS BUTTON HELPER
--========================================================--

local function createSettingButton(name, y)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1,-32,0,42)
	button.Position = UDim2.fromOffset(16,y)

	button.BackgroundColor3 = C.Surface2
	button.TextColor3 = C.Text

	button.TextSize = 13
	button.Font = Enum.Font.GothamMedium

	button.AutoButtonColor = false

	button.Parent = Settings

	local corner = Instance.new("UICorner",button)
	corner.CornerRadius = UDim.new(0,9)

	return button
end

local LanguageButton = createSettingButton("Language",48)
local AnimationButton = createSettingButton("Animation",98)
local ScaleButton = createSettingButton("Scale",148)
local TransparencyButton = createSettingButton("Transparency",198)
local ResetButton = createSettingButton("Reset",248)

--========================================================--
-- BOTTOM BUTTONS
--========================================================--

local Refresh = Instance.new("TextButton")
Refresh.Size = UDim2.fromOffset(115,40)
Refresh.Position = UDim2.fromOffset(20,-55)
Refresh.BackgroundColor3 = C.Accent
Refresh.TextColor3 = C.Text
Refresh.TextSize = 13
Refresh.Font = Enum.Font.GothamBold
Refresh.AutoButtonColor = false
Refresh.Parent = Main

local RefreshCorner = Instance.new("UICorner",Refresh)
RefreshCorner.CornerRadius = UDim.new(0,10)

local SettingsButton = Instance.new("TextButton")
SettingsButton.Size = UDim2.fromOffset(115,40)
SettingsButton.Position = UDim2.new(0,145,1,15)
SettingsButton.BackgroundColor3 = C.Surface2
SettingsButton.TextColor3 = C.Text
SettingsButton.TextSize = 13
SettingsButton.Font = Enum.Font.GothamBold
SettingsButton.AutoButtonColor = false
SettingsButton.Parent = Main

local SettingsCorner2 = Instance.new("UICorner",SettingsButton)
SettingsCorner2.CornerRadius = UDim.new(0,10)

--========================================================--
-- FOOTER
--========================================================--

local Footer = Instance.new("TextLabel")
Footer.BackgroundTransparency = 1
Footer.AnchorPoint = Vector2.new(1,0)
Footer.Position = UDim2.new(1,-20,1,-52)
Footer.Size = UDim2.fromOffset(220,20)
Footer.Text = tr("created") .. "  •  v" .. VERSION
Footer.TextColor3 = C.SubText
Footer.TextSize = 10
Footer.Font = Enum.Font.Gotham
Footer.TextXAlignment = Enum.TextXAlignment.Right
Footer.Parent = Main

--========================================================--
-- RESIZE
--========================================================--

local Resize = Instance.new("TextButton")
Resize.Size = UDim2.fromOffset(38,38)
Resize.AnchorPoint = Vector2.new(1,1)
Resize.Position = UDim2.new(1,-5,1,-5)
Resize.BackgroundTransparency = 1
Resize.Text = "↘"
Resize.TextColor3 = C.SubText
Resize.TextSize = 20
Resize.Font = Enum.Font.GothamBold
Resize.AutoButtonColor = false
Resize.Parent = Main

--========================================================--
-- OPEN BUTTON
--========================================================--

local Open = Instance.new("TextButton")
Open.Size = UDim2.fromOffset(58,58)
Open.Position = UDim2.new(0,20,.5,-29)
Open.BackgroundColor3 = C.Background
Open.Text = "CH"
Open.TextColor3 = C.Text
Open.TextSize = 16
Open.Font = Enum.Font.GothamBold
Open.Visible = false
Open.Parent = GUI

local OpenCorner = Instance.new("UICorner",Open)
OpenCorner.CornerRadius = UDim.new(1,0)

local OpenStroke = Instance.new("UIStroke",Open)
OpenStroke.Color = C.Accent
OpenStroke.Thickness = 1

--========================================================--
-- TOAST
--========================================================--

local Toast = Instance.new("TextLabel")
Toast.AnchorPoint = Vector2.new(.5,1)
Toast.Position = UDim2.new(.5,0,1,-25)
Toast.Size = UDim2.fromOffset(280,42)
Toast.BackgroundColor3 = C.Surface2
Toast.TextColor3 = C.Text
Toast.TextSize = 12
Toast.Font = Enum.Font.GothamMedium
Toast.Visible = false
Toast.Parent = GUI

local ToastCorner = Instance.new("UICorner",Toast)
ToastCorner.CornerRadius = UDim.new(0,10)

local ToastStroke = Instance.new("UIStroke",Toast)
ToastStroke.Color = C.Border

local function toast(message)

	Toast.Text = message
	Toast.Visible = true
	Toast.TextTransparency = 0

	task.delay(1.8,function()

		if Toast then

			local tween = TweenService:Create(
				Toast,
				TweenInfo.new(.2),
				{TextTransparency = 1}
			)

			tween:Play()

			tween.Completed:Wait()

			Toast.Visible = false
			Toast.TextTransparency = 0

		end

	end)

end

--========================================================--
-- DATA
--========================================================--

local FPS = 0
local Frames = 0
local LastFPS = tick()

local function getPing()

	local result = "N/A"

	pcall(function()

		local item =
			Stats.Network.ServerStatsItem["Data Ping"]

		result =
			tostring(math.floor(item:GetValue()))
			.. " ms"

	end)

	return result
end

local function formatTime(seconds)

	seconds = math.floor(seconds)

	local h = math.floor(seconds / 3600)

	local m = math.floor(
		(seconds % 3600) / 60
	)

	local s = seconds % 60

	return string.format(
		"%02d:%02d:%02d",
		h,m,s
	)

end

local function updateData()

	local jobId = game.JobId

	if jobId == "" then
		jobId = "Studio"
	end

	DataText.Text =

		tr("player") ..

		"\n\n" ..
		tr("username") ..
		"     :  " ..
		Player.Name ..

		"\n" ..
		tr("display") ..
		"     :  " ..
		Player.DisplayName ..

		"\n" ..
		tr("userid") ..
		"       :  " ..
		tostring(Player.UserId) ..

		"\n" ..
		tr("account") ..
		"     :  " ..
		tostring(Player.AccountAge) ..
		" days" ..

		"\n\n" ..

		tr("performance") ..

		"\n\n" ..
		tr("ping") ..
		"          :  " ..
		getPing() ..

		"\n" ..
		tr("fps") ..
		"           :  " ..
		tostring(FPS) ..

		"\n\n" ..

		tr("session") ..

		"\n\n" ..
		tr("place") ..
		"        :  " ..
		tostring(game.PlaceId) ..

		"\n" ..
		tr("job") ..
		" :  " ..
		jobId ..

		"\n" ..
		tr("time") ..
		"    :  " ..
		formatTime(tick() - SessionStart)

end

--========================================================--
-- FPS LOOP
--========================================================--

RunService.RenderStepped:Connect(function()

	Frames += 1

	local now = tick()

	if now - LastFPS >= 1 then

		FPS = Frames

		Frames = 0

		LastFPS = now

		if Dashboard.Visible then
			updateData()
		end

	end

end)

--========================================================--
-- UPDATE LANGUAGE
--========================================================--

local function updateLanguage()

	Subtitle.Text =
		tr("subtitle")
		.. "  •  v"
		.. VERSION

	StatusText.Text =
		"●  "
		.. tr("ready")

	Refresh.Text =
		"↻  "
		.. tr("refresh")

	SettingsButton.Text =
		"⚙  "
		.. tr("settings")

	SettingsTitle.Text =
		tr("settings")

	LanguageButton.Text =
		tr("language")
		.. "     :  "
		.. Language

	AnimationButton.Text =
		tr("animation")
		.. "     :  "
		.. (Animations and tr("enabled") or tr("disabled"))

	ScaleButton.Text =
		tr("scale")
		.. "          :  "
		.. tostring(UIScaleValue)

	TransparencyButton.Text =
		tr("transparency")
		.. " :  "
		.. tostring(math.floor(Transparency * 100))
		.. "%"

	ResetButton.Text =
		"↺  "
		.. tr("reset")

	Footer.Text =
		tr("created")
		.. "  •  v"
		.. VERSION

	updateData()

end

--========================================================--
-- LANGUAGE BUTTON
--========================================================--

LanguageButton.Activated:Connect(function()

	if Language == "EN" then
		Language = "KH"
	else
		Language = "EN"
	end

	updateLanguage()

	toast(
		Language == "KH"
		and "ភាសា: ខ្មែរ"
		or "Language: English"
	)

end)

--========================================================--
-- ANIMATION BUTTON
--========================================================--

AnimationButton.Activated:Connect(function()

	Animations = not Animations

	updateLanguage()

end)

--========================================================--
-- SCALE BUTTON
--========================================================--

ScaleButton.Activated:Connect(function()

	UIScaleValue += .1

	if UIScaleValue > 1.3 then
		UIScaleValue = .8
	end

	UIScale.Scale = UIScaleValue

	updateLanguage()

end)

--========================================================--
-- TRANSPARENCY BUTTON
--========================================================--

TransparencyButton.Activated:Connect(function()

	Transparency += .1

	if Transparency > .4 then
		Transparency = 0
	end

	Main.BackgroundTransparency = Transparency

	updateLanguage()

end)

--========================================================--
-- RESET
--========================================================--

local function resetUI()

	Main.Size = UDim2.fromOffset(
		START_SIZE.X,
		START_SIZE.Y
	)

	Main.Position = UDim2.new(
		.5,
		-START_SIZE.X/2,
		.5,
		-START_SIZE.Y/2
	)

	UIScaleValue = DEFAULT_SCALE
	Transparency = DEFAULT_TRANSPARENCY

	UIScale.Scale = DEFAULT_SCALE
	Main.BackgroundTransparency = 0

	updateLanguage()

	toast(tr("resetDone"))

end

ResetButton.Activated:Connect(resetUI)

--========================================================--
-- REFRESH
--========================================================--

Refresh.Activated:Connect(function()

	StatusText.Text =
		"●  "
		.. tr("updated")

	StatusDot.BackgroundColor3 = C.Accent

	updateData()

	task.delay(.8,function()

		StatusText.Text =
			"●  "
			.. tr("ready")

		StatusDot.BackgroundColor3 =
			C.Success

	end)

end)

--========================================================--
-- SETTINGS TOGGLE
--========================================================--

local function showSettings()

	Dashboard.Visible = false
	Settings.Visible = true

	Refresh.Visible = false
	SettingsButton.Text =
		"←  "
		.. tr("back")

end

local function showDashboard()

	Settings.Visible = false
	Dashboard.Visible = true

	Refresh.Visible = true

	SettingsButton.Text =
		"⚙  "
		.. tr("settings")

end

SettingsButton.Activated:Connect(function()

	if Dashboard.Visible then
		showSettings()
	else
		showDashboard()
	end

end)

--========================================================--
-- DRAG
--========================================================--

local dragging = false
local dragStart
local startPosition
local dragInput

Header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true

		dragStart = input.Position
		startPosition = Main.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				dragging = false

			end

		end)

	end

end)

Header.InputChanged:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or input.UserInputType ==
		Enum.UserInputType.Touch then

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

	local delta =
		input.Position - dragStart

	Main.Position = UDim2.new(

		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,

		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y

	)

end)

--========================================================--
-- RESIZE
--========================================================--

local resizing = false
local resizeStart
local startSize
local resizeInput

Resize.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		resizing = true

		resizeStart = input.Position
		startSize = Main.AbsoluteSize

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				resizing = false

			end

		end)

	end

end)

Resize.InputChanged:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or input.UserInputType ==
		Enum.UserInputType.Touch then

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

	local delta =
		input.Position - resizeStart

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

	Main.Size =
		UDim2.fromOffset(
			width,
			height
		)

end)

--========================================================--
-- CLOSE
--========================================================--

Close.Activated:Connect(function()

	if Animations then

		local tween = TweenService:Create(

			Main,

			TweenInfo.new(
				.2,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.In
			),

			{
				Size = UDim2.fromOffset(0,0)
			}

		)

		tween:Play()
		tween.Completed:Wait()

	end

	Main.Visible = false
	Open.Visible = true

end)

--========================================================--
-- OPEN
--========================================================--

Open.Activated:Connect(function()

	Open.Visible = false
	Main.Visible = true

	if Animations then

		Main.Size =
			UDim2.fromOffset(0,0)

		TweenService:Create(

			Main,

			TweenInfo.new(
				.25,
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

	else

		Main.Size =
			UDim2.fromOffset(
				START_SIZE.X,
				START_SIZE.Y
			)

	end

end)

--========================================================--
-- BUTTON EFFECT
--========================================================--

local function hover(button, normal, active)

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(.12),
			{
				BackgroundColor3 = active
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(.12),
			{
				BackgroundColor3 = normal
			}
		):Play()

	end)

end

hover(
	Refresh,
	C.Accent,
	C.AccentDark
)

hover(
	SettingsButton,
	C.Surface2,
	C.Border
)

hover(
	Close,
	C.Surface2,
	Color3.fromRGB(65,45,50)
)

hover(
	LanguageButton,
	C.Surface2,
	C.Border
)

hover(
	AnimationButton,
	C.Surface2,
	C.Border
)

hover(
	ScaleButton,
	C.Surface2,
	C.Border
)

hover(
	TransparencyButton,
	C.Surface2,
	C.Border
)

hover(
	ResetButton,
	C.Surface2,
	C.Border
)

--========================================================--
-- START
--========================================================--

updateLanguage()
updateData()

print(
	"[CH3A5] Premium UI v"
	.. VERSION
	.. " loaded."
)
