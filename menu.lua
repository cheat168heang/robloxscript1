--[================================================================]--
-- CH3A5 HUB | V1.0 - Modern Dark Glass Roblox Executor GUI
-- Designed for Desktop & Mobile responsiveness with Glassmorphism
--[================================================================]--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Prevent duplicate GUIs
if CoreGui:FindFirstChild("CH3A5Hub") then
	CoreGui.CH3A5Hub:Destroy()
end

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Use CoreGui if possible, else PlayerGui
local success, err = pcall(function()
	ScreenGui.Parent = CoreGui
end)
if not success then
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

--[================================================================]--
-- COLOR PALETTE & CONSTANTS
--[================================================================]--
local Theme = {
	Canvas = Color3.fromRGB(15, 15, 20),
	PrimaryGlass = Color3.fromRGB(25, 25, 35),
	SecondaryGlass = Color3.fromRGB(40, 40, 55),
	Accent = Color3.fromRGB(0, 180, 255),
	TextPrimary = Color3.fromRGB(240, 240, 245),
	TextSecondary = Color3.fromRGB(160, 160, 175),
	Border = Color3.fromRGB(60, 60, 80),
	Success = Color3.fromRGB(46, 204, 113),
	Warning = Color3.fromRGB(241, 196, 15),
	Error = Color3.fromRGB(231, 76, 60),
}

local FontGotham = Enum.Font.GothamSSm

--[================================================================]--
-- 1. FLOATING TOGGLE BUTTON
--[================================================================]--
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.fromOffset(50, 50)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.BackgroundColor3 = Theme.PrimaryGlass
ToggleButton.BackgroundTransparency = 0.2
ToggleButton.Text = "C"
ToggleButton.TextColor3 = Theme.Accent
ToggleButton.TextSize = 22
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Theme.Border
ToggleStroke.Transparency = 0.5
ToggleStroke.Thickness = 1
ToggleStroke.Parent = ToggleButton

--[================================================================]--
-- 2. MAIN WINDOW
--[================================================================]--
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = isMobile and UDim2.new(0.9, 0, 0.7, 0) or UDim2.fromOffset(700, 450)
MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
MainWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
MainWindow.BackgroundColor3 = Theme.Canvas
MainWindow.BackgroundTransparency = 0.1
MainWindow.Visible = false
MainWindow.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainWindow

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Border
MainStroke.Transparency = 0.5
MainStroke.Thickness = 1
MainStroke.Parent = MainWindow

-- Header Bar
local HeaderBar = Instance.new("Frame")
HeaderBar.Name = "HeaderBar"
HeaderBar.Size = UDim2.new(1, 0, 0, 40)
HeaderBar.BackgroundColor3 = Theme.PrimaryGlass
HeaderBar.BackgroundTransparency = 0.2
HeaderBar.Parent = MainWindow

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = HeaderBar

-- Fix bottom corners of header
local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 12)
HeaderFix.Position = UDim2.new(0, 0, 1, -12)
HeaderFix.BackgroundColor3 = Theme.PrimaryGlass
HeaderFix.BackgroundTransparency = 0.2
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = HeaderBar

local HeaderDivider = Instance.new("Frame")
HeaderDivider.Size = UDim2.new(1, 0, 0, 1)
HeaderDivider.Position = UDim2.new(0, 0, 1, 0)
HeaderDivider.BackgroundColor3 = Theme.Border
HeaderDivider.BackgroundTransparency = 0.5
HeaderDivider.BorderSizePixel = 0
HeaderDivider.Parent = HeaderBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 250, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "CH3A5 HUB | V1.0"
TitleLabel.TextColor3 = Theme.TextPrimary
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = HeaderBar

-- Window Controls (Close & Minimize)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.fromOffset(30, 30)
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.Position = UDim2.new(1, -10, 0.5, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Theme.TextSecondary
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = HeaderBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.fromOffset(30, 30)
MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
MinimizeButton.Position = UDim2.new(1, -45, 0.5, 0)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Theme.TextSecondary
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = HeaderBar

--[================================================================]--
-- 3. NAVIGATION & LAYOUT STRUCTURE
--[================================================================]--
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, 0, 1, -40)
ContentContainer.Position = UDim2.new(0, 0, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainWindow

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Theme.PrimaryGlass
Sidebar.BackgroundTransparency = 0.4
Sidebar.Parent = ContentContainer

local SidebarDivider = Instance.new("Frame")
SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
SidebarDivider.Position = UDim2.new(1, 0, 0, 0)
SidebarDivider.BackgroundColor3 = Theme.Border
SidebarDivider.BackgroundTransparency = 0.5
SidebarDivider.BorderSizePixel = 0
SidebarDivider.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = Sidebar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 10)
TabPadding.PaddingLeft = UDim.new(0, 10)
TabPadding.PaddingRight = UDim.new(0, 10)
TabPadding.Parent = Sidebar

