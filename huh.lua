--========================================================--
--              CH3A5 PREMIUM INTERFACE v11.0             --
--                    FULL UI REMAKE                      --
--========================================================--
-- Created by CH3A5
-- UI ONLY / LocalScript
-- Khmer + English
-- Home / Player / Server / Stats / Settings
-- Drag / Resize / Mobile / PC
-- FPS / Ping / Session
--========================================================--

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local VERSION = "11.0"

local MIN_SIZE = Vector2.new(650, 420)
local MAX_SIZE = Vector2.new(1100, 700)

local DEFAULT_WIDTH = 820
local DEFAULT_HEIGHT = 520

local language = "EN"
local animations = true
local scale = 1

local sessionStart = os.clock()

--========================================================--
-- THEME
--========================================================--

local Theme = {

	Background = Color3.fromRGB(9, 10, 14),

	Sidebar = Color3.fromRGB(14, 16, 22),

	Card = Color3.fromRGB(18, 20, 27),

	CardHover = Color3.fromRGB(24, 26, 34),

	Border = Color3.fromRGB(45, 48, 60),

	Text = Color3.fromRGB(244, 245, 249),

	Muted = Color3.fromRGB(142, 146, 160),

	Accent = Color3.fromRGB(116, 84, 240),

	AccentDark = Color3.fromRGB(82, 59, 185),

	Success = Color3.fromRGB(74, 210, 125),

	Warning = Color3.fromRGB(240, 185, 70)
}

--========================================================--
-- LANGUAGE
--========================================================--

local LANG = {

	EN = {

		home = "Home",
		player = "Player",
		server = "Server",
		stats = "Statistics",
		settings = "Settings",

		welcome = "Welcome back",
		overview = "Here's your current overview.",

		fps = "FPS",
		ping = "PING",
		session = "SESSION",

		playerInfo = "PLAYER INFORMATION",
		serverInfo = "SERVER INFORMATION",
		performance = "PERFORMANCE",

		username = "Username",
		display = "Display Name",
		userid = "User ID",
		account = "Account Age",

		place = "Place ID",
		job = "Server Job ID",

		online = "ONLINE",
		connected = "Connected",

		language = "Language",
		animation = "Animations",
		scale = "Interface Scale",
		reset = "Reset Interface",

		refresh = "Refresh",
		close = "Close",

		about = "About",
		created = "Created by CH3A5",

		ready = "System ready"
	},

	KH = {

		home = "ទំព័រដើម",
		player = "អ្នកលេង",
		server = "Server",
		stats = "ស្ថិតិ",
		settings = "ការកំណត់",

		welcome = "សូមស្វាគមន៍មកវិញ",
		overview = "នេះជាព័ត៌មានបច្ចុប្បន្នរបស់អ្នក។",

		fps = "FPS",
		ping = "PING",
		session = "SESSION",

		playerInfo = "ព័ត៌មានអ្នកលេង",
		serverInfo = "ព័ត៌មាន Server",
		performance = "ប្រសិទ្ធភាព",

		username = "ឈ្មោះអ្នកប្រើ",
		display = "ឈ្មោះបង្ហាញ",
		userid = "User ID",
		account = "អាយុគណនី",

		place = "Place ID",
		job = "Server Job ID",

		online = "ONLINE",
		connected = "បានភ្ជាប់",

		language = "ភាសា",
		animation = "Animation",
		scale = "ទំហំ Interface",
		reset = "Reset Interface",

		refresh = "ធ្វើថ្មី",
		close = "បិទ",

		about = "អំពី",
		created = "បង្កើតដោយ CH3A5",

		ready = "ប្រព័ន្ធរួចរាល់"
	}
}

local function tr(key)

	return LANG[language][key] or key

end

--========================================================--
-- GUI
--========================================================--

local GUI = Instance.new("ScreenGui")

GUI.Name = "CH3A5_v11"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

GUI.Parent = playerGui

--========================================================--
-- MAIN WINDOW
--========================================================--

local Main = Instance.new("Frame")

Main.Name = "Window"

Main.Size = UDim2.fromOffset(
	DEFAULT_WIDTH,
	DEFAULT_HEIGHT
)

