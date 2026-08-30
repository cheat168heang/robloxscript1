--========================================================--
--              CH3A5 PREMIUM DASHBOARD v10.0             --
--========================================================--
-- Single LocalScript
-- Roblox Studio -> StarterGui -> LocalScript
-- Created by CH3A5
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================--
-- SETTINGS
--========================================================--

local VERSION = "10.0"

local MIN_SIZE = Vector2.new(340, 260)
local MAX_SIZE = Vector2.new(780, 560)
local DEFAULT_SIZE = Vector2.new(500, 400)

local language = "EN"
local animations = true
local uiScale = 1

local sessionStart = os.clock()

--========================================================--
-- COLORS
--========================================================--

local BG = Color3.fromRGB(10, 11, 15)
local CARD = Color3.fromRGB(18, 20, 27)
local CARD2 = Color3.fromRGB(24, 26, 34)

local TEXT = Color3.fromRGB(245, 246, 250)
local MUTED = Color3.fromRGB(145, 149, 162)

local ACCENT = Color3.fromRGB(112, 82, 240)
local ACCENT_DARK = Color3.fromRGB(82, 59, 190)

local GREEN = Color3.fromRGB(75, 210, 125)

--========================================================--
-- TRANSLATION
--========================================================--

local LANG = {

	EN = {
		title = "Personal Dashboard",
		subtitle = "Premium Player Interface",

		dashboard = "Dashboard",
		settings = "Settings",

		player = "PLAYER",
		performance = "PERFORMANCE",
		server = "SERVER",

		username = "Username",
		display = "Display Name",
		userid = "User ID",
		account = "Account Age",

		fps = "FPS",
		ping = "Ping",
		session = "Session",

		place = "Place ID",
		job = "Server Job ID",

		refresh = "Refresh",
		language = "Language",
		animations = "Animations",
		scale = "UI Scale",
		reset = "Reset UI",

		online = "ONLINE",
		ready = "System Ready",

		created = "Created by CH3A5"
	},

	KH = {
		title = "ផ្ទាំងព័ត៌មានផ្ទាល់ខ្លួន",
		subtitle = "Premium Player Interface",

		dashboard = "ផ្ទាំងព័ត៌មាន",
		settings = "ការកំណត់",

		player = "ព័ត៌មានអ្នកលេង",
		performance = "ប្រសិទ្ធភាព",
		server = "SERVER",

		username = "ឈ្មោះអ្នកប្រើ",
		display = "ឈ្មោះបង្ហាញ",
		userid = "User ID",
		account = "អាយុគណនី",

		fps = "FPS",
		ping = "Ping",
		session = "Session",

		place = "Place ID",
		job = "Server Job ID",

		refresh = "ធ្វើថ្មី",
		language = "ភាសា",
		animations = "Animation",
		scale = "ទំហំ UI",
		reset = "Reset UI",

		online = "ONLINE",
		ready = "ប្រព័ន្ធរួចរាល់",

		created = "បង្កើតដោយ CH3A5"
	}
}

local function text(key)
	return LANG[language][key] or key
end

--========================================================--
-- GUI
--========================================================--

local gui = Instance.new("ScreenGui")

gui.Name = "CH3A5_Premium_v10"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

gui.Parent = playerGui

--========================================================--
-- MAIN
--========================================================--

local main = Instance.new("Frame")

main.Size = UDim2.fromOffset(
	DEFAULT_SIZE.X,
	DEFAULT_SIZE.Y
)

main.Position = UDim2.new(
	0.5,
	-DEFAULT_SIZE.X / 2,
	0.5,
	-DEFAULT_SIZE.Y / 2
)

main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Active = true

main.Parent = gui

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(55, 58, 72)
stroke.Transparency = 0.15

local scaleObject = Instance.new("UIScale", main)
scaleObject.Scale = uiScale

--========================================================--
-- HEADER
--========================================================--

local header = Instance.new("Frame")