-- Pages Container
local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -160, 1, 0)
PagesContainer.Position = UDim2.new(0, 160, 0, 0)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = ContentContainer

-- Create Pages
local Pages = {}
local Tabs = {}

local function CreatePage(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.ScrollBarThickness = 4
	page.ScrollBarImageColor3 = Theme.Accent
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Parent = PagesContainer

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 15)
	padding.PaddingBottom = UDim.new(0, 15)
	padding.PaddingLeft = UDim.new(0, 15)
	padding.PaddingRight = UDim.new(0, 15)
	padding.Parent = page

	Pages[name] = page
	return page
end

local function CreateTab(name, order)
	local tabBtn = Instance.new("TextButton")
	tabBtn.Name = name .. "Tab"
	tabBtn.Size = UDim2.new(1, 0, 0, 36)
	tabBtn.BackgroundColor3 = Theme.SecondaryGlass
	tabBtn.BackgroundTransparency = 1
	tabBtn.Text = "  " .. name
	tabBtn.TextColor3 = Theme.TextSecondary
	tabBtn.TextSize = 14
	tabBtn.Font = FontGotham
	tabBtn.TextXAlignment = Enum.TextXAlignment.Left
	tabBtn.LayoutOrder = order
	tabBtn.AutoButtonColor = false
	tabBtn.Parent = Sidebar

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = tabBtn

	local indicator = Instance.new("Frame")
	indicator.Name = "Indicator"
	indicator.Size = UDim2.new(0, 3, 0, 18)
	indicator.AnchorPoint = Vector2.new(0, 0.5)
	indicator.Position = UDim2.new(0, 0, 0.5, 0)
	indicator.BackgroundColor3 = Theme.Accent
	indicator.BorderSizePixel = 0
	indicator.Visible = false
	indicator.Parent = tabBtn

	local indicatorCorner = Instance.new("UICorner")
	indicatorCorner.CornerRadius = UDim.new(1, 0)
	indicatorCorner.Parent = indicator

	Tabs[name] = {Button = tabBtn, Indicator = indicator}
	CreatePage(name)

	return tabBtn
end

-- Initialize Tabs
local tabNames = {"Home", "Trading Hub", "Favourite", "Keyless", "Key System", "About"}
for i, name in ipairs(tabNames) do
	CreateTab(name, i)
end

local activeTabName = nil
local function SwitchTab(name)
	if activeTabName == name then return end
	activeTabName = name

	for tabName, tabData in pairs(Tabs) do
		local isActive = (tabName == name)
		tabData.Indicator.Visible = isActive
		tabData.Button.TextColor3 = isActive and Theme.TextPrimary or Theme.TextSecondary
		tabData.Button.BackgroundTransparency = isActive and 0.6 or 1
	end

	for pageName, pageObj in pairs(Pages) do
		pageObj.Visible = (pageName == name)
	end
end

for name, tabData in pairs(Tabs) do
	tabData.Button.MouseButton1Click:Connect(function()
		SwitchTab(name)
	end)
end

SwitchTab("Home")

--[================================================================]--
-- 4. DYNAMIC TABS CONTENT
--[================================================================]--

-- A. HOME TAB
local homePage = Pages["Home"]
local homeLayout = Instance.new("UIListLayout")
homeLayout.SortOrder = Enum.SortOrder.LayoutOrder
homeLayout.Padding = UDim.new(0, 15)
homeLayout.Parent = homePage

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, 0, 0, 25)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "Welcome back, " .. LocalPlayer.DisplayName .. "!"
WelcomeLabel.TextColor3 = Theme.TextPrimary
WelcomeLabel.TextSize = 18
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
WelcomeLabel.LayoutOrder = 1
WelcomeLabel.Parent = homePage