Main.Position = UDim2.new(
	0.5,
	-DEFAULT_WIDTH / 2,
	0.5,
	-DEFAULT_HEIGHT / 2
)

Main.BackgroundColor3 = Theme.Background

Main.BorderSizePixel = 0

Main.Parent = GUI

local MainCorner = Instance.new("UICorner", Main)

MainCorner.CornerRadius =
	UDim.new(0, 18)

local MainStroke = Instance.new("UIStroke", Main)

MainStroke.Color = Theme.Border
MainStroke.Transparency = 0.15

local UIScale = Instance.new("UIScale", Main)

UIScale.Scale = scale

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = Instance.new("Frame")

Sidebar.Size =
	UDim2.new(0, 185, 1, 0)

Sidebar.BackgroundColor3 =
	Theme.Sidebar

Sidebar.BorderSizePixel = 0

Sidebar.Parent = Main

local SidebarCorner = Instance.new("UICorner", Sidebar)

SidebarCorner.CornerRadius =
	UDim.new(0, 18)

--========================================================--
-- BRAND
--========================================================--

local Logo = Instance.new("Frame")

Logo.Size =
	UDim2.fromOffset(42,42)

Logo.Position =
	UDim2.fromOffset(18,17)

Logo.BackgroundColor3 =
	Theme.Accent

Logo.BorderSizePixel = 0

Logo.Parent = Sidebar

local LogoCorner = Instance.new("UICorner", Logo)

LogoCorner.CornerRadius =
	UDim.new(0,12)

local LogoText = Instance.new("TextLabel")

LogoText.Size =
	UDim2.fromScale(1,1)

LogoText.BackgroundTransparency = 1

LogoText.Text = "CH"

LogoText.TextColor3 =
	Theme.Text

LogoText.Font =
	Enum.Font.GothamBold

LogoText.TextSize = 13

LogoText.Parent = Logo

local Brand = Instance.new("TextLabel")

Brand.BackgroundTransparency = 1

Brand.Position =
	UDim2.fromOffset(70,15)

Brand.Size =
	UDim2.new(1,-80,0,25)

Brand.Text = "CH3A5"

Brand.TextColor3 =
	Theme.Text

Brand.Font =
	Enum.Font.GothamBold

Brand.TextSize = 17

Brand.TextXAlignment =
	Enum.TextXAlignment.Left

Brand.Parent = Sidebar

local BrandSub = Instance.new("TextLabel")

BrandSub.BackgroundTransparency = 1

Brand.Position =
	UDim2.fromOffset(71,38)

Brand.Size =
	UDim2.new(1,-80,0,17)

Brand.Text =
	"PREMIUM v" .. VERSION

Brand.TextColor3 =
	Theme.Muted

Brand.Font =
	Enum.Font.Gotham

Brand.TextSize = 8

Brand.TextXAlignment =
	Enum.TextXAlignment.Left

Brand.Parent = Sidebar

--========================================================--
-- NAVIGATION
--========================================================--

local Nav = Instance.new("Frame")

Nav.BackgroundTransparency = 1

Nav.Position =
	UDim2.fromOffset(10,85)

Nav.Size =
	UDim2.new(1,-20,1,-145)

Nav.Parent = Sidebar

local NavLayout =
	Instance.new("UIListLayout", Nav)

NavLayout.Padding =
	UDim.new(0,7)

NavLayout.SortOrder =
	Enum.SortOrder.LayoutOrder

local Pages = {}

local NavButtons = {}

