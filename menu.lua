--[================================================================[
	CH3A5 HUB - v1.0
	Developer: CH3A5
	Style: Premium Dark Hacker UI
	Environment: Client-side Script Executor (Roblox Luau)
--================================================================]--

if not game:IsLoaded() then
	game.Loaded:Wait()
end

-- Prevent duplicate instances
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("CH3A5_HUB") then
	CoreGui.CH3A5_HUB:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local success, err = pcall(function()
	ScreenGui.Parent = CoreGui
end)
if not success then
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

-- Configuration & State
local Config = {
	Scale = 0.7,
	Theme = "Neon Green",
	Animations = true,
	AutoHopDelay = 5,
	MinPlayers = 0,
	MaxPlayers = 5,
	RetryLimit = 3,
}

local AutoHopRunning = false
local AutoHopAttempts = 0
local CurrentStatus = "Idle"
local ActiveConnections = {}

-- Theme Colors
local Colors = {
	Background = Color3.fromRGB(11, 13, 16),
	Panel = Color3.fromRGB(20, 24, 32),
	PanelAlt = Color3.fromRGB(28, 34, 45),
	Accent = Color3.fromRGB(57, 255, 136), -- #39FF88
	Cyan = Color3.fromRGB(0, 217, 255),     -- #00D9FF
	Text = Color3.fromRGB(240, 244, 248),
	SubText = Color3.fromRGB(140, 150, 165),
	Border = Color3.fromRGB(45, 55, 72),
	Error = Color3.fromRGB(255, 95, 95),
}

-- Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560 * Config.Scale, 0, 360 * Config.Scale)
MainFrame.Position = UDim2.new(0.5, -280 * Config.Scale, 0.5, -180 * Config.Scale)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Colors.Border
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = Colors.Panel
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

-- Fix bottom corners of top bar
local TopBarCover = Instance.new("Frame")
TopBarCover.Size = UDim2.new(1, 0, 0, 6)
TopBarCover.Position = UDim2.new(0, 0, 1, -6)
TopBarCover.BackgroundColor3 = Colors.Panel
TopBarCover.BorderSizePixel = 0
TopBarCover.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.Code
TitleLabel.Text = "CH3A5 HUB <font color=\"#39FF88\">v1.0</font>"
TitleLabel.RichText = true
TitleLabel.TextColor3 = Colors.Text
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Window Controls (Close, Minimize)
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0, 70, 1, 0)
ButtonContainer.Position = UDim2.new(1, -75, 0, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = TopBar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ButtonContainer

local function createWinButton(text, color)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 24, 0, 24)
	btn.BackgroundColor3 = Colors.PanelAlt
	btn.BorderSizePixel = 0
	btn.Font = Enum.Font.Code
	btn.Text = text
	btn.TextColor3 = color
	btn.TextSize = 12
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = btn
	
	return btn
end

local CloseBtn = createWinButton("X", Colors.Error)
CloseBtn.Parent = ButtonContainer
CloseBtn.MouseButton1Click:Connect(function()
	for _, conn in ipairs(ActiveConnections) do
		conn:Disconnect()
	end
	ScreenGui:Destroy()
end)

local Minimized = false
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, 0, 1, -36)
ContentContainer.Position = UDim2.new(0, 0, 0, 36)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local MinimizeBtn = createWinButton("-", Colors.Cyan)
MinimizeBtn.Parent = ButtonContainer
MinimizeBtn.MouseButton1Click:Connect(function()
	Minimized = not Minimized
	ContentContainer.Visible = not Minimized
	local targetSize = Minimized and UDim2.new(0, 560 * Config.Scale, 0, 36) or UDim2.new(0, 560 * Config.Scale, 0, 360 * Config.Scale)
	if Config.Animations then
		TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = targetSize}):Play()
	else
		MainFrame.Size = targetSize
	end
end)

-- Navigation Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BackgroundColor3 = Colors.Panel
Sidebar.BorderSizePixel = 0
Sidebar.Parent = ContentContainer

local SidebarCover = Instance.new("Frame")
SidebarCover.Size = UDim2.new(0, 6, 1, 0)
SidebarCover.Position = UDim2.new(1, -6, 0, 0)
SidebarCover.BackgroundColor3 = Colors.Panel
SidebarCover.BorderSizePixel = 0
SidebarCover.Parent = Sidebar