-- Profile Card
local ProfileCard = Instance.new("Frame")
ProfileCard.Size = UDim2.new(1, 0, 0, 90)
ProfileCard.BackgroundColor3 = Theme.PrimaryGlass
ProfileCard.BackgroundTransparency = 0.2
ProfileCard.LayoutOrder = 2
ProfileCard.Parent = homePage

local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(0, 10)
ProfileCorner.Parent = ProfileCard

local ProfileStroke = Instance.new("UIStroke")
ProfileStroke.Color = Theme.Border
ProfileStroke.Transparency = 0.5
ProfileStroke.Parent = ProfileCard

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.fromOffset(60, 60)
AvatarImg.Position = UDim2.new(0, 15, 0.5, -30)
AvatarImg.BackgroundColor3 = Theme.SecondaryGlass
AvatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
AvatarImg.Parent = ProfileCard

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImg

local DisplayNameLabel = Instance.new("TextLabel")
DisplayNameLabel.Size = UDim2.new(0, 250, 0, 22)
DisplayNameLabel.Position = UDim2.new(0, 85, 0, 18)
DisplayNameLabel.BackgroundTransparency = 1
DisplayNameLabel.Text = LocalPlayer.DisplayName
DisplayNameLabel.TextColor3 = Theme.TextPrimary
DisplayNameLabel.TextSize = 16
DisplayNameLabel.Font = Enum.Font.GothamBold
DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameLabel.Parent = ProfileCard

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Size = UDim2.new(0, 250, 0, 18)
UsernameLabel.Position = UDim2.new(0, 85, 0, 40)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = "@" .. LocalPlayer.Name
UsernameLabel.TextColor3 = Theme.TextSecondary
UsernameLabel.TextSize = 13
UsernameLabel.Font = FontGotham
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Parent = ProfileCard

local UserDetailsLabel = Instance.new("TextLabel")
UserDetailsLabel.Size = UDim2.new(0, 250, 0, 18)
UserDetailsLabel.Position = UDim2.new(0, 85, 0, 58)
UserDetailsLabel.BackgroundTransparency = 1
UserDetailsLabel.Text = "ID: " .. LocalPlayer.UserId .. " | Age: 3 Years"
UserDetailsLabel.TextColor3 = Theme.TextSecondary
UserDetailsLabel.TextSize = 12
UserDetailsLabel.Font = FontGotham
UserDetailsLabel.TextXAlignment = Enum.TextXAlignment.Left
UserDetailsLabel.Parent = ProfileCard

-- Server Stats Grid (2x2)
local StatsGrid = Instance.new("Frame")
StatsGrid.Size = UDim2.new(1, 0, 0, 140)
StatsGrid.BackgroundTransparency = 1
StatsGrid.LayoutOrder = 3
StatsGrid.Parent = homePage

local StatsGridFlow = Instance.new("UIGridLayout")
StatsGridFlow.CellSize = UDim2.new(0.48, 0, 0, 60)
StatsGridFlow.CellPadding = UDim2.new(0.04, 0, 0, 10)
StatsGridFlow.Parent = StatsGrid

local function CreateStatCard(labelTitle, initialVal)
	local card = Instance.new("Frame")
	card.BackgroundColor3 = Theme.PrimaryGlass
	card.BackgroundTransparency = 0.3
	card.Parent = StatsGrid

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Theme.Border
	stroke.Transparency = 0.5
	stroke.Parent = card

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -15, 0, 20)
	title.Position = UDim2.new(0, 10, 0, 8)
	title.BackgroundTransparency = 1
	title.Text = labelTitle
	title.TextColor3 = Theme.TextSecondary
	title.TextSize = 12
	title.Font = FontGotham
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = card

	local val = Instance.new("TextLabel")
	val.Name = "ValueLabel"
	val.Size = UDim2.new(1, -15, 0, 25)
	val.Position = UDim2.new(0, 10, 0, 25)
	val.BackgroundTransparency = 1
	val.Text = initialVal
	val.TextColor3 = Theme.TextPrimary
	val.TextSize = 16
	val.Font = Enum.Font.GothamBold
	val.TextXAlignment = Enum.TextXAlignment.Left
	val.Parent = card

	return val
end