local function createNav(name, icon, order)

	local button = Instance.new("TextButton")

	button.Size =
		UDim2.new(1,0,0,43)

	button.BackgroundColor3 =
		Theme.Sidebar

	button.BorderSizePixel = 0

	button.AutoButtonColor = false

	button.Text = ""

	button.LayoutOrder = order

	button.Parent = Nav

	local corner =
		Instance.new("UICorner",button)

	corner.CornerRadius =
		UDim.new(0,10)

	local iconLabel =
		Instance.new("TextLabel")

	iconLabel.BackgroundTransparency = 1

	iconLabel.Position =
		UDim2.fromOffset(12,0)

	iconLabel.Size =
		UDim2.fromOffset(28,43)

	iconLabel.Text = icon

	iconLabel.TextColor3 =
		Theme.Muted

	iconLabel.TextSize = 15

	iconLabel.Font =
		Enum.Font.GothamBold

	iconLabel.Parent = button

	local label =
		Instance.new("TextLabel")

	label.BackgroundTransparency = 1

	label.Position =
		UDim2.fromOffset(45,0)

	label.Size =
		UDim2.new(1,-50,1,0)

	label.Text = name

	label.TextColor3 =
		Theme.Muted

	label.TextSize = 11

	label.Font =
		Enum.Font.GothamMedium

	label.TextXAlignment =
		Enum.TextXAlignment.Left

	label.Parent = button

	NavButtons[name] = {
		Button = button,
		Label = label,
		Icon = iconLabel
	}

	return button

end

local HomeButton =
	createNav(tr("home"),"⌂",1)

local PlayerButton =
	createNav(tr("player"),"◉",2)

local ServerButton =
	createNav(tr("server"),"◇",3)

local StatsButton =
	createNav(tr("stats"),"◆",4)

local SettingsButton =
	createNav(tr("settings"),"⚙",5)

--========================================================--
-- SIDEBAR FOOTER
--========================================================--

local SideFooter = Instance.new("TextLabel")

SideFooter.BackgroundTransparency = 1

SideFooter.Position =
	UDim2.new(0,16,1,-45)

SideFooter.Size =
	UDim2.new(1,-32,0,30)

SideFooter.Text =
	tr("created")

SideFooter.TextColor3 =
	Theme.Muted

SideFooter.TextSize = 8

SideFooter.Font =
	Enum.Font.Gotham

SideFooter.TextXAlignment =
	Enum.TextXAlignment.Left

SideFooter.Parent = Sidebar

--========================================================--
-- CONTENT AREA
--========================================================--

local Content = Instance.new("Frame")

Content.Position =
	UDim2.new(0,185,0,0)

Content.Size =
	UDim2.new(1,-185,1,0)

Content.BackgroundTransparency = 1

Content.Parent = Main

--========================================================--
-- HEADER
--========================================================--

local Header = Instance.new("Frame")

Header.Size =
	UDim2.new(1,0,0,64)

Header.BackgroundTransparency = 1

Header.Active = true

Header.Parent = Content

local PageTitle = Instance.new("TextLabel")

PageTitle.BackgroundTransparency = 1

PageTitle.Position =
	UDim2.fromOffset(22,13)

PageTitle.Size =
	UDim2.new(1,-120,0,25)

PageTitle.Text =
	tr("home")

PageTitle.TextColor3 =
	Theme.Text

PageTitle.TextSize = 18

PageTitle.Font =
	Enum.Font.GothamBold

PageTitle.TextXAlignment =
	Enum.TextXAlignment.Left

PageTitle.Parent = Header

local PageSub = Instance.new("TextLabel")

PageSub.BackgroundTransparency = 1

PageSub.Position =
	UDim2.fromOffset(23,37)

PageSub.Size =
	UDim2.new(1,-130,0,17)

PageSub.Text =
	tr("overview")

PageSub.TextColor3 =
	Theme.Muted

PageSub.TextSize = 9

PageSub.Font =
	Enum.Font.Gotham

PageSub.TextXAlignment =
	Enum.TextXAlignment.Left

PageSub.Parent = Header

-- STATUS

local Status = Instance.new("TextLabel")

Status.BackgroundTransparency = 1

Status.AnchorPoint =
	Vector2.new(1,0.5)

Status.Position =
	UDim2.new(1,-48,.5,0)

Status.Size =
	UDim2.fromOffset(90,22)

Status.Text =
	"● " .. tr("online")

Status.TextColor3 =
	Theme.Success

Status.TextSize = 9

Status.Font =
	Enum.Font.GothamBold

Status.Parent = Header

-- CLOSE

local Close = Instance.new("TextButton")

Close.Size =
	UDim2.fromOffset(30,30)

Close.Position =
	UDim2.new(1,-38,0,17)