local NavList = Instance.new("UIListLayout")
NavList.FillDirection = Enum.FillDirection.Vertical
NavList.HorizontalAlignment = Enum.HorizontalAlignment.Center
NavList.VerticalAlignment = Enum.VerticalAlignment.Top
NavList.Padding = UDim.new(0, 4)
NavList.Parent = Sidebar

local NavPadding = Instance.new("UIPadding")
NavPadding.PaddingTop = UDim.new(0, 10)
NavPadding.Parent = Sidebar

-- Pages Container
local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -130, 1, 0)
PagesContainer.Position = UDim2.new(0, 130, 0, 0)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = ContentContainer

local Pages = {}
local NavButtons = {}

local function createPage(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.ScrollBarThickness = 4
	page.ScrollBarImageColor3 = Colors.Accent
	page.Visible = false
	page.Parent = PagesContainer
	
	local pad = Instance.new("UIPadding")
	pad.PaddingLeft = UDim.new(0, 12)
	pad.PaddingRight = UDim.new(0, 12)
	pad.PaddingTop = UDim.new(0, 12)
	pad.PaddingBottom = UDim.new(0, 12)
	pad.Parent = page
	
	local list = Instance.new("UIListLayout")
	list.FillDirection = Enum.FillDirection.Vertical
	list.Padding = UDim.new(0, 10)
	list.Parent = page
	
	Pages[name] = page
	return page
end

local function createNavButton(name)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -16, 0, 32)
	btn.BackgroundColor3 = Colors.PanelAlt
	btn.BackgroundTransparency = 1
	btn.BorderSizePixel = 0
	btn.Font = Enum.Font.Code
	btn.Text = name
	btn.TextColor3 = Colors.SubText
	btn.TextSize = 13
	btn.Parent = Sidebar
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		for pName, pObj in pairs(Pages) do
			pObj.Visible = (pName == name)
		end
		for bName, bObj in pairs(NavButtons) do
			bObj.TextColor3 = (bName == name) and Colors.Accent or Colors.SubText
			bObj.BackgroundTransparency = (bName == name) and 0 or 1
		end
	end)
	
	NavButtons[name] = btn
	return btn
end

-- Create Tabs
local tabNames = {"HOME", "SERVER HOP", "AUTO HOP", "SETTINGS", "ABOUT"}
for i, name in ipairs(tabNames) do
	createPage(name)
	local btn = createNavButton(name)
	if i == 1 then
		btn.TextColor3 = Colors.Accent
		btn.BackgroundTransparency = 0
		Pages[name].Visible = true
	end
end

-- UI Component Helpers
local function createCard(parent, height)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, height or 40)
	card.BackgroundColor3 = Colors.Panel
	card.BorderSizePixel = 0
	card.Parent = parent
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = card
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = Colors.Border
	stroke.Thickness = 1
	stroke.Parent = card
	
	return card
end

-- ==========================================
-- 1. HOME TAB
-- ==========================================
local homePage = Pages["HOME"]

local profileCard = createCard(homePage, 70)
local avatarImg = Instance.new("ImageLabel")
avatarImg.Size = UDim2.new(0, 50, 0, 50)
avatarImg.Position = UDim2.new(0, 10, 0, 10)
avatarImg.BackgroundTransparency = 1
avatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
avatarImg.Parent = profileCard

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatarImg

local userLabel = Instance.new("TextLabel")
userLabel.Size = UDim2.new(1, -70, 0, 20)
userLabel.Position = UDim2.new(0, 70, 0, 14)
userLabel.BackgroundTransparency = 1
userLabel.Font = Enum.Font.Code
userLabel.Text = LocalPlayer.Name .. " (@" .. LocalPlayer.DisplayName .. ")"
userLabel.TextColor3 = Colors.Text
userLabel.TextSize = 14
userLabel.TextXAlignment = Enum.TextXAlignment.Left
userLabel.Parent = profileCard

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -70, 0, 16)
statusLabel.Position = UDim2.new(0, 70, 0, 36)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Code
statusLabel.Text = "Status: Online | Executor Ready"
statusLabel.TextColor3 = Colors.Accent
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = profileCard