local fpsVal = CreateStatCard("FPS", "60")
local pingVal = CreateStatCard("PING", "45ms")
local regionVal = CreateStatCard("REGION", "US-East")
local playersVal = CreateStatCard("PLAYERS", #Players:GetPlayers() .. " / " .. Players.MaxPlayers)

-- Dynamic Updater
RunService.RenderStepped:Connect(function(dt)
	local fps = math.floor(1 / dt)
	fpsVal.Text = tostring(fps)

	local stats = LocalPlayer:FindFirstChild("PlayerStats")
	local ping = 45
	pcall(function()
		ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
	end)
	pingVal.Text = ping .. "ms"
	pingVal.TextColor3 = ping < 50 and Theme.Success or (ping <= 150 and Theme.Warning or Theme.Error)

	playersVal.Text = #Players:GetPlayers() .. " / " .. Players.MaxPlayers
end)


-- B. TRADING HUB TAB
local tradingPage = Pages["Trading Hub"]
local tradingLayout = Instance.new("UIListLayout")
tradingLayout.SortOrder = Enum.SortOrder.LayoutOrder
tradingLayout.Padding = UDim.new(0, 12)
tradingLayout.Parent = tradingPage

local TradingHeader = Instance.new("TextLabel")
TradingHeader.Size = UDim2.new(1, 0, 0, 25)
TradingHeader.BackgroundTransparency = 1
TradingHeader.Text = "Trading Hub"
TradingHeader.TextColor3 = Theme.TextPrimary
TradingHeader.TextSize = 18
TradingHeader.Font = Enum.Font.GothamBold
TradingHeader.TextXAlignment = Enum.TextXAlignment.Left
TradingHeader.LayoutOrder = 1
TradingHeader.Parent = tradingPage

local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, 0, 0, 36)
SearchBar.BackgroundColor3 = Theme.PrimaryGlass
SearchBar.BackgroundTransparency = 0.3
SearchBar.PlaceholderText = "Search Players..."
SearchBar.PlaceholderColor3 = Theme.TextSecondary
SearchBar.Text = ""
SearchBar.TextColor3 = Theme.TextPrimary
SearchBar.TextSize = 14
SearchBar.Font = FontGotham
SearchBar.ClearTextOnFocus = false
SearchBar.LayoutOrder = 2
SearchBar.Parent = tradingPage

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBar

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = Theme.Border
SearchStroke.Transparency = 0.5
SearchStroke.Parent = SearchBar

local PlayerListContainer = Instance.new("Frame")
PlayerListContainer.Size = UDim2.new(1, 0, 0, 200)
PlayerListContainer.BackgroundTransparency = 1
PlayerListContainer.LayoutOrder = 3
PlayerListContainer.Parent = tradingPage

local PlayerListFlow = Instance.new("UIListLayout")
PlayerListFlow.SortOrder = Enum.SortOrder.LayoutOrder
PlayerListFlow.Padding = UDim.new(0, 8)
PlayerListFlow.Parent = PlayerListContainer

local function CreatePlayerCard(plrName, status)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 50)
	card.BackgroundColor3 = Theme.PrimaryGlass
	card.BackgroundTransparency = 0.3
	card.Parent = PlayerListContainer

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Theme.Border
	stroke.Transparency = 0.5
	stroke.Parent = card

	local nameLbl = Instance.new("TextLabel")
	nameLbl.Size = UDim2.new(0, 150, 1, 0)
	nameLbl.Position = UDim2.new(0, 15, 0, 0)
	nameLbl.BackgroundTransparency = 1
	nameLbl.Text = plrName
	nameLbl.TextColor3 = Theme.TextPrimary
	nameLbl.TextSize = 14
	nameLbl.Font = Enum.Font.GothamBold
	nameLbl.TextXAlignment = Enum.TextXAlignment.Left
	nameLbl.Parent = card

	local statusLbl = Instance.new("TextLabel")
	statusLbl.Size = UDim2.new(0, 100, 1, 0)
	statusLbl.Position = UDim2.new(0, 130, 0, 0)
	statusLbl.BackgroundTransparency = 1
	statusLbl.Text = status
	statusLbl.TextColor3 = status == "Trading" and Theme.Success or Theme.TextSecondary
	statusLbl.TextSize = 12
	statusLbl.Font = FontGotham
	statusLbl.TextXAlignment = Enum.TextXAlignment.Left
	statusLbl.Parent = card

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.fromOffset(90, 28)
	btn.AnchorPoint = Vector2.new(1, 0.5)
	btn.Position = UDim2.new(1, -10, 0.5, 0)
	btn.BackgroundColor3 = Theme.Accent
	btn.BackgroundTransparency = 0.2
	btn.Text = "Trade"
	btn.TextColor3 = Theme.TextPrimary
	btn.TextSize = 12
	btn.Font = Enum.Font.GothamBold
	btn.Parent = card

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn
end