Close.BackgroundColor3 =
	Theme.Card

Close.Text = "×"

Close.TextColor3 =
	Theme.Text

Close.TextSize = 19

Close.Font =
	Enum.Font.GothamBold

Close.AutoButtonColor = false

Close.Parent = Header

local CloseCorner =
	Instance.new("UICorner",Close)

CloseCorner.CornerRadius =
	UDim.new(0,8)

--========================================================--
-- PAGE SYSTEM
--========================================================--

local PageContainer = Instance.new("Frame")

PageContainer.Position =
	UDim2.fromOffset(18,70)

PageContainer.Size =
	UDim2.new(1,-36,1,-90)

PageContainer.BackgroundTransparency = 1

PageContainer.Parent = Content

local function createPage()

	local page = Instance.new("Frame")

	page.Size =
		UDim2.fromScale(1,1)

	page.BackgroundTransparency = 1

	page.Visible = false

	page.Parent = PageContainer

	table.insert(Pages,page)

	return page

end

local HomePage = createPage()
local PlayerPage = createPage()
local ServerPage = createPage()
local StatsPage = createPage()
local SettingsPage = createPage()

--========================================================--
-- CARD FUNCTION
--========================================================--

local function card(parent,pos,size)

	local c = Instance.new("Frame")

	c.Position = pos

	c.Size = size

	c.BackgroundColor3 =
		Theme.Card

	c.BorderSizePixel = 0

	c.Parent = parent

	local corner =
		Instance.new("UICorner",c)

	corner.CornerRadius =
		UDim.new(0,13)

	local stroke =
		Instance.new("UIStroke",c)

	stroke.Color =
		Theme.Border

	stroke.Transparency = .5

	return c

end

--========================================================--
-- HOME
--========================================================--

local Welcome = Instance.new("TextLabel")

Welcome.BackgroundTransparency = 1

Welcome.Position =
	UDim2.fromOffset(5,3)

Welcome.Size =
	UDim2.new(1,-10,0,28)

Welcome.Text =
	tr("welcome") .. ", " .. player.DisplayName

Welcome.TextColor3 =
	Theme.Text

Welcome.TextSize = 16

Welcome.Font =
	Enum.Font.GothamBold

Welcome.TextXAlignment =
	Enum.TextXAlignment.Left

Welcome.Parent = HomePage

local Overview = Instance.new("TextLabel")

Overview.BackgroundTransparency = 1

Overview.Position =
	UDim2.fromOffset(6,29)

Overview.Size =
	UDim2.new(1,-12,0,20)

Overview.Text =
	tr("overview")

Overview.TextColor3 =
	Theme.Muted

Overview.TextSize = 9

Overview.Font =
	Enum.Font.Gotham

Overview.TextXAlignment =
	Enum.TextXAlignment.Left

Overview.Parent = HomePage

--========================================================--
-- STAT CARDS
--========================================================--

local FPSCard =
	card(
		HomePage,
		UDim2.new(0,0,0,58),
		UDim2.new(.32,-7,0,82)
	)

local PingCard =
	card(
		HomePage,
		UDim2.new(.34,5,0,58),
		UDim2.new(.32,-7,0,82)
	)

local SessionCard =
	card(
		HomePage,
		UDim2.new(.68,10,0,58),
		UDim2.new(.32,-10,0,82)
	)

local function statCard(cardObj,title)

	local titleLabel =
		Instance.new("TextLabel")

	titleLabel.BackgroundTransparency = 1

	titleLabel.Position =
		UDim2.fromOffset(14,12)

	titleLabel.Size =
		UDim2.new(1,-28,0,17)

	titleLabel.Text = title

	titleLabel.TextColor3 =
		Theme.Muted

	titleLabel.TextSize = 8

	titleLabel.Font =
		Enum.Font.GothamBold

	titleLabel.TextXAlignment =
		Enum.TextXAlignment.Left

	titleLabel.Parent = cardObj

	local value =
		Instance.new("TextLabel")

	value.BackgroundTransparency = 1

	value.Position =
		UDim2.fromOffset(14,31)

	value.Size =
		UDim2.new(1,-28,0,35)

	value.Text = "--"

	value.TextColor3 =
		Theme.Text

	value.TextSize = 21

	value.Font =
		Enum.Font.GothamBold

	value.TextXAlignment =
		Enum.TextXAlignment.Left

	value.Parent = cardObj

	return value