header.Size = UDim2.new(1, 0, 0, 70)
header.BackgroundColor3 = CARD
header.BorderSizePixel = 0
header.Active = true

header.Parent = main

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 18)

-- Logo

local logo = Instance.new("Frame")

logo.Size = UDim2.fromOffset(42, 42)
logo.Position = UDim2.fromOffset(16, 14)
logo.BackgroundColor3 = ACCENT
logo.BorderSizePixel = 0

logo.Parent = header

local logoCorner = Instance.new("UICorner", logo)
logoCorner.CornerRadius = UDim.new(0, 12)

local logoText = Instance.new("TextLabel")

logoText.Size = UDim2.fromScale(1, 1)
logoText.BackgroundTransparency = 1

logoText.Text = "CH"
logoText.TextColor3 = TEXT
logoText.TextSize = 14
logoText.Font = Enum.Font.GothamBold

logoText.Parent = logo

-- Brand

local brand = Instance.new("TextLabel")

brand.BackgroundTransparency = 1

brand.Position = UDim2.fromOffset(68, 11)
brand.Size = UDim2.new(1, -160, 0, 25)

brand.Text = "CH3A5"

brand.TextColor3 = TEXT
brand.TextSize = 19
brand.Font = Enum.Font.GothamBold

brand.TextXAlignment = Enum.TextXAlignment.Left

brand.Parent = header

local subtitle = Instance.new("TextLabel")

subtitle.BackgroundTransparency = 1

subtitle.Position = UDim2.fromOffset(69, 37)
subtitle.Size = UDim2.new(1, -170, 0, 18)

subtitle.Text = text("subtitle") .. "  •  v" .. VERSION

subtitle.TextColor3 = MUTED
subtitle.TextSize = 10
subtitle.Font = Enum.Font.Gotham

subtitle.TextXAlignment = Enum.TextXAlignment.Left

subtitle.Parent = header

-- ONLINE

local online = Instance.new("TextLabel")

online.BackgroundTransparency = 1

online.AnchorPoint = Vector2.new(1, 0.5)
online.Position = UDim2.new(1, -55, 0.5, 0)

online.Size = UDim2.fromOffset(65, 20)

online.Text = "● " .. text("online")

online.TextColor3 = GREEN
online.TextSize = 10
online.Font = Enum.Font.GothamBold

online.Parent = header

-- CLOSE

local close = Instance.new("TextButton")

close.Size = UDim2.fromOffset(32, 32)

close.Position = UDim2.new(1, -42, 0, 19)

close.BackgroundColor3 = CARD2

close.Text = "×"

close.TextColor3 = TEXT
close.TextSize = 20
close.Font = Enum.Font.GothamBold

close.AutoButtonColor = false

close.Parent = header

local closeCorner = Instance.new("UICorner", close)
closeCorner.CornerRadius = UDim.new(0, 9)

--========================================================--
-- STATUS
--========================================================--

local status = Instance.new("Frame")

status.Position = UDim2.fromOffset(18, 82)

status.Size = UDim2.new(1, -36, 0, 35)

status.BackgroundColor3 = CARD
status.BorderSizePixel = 0

status.Parent = main

local statusCorner = Instance.new("UICorner", status)
statusCorner.CornerRadius = UDim.new(0, 10)

local statusDot = Instance.new("Frame")

statusDot.Size = UDim2.fromOffset(8, 8)

statusDot.Position = UDim2.fromOffset(13, 13)

statusDot.BackgroundColor3 = GREEN
statusDot.BorderSizePixel = 0

statusDot.Parent = status

local statusDotCorner = Instance.new("UICorner", statusDot)
statusDotCorner.CornerRadius = UDim.new(1, 0)

local statusText = Instance.new("TextLabel")

statusText.BackgroundTransparency = 1

statusText.Position = UDim2.fromOffset(29, 0)

statusText.Size = UDim2.new(1, -40, 1, 0)

statusText.Text = text("ready")