CreatePlayerCard("ROBLOX_Trader1", "Trading")
CreatePlayerCard("ScriptMaster99", "Online")
CreatePlayerCard("CH3A5_Fan", "Offline")


-- C. FAVOURITE TAB
local favPage = Pages["Favourite"]
local favLayout = Instance.new("UIListLayout")
favLayout.SortOrder = Enum.SortOrder.LayoutOrder
favLayout.Padding = UDim.new(0, 12)
favLayout.Parent = favPage

local FavHeader = Instance.new("TextLabel")
FavHeader.Size = UDim2.new(1, 0, 0, 25)
FavHeader.BackgroundTransparency = 1
FavHeader.Text = "Favorite Scripts"
FavHeader.TextColor3 = Theme.TextPrimary
FavHeader.TextSize = 18
FavHeader.Font = Enum.Font.GothamBold
FavHeader.TextXAlignment = Enum.TextXAlignment.Left
FavHeader.LayoutOrder = 1
FavHeader.Parent = favPage

local FavEmptyContainer = Instance.new("Frame")
FavEmptyContainer.Size = UDim2.new(1, 0, 0, 150)
FavEmptyContainer.BackgroundTransparency = 1
FavEmptyContainer.LayoutOrder = 2
FavEmptyContainer.Parent = favPage

local FavEmptyMsg = Instance.new("TextLabel")
FavEmptyMsg.Size = UDim2.new(1, 0, 1, 0)
FavEmptyMsg.BackgroundTransparency = 1
FavEmptyMsg.Text = "⭐ No favorites yet.\nStar scripts to see them here!"
FavEmptyMsg.TextColor3 = Theme.TextSecondary
FavEmptyMsg.TextSize = 14
FavEmptyMsg.Font = FontGotham
FavEmptyMsg.TextWrapped = true
FavEmptyMsg.Parent = FavEmptyContainer


-- D. KEYLESS TAB
local keylessPage = Pages["Keyless"]
local keylessLayout = Instance.new("UIListLayout")
keylessLayout.SortOrder = Enum.SortOrder.LayoutOrder
keylessLayout.Padding = UDim.new(0, 10)
keylessLayout.Parent = keylessPage

local function CreateScriptCard(parent, title, desc, isKeyRequired)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 65)
	card.BackgroundColor3 = Theme.PrimaryGlass
	card.BackgroundTransparency = 0.3
	card.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Theme.Border
	stroke.Transparency = 0.5
	stroke.Parent = card

	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size = UDim2.new(1, -110, 0, 20)
	titleLbl.Position = UDim2.new(0, 15, 0, 10)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text = title
	titleLbl.TextColor3 = Theme.TextPrimary
	titleLbl.TextSize = 15
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.Parent = card

	local descLbl = Instance.new("TextLabel")
	descLbl.Size = UDim2.new(1, -110, 0, 20)
	descLbl.Position = UDim2.new(0, 15, 0, 32)
	descLbl.BackgroundTransparency = 1
	descLbl.Text = desc
	descLbl.TextColor3 = Theme.TextSecondary
	descLbl.TextSize = 12
	descLbl.Font = FontGotham
	descLbl.TextXAlignment = Enum.TextXAlignment.Left
	descLbl.Parent = card

	local execBtn = Instance.new("TextButton")
	execBtn.Size = UDim2.fromOffset(80, 32)
	execBtn.AnchorPoint = Vector2.new(1, 0.5)
	execBtn.Position = UDim2.new(1, -12, 0.5, 0)
	execBtn.BackgroundColor3 = isKeyRequired and Theme.SecondaryGlass or Theme.Accent
	execBtn.BackgroundTransparency = 0.2
	execBtn.Text = isKeyRequired and "Locked" or "Execute"
	execBtn.TextColor3 = Theme.TextPrimary
	execBtn.TextSize = 12
	execBtn.Font = Enum.Font.GothamBold
	execBtn.Parent = card

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = execBtn
end

CreateScriptCard(keylessPage, "Infinite Jump", "Allows you to jump infinitely in the air.", false)
CreateScriptCard(keylessPage, "ESP Highlight", "Highlights all players across the map easily.", false)
CreateScriptCard(keylessPage, "Fullbright", "Removes shadows and dark atmospheric lighting.", false)