end

local FPSValue =
	statCard(FPSCard,tr("fps"))

local PingValue =
	statCard(PingCard,tr("ping"))

local SessionValue =
	statCard(SessionCard,tr("session"))

--========================================================--
-- HOME PLAYER CARD
--========================================================--

local HomePlayer =
	card(
		HomePage,
		UDim2.new(0,0,0,153),
		UDim2.new(.49,-5,1,-153)
	)

local HomeServer =
	card(
		HomePage,
		UDim2.new(.51,5,0,153),
		UDim2.new(.49,-5,1,-153)
	)

local function titleLabel(parent,textValue)

	local l = Instance.new("TextLabel")

	l.BackgroundTransparency = 1

	l.Position =
		UDim2.fromOffset(14,12)

	l.Size =
		UDim2.new(1,-28,0,20)

	l.Text =
		textValue

	l.TextColor3 =
		Theme.Text

	l.TextSize = 9

	l.Font =
		Enum.Font.GothamBold

	l.TextXAlignment =
		Enum.TextXAlignment.Left

	l.Parent = parent

	return l

end

local HomePlayerTitle =
	titleLabel(HomePlayer,tr("playerInfo"))

local HomeServerTitle =
	titleLabel(HomeServer,tr("serverInfo"))

local HomePlayerText =
	Instance.new("TextLabel")

HomePlayerText.BackgroundTransparency = 1

HomePlayerText.Position =
	UDim2.fromOffset(14,38)

HomePlayerText.Size =
	UDim2.new(1,-28,1,-45)

HomePlayerText.TextColor3 =
	Theme.Muted

HomePlayerText.TextSize = 10

HomePlayerText.Font =
	Enum.Font.Gotham

HomePlayerText.TextXAlignment =
	Enum.TextXAlignment.Left

HomePlayerText.TextYAlignment =
	Enum.TextYAlignment.Top

HomePlayerText.Parent =
	HomePlayer

local HomeServerText =
	Instance.new("TextLabel")

HomeServerText.BackgroundTransparency = 1

HomeServerText.Position =
	UDim2.fromOffset(14,38)

HomeServerText.Size =
	UDim2.new(1,-28,1,-45)

HomeServerText.TextColor3 =
	Theme.Muted

HomeServerText.TextSize = 10

HomeServerText.Font =
	Enum.Font.Gotham

HomeServerText.TextXAlignment =
	Enum.TextXAlignment.Left

HomeServerText.TextYAlignment =
	Enum.TextYAlignment.Top

HomeServerText.Parent =
	HomeServer

--========================================================--
-- PLAYER PAGE
--========================================================--

local PlayerCard =
	card(
		PlayerPage,
		UDim2.fromOffset(0,0),
		UDim2.new(1,0,1,0)
	)

local PlayerTitle =
	titleLabel(PlayerCard,tr("playerInfo"))

local PlayerText =
	Instance.new("TextLabel")

PlayerText.BackgroundTransparency = 1

PlayerText.Position =
	UDim2.fromOffset(18,48)

PlayerText.Size =
	UDim2.new(1,-36,1,-60)

PlayerText.TextColor3 =
	Theme.Muted

PlayerText.TextSize = 12

PlayerText.Font =
	Enum.Font.Gotham

PlayerText.TextXAlignment =
	Enum.TextXAlignment.Left

PlayerText.TextYAlignment =
	Enum.TextYAlignment.Top

PlayerText.Parent =
	PlayerCard

--========================================================--
-- SERVER PAGE
--========================================================--

local ServerCard =
	card(
		ServerPage,
		UDim2.fromOffset(0,0),
		UDim2.new(1,0,1,0)
	)

local ServerTitle =
	titleLabel(ServerCard,tr("serverInfo"))

local ServerText =
	Instance.new("TextLabel")

ServerText.BackgroundTransparency = 1