statusText.TextColor3 = MUTED
statusText.TextSize = 11
statusText.Font = Enum.Font.GothamMedium

statusText.TextXAlignment = Enum.TextXAlignment.Left

statusText.Parent = status

--========================================================--
-- CONTENT
--========================================================--

local content = Instance.new("Frame")

content.Position = UDim2.fromOffset(18, 128)

content.Size = UDim2.new(
	1,
	-36,
	1,
	-190
)

content.BackgroundTransparency = 1

content.Parent = main

--========================================================--
-- CARD CREATOR
--========================================================--

local function createCard(position, size)

	local card = Instance.new("Frame")

	card.Position = position
	card.Size = size

	card.BackgroundColor3 = CARD
	card.BorderSizePixel = 0

	card.Parent = content

	local corner = Instance.new("UICorner", card)
	corner.CornerRadius = UDim.new(0, 13)

	return card
end

-- PLAYER CARD

local playerCard = createCard(
	UDim2.fromScale(0, 0),
	UDim2.new(.49, -5, .48, -5)
)

local playerTitle = Instance.new("TextLabel")

playerTitle.BackgroundTransparency = 1
playerTitle.Position = UDim2.fromOffset(14, 10)
playerTitle.Size = UDim2.new(1, -28, 0, 20)

playerTitle.Text = text("player")

playerTitle.TextColor3 = TEXT
playerTitle.TextSize = 11
playerTitle.Font = Enum.Font.GothamBold

playerTitle.TextXAlignment = Enum.TextXAlignment.Left

playerTitle.Parent = playerCard

local playerInfo = Instance.new("TextLabel")

playerInfo.BackgroundTransparency = 1

playerInfo.Position = UDim2.fromOffset(14, 34)

playerInfo.Size = UDim2.new(1, -28, 1, -42)

playerInfo.TextColor3 = MUTED

playerInfo.TextSize = 11
playerInfo.Font = Enum.Font.Gotham

playerInfo.TextXAlignment = Enum.TextXAlignment.Left
playerInfo.TextYAlignment = Enum.TextYAlignment.Top

playerInfo.Parent = playerCard

-- PERFORMANCE CARD

local performanceCard = createCard(
	UDim2.new(.51, 5, 0, 0),
	UDim2.new(.49, -5, .48, -5)
)

local performanceTitle = Instance.new("TextLabel")

performanceTitle.BackgroundTransparency = 1

performanceTitle.Position = UDim2.fromOffset(14, 10)

performanceTitle.Size = UDim2.new(1, -28, 0, 20)

performanceTitle.Text = text("performance")

performanceTitle.TextColor3 = TEXT
performanceTitle.TextSize = 11
performanceTitle.Font = Enum.Font.GothamBold

performanceTitle.TextXAlignment = Enum.TextXAlignment.Left

performanceTitle.Parent = performanceCard

local performanceInfo = Instance.new("TextLabel")

performanceInfo.BackgroundTransparency = 1

performanceInfo.Position = UDim2.fromOffset(14, 34)

performanceInfo.Size = UDim2.new(1, -28, 1, -42)

performanceInfo.TextColor3 = MUTED

performanceInfo.TextSize = 11
performanceInfo.Font = Enum.Font.Gotham

performanceInfo.TextXAlignment = Enum.TextXAlignment.Left
performanceInfo.TextYAlignment = Enum.TextYAlignment.Top

performanceInfo.Parent = performanceCard

-- SERVER CARD

local serverCard = createCard(
	UDim2.fromScale(0, .52),
	UDim2.new(1, 0, .48, -5)
)

local serverTitle = Instance.new("TextLabel")

serverTitle.BackgroundTransparency = 1

serverTitle.Position = UDim2.fromOffset(14, 10)

serverTitle.Size = UDim2.new(1, -28, 0, 20)

serverTitle.Text = text("server")

serverTitle.TextColor3 = TEXT
serverTitle.TextSize = 11
serverTitle.Font = Enum.Font.GothamBold