-- Game Info Card
local gameInfoCard = createCard(homePage, 120)
local gameListLayout = Instance.new("UIListLayout")
gameListLayout.Padding = UDim.new(0, 6)
gameListLayout.Parent = gameInfoCard

local gamePad = Instance.new("UIPadding")
gamePad.PaddingLeft = UDim.new(0, 12)
gamePad.PaddingTop = UDim.new(0, 10)
gamePad.PaddingRight = UDim.new(0, 12)
gamePad.Parent = gameInfoCard

local function createInfoRow(title, value)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 18)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Code
	lbl.Text = title .. ": <font color=\"#00D9FF\">" .. tostring(value) .. "</font>"
	lbl.RichText = true
	lbl.TextColor3 = Colors.SubText
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = gameInfoCard
	return lbl
end

local gameName = "Unknown Game"
pcall(function()
	gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

createInfoRow("Game Name", gameName)
createInfoRow("PlaceId", game.PlaceId)
createInfoRow("JobId", game.JobId ~= "" and game.JobId or "Local/Studio")
local playerStatsRow = createInfoRow("Players", #Players:GetPlayers() .. " / " .. Players.MaxPlayers)

local fpsPingRow = createInfoRow("Performance", "FPS: 60 | Ping: 0ms")

local lastUpdate = 0
table.insert(ActiveConnections, RunService.RenderStepped:Connect(function(dt)
	lastUpdate = lastUpdate + dt
	if lastUpdate > 1 then
		lastUpdate = 0
		pcall(function()
			local fps = math.floor(1 / dt)
			local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
			fpsPingRow.Text = string.format("Performance: <font color=\"#00D9FF\">FPS: %d | Ping: %dms</font>", fps, ping)
			playerStatsRow.Text = string.format("Players: <font color=\"#00D9FF\">%d / %d</font>", #Players:GetPlayers(), Players.MaxPlayers)
		end)
	end
end))

-- ==========================================
-- 2. SERVER HOP TAB
-- ==========================================
local serverHopPage = Pages["SERVER HOP"]

local serverControlsCard = createCard(serverHopPage, 90)
local scList = Instance.new("UIListLayout")
scList.Padding = UDim.new(0, 8)
scList.Parent = serverControlsCard
local scPad = Instance.new("UIPadding")
scPad.PaddingLeft = UDim.new(0, 10)
scPad.PaddingTop = UDim.new(0, 8)
scPad.PaddingRight = UDim.new(0, 10)
scPad.Parent = serverControlsCard

local infoServerHopNote = Instance.new("TextLabel")
infoServerHopNote.Size = UDim2.new(1, 0, 0, 24)
infoServerHopNote.BackgroundTransparency = 1
infoServerHopNote.Font = Enum.Font.Code
infoServerHopNote.Text = "Note: Public server discovery relies on TeleportService/HTTP APIs."
infoServerHopNote.TextColor3 = Colors.SubText
infoServerHopNote.TextSize = 10
infoServerHopNote.TextXAlignment = Enum.TextXAlignment.Left
infoServerHopNote.Parent = serverControlsCard

local buttonRow = Instance.new("Frame")
buttonRow.Size = UDim2.new(1, 0, 0, 32)
buttonRow.BackgroundTransparency = 1
buttonRow.Parent = serverControlsCard

local findLowBtn = Instance.new("TextButton")
findLowBtn.Size = UDim2.new(0.48, 0, 1, 0)
findLowBtn.BackgroundColor3 = Colors.Accent
findLowBtn.BorderSizePixel = 0
findLowBtn.Font = Enum.Font.Code
findLowBtn.Text = "Find Low Servers"
findLowBtn.TextColor3 = Colors.Background
findLowBtn.TextSize = 12
findLowBtn.Parent = buttonRow

local findCorner = Instance.new("UICorner")
findCorner.CornerRadius = UDim.new(0, 4)
findCorner.Parent = findLowBtn

local refreshBtn = Instance.new("TextButton")
findLowBtn.Size = UDim2.new(0.48, 0, 1, 0)
refreshBtn.Size = UDim2.new(0.48, 0, 1, 0)
refreshBtn.Position = UDim2.new(0.52, 0, 0, 0)
refreshBtn.BackgroundColor3 = Colors.PanelAlt
refreshBtn.BorderSizePixel = 0
refreshBtn.Font = Enum.Font.Code
refreshBtn.Text = "Refresh List"
refreshBtn.TextColor3 = Colors.Text
refreshBtn.TextSize = 12
refreshBtn.Parent = buttonRow

local refCorner = Instance.new("UICorner")
refCorner.CornerRadius = UDim.new(0, 4)
refCorner.Parent = refreshBtn

local serverListContainer = createCard(serverHopPage, 180)
serverListContainer.ClipsDescendants = true

local serverScroll = Instance.new("ScrollingFrame")
serverScroll.Size = UDim2.new(1, 0, 1, 0)
serverScroll.BackgroundTransparency = 1
serverScroll.BorderSizePixel = 1
serverScroll.BorderColor3 = Colors.Border
serverScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
serverScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
serverScroll.ScrollBarThickness = 3
serverScroll.Parent = serverListContainer

local serverScrollList = Instance.new("UIListLayout")
serverScrollList.Padding = UDim.new(0, 4)
serverScrollList.Parent = serverScroll

local serverScrollPad = Instance.new("UIPadding")
serverScrollPad.PaddingLeft = UDim.new(0, 6)
serverScrollPad.PaddingRight = UDim.new(0, 6)
serverScrollPad.PaddingTop = UDim.new(0, 6)
serverScrollPad.Parent = serverScroll

local function addServerRow(jobId, playersMax, ping)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 30)
	row.BackgroundColor3 = Colors.PanelAlt
	row.BorderSizePixel = 0
	row.Parent = serverScroll
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = row
	
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(0.7, 0, 1, 0)
	lbl.Position = UDim2.new(0, 8, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Code
	lbl.Text = "Players: " .. tostring(playersMax) .. " | Job: " .. string.sub(jobId, 1, 8) .. "..."
	lbl.TextColor3 = Colors.Text
	lbl.TextSize = 11
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = row
	
	local joinBtn = Instance.new("TextButton")
	joinBtn.Size = UDim2.new(0, 60, 0, 20)
	joinBtn.Position = UDim2.new(1, -68, 0.5, -10)
	joinBtn.BackgroundColor3 = Colors.Cyan
	joinBtn.BorderSizePixel = 0
	joinBtn.Font = Enum.Font.Code
	joinBtn.Text = "Join"
	joinBtn.TextColor3 = Colors.Background
	joinBtn.TextSize = 11
	joinBtn.Parent = row
	
	local jCorner = Instance.new("UICorner")
    jCorner.CornerRadius = UDim.new(0, 3)
    jCorner.Parent = joinBtn
	
	joinBtn.MouseButton1Click:Connect(function()
		pcall(function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer)
		end)
	end)
end

local function fetchServers()
	for _, child in ipairs(serverScroll:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end
	
	local successHttp, response = pcall(function()
		local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=10"
		return HttpService:JSONDecode(game:HttpGet(url))
	end)
	
	if successHttp and response and response.data then
		local found = false
		for _, srv in ipairs(response.data) do
			if srv.id ~= game.JobId and srv.playing < srv.maxPlayers then
				found = true
				addServerRow(srv.id, srv.playing .. "/" .. srv.maxPlayers, 0)
			end
		end
		if not found then
			local errLbl = Instance.new("TextLabel")
			errLbl.Size = UDim2.new(1, 0, 0, 30)
			errLbl.BackgroundTransparency = 1
			errLbl.Font = Enum.Font.Code
			errLbl.Text = "No alternate public servers found via API."
			errLbl.TextColor3 = Colors.Error
			errLbl.TextSize = 11
			errLbl.Parent = serverScroll
		end
	else
		local errLbl = Instance.new("TextLabel")
		errLbl.Size = UDim2.new(1, 0, 0, 30)
		errLbl.BackgroundTransparency = 1
		errLbl.Font = Enum.Font.Code
		errLbl.Text = "HTTP GET restricted in this executor/environment."
		errLbl.TextColor3 = Colors.Error
		errLbl.TextSize = 11
		errLbl.Parent = serverScroll
	end
end

refreshBtn.MouseButton1Click:Connect(fetchServers)
findLowBtn.MouseButton1Click:Connect(fetchServers)

-- ==========================================
-- 3. AUTO HOP TAB
-- ==========================================
local autoHopPage = Pages["AUTO HOP"]

local autoCard = createCard(autoHopPage, 160)
local autoList = Instance.new("UIListLayout")
autoList.Padding = UDim.new(0, 8)
autoList.Parent = autoCard
local autoPad = Instance.new("UIPadding")
autoPad.PaddingLeft = UDim.new(0, 10)
autoPad.PaddingTop = UDim.new(0, 10)
autoPad.PaddingRight = UDim.new(0, 10)
autoPad.Parent = autoCard

local statusDisplay = Instance.new("TextLabel")
statusDisplay.Size = UDim2.new(1, 0, 0, 20)
statusDisplay.BackgroundTransparency = 1
statusDisplay.Font = Enum.Font.Code
statusDisplay.Text = "Status: Idle | Attempts: 0"
statusDisplay.TextColor3 = Colors.SubText
statusDisplay.TextSize = 12
statusDisplay.TextXAlignment = Enum.TextXAlignment.Left
statusDisplay.Parent = autoCard

local autoBtnRow = Instance.new("Frame")
autoBtnRow.Size = UDim2.new(1, 0, 0, 32)
autoBtnRow.BackgroundTransparency = 1
autoBtnRow.Parent = autoCard

local startAutoBtn = Instance.new("TextButton")
startAutoBtn.Size = UDim2.new(0.48, 0, 1, 0)
startAutoBtn.BackgroundColor3 = Colors.Accent
startAutoBtn.BorderSizePixel = 0
startAutoBtn.Font = Enum.Font.Code
startAutoBtn.Text = "Start Auto Hop"
startAutoBtn.TextColor3 = Colors.Background
startAutoBtn.TextSize = 12
startAutoBtn.Parent = autoBtnRow
local saCorner = Instance.new("UICorner") saCorner.CornerRadius = UDim.new(0, 4) saCorner.Parent = startAutoBtn

local stopAutoBtn = Instance.new("TextButton")
stopAutoBtn.Size = UDim2.new(0.48, 0, 1, 0)
stopAutoBtn.Position = UDim2.new(0.52, 0, 0, 0)
stopAutoBtn.BackgroundColor3 = Colors.PanelAlt
stopAutoBtn.BorderSizePixel = 0
stopAutoBtn.Font = Enum.Font.Code
stopAutoBtn.Text = "Stop"
stopAutoBtn.TextColor3 = Colors.Text
stopAutoBtn.TextSize = 12
stopAutoBtn.Parent = autoBtnRow
local soCorner = Instance.new("UICorner") soCorner.CornerRadius = UDim.new(0, 4) soCorner.Parent = stopAutoBtn

local autoNote = Instance.new("TextLabel")
autoNote.Size = UDim2.new(1, 0, 0, 40)
autoNote.BackgroundTransparency = 1
autoNote.Font = Enum.Font.Code
autoNote.Text = "Continuously attempts to find and teleport to a different server until successful."
autoNote.TextWrapped = true
autoNote.TextColor3 = Colors.SubText
autoNote.TextSize = 10
autoNote.TextXAlignment = Enum.TextXAlignment.Left
autoNote.Parent = autoCard

startAutoBtn.MouseButton1Click:Connect(function()
	if AutoHopRunning then return end
	AutoHopRunning = true
	AutoHopAttempts = 0
	statusDisplay.TextColor3 = Colors.Accent
	
	task.spawn(function()
		while AutoHopRunning do
			AutoHopAttempts = AutoHopAttempts + 1
			statusDisplay.Text = string.format("Status: Searching... | Attempts: %d", AutoHopAttempts)
			
			local successHttp, response = pcall(function()
				local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=10"
				return HttpService:JSONDecode(game:HttpGet(url))
			end)
			
			if successHttp and response and response.data then
				for _, srv in ipairs(response.data) do
					if srv.id ~= game.JobId and srv.playing <= Config.MaxPlayers and srv.playing >= Config.MinPlayers then
						statusDisplay.Text = "Status: Teleporting to " .. srv.id .. "..."
						pcall(function()
							TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, LocalPlayer)
						end)
						task.wait(5)
					end
				end
			end
			
			task.wait(Config.AutoHopDelay)
			if AutoHopAttempts >= (Config.RetryLimit * 10) then
				AutoHopRunning = false
				statusDisplay.Text = "Status: Retry limit reached. Stopped."
				statusDisplay.TextColor3 = Colors.Error
				break
			end
		end
	end)
end)

stopAutoBtn.MouseButton1Click:Connect(function()
	AutoHopRunning = false
	statusDisplay.Text = "Status: Stopped | Attempts: " .. AutoHopAttempts
	statusDisplay.TextColor3 = Colors.SubText
end)

-- ==========================================
-- 4. SETTINGS TAB
-- ==========================================
local settingsPage = Pages["SETTINGS"]

local settingsCard = createCard(settingsPage, 140)
local setList = Instance.new("UIListLayout")
setList.Padding = UDim.new(0, 10)
setList.Parent = settingsCard
local setPad = Instance.new("UIPadding")
setPad.PaddingLeft = UDim.new(0, 10)
setPad.PaddingTop = UDim.new(0, 10)
setPad.PaddingRight = UDim.new(0, 10)
setPad.Parent = settingsCard

local function createToggleSetting(title, defaultState, callback)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 24)
	row.BackgroundTransparency = 1
	row.Parent = settingsCard
	
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(0.7, 0, 1, 0)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Code
	lbl.Text = title
	lbl.TextColor3 = Colors.Text
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = row
	
	local tBtn = Instance.new("TextButton")
	tBtn.Size = UDim2.new(0, 40, 0, 20)
	tBtn.Position = UDim2.new(1, -40, 0, 2)
	tBtn.BackgroundColor3 = defaultState and Colors.Accent or Colors.PanelAlt
	tBtn.BorderSizePixel = 0
	tBtn.Font = Enum.Font.Code
	tBtn.Text = defaultState and "ON" or "OFF"
	tBtn.TextColor3 = Colors.Background
	tBtn.TextSize = 10
	tBtn.Parent = row
	
	local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 4) corner.Parent = tBtn
	
	local state = defaultState
	tBtn.MouseButton1Click:Connect(function()
		state = not state
		tBtn.BackgroundColor3 = state and Colors.Accent or Colors.PanelAlt
		tBtn.Text = state and "ON" or "OFF"
		callback(state)
	end)