ServerText.Position =
	UDim2.fromOffset(18,48)

ServerText.Size =
	UDim2.new(1,-36,1,-60)

ServerText.TextColor3 =
	Theme.Muted

ServerText.TextSize = 12

ServerText.Font =
	Enum.Font.Gotham

ServerText.TextXAlignment =
	Enum.TextXAlignment.Left

ServerText.TextYAlignment =
	Enum.TextYAlignment.Top

ServerText.Parent =
	ServerCard

--========================================================--
-- STATS PAGE
--========================================================--

local StatsCard =
	card(
		StatsPage,
		UDim2.fromOffset(0,0),
		UDim2.new(1,0,1,0)
	)

local StatsTitle =
	titleLabel(StatsCard,tr("performance"))

local StatsText =
	Instance.new("TextLabel")

StatsText.BackgroundTransparency = 1

StatsText.Position =
	UDim2.fromOffset(18,48)

StatsText.Size =
	UDim2.new(1,-36,1,-60)

StatsText.TextColor3 =
	Theme.Muted

StatsText.TextSize = 12

StatsText.Font =
	Enum.Font.Gotham

StatsText.TextXAlignment =
	Enum.TextXAlignment.Left

StatsText.TextYAlignment =
	Enum.TextYAlignment.Top

StatsText.Parent =
	StatsCard

--========================================================--
-- SETTINGS PAGE
--========================================================--

local SettingsCard =
	card(
		SettingsPage,
		UDim2.fromOffset(0,0),
		UDim2.new(1,0,1,0)
	)

local SettingsTitle =
	titleLabel(SettingsCard,tr("settings"))

local function createSettingButton(y)

	local b =
		Instance.new("TextButton")

	b.Position =
		UDim2.fromOffset(16,y)

	b.Size =
		UDim2.new(1,-32,0,43)

	b.BackgroundColor3 =
		Theme.CardHover

	b.TextColor3 =
		Theme.Text

	b.TextSize = 11

	b.Font =
		Enum.Font.GothamMedium

	b.AutoButtonColor = false

	b.Parent =
		SettingsCard

	local c =
		Instance.new("UICorner",b)

	c.CornerRadius =
		UDim.new(0,10)

	return b

end

local LanguageSetting =
	createSettingButton(48)

local AnimationSetting =
	createSettingButton(98)

local ScaleSetting =
	createSettingButton(148)

local ResetSetting =
	createSettingButton(198)

--========================================================--
-- PAGE SWITCH
--========================================================--

local CurrentPage

local function switchPage(page,name)

	for _,p in ipairs(Pages) do
		p.Visible = false
	end

	page.Visible = true

	PageTitle.Text = name

	if page == HomePage then
		PageSub.Text = tr("overview")
	else
		PageSub.Text = "CH3A5 Premium Interface"
	end

	CurrentPage = page

	for _,data in pairs(NavButtons) do

		data.Button.BackgroundColor3 =
			Theme.Sidebar

		data.Label.TextColor3 =
			Theme.Muted

		data.Icon.TextColor3 =
			Theme.Muted

	end

	local selected = NavButtons[name]

	if selected then

		selected.Button.BackgroundColor3 =
			Theme.AccentDark

		selected.Label.TextColor3 =
			Theme.Text

		selected.Icon.TextColor3 =
			Theme.Text

	end

end

--========================================================--
-- NAV BUTTON EVENTS
--========================================================--

HomeButton.Activated:Connect(function()

	switchPage(
		HomePage,
		tr("home")
	)

end)

PlayerButton.Activated:Connect(function()

	switchPage(
		PlayerPage,
		tr("player")
	)

end)

ServerButton.Activated:Connect(function()

	switchPage(
		ServerPage,
		tr("server")
	)

end)

StatsButton.Activated:Connect(function()

	switchPage(
		StatsPage,
		tr("stats")
	)

end)

SettingsButton.Activated:Connect(function()

	switchPage(
		SettingsPage,
		tr("settings")
	)

end)

--========================================================--
-- DATA
--========================================================--

local FPS = 0
local frames = 0
local fpsClock = tick()