serverTitle.TextXAlignment = Enum.TextXAlignment.Left

serverTitle.Parent = serverCard

local serverInfo = Instance.new("TextLabel")

serverInfo.BackgroundTransparency = 1

serverInfo.Position = UDim2.fromOffset(14, 34)

serverInfo.Size = UDim2.new(1, -28, 1, -42)

serverInfo.TextColor3 = MUTED
serverInfo.TextSize = 11
serverInfo.Font = Enum.Font.Gotham

serverInfo.TextXAlignment = Enum.TextXAlignment.Left
serverInfo.TextYAlignment = Enum.TextYAlignment.Top

serverInfo.Parent = serverCard

--========================================================--
-- SETTINGS
--========================================================--

local settingsPanel = Instance.new("Frame")

settingsPanel.Position = UDim2.fromOffset(18, 128)

settingsPanel.Size = UDim2.new(
	1,
	-36,
	1,
	-190
)

settingsPanel.BackgroundColor3 = CARD

settingsPanel.BorderSizePixel = 0

settingsPanel.Visible = false

settingsPanel.Parent = main

local settingsCorner = Instance.new("UICorner", settingsPanel)
settingsCorner.CornerRadius = UDim.new(0, 13)

local settingsTitle = Instance.new("TextLabel")

settingsTitle.BackgroundTransparency = 1

settingsTitle.Position = UDim2.fromOffset(16, 14)

settingsTitle.Size = UDim2.new(1, -32, 0, 24)

settingsTitle.Text = text("settings")

settingsTitle.TextColor3 = TEXT
settingsTitle.TextSize = 15
settingsTitle.Font = Enum.Font.GothamBold

settingsTitle.TextXAlignment = Enum.TextXAlignment.Left

settingsTitle.Parent = settingsPanel

local function settingButton(y)

	local b = Instance.new("TextButton")

	b.Position = UDim2.fromOffset(16, y)

	b.Size = UDim2.new(1, -32, 0, 42)

	b.BackgroundColor3 = CARD2

	b.TextColor3 = TEXT

	b.TextSize = 12
	b.Font = Enum.Font.GothamMedium

	b.AutoButtonColor = false

	b.Parent = settingsPanel

	local c = Instance.new("UICorner", b)
	c.CornerRadius = UDim.new(0, 9)

	return b
end

local languageButton = settingButton(50)
local animationButton = settingButton(100)
local scaleButton = settingButton(150)
local resetButton = settingButton(200)

--========================================================--
-- BOTTOM
--========================================================--

local refresh = Instance.new("TextButton")

refresh.Size = UDim2.fromOffset(115, 40)

refresh.Position = UDim2.fromOffset(18, -53)

refresh.BackgroundColor3 = ACCENT

refresh.TextColor3 = TEXT

refresh.Text = "↻  " .. text("refresh")

refresh.TextSize = 12
refresh.Font = Enum.Font.GothamBold

refresh.AutoButtonColor = false

refresh.Parent = main

local refreshCorner = Instance.new("UICorner", refresh)
refreshCorner.CornerRadius = UDim.new(0, 10)

local settingsButton = Instance.new("TextButton")

settingsButton.Size = UDim2.fromOffset(115, 40)

settingsButton.Position = UDim2.fromOffset(143, -53)

settingsButton.BackgroundColor3 = CARD2

settingsButton.TextColor3 = TEXT

settingsButton.Text = "⚙  " .. text("settings")

settingsButton.TextSize = 12
settingsButton.Font = Enum.Font.GothamBold

settingsButton.AutoButtonColor = false

settingsButton.Parent = main

local settingsButtonCorner = Instance.new("UICorner", settingsButton)
settingsButtonCorner.CornerRadius = UDim.new(0, 10)

-- FOOTER

local footer = Instance.new("TextLabel")

footer.BackgroundTransparency = 1

footer.AnchorPoint = Vector2.new(1, 0)

footer.Position = UDim2.new(1, -18, 1, -47)