end

createToggleSetting("Smooth Animations", true, function(val)
	Config.Animations = val
end)

local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(1, 0, 0, 28)
resetBtn.BackgroundColor3 = Colors.PanelAlt
resetBtn.BorderSizePixel = 0
resetBtn.Font = Enum.Font.Code
resetBtn.Text = "Reset Settings to Default"
resetBtn.TextColor3 = Colors.Error
resetBtn.TextSize = 12
resetBtn.Parent = settingsCard
local rbCorner = Instance.new("UICorner") rbCorner.CornerRadius = UDim.new(0, 4) rbCorner.Parent = resetBtn

resetBtn.MouseButton1Click:Connect(function()
	Config.Animations = true
	Config.AutoHopDelay = 5
	Config.MinPlayers = 0
	Config.MaxPlayers = 5
	AutoHopRunning = false
	MainFrame.Size = UDim2.new(0, 560 * 0.7, 0, 360 * 0.7)
end)

-- ==========================================
-- 5. ABOUT TAB
-- ==========================================
local aboutPage = Pages["ABOUT"]

local aboutCard = createCard(aboutPage, 110)
local aboutList = Instance.new("UIListLayout")
aboutList.Padding = UDim.new(0, 6)
aboutList.Parent = aboutCard
local aboutPad = Instance.new("UIPadding")
aboutPad.PaddingLeft = UDim.new(0, 12)
aboutPad.PaddingTop = UDim.new(0, 10)
aboutPad.PaddingRight = UDim.new(0, 12)
aboutPad.Parent = aboutCard

local function createAboutRow(k, v)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 18)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Code
	lbl.Text = k .. ": <font color=\"#39FF88\">" .. v .. "</font>"
	lbl.RichText = true
	lbl.TextColor3 = Colors.SubText
	lbl.TextSize = 12
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = aboutCard
end

createAboutRow("Product", "CH3A5 HUB")
createAboutRow("Version", "1.0")
createAboutRow("Developer", "CH3A5")
createAboutRow("Release Year", "2026")
createAboutRow("Design Style", "Premium Dark Hacker UI")