local function getPing()

	local result = "N/A"

	pcall(function()

		local item =
			Stats.Network.ServerStatsItem["Data Ping"]

		result =
			math.floor(
				item:GetValue()
			) .. " ms"

	end)

	return result

end

local function formatTime()

	local seconds =
		math.floor(
			os.clock() - sessionStart
		)

	local hours =
		math.floor(seconds / 3600)

	local minutes =
		math.floor(
			(seconds % 3600) / 60
		)

	local secs =
		seconds % 60

	return string.format(
		"%02d:%02d:%02d",
		hours,
		minutes,
		secs
	)

end

local function updateData()

	local ping =
		getPing()

	local session =
		formatTime()

	FPSValue.Text =
		tostring(FPS)

	PingValue.Text =
		ping

	SessionValue.Text =
		session

	local jobId =
		game.JobId

	if jobId == "" then
		jobId = "Studio"
	end

	HomePlayerText.Text =

		tr("username")
		.. "     :  "
		.. player.Name

		.. "\n\n"

		.. tr("display")
		.. "     :  "
		.. player.DisplayName

		.. "\n\n"

		.. tr("userid")
		.. "       :  "
		.. player.UserId

		.. "\n\n"

		.. tr("account")
		.. "     :  "
		.. player.AccountAge
		.. " days"

	HomeServerText.Text =

		tr("place")
		.. "        :  "
		.. game.PlaceId

		.. "\n\n"

		.. tr("job")
		.. " :  "
		.. jobId

		.. "\n\n"

		.. tr("ping")
		.. "          :  "
		.. ping

	ServerText.Text =
		HomeServerText.Text

	PlayerText.Text =
		HomePlayerText.Text

	StatsText.Text =

		tr("fps")
		.. "           :  "
		.. FPS

		.. "\n\n"

		.. tr("ping")
		.. "          :  "
		.. ping

		.. "\n\n"

		.. tr("session")
		.. "     :  "
		.. session

end

RunService.RenderStepped:Connect(function()

	frames += 1

	if tick() - fpsClock >= 1 then

		FPS = frames

		frames = 0

		fpsClock = tick()

		updateData()

	end

end)

--========================================================--
-- LANGUAGE UPDATE
--========================================================--

local function updateLanguage()

	HomeButton:FindFirstChildOfClass("TextLabel").Text =
		tr("home")

	PlayerButton:FindFirstChildOfClass("TextLabel").Text =
		tr("player")

	ServerButton:FindFirstChildOfClass("TextLabel").Text =
		tr("server")

	StatsButton:FindFirstChildOfClass("TextLabel").Text =
		tr("stats")

	SettingsButton:FindFirstChildOfClass("TextLabel").Text =
		tr("settings")

	Welcome.Text =
		tr("welcome")
		.. ", "
		.. player.DisplayName

	Overview.Text =
		tr("overview")

	HomePlayerTitle.Text =
		tr("playerInfo")

	HomeServerTitle.Text =
		tr("serverInfo")

	PlayerTitle.Text =
		tr("playerInfo")

	ServerTitle.Text =
		tr("serverInfo")

	StatsTitle.Text =
		tr("performance")

	SettingsTitle.Text =
		tr("settings")

	LanguageSetting.Text =
		tr("language")
		.. "    :    "
		.. language

	AnimationSetting.Text =
		tr("animation")
		.. "    :    "
		.. (animations and "ON" or "OFF")

	ScaleSetting.Text =
		tr("scale")
		.. "    :    "
		.. string.format("%.1f",scale)

	ResetSetting.Text =
		"↺    "
		.. tr("reset")

	Status.Text =
		"● "
		.. tr("online")

	SideFooter.Text =
		tr("created")

	if CurrentPage == HomePage then
		PageTitle.Text = tr("home")
	elseif CurrentPage == PlayerPage then
		PageTitle.Text = tr("player")
	elseif CurrentPage == ServerPage then
		PageTitle.Text = tr("server")
	elseif CurrentPage == StatsPage then
		PageTitle.Text = tr("stats")
	elseif CurrentPage == SettingsPage then
		PageTitle.Text = tr("settings")
	end

	updateData()

end