-- E. KEY SYSTEM TAB
local keyPage = Pages["Key System"]
local keyLayout = Instance.new("UIListLayout")
keyLayout.SortOrder = Enum.SortOrder.LayoutOrder
keyLayout.Padding = UDim.new(0, 12)
keyLayout.Parent = keyPage

local KeyHeader = Instance.new("TextLabel")
KeyHeader.Size = UDim2.new(1, 0, 0, 25)
KeyHeader.BackgroundTransparency = 1
KeyHeader.Text = "Key System Verification"
KeyHeader.TextColor3 = Theme.TextPrimary
KeyHeader.TextSize = 18
KeyHeader.Font = Enum.Font.GothamBold
KeyHeader.TextXAlignment = Enum.TextXAlignment.Left
KeyHeader.LayoutOrder = 1
KeyHeader.Parent = keyPage

CreateScriptCard(keyPage, "Premium Aimbot", "Advanced combat assistance with smooth camera locking.", true)
CreateScriptCard(keyPage, "Silent Aim / Hitbox", "Enables custom expanded hitboxes for players.", true)

local KeyInputBox = Instance.new("TextBox")
KeyInputBox.Size = UDim2.new(1, 0, 0, 38)
KeyInputBox.BackgroundColor3 = Theme.PrimaryGlass
KeyInputBox.BackgroundTransparency = 0.3
KeyInputBox.PlaceholderText = "Enter your access key here..."
KeyInputBox.PlaceholderColor3 = Theme.TextSecondary
KeyInputBox.Text = ""
KeyInputBox.TextColor3 = Theme.TextPrimary
KeyInputBox.TextSize = 14
KeyInputBox.Font = FontGotham
KeyInputBox.LayoutOrder = 4
KeyInputBox.Parent = keyPage

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 8)
KeyCorner.Parent = KeyInputBox

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Theme.Border
KeyStroke.Transparency = 0.5
KeyStroke.Parent = KeyInputBox

local KeyActionHolder = Instance.new("Frame")
KeyActionHolder.Size = UDim2.new(1, 0, 0, 36)
KeyActionHolder.BackgroundTransparency = 1
KeyActionHolder.LayoutOrder = 5
KeyActionHolder.Parent = keyPage

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
GetKeyBtn.BackgroundColor3 = Theme.SecondaryGlass
GetKeyBtn.BackgroundTransparency = 0.3
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Theme.TextPrimary
GetKeyBtn.TextSize = 13
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = KeyActionHolder

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

local VerifyKeyBtn = Instance.new("TextButton")
VerifyKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
VerifyKeyBtn.Position = UDim2.new(0.52, 0, 0, 0)
VerifyKeyBtn.BackgroundColor3 = Theme.Accent
VerifyKeyBtn.BackgroundTransparency = 0.2
VerifyKeyBtn.Text = "Verify Key"
VerifyKeyBtn.TextColor3 = Theme.TextPrimary
VerifyKeyBtn.TextSize = 13
VerifyKeyBtn.Font = Enum.Font.GothamBold
VerifyKeyBtn.Parent = KeyActionHolder

local VerifyKeyCorner = Instance.new("UICorner")
VerifyKeyCorner.CornerRadius = UDim.new(0, 8)
VerifyKeyCorner.Parent = VerifyKeyBtn

local KeyFeedback = Instance.new("TextLabel")
KeyFeedback.Size = UDim2.new(1, 0, 0, 20)
KeyFeedback.BackgroundTransparency = 1
KeyFeedback.Text = "Status: Locked. Please enter a valid key."
KeyFeedback.TextColor3 = Theme.TextSecondary
KeyFeedback.TextSize = 12
KeyFeedback.Font = FontGotham
KeyFeedback.TextXAlignment = Enum.TextXAlignment.Left
KeyFeedback.LayoutOrder = 6
KeyFeedback.Parent = keyPage

VerifyKeyBtn.MouseButton1Click:Connect(function()
	if KeyInputBox.Text == "CH3A5-VALID" then
		KeyFeedback.Text = "Success! Key verified successfully."
		KeyFeedback.TextColor3 = Theme.Success
	else
		KeyFeedback.Text = "Error! Invalid access key provided."
		KeyFeedback.TextColor3 = Theme.Error
	end
end)