footer.Size = UDim2.fromOffset(210, 18)

footer.Text = text("created") .. "  •  v" .. VERSION

footer.TextColor3 = MUTED

footer.TextSize = 9
footer.Font = Enum.Font.Gotham

footer.TextXAlignment = Enum.TextXAlignment.Right

footer.Parent = main

--========================================================--
-- RESIZE HANDLE
--========================================================--

local resize = Instance.new("TextButton")

resize.Size = UDim2.fromOffset(38, 38)

resize.AnchorPoint = Vector2.new(1, 1)

resize.Position = UDim2.new(1, -4, 1, -4)

resize.BackgroundTransparency = 1

resize.Text = "↘"

resize.TextColor3 = MUTED

resize.TextSize = 18

resize.Font = Enum.Font.GothamBold

resize.AutoButtonColor = false

resize.Parent = main

--========================================================--
-- OPEN BUTTON
--========================================================--

local open = Instance.new("TextButton")

open.Size = UDim2.fromOffset(58, 58)

open.Position = UDim2.new(0, 18, .5, -29)

open.BackgroundColor3 = BG

open.Text = "CH"

open.TextColor3 = TEXT

open.TextSize = 15
open.Font = Enum.Font.GothamBold

open.Visible = false

open.Parent = gui

local openCorner = Instance.new("UICorner", open)
openCorner.CornerRadius = UDim.new(1, 0)

local openStroke = Instance.new("UIStroke", open)
openStroke.Color = ACCENT

--========================================================--
-- UPDATE
--========================================================--

local FPS = 0
local frames = 0
local fpsTime = tick()

local function getPing()

	local result = "N/A"

	pcall(function()

		local item =
			Stats.Network.ServerStatsItem["Data Ping"]

		result =
			math.floor(item:GetValue())
			.. " ms"

	end)

	return result
end

local function formatTime()

	local total = math.floor(
		os.clock() - sessionStart
	)

	local h = math.floor(total / 3600)

	local m = math.floor(
		(total % 3600) / 60
	)

	local s = total % 60

	return string.format(
		"%02d:%02d:%02d",
		h,m,s
	)
end

local function update()

	playerTitle.Text = text("player")
	performanceTitle.Text = text("performance")
	serverTitle.Text = text("server")

	playerInfo.Text =
		text("username") .. "\n" ..
		Player.Name ..

		"\n\n" ..
		text("display") .. "\n" ..
		Player.DisplayName ..

		"\n\n" ..
		text("userid") .. "\n" ..
		tostring(Player.UserId) ..

		"\n\n" ..
		text("account") .. "\n" ..
		tostring(Player.AccountAge) .. " days"

	performanceInfo.Text =
		text("fps") ..
		"\n" ..
		tostring(FPS) ..

		"\n\n" ..
		text("ping") ..
		"\n" ..
		getPing() ..

		"\n\n" ..
		text("session") ..
		"\n" ..
		formatTime()

	local jobId = game.JobId

	if jobId == "" then
		jobId = "Studio"
	end

	serverInfo.Text =
		text("place") ..
		"\n" ..
		tostring(game.PlaceId) ..

		"\n\n" ..
		text("job") ..
		"\n" ..
		jobId

end

RunService.RenderStepped:Connect(function()

	frames += 1

	if tick() - fpsTime >= 1 then

		FPS = frames

		frames = 0
		fpsTime = tick()

		update()

	end

end)

--========================================================--
-- LANGUAGE UPDATE
--========================================================--

local function updateLanguage()

	subtitle.Text =
		text("subtitle")
		.. "  •  v"
		.. VERSION

	online.Text =
		"● "
		.. text("online")

	statusText.Text =
		text("ready")

	refresh.Text =
		"↻  "
		.. text("refresh")

	settingsButton.Text =
		"⚙  "
		.. text("settings")

	settingsTitle.Text =
		text("settings")

	languageButton.Text =
		text("language")
		.. "  :  "
		.. language

	animationButton.Text =
		text("animations")
		.. "  :  "
		.. (animations and "ON" or "OFF")

	scaleButton.Text =
		text("scale")
		.. "  :  "
		.. string.format("%.1f", uiScale)

	resetButton.Text =
		"↺  "
		.. text("reset")

	footer.Text =
		text("created")
		.. "  •  v"
		.. VERSION

	update()