--========================================================--
-- SETTINGS
--========================================================--

LanguageSetting.Activated:Connect(function()

	if language == "EN" then

		language = "KH"

	else

		language = "EN"

	end

	updateLanguage()

end)

AnimationSetting.Activated:Connect(function()

	animations = not animations

	updateLanguage()

end)

ScaleSetting.Activated:Connect(function()

	scale += .1

	if scale > 1.3 then
		scale = .8
	end

	UIScale.Scale = scale

	updateLanguage()

end)

ResetSetting.Activated:Connect(function()

	Main.Size =
		UDim2.fromOffset(
			DEFAULT_WIDTH,
			DEFAULT_HEIGHT
		)

	Main.Position =
		UDim2.new(
			.5,
			-DEFAULT_WIDTH / 2,
			.5,
			-DEFAULT_HEIGHT / 2
		)

	scale = 1

	UIScale.Scale = 1

	updateLanguage()

end)

--========================================================--
-- DRAG
--========================================================--

local dragging = false
local dragStart
local startPos
local dragInput

Header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		dragging = true

		dragStart =
			input.Position

		startPos =
			Main.Position

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

	Main.Position =
		UDim2.new(

			startPos.X.Scale,
			startPos.X.Offset + delta.X,

			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y

		)

end)

--========================================================--
-- RESIZE
--========================================================--

local Resize = Instance.new("TextButton")

Resize.Size =
	UDim2.fromOffset(38,38)

Resize.AnchorPoint =
	Vector2.new(1,1)

Resize.Position =
	UDim2.new(1,-4,1,-4)

Resize.BackgroundTransparency = 1

Resize.Text = "↘"

Resize.TextColor3 =
	Theme.Muted

Resize.TextSize = 18

Resize.Font =
	Enum.Font.GothamBold

Resize.AutoButtonColor = false

Resize.Parent = Main

local resizing = false
local resizeStart
local resizeStartSize
local resizeInput

Resize.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		resizing = true

		resizeStart =
			input.Position

		resizeStartSize =
			Main.AbsoluteSize

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

	local width =
		math.clamp(
			resizeStartSize.X + delta.X,
			MIN_SIZE.X,
			MAX_SIZE.X
		)

	local height =
		math.clamp(
			resizeStartSize.Y + delta.Y,
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

local Open = Instance.new("TextButton")

Open.Size =
	UDim2.fromOffset(60,60)

Open.Position =
	UDim2.new(0,18,.5,-30)

Open.BackgroundColor3 =
	Theme.Background

Open.Text = "CH"

Open.TextColor3 =
	Theme.Text

Open.TextSize = 15

Open.Font =
	Enum.Font.GothamBold

Open.Visible = false

Open.Parent = GUI

local OpenCorner =
	Instance.new("UICorner",Open)

OpenCorner.CornerRadius =
	UDim.new(1,0)

local OpenStroke =
	Instance.new("UIStroke",Open)

OpenStroke.Color =
	Theme.Accent

Close.Activated:Connect(function()

	Main.Visible = false

	Open.Visible = true

end)

Open.Activated:Connect(function()

	Open.Visible = false

	Main.Visible = true

end)

--========================================================--
-- HOVER EFFECTS
--========================================================--

local function hover(button,normal,hoverColor)

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(.12),
			{
				BackgroundColor3 =
					hoverColor
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(.12),
			{
				BackgroundColor3 =
					normal
			}
		):Play()

	end)

end

hover(
	Close,
	Theme.Card,
	Color3.fromRGB(70,40,48)
)

hover(
	LanguageSetting,
	Theme.CardHover,
	Theme.AccentDark
)

hover(
	AnimationSetting,
	Theme.CardHover,
	Theme.AccentDark
)

hover(
	ScaleSetting,
	Theme.CardHover,
	Theme.AccentDark
)

hover(
	ResetSetting,
	Theme.CardHover,
	Theme.AccentDark
)

--========================================================--
-- START
--========================================================--

switchPage(
	HomePage,
	tr("home")
)

updateLanguage()

print(
	"[CH3A5] Premium Interface v"
	.. VERSION
	.. " loaded successfully."
)