-- F. ABOUT TAB
local aboutPage = Pages["About"]
local aboutLayout = Instance.new("UIListLayout")
aboutLayout.SortOrder = Enum.SortOrder.LayoutOrder
aboutLayout.Padding = UDim.new(0, 12)
aboutLayout.Parent = aboutPage

local AboutLogo = Instance.new("TextLabel")
AboutLogo.Size = UDim2.new(1, 0, 0, 35)
AboutLogo.BackgroundTransparency = 1
AboutLogo.Text = "CH3A5 HUB"
AboutLogo.TextColor3 = Theme.Accent
AboutLogo.TextSize = 22
AboutLogo.Font = Enum.Font.GothamBold
AboutLogo.LayoutOrder = 1
AboutLogo.Parent = aboutPage

local AboutInfoCard = Instance.new("Frame")
AboutInfoCard.Size = UDim2.new(1, 0, 0, 85)
AboutInfoCard.BackgroundColor3 = Theme.PrimaryGlass
AboutInfoCard.BackgroundTransparency = 0.3
AboutInfoCard.LayoutOrder = 2
AboutInfoCard.Parent = aboutPage

local AboutCorner = Instance.new("UICorner")
AboutCorner.CornerRadius = UDim.new(0, 8)
AboutCorner.Parent = AboutInfoCard

local AboutStroke = Instance.new("UIStroke")
AboutStroke.Color = Theme.Border
AboutStroke.Transparency = 0.5
AboutStroke.Parent = AboutInfoCard

local AboutDetailsText = Instance.new("TextLabel")
AboutDetailsText.Size = UDim2.new(1, -20, 1, 0)
AboutDetailsText.Position = UDim2.new(0, 10, 0, 0)
AboutDetailsText.BackgroundTransparency = 1
AboutDetailsText.Text = "Version: 1.0\nDeveloper: CH3A5\nStatus: Online 🟢\nRelease: 2026"
AboutDetailsText.TextColor3 = Theme.TextSecondary
AboutDetailsText.TextSize = 13
AboutDetailsText.Font = FontGotham
AboutDetailsText.TextXAlignment = Enum.TextXAlignment.Left
AboutDetailsText.Parent = AboutInfoCard

local function CreateSocialButton(text, link)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Theme.SecondaryGlass
	btn.BackgroundTransparency = 0.3
	btn.Text = text
	btn.TextColor3 = Theme.TextPrimary
	btn.TextSize = 13
	btn.Font = FontGotham
	btn.Parent = aboutPage

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		pcall(function()
			setclipboard(link)
		end)
		btn.Text = "Copied Link to Clipboard!"
		task.wait(1.5)
		btn.Text = text
	end)
end

CreateSocialButton("Telegram Channel: t.me/stealanegg_ch3a5_script", "https://t.me/stealanegg_ch3a5_script")
CreateSocialButton("Telegram Support: t.me/ch3a5", "https://t.me/ch3a5")
CreateSocialButton("TikTok: @ch3a5smos_404", "https://www.tiktok.com/@ch3a5smos_404")


--[================================================================]--
-- 5. ANIMATIONS & INTERACTIONS
--[================================================================]--
local isOpen = false

local function ToggleUI()
	isOpen = not isOpen
	if isOpen then
		MainWindow.Visible = true
		MainWindow.Size = isMobile and UDim2.new(0.85, 0, 0.65, 0) or UDim2.fromOffset(600, 380)
		MainWindow.BackgroundTransparency = 1
		
		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		TweenService:Create(MainWindow, tweenInfo, {
			Size = isMobile and UDim2.new(0.9, 0, 0.7, 0) or UDim2.fromOffset(700, 450),
			BackgroundTransparency = 0.1
		}):Play()
	else
		local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
		local tween = TweenService:Create(MainWindow, tweenInfo, {
			Size = isMobile and UDim2.new(0.8, 0, 0.6, 0) or UDim2.fromOffset(600, 380),
			BackgroundTransparency = 1
		})
		tween:Play()
		tween.Completed:Connect(function()
			if not isOpen then MainWindow.Visible = false end
		end)
	end
end

ToggleButton.MouseButton1Click:Connect(ToggleUI)
CloseButton.MouseButton1Click:Connect(ToggleUI)

MinimizeButton.MouseButton1Click:Connect(function()
	ToggleUI()
end)

-- Draggable Window logic
local dragging, dragInput, dragStart, startPos
HeaderBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainWindow.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

HeaderBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Auto open on execution for instant test feedback
ToggleUI()