end

--========================================================--
-- SETTINGS
--========================================================--

languageButton.Activated:Connect(function()

	if language == "EN" then
		language = "KH"
	else
		language = "EN"
	end

	updateLanguage()

end)

animationButton.Activated:Connect(function()

	animations = not animations

	updateLanguage()

end)

scaleButton.Activated:Connect(function()

	uiScale += .1

	if uiScale > 1.3 then
		uiScale = .8
	end

	scaleObject.Scale = uiScale

	updateLanguage()

end)

resetButton.Activated:Connect(function()

	main.Size =
		UDim2.fromOffset(
			DEFAULT_SIZE.X,
			DEFAULT_SIZE.Y
		)

	main.Position =
		UDim2.new(
			.5,
			-DEFAULT_SIZE.X / 2,
			.5,
			-DEFAULT_SIZE.Y / 2
		)

	uiScale = 1

	scaleObject.Scale = 1

	updateLanguage()

end)

--========================================================--
-- SETTINGS TOGGLE
--========================================================--

settingsButton.Activated:Connect(function()

	if content.Visible then

		content.Visible = false
		settingsPanel.Visible = true

		refresh.Visible = false

		settingsButton.Text =
			"←  "
			.. text("dashboard")

	else

		content.Visible = true
		settingsPanel.Visible = false

		refresh.Visible = true

		settingsButton.Text =
			"⚙  "
			.. text("settings")

	end

end)

--========================================================--
-- REFRESH
--========================================================--

refresh.Activated:Connect(function()

	statusText.Text = text("refresh") .. "..."

	statusDot.BackgroundColor3 = ACCENT

	update()

	task.delay(.7, function()

		statusText.Text = text("ready")

		statusDot.BackgroundColor3 = GREEN

	end)

end)

--========================================================--
-- DRAG
--========================================================--

local dragging = false
local dragStart
local startPosition
local dragInput

header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true

		dragStart = input.Position

		startPosition = main.Position

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				dragging = false

			end

		end)

	end

end)

header.InputChanged:Connect(function(input)

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

	main.Position = UDim2.new(

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

resize.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		resizing = true

		resizeStart = input.Position

		startSize = main.AbsoluteSize

		input.Changed:Connect(function()

			if input.UserInputState ==
				Enum.UserInputState.End then

				resizing = false

			end

		end)

	end

end)

resize.InputChanged:Connect(function(input)

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

	main.Size =
		UDim2.fromOffset(
			width,
			height
		)

end)

--========================================================--
-- CLOSE / OPEN
--========================================================--

close.Activated:Connect(function()

	if animations then

		local tween = TweenService:Create(
			main,
			TweenInfo.new(.2),
			{
				Size = UDim2.fromOffset(0,0)
			}
		)

		tween:Play()
		tween.Completed:Wait()

	end

	main.Visible = false
	open.Visible = true

end)

open.Activated:Connect(function()

	open.Visible = false
	main.Visible = true

	if animations then

		main.Size =
			UDim2.fromOffset(0,0)

		TweenService:Create(
			main,
			TweenInfo.new(
				.25,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size = UDim2.fromOffset(
					DEFAULT_SIZE.X,
					DEFAULT_SIZE.Y
				)
			}
		):Play()

	else

		main.Size =
			UDim2.fromOffset(
				DEFAULT_SIZE.X,
				DEFAULT_SIZE.Y
			)

	end

end)

--========================================================--
-- START
--========================================================--

updateLanguage()

print(
	"[CH3A5] Premium Dashboard v"
	.. VERSION
	.. " loaded."
)
