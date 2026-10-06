--[[
    CH3A5 HUB V2
    Premium Responsive GUI Framework
    GUI / UX / Theme / Animation / Search / Filter / Settings

    Includes:
    01 Core Structure
    02 Visual Design
    03 Branding
    04 Responsive System
    05 Window System
    06 Navigation
    07 Home Dashboard
    08 Script Cards
    09 Search System
    10 Category Filter
    11 Theme Engine
    12 Theme Transition
    13 Loading System
    14 Animation Engine
    15 Notification System
    16 Key / Keyless / Coming Soon UI
    17 Settings
    18 UX Improvements
    19 Performance / Architecture
    20 Final Polish
]]

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

--==================================================
-- DUPLICATE GUI PROTECTION
--==================================================

local GUI_NAME = "CH3A5_HUB_V2"

local oldGui =
    Player:FindFirstChildOfClass("PlayerGui")
    and Player.PlayerGui:FindFirstChild(GUI_NAME)

if oldGui then
    oldGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GUI_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

--==================================================
-- STATE
--==================================================

local State = {
    Open = true,
    Minimized = false,
    Animations = true,
    Notifications = true,
    CompactMode = false,
    AutoOpen = true,
    CurrentPage = "Home",
    CurrentCategory = "All",
    Search = "",
    CurrentTheme = "Midnight",
}

--==================================================
-- THEME ENGINE
--==================================================

local Themes = {

    Midnight = {
        Background = Color3.fromRGB(9, 10, 15),
        Sidebar = Color3.fromRGB(13, 14, 21),
        Surface = Color3.fromRGB(18, 20, 29),
        Card = Color3.fromRGB(22, 24, 34),
        Border = Color3.fromRGB(55, 58, 75),
        Text = Color3.fromRGB(245, 247, 255),
        Muted = Color3.fromRGB(145, 150, 168),
        Accent = Color3.fromRGB(126, 92, 255),
        Button = Color3.fromRGB(105, 75, 220),
        Glow = Color3.fromRGB(126, 92, 255),
        Notification = Color3.fromRGB(126, 92, 255),
    },

    Purple = {
        Background = Color3.fromRGB(16, 10, 25),
        Sidebar = Color3.fromRGB(21, 13, 33),
        Surface = Color3.fromRGB(30, 18, 45),
        Card = Color3.fromRGB(37, 22, 55),
        Border = Color3.fromRGB(87, 52, 120),
        Text = Color3.fromRGB(250, 245, 255),
        Muted = Color3.fromRGB(177, 155, 195),
        Accent = Color3.fromRGB(180, 90, 255),
        Button = Color3.fromRGB(150, 70, 230),
        Glow = Color3.fromRGB(180, 90, 255),
        Notification = Color3.fromRGB(180, 90, 255),
    },

    Blue = {
        Background = Color3.fromRGB(7, 14, 25),
        Sidebar = Color3.fromRGB(10, 19, 33),
        Surface = Color3.fromRGB(15, 29, 48),
        Card = Color3.fromRGB(18, 36, 58),
        Border = Color3.fromRGB(38, 80, 120),
        Text = Color3.fromRGB(240, 248, 255),
        Muted = Color3.fromRGB(145, 170, 195),
        Accent = Color3.fromRGB(50, 140, 255),
        Button = Color3.fromRGB(35, 110, 220),
        Glow = Color3.fromRGB(50, 140, 255),
        Notification = Color3.fromRGB(50, 140, 255),
    },

    Cyan = {
        Background = Color3.fromRGB(5, 16, 19),
        Sidebar = Color3.fromRGB(7, 24, 28),
        Surface = Color3.fromRGB(10, 34, 39),
        Card = Color3.fromRGB(12, 43, 49),
        Border = Color3.fromRGB(30, 100, 110),
        Text = Color3.fromRGB(235, 255, 255),
        Muted = Color3.fromRGB(140, 185, 190),
        Accent = Color3.fromRGB(0, 220, 235),
        Button = Color3.fromRGB(0, 175, 190),
        Glow = Color3.fromRGB(0, 220, 235),
        Notification = Color3.fromRGB(0, 220, 235),
    },

    Red = {
        Background = Color3.fromRGB(20, 8, 10),
        Sidebar = Color3.fromRGB(29, 10, 13),
        Surface = Color3.fromRGB(40, 14, 18),
        Card = Color3.fromRGB(48, 16, 21),
        Border = Color3.fromRGB(105, 35, 42),
        Text = Color3.fromRGB(255, 243, 245),
        Muted = Color3.fromRGB(190, 145, 150),
        Accent = Color3.fromRGB(245, 55, 75),
        Button = Color3.fromRGB(205, 40, 58),
        Glow = Color3.fromRGB(245, 55, 75),
        Notification = Color3.fromRGB(245, 55, 75),
    },

    Green = {
        Background = Color3.fromRGB(7, 17, 12),
        Sidebar = Color3.fromRGB(10, 25, 17),
        Surface = Color3.fromRGB(14, 36, 23),
        Card = Color3.fromRGB(17, 45, 28),
        Border = Color3.fromRGB(35, 105, 58),
        Text = Color3.fromRGB(238, 255, 244),
        Muted = Color3.fromRGB(145, 185, 155),
        Accent = Color3.fromRGB(45, 220, 120),
        Button = Color3.fromRGB(35, 180, 95),
        Glow = Color3.fromRGB(45, 220, 120),
        Notification = Color3.fromRGB(45, 220, 120),
    },

    Orange = {
        Background = Color3.fromRGB(22, 13, 6),
        Sidebar = Color3.fromRGB(31, 18, 8),
        Surface = Color3.fromRGB(43, 25, 10),
        Card = Color3.fromRGB(53, 30, 12),
        Border = Color3.fromRGB(120, 67, 25),
        Text = Color3.fromRGB(255, 247, 235),
        Muted = Color3.fromRGB(195, 165, 135),
        Accent = Color3.fromRGB(255, 145, 40),
        Button = Color3.fromRGB(220, 110, 25),
        Glow = Color3.fromRGB(255, 145, 40),
        Notification = Color3.fromRGB(255, 145, 40),
    },

    Pink = {
        Background = Color3.fromRGB(21, 8, 17),
        Sidebar = Color3.fromRGB(31, 10, 24),
        Surface = Color3.fromRGB(43, 14, 34),
        Card = Color3.fromRGB(52, 16, 40),
        Border = Color3.fromRGB(120, 42, 91),
        Text = Color3.fromRGB(255, 242, 250),
        Muted = Color3.fromRGB(195, 150, 178),
        Accent = Color3.fromRGB(255, 70, 170),
        Button = Color3.fromRGB(220, 50, 140),
        Glow = Color3.fromRGB(255, 70, 170),
        Notification = Color3.fromRGB(255, 70, 170),
    },

    Gold = {
        Background = Color3.fromRGB(20, 16, 7),
        Sidebar = Color3.fromRGB(29, 23, 10),
        Surface = Color3.fromRGB(42, 33, 13),
        Card = Color3.fromRGB(52, 41, 15),
        Border = Color3.fromRGB(120, 92, 30),
        Text = Color3.fromRGB(255, 249, 225),
        Muted = Color3.fromRGB(195, 175, 120),
        Accent = Color3.fromRGB(235, 180, 55),
        Button = Color3.fromRGB(200, 145, 30),
        Glow = Color3.fromRGB(235, 180, 55),
        Notification = Color3.fromRGB(235, 180, 55),
    },

    White = {
        Background = Color3.fromRGB(235, 237, 242),
        Sidebar = Color3.fromRGB(245, 246, 249),
        Surface = Color3.fromRGB(255, 255, 255),
        Card = Color3.fromRGB(250, 250, 252),
        Border = Color3.fromRGB(210, 213, 220),
        Text = Color3.fromRGB(25, 27, 32),
        Muted = Color3.fromRGB(100, 105, 115),
        Accent = Color3.fromRGB(90, 80, 220),
        Button = Color3.fromRGB(80, 70, 200),
        Glow = Color3.fromRGB(90, 80, 220),
        Notification = Color3.fromRGB(90, 80, 220),
    },

    AMOLED = {
        Background = Color3.fromRGB(0, 0, 0),
        Sidebar = Color3.fromRGB(2, 2, 2),
        Surface = Color3.fromRGB(8, 8, 8),
        Card = Color3.fromRGB(13, 13, 13),
        Border = Color3.fromRGB(35, 35, 35),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(140, 140, 140),
        Accent = Color3.fromRGB(0, 200, 255),
        Button = Color3.fromRGB(0, 150, 200),
        Glow = Color3.fromRGB(0, 200, 255),
        Notification = Color3.fromRGB(0, 200, 255),
    },

    Discord = {
        Background = Color3.fromRGB(20, 21, 24),
        Sidebar = Color3.fromRGB(30, 31, 34),
        Surface = Color3.fromRGB(43, 45, 49),
        Card = Color3.fromRGB(49, 51, 56),
        Border = Color3.fromRGB(70, 72, 78),
        Text = Color3.fromRGB(242, 243, 245),
        Muted = Color3.fromRGB(148, 155, 164),
        Accent = Color3.fromRGB(88, 101, 242),
        Button = Color3.fromRGB(71, 82, 196),
        Glow = Color3.fromRGB(88, 101, 242),
        Notification = Color3.fromRGB(88, 101, 242),
    },

    GitHub = {
        Background = Color3.fromRGB(13, 17, 23),
        Sidebar = Color3.fromRGB(22, 27, 34),
        Surface = Color3.fromRGB(33, 38, 45),
        Card = Color3.fromRGB(36, 41, 48),
        Border = Color3.fromRGB(48, 54, 61),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158),
        Accent = Color3.fromRGB(46, 160, 67),
        Button = Color3.fromRGB(35, 134, 54),
        Glow = Color3.fromRGB(46, 160, 67),
        Notification = Color3.fromRGB(46, 160, 67),
    },

    VSCode = {
        Background = Color3.fromRGB(24, 24, 24),
        Sidebar = Color3.fromRGB(30, 30, 30),
        Surface = Color3.fromRGB(37, 37, 38),
        Card = Color3.fromRGB(45, 45, 48),
        Border = Color3.fromRGB(65, 65, 70),
        Text = Color3.fromRGB(220, 220, 220),
        Muted = Color3.fromRGB(150, 150, 150),
        Accent = Color3.fromRGB(0, 122, 204),
        Button = Color3.fromRGB(0, 105, 175),
        Glow = Color3.fromRGB(0, 122, 204),
        Notification = Color3.fromRGB(0, 122, 204),
    },

    Cyberpunk = {
        Background = Color3.fromRGB(12, 5, 20),
        Sidebar = Color3.fromRGB(20, 7, 30),
        Surface = Color3.fromRGB(30, 9, 43),
        Card = Color3.fromRGB(39, 11, 55),
        Border = Color3.fromRGB(120, 20, 160),
        Text = Color3.fromRGB(255, 240, 255),
        Muted = Color3.fromRGB(190, 140, 205),
        Accent = Color3.fromRGB(0, 255, 230),
        Button = Color3.fromRGB(0, 180, 165),
        Glow = Color3.fromRGB(255, 0, 180),
        Notification = Color3.fromRGB(0, 255, 230),
    },

    Angkor = {
        Background = Color3.fromRGB(17, 13, 9),
        Sidebar = Color3.fromRGB(28, 21, 13),
        Surface = Color3.fromRGB(42, 31, 18),
        Card = Color3.fromRGB(51, 38, 21),
        Border = Color3.fromRGB(115, 82, 38),
        Text = Color3.fromRGB(255, 244, 214),
        Muted = Color3.fromRGB(190, 160, 115),
        Accent = Color3.fromRGB(220, 165, 65),
        Button = Color3.fromRGB(185, 130, 45),
        Glow = Color3.fromRGB(220, 165, 65),
        Notification = Color3.fromRGB(220, 165, 65),
    },

    Solar = {
        Background = Color3.fromRGB(20, 12, 6),
        Sidebar = Color3.fromRGB(31, 19, 9),
        Surface = Color3.fromRGB(45, 27, 11),
        Card = Color3.fromRGB(56, 32, 12),
        Border = Color3.fromRGB(125, 70, 20),
        Text = Color3.fromRGB(255, 245, 225),
        Muted = Color3.fromRGB(195, 165, 120),
        Accent = Color3.fromRGB(255, 190, 55),
        Button = Color3.fromRGB(220, 145, 25),
        Glow = Color3.fromRGB(255, 190, 55),
        Notification = Color3.fromRGB(255, 190, 55),
    },

    Rose = {
        Background = Color3.fromRGB(19, 8, 12),
        Sidebar = Color3.fromRGB(29, 11, 17),
        Surface = Color3.fromRGB(42, 15, 24),
        Card = Color3.fromRGB(51, 17, 28),
        Border = Color3.fromRGB(105, 40, 55),
        Text = Color3.fromRGB(255, 240, 244),
        Muted = Color3.fromRGB(190, 150, 160),
        Accent = Color3.fromRGB(240, 95, 120),
        Button = Color3.fromRGB(205, 65, 90),
        Glow = Color3.fromRGB(240, 95, 120),
        Notification = Color3.fromRGB(240, 95, 120),
    },
}

local Theme = Themes[State.CurrentTheme]

--==================================================
-- DATA
--==================================================

local Scripts = {
    {
        Name = "Sources Hub",
        Category = "Keyless",
        Description = "Premium keyless hub interface.",
        Status = "Available",
        Version = "v1.0",
        Icon = "S",
    },

    {
        Name = "Limbo Hub",
        Category = "Keyless",
        Description = "Modern keyless hub interface.",
        Status = "Available",
        Version = "v1.0",
        Icon = "L",
    },

    {
        Name = "Virexx",
        Category = "Keyless",
        Description = "Advanced keyless hub interface.",
        Status = "Available",
        Version = "v1.0",
        Icon = "V",
    },

    {
        Name = "Wzeus Hub",
        Category = "Key",
        Description = "Hub with key verification flow.",
        Status = "Key Required",
        Version = "v1.0",
        Icon = "W",
    },

    {
        Name = "Pulse Hub",
        Category = "Key",
        Description = "Hub with key system interface.",
        Status = "Key Required",
        Version = "v1.0",
        Icon = "P",
    },

    {
        Name = "Next Generation Hub",
        Category = "Coming Soon",
        Description = "A new CH3A5 feature is coming.",
        Status = "Coming Soon",
        Version = "Soon",
        Icon = "N",
    },
}

--==================================================
-- UTILITIES
--==================================================

local Connections = {}

local function Connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(Connections, connection)
    return connection
end

local function Tween(object, properties, duration)
    if not State.Animations then
        for property, value in pairs(properties) do
            object[property] = value
        end
        return
    end

    TweenService:Create(
        object,
        TweenInfo.new(
            duration or 0.25,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    ):Play()
end

local function Corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = object
    return c
end

local function Stroke(object, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Border
    s.Transparency = transparency or 0
    s.Thickness = 1
    s.Parent = object
    return s
end

local function Padding(object, value)
    local p = Instance.new("UIPadding")
    p.PaddingTop = UDim.new(0, value)
    p.PaddingBottom = UDim.new(0, value)
    p.PaddingLeft = UDim.new(0, value)
    p.PaddingRight = UDim.new(0, value)
    p.Parent = object
    return p
end

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Name = "MainWindow"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(900, 570)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

Corner(Main, 18)
local MainStroke = Stroke(Main, Theme.Border, 0.15)

-- Glow layer
local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.Position = UDim2.fromScale(0.5, 0.5)
Glow.Size = UDim2.new(1, 55, 1, 55)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://5028857084"
Glow.ImageColor3 = Theme.Glow
Glow.ImageTransparency = 0.92
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(24, 24, 276, 276)
Glow.ZIndex = 0
Glow.Parent = Main

--==================================================
-- TOPBAR
--==================================================

local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 66)
Topbar.BackgroundColor3 = Theme.Surface
Topbar.BorderSizePixel = 0
Topbar.ZIndex = 5
Topbar.Parent = Main

local Logo = Instance.new("Frame")
Logo.Size = UDim2.fromOffset(42, 42)
Logo.Position = UDim2.fromOffset(13, 12)
Logo.BackgroundColor3 = Theme.Accent
Logo.BorderSizePixel = 0
Logo.ZIndex = 6
Logo.Parent = Topbar
Corner(Logo, 12)

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.fromScale(1, 1)
LogoText.BackgroundTransparency = 1
LogoText.Text = "C3"
LogoText.Font = Enum.Font.GothamBlack
LogoText.TextSize = 14
LogoText.TextColor3 = Color3.new(1, 1, 1)
LogoText.ZIndex = 7
LogoText.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Position = UDim2.fromOffset(68, 10)
Title.Size = UDim2.fromOffset(230, 27)
Title.BackgroundTransparency = 1
Title.Text = "CH3A5 HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Theme.Text
Title.ZIndex = 6
Title.Parent = Topbar

local Version = Instance.new("TextLabel")
Version.Position = UDim2.fromOffset(68, 36)
Version.Size = UDim2.fromOffset(80, 18)
Version.BackgroundTransparency = 1
Version.Text = "V2.0 • PREMIUM"
Version.Font = Enum.Font.GothamMedium
Version.TextSize = 9
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.TextColor3 = Theme.Muted
Version.ZIndex = 6
Version.Parent = Topbar

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(7, 7)
StatusDot.Position = UDim2.new(1, -175, 0.5, -3)
StatusDot.BackgroundColor3 = Color3.fromRGB(45, 220, 120)
StatusDot.BorderSizePixel = 0
StatusDot.ZIndex = 6
StatusDot.Parent = Topbar
Corner(StatusDot, 10)

local StatusText = Instance.new("TextLabel")
StatusText.Position = UDim2.new(1, -160, 0.5, -10)
StatusText.Size = UDim2.fromOffset(75, 20)
StatusText.BackgroundTransparency = 1
StatusText.Text = "ONLINE"
StatusText.Font = Enum.Font.GothamBold
StatusText.TextSize = 9
StatusText.TextColor3 = Theme.Muted
StatusText.ZIndex = 6
StatusText.Parent = Topbar

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(38, 38)
Minimize.Position = UDim2.new(1, -90, 0.5, -19)
Minimize.BackgroundColor3 = Theme.Card
Minimize.Text = "−"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 20
Minimize.TextColor3 = Theme.Text
Minimize.AutoButtonColor = false
Minimize.ZIndex = 7
Minimize.Parent = Topbar
Corner(Minimize, 10)

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -46, 0.5, -19)
Close.BackgroundColor3 = Theme.Card
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 20
Close.TextColor3 = Theme.Text
Close.AutoButtonColor = false
Close.ZIndex = 7
Close.Parent = Topbar
Corner(Close, 10)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Position = UDim2.fromOffset(0, 66)
Sidebar.Size = UDim2.new(0, 185, 1, -66)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 4
Sidebar.Parent = Main

local SidePadding = Padding(Sidebar, 12)

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 7)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

--==================================================
-- CONTENT AREA
--==================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Position = UDim2.fromOffset(185, 66)
Content.Size = UDim2.new(1, -185, 1, -66)
Content.BackgroundColor3 = Theme.Background
Content.BorderSizePixel = 0
Content.ZIndex = 2
Content.Parent = Main

--==================================================
-- PAGE SYSTEM
--==================================================

local Pages = {}

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Size = UDim2.new(1, -28, 1, -28)
    Page.Position = UDim2.fromOffset(14, 14)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Theme.Accent
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new()
    Page.Visible = false
    Page.ZIndex = 3
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 12)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    Pages[name] = Page

    return Page
end

local HomePage = CreatePage("Home")
local ScriptsPage = CreatePage("Scripts")
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")
local KeyPage = CreatePage("Key")
local ComingSoonPage = CreatePage("ComingSoon")

--==================================================
-- SIDEBAR NAVIGATION
--==================================================

local NavButtons = {}

local function CreateNav(name, icon, pageName)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(1, 0, 0, 43)
    Button.BackgroundColor3 = Theme.Sidebar
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.ZIndex = 5
    Button.Parent = Sidebar
    Corner(Button, 10)

    local Active = Instance.new("Frame")
    Active.Size = UDim2.fromOffset(3, 22)
    Active.Position = UDim2.new(0, 0, 0.5, -11)
    Active.BackgroundColor3 = Theme.Accent
    Active.BorderSizePixel = 0
    Active.Visible = false
    Active.ZIndex = 7
    Active.Parent = Button
    Corner(Active, 5)

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.fromOffset(30, 43)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 15
    Icon.TextColor3 = Theme.Muted
    Icon.ZIndex = 6
    Icon.Parent = Button

    local Label = Instance.new("TextLabel")
    Label.Position = UDim2.fromOffset(37, 0)
    Label.Size = UDim2.new(1, -45, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = Theme.Muted
    Label.ZIndex = 6
    Label.Parent = Button

    NavButtons[pageName] = {
        Button = Button,
        Active = Active,
        Icon = Icon,
        Label = Label,
    }

    Connect(Button.MouseButton1Click, function()
        for page, data in pairs(NavButtons) do
            data.Active.Visible = false
            data.Label.TextColor3 = Theme.Muted
            data.Icon.TextColor3 = Theme.Muted
        end

        for page, obj in pairs(Pages) do
            obj.Visible = false
        end

        Pages[pageName].Visible = true

        Active.Visible = true
        Label.TextColor3 = Theme.Text
        Icon.TextColor3 = Theme.Accent

        State.CurrentPage = pageName
    end)

    Connect(Button.MouseEnter, function()
        if State.CurrentPage ~= pageName then
            Tween(Button, {
                BackgroundColor3 = Theme.Card
            }, 0.15)
        end
    end)

    Connect(Button.MouseLeave, function()
        if State.CurrentPage ~= pageName then
            Tween(Button, {
                BackgroundColor3 = Theme.Sidebar
            }, 0.15)
        end
    end)

    return Button
end

CreateNav("Dashboard", "⌂", "Home")
CreateNav("Scripts", "◆", "Scripts")
CreateNav("Key System", "◇", "Key")
CreateNav("Coming Soon", "○", "ComingSoon")
CreateNav("Themes", "✦", "Themes")
CreateNav("Settings", "⚙", "Settings")

--==================================================
-- PAGE HELPERS
--==================================================

local function Header(Page, title, description)
    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1, 0, 0, 62)
    Holder.BackgroundTransparency = 1
    Holder.Parent = Page

    local T = Instance.new("TextLabel")
    T.Size = UDim2.new(1, 0, 0, 32)
    T.BackgroundTransparency = 1
    T.Text = title
    T.Font = Enum.Font.GothamBold
    T.TextSize = 22
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.TextColor3 = Theme.Text
    T.Parent = Holder

    local D = Instance.new("TextLabel")
    D.Position = UDim2.fromOffset(0, 34)
    D.Size = UDim2.new(1, 0, 0, 20)
    D.BackgroundTransparency = 1
    D.Text = description
    D.Font = Enum.Font.Gotham
    D.TextSize = 11
    D.TextXAlignment = Enum.TextXAlignment.Left
    D.TextColor3 = Theme.Muted
    D.Parent = Holder
end

--==================================================
-- HOME DASHBOARD
--==================================================

Header(
    HomePage,
    "Welcome to CH3A5 HUB",
    "Premium script interface • clean • responsive • futuristic"
)

local Welcome = Instance.new("Frame")
Welcome.Size = UDim2.new(1, 0, 0, 120)
Welcome.BackgroundColor3 = Theme.Surface
Welcome.BorderSizePixel = 0
Welcome.Parent = HomePage
Corner(Welcome, 14)
Stroke(Welcome, Theme.Border, 0.2)

local WelcomeTitle = Instance.new("TextLabel")
WelcomeTitle.Position = UDim2.fromOffset(20, 18)
WelcomeTitle.Size = UDim2.new(1, -40, 0, 28)
WelcomeTitle.BackgroundTransparency = 1
WelcomeTitle.Text = "CH3A5 PREMIUM"
WelcomeTitle.Font = Enum.Font.GothamBlack
WelcomeTitle.TextSize = 20
WelcomeTitle.TextXAlignment = Enum.TextXAlignment.Left
WelcomeTitle.TextColor3 = Theme.Text
WelcomeTitle.Parent = Welcome

local WelcomeDesc = Instance.new("TextLabel")
WelcomeDesc.Position = UDim2.fromOffset(20, 52)
WelcomeDesc.Size = UDim2.new(1, -40, 0, 45)
WelcomeDesc.BackgroundTransparency = 1
WelcomeDesc.Text = "Explore available hubs, key systems and upcoming features."
WelcomeDesc.Font = Enum.Font.Gotham
WelcomeDesc.TextSize = 12
WelcomeDesc.TextWrapped = true
WelcomeDesc.TextXAlignment = Enum.TextXAlignment.Left
WelcomeDesc.TextColor3 = Theme.Muted
WelcomeDesc.Parent = Welcome

local Stats = Instance.new("Frame")
Stats.Size = UDim2.new(1, 0, 0, 88)
Stats.BackgroundTransparency = 1
Stats.Parent = HomePage

local StatsLayout = Instance.new("UIGridLayout")
StatsLayout.CellSize = UDim2.new(0.32, -5, 1, 0)
StatsLayout.CellPadding = UDim2.new(0.02, 0, 0, 0)
StatsLayout.Parent = Stats

local function StatCard(title, value)
    local Card = Instance.new("Frame")
    Card.BackgroundColor3 = Theme.Card
    Card.BorderSizePixel = 0
    Card.Parent = Stats
    Corner(Card, 12)
    Stroke(Card, Theme.Border, 0.3)

    local V = Instance.new("TextLabel")
    V.Position = UDim2.fromOffset(15, 12)
    V.Size = UDim2.new(1, -30, 0, 27)
    V.BackgroundTransparency = 1
    V.Text = value
    V.Font = Enum.Font.GothamBold
    V.TextSize = 19
    V.TextXAlignment = Enum.TextXAlignment.Left
    V.TextColor3 = Theme.Accent
    V.Parent = Card

    local T = Instance.new("TextLabel")
    T.Position = UDim2.fromOffset(15, 43)
    T.Size = UDim2.new(1, -30, 0, 20)
    T.BackgroundTransparency = 1
    T.Text = title
    T.Font = Enum.Font.Gotham
    T.TextSize = 10
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.TextColor3 = Theme.Muted
    T.Parent = Card
end

StatCard("Total Hubs", "05")
StatCard("Keyless", "03")
StatCard("Categories", "06")

--==================================================
-- SCRIPT PAGE
--==================================================

Header(
    ScriptsPage,
    "Script Library",
    "Search and filter available interfaces."
)

-- Search
local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, 0, 0, 44)
SearchFrame.BackgroundColor3 = Theme.Surface
SearchFrame.BorderSizePixel = 0
SearchFrame.Parent = ScriptsPage
Corner(SearchFrame, 10)
Stroke(SearchFrame, Theme.Border, 0.25)

local SearchBox = Instance.new("TextBox")
SearchBox.Position = UDim2.fromOffset(14, 0)
SearchBox.Size = UDim2.new(1, -55, 1, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "Search scripts..."
SearchBox.PlaceholderColor3 = Theme.Muted
SearchBox.Text = ""
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.TextColor3 = Theme.Text
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = SearchFrame

local ClearSearch = Instance.new("TextButton")
ClearSearch.Position = UDim2.new(1, -40, 0, 5)
ClearSearch.Size = UDim2.fromOffset(34, 34)
ClearSearch.BackgroundTransparency = 1
ClearSearch.Text = "×"
ClearSearch.TextSize = 18
ClearSearch.Font = Enum.Font.GothamBold
ClearSearch.TextColor3 = Theme.Muted
ClearSearch.Parent = SearchFrame

-- Filters
local FilterFrame = Instance.new("Frame")
FilterFrame.Size = UDim2.new(1, 0, 0, 38)
FilterFrame.BackgroundTransparency = 1
FilterFrame.Parent = ScriptsPage

local FilterLayout = Instance.new("UIListLayout")
FilterLayout.FillDirection = Enum.FillDirection.Horizontal
FilterLayout.Padding = UDim.new(0, 7)
FilterLayout.Parent = FilterFrame

local Categories = {
    "All",
    "Featured",
    "Keyless",
    "Key",
    "Coming Soon",
    "Other",
}

local FilterButtons = {}

local function Matches(item)
    local query = string.lower(State.Search or "")

    local searchMatch =
        query == ""
        or string.find(string.lower(item.Name), query, 1, true)
        or string.find(string.lower(item.Category), query, 1, true)
        or string.find(string.lower(item.Description), query, 1, true)

    local categoryMatch =
        State.CurrentCategory == "All"
        or State.CurrentCategory == "Featured" and item.Name == "Sources Hub"
        or item.Category == State.CurrentCategory

    return searchMatch and categoryMatch
end

for _, category in ipairs(Categories) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.fromOffset(82, 34)
    Button.BackgroundColor3 = Theme.Card
    Button.BorderSizePixel = 0
    Button.Text = category
    Button.Font = Enum.Font.GothamMedium
    Button.TextSize = 10
    Button.TextColor3 = Theme.Muted
    Button.AutoButtonColor = false
    Button.Parent = FilterFrame
    Corner(Button, 8)

    FilterButtons[category] = Button

    Connect(Button.MouseButton1Click, function()
        State.CurrentCategory = category

        for name, btn in pairs(FilterButtons) do
            btn.BackgroundColor3 = Theme.Card
            btn.TextColor3 = Theme.Muted
        end

        Button.BackgroundColor3 = Theme.Accent
        Button.TextColor3 = Color3.new(1, 1, 1)

        RefreshCards()
    end)
end

-- Cards container
local Cards = Instance.new("Frame")
Cards.Name = "Cards"
Cards.Size = UDim2.new(1, 0, 0, 0)
Cards.AutomaticSize = Enum.AutomaticSize.Y
Cards.BackgroundTransparency = 1
Cards.Parent = ScriptsPage

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0.48, -6, 0, 150)
Grid.CellPadding = UDim2.fromOffset(12, 12)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = Cards

local NoResults = Instance.new("TextLabel")
NoResults.Size = UDim2.new(1, 0, 0, 100)
NoResults.BackgroundTransparency = 1
NoResults.Text = "No scripts found"
NoResults.Font = Enum.Font.GothamMedium
NoResults.TextSize = 14
NoResults.TextColor3 = Theme.Muted
NoResults.Visible = false
NoResults.Parent = Cards

local function CreateScriptCard(item)
    local Card = Instance.new("Frame")
    Card.BackgroundColor3 = Theme.Card
    Card.BorderSizePixel = 0
    Card.Parent = Cards
    Corner(Card, 13)
    Stroke(Card, Theme.Border, 0.25)

    local Icon = Instance.new("Frame")
    Icon.Size = UDim2.fromOffset(40, 40)
    Icon.Position = UDim2.fromOffset(13, 13)
    Icon.BackgroundColor3 = Theme.Accent
    Icon.BorderSizePixel = 0
    Icon.Parent = Card
    Corner(Icon, 10)

    local IconText = Instance.new("TextLabel")
    IconText.Size = UDim2.fromScale(1, 1)
    IconText.BackgroundTransparency = 1
    IconText.Text = item.Icon
    IconText.Font = Enum.Font.GothamBlack
    IconText.TextSize = 16
    IconText.TextColor3 = Color3.new(1, 1, 1)
    IconText.Parent = Icon

    local Name = Instance.new("TextLabel")
    Name.Position = UDim2.fromOffset(63, 13)
    Name.Size = UDim2.new(1, -75, 0, 22)
    Name.BackgroundTransparency = 1
    Name.Text = item.Name
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 13
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = Theme.Text
    Name.Parent = Card

    local Category = Instance.new("TextLabel")
    Category.Position = UDim2.fromOffset(63, 36)
    Category.Size = UDim2.new(1, -75, 0, 17)
    Category.BackgroundTransparency = 1
    Category.Text = item.Category .. " • " .. item.Version
    Category.Font = Enum.Font.Gotham
    Category.TextSize = 9
    Category.TextXAlignment = Enum.TextXAlignment.Left
    Category.TextColor3 = Theme.Accent
    Category.Parent = Card

    local Description = Instance.new("TextLabel")
    Description.Position = UDim2.fromOffset(13, 60)
    Description.Size = UDim2.new(1, -26, 0, 32)
    Description.BackgroundTransparency = 1
    Description.Text = item.Description
    Description.Font = Enum.Font.Gotham
    Description.TextSize = 10
    Description.TextWrapped = true
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.TextYAlignment = Enum.TextYAlignment.Top
    Description.TextColor3 = Theme.Muted
    Description.Parent = Card

    local Action = Instance.new("TextButton")
    Action.Position = UDim2.fromOffset(13, 108)
    Action.Size = UDim2.new(1, -54, 0, 29)
    Action.BackgroundColor3 = Theme.Button
    Action.BorderSizePixel = 0
    Action.Text = item.Category == "Coming Soon" and "COMING SOON" or "OPEN"
    Action.Font = Enum.Font.GothamBold
    Action.TextSize = 9
    Action.TextColor3 = Color3.new(1, 1, 1)
    Action.AutoButtonColor = false
    Action.Parent = Card
    Corner(Action, 8)

    local Favorite = Instance.new("TextButton")
    Favorite.Position = UDim2.new(1, -35, 0, 108)
    Favorite.Size = UDim2.fromOffset(29, 29)
    Favorite.BackgroundColor3 = Theme.Surface
    Favorite.BorderSizePixel = 0
    Favorite.Text = "☆"
    Favorite.Font = Enum.Font.GothamBold
    Favorite.TextSize = 15
    Favorite.TextColor3 = Theme.Muted
    Favorite.Parent = Card
    Corner(Favorite, 8)

    Connect(Favorite.MouseButton1Click, function()
        if Favorite.Text == "☆" then
            Favorite.Text = "★"
            Favorite.TextColor3 = Theme.Accent
        else
            Favorite.Text = "☆"
            Favorite.TextColor3 = Theme.Muted
        end
    end)

    Connect(Action.MouseButton1Click, function()
        if item.Category == "Coming Soon" then
            Notify(
                "Coming Soon",
                item.Name .. " is not available yet.",
                "Info"
            )
        elseif item.Category == "Key" then
            Pages.Scripts.Visible = false
            Pages.Key.Visible = true
            State.CurrentPage = "Key"
            Notify(
                "Key Required",
                item.Name .. " requires verification.",
                "Warning"
            )
        else
            Notify(
                "Selected",
                item.Name .. " interface opened.",
                "Success"
            )
        end
    end)

    Connect(Card.MouseEnter, function()
        Tween(Card, {
            BackgroundColor3 = Theme.Surface
        }, 0.15)
    end)

    Connect(Card.MouseLeave, function()
        Tween(Card, {
            BackgroundColor3 = Theme.Card
        }, 0.15)
    end)

    return Card
end

function RefreshCards()
    for _, child in ipairs(Cards:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local count = 0

    for _, item in ipairs(Scripts) do
        if Matches(item) then
            count += 1
            CreateScriptCard(item)
        end
    end

    NoResults.Visible = count == 0
end

Connect(SearchBox:GetPropertyChangedSignal("Text"), function()
    State.Search = SearchBox.Text
    RefreshCards()
end)

Connect(ClearSearch.MouseButton1Click, function()
    SearchBox.Text = ""
    State.Search = ""
    RefreshCards()
end)

--==================================================
-- KEY PAGE
--==================================================

Header(
    KeyPage,
    "Key System",
    "Verification interface for key-based hubs."
)

local KeyBox = Instance.new("Frame")
KeyBox.Size = UDim2.new(1, 0, 0, 180)
KeyBox.BackgroundColor3 = Theme.Surface
KeyBox.BorderSizePixel = 0
KeyBox.Parent = KeyPage
Corner(KeyBox, 14)
Stroke(KeyBox, Theme.Border, 0.2)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Position = UDim2.fromOffset(20, 18)
KeyTitle.Size = UDim2.new(1, -40, 0, 25)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "Key Verification"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16
KeyTitle.TextColor3 = Theme.Text
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyBox

local KeyInput = Instance.new("TextBox")
KeyInput.Position = UDim2.fromOffset(20, 57)
KeyInput.Size = UDim2.new(1, -40, 0, 40)
KeyInput.BackgroundColor3 = Theme.Card
KeyInput.BorderSizePixel = 0
KeyInput.PlaceholderText = "Enter key..."
KeyInput.PlaceholderColor3 = Theme.Muted
KeyInput.Text = ""
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12
KeyInput.TextColor3 = Theme.Text
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyBox
Corner(KeyInput, 9)
Stroke(KeyInput, Theme.Border, 0.25)

local Verify = Instance.new("TextButton")
Verify.Position = UDim2.fromOffset(20, 110)
Verify.Size = UDim2.fromOffset(130, 38)
Verify.BackgroundColor3 = Theme.Button
Verify.BorderSizePixel = 0
Verify.Text = "VERIFY"
Verify.Font = Enum.Font.GothamBold
Verify.TextSize = 10
Verify.TextColor3 = Color3.new(1, 1, 1)
Verify.Parent = KeyBox
Corner(Verify, 9)

Connect(Verify.MouseButton1Click, function()
    if KeyInput.Text == "" then
        Notify("Warning", "Please enter a key.", "Warning")
    else
        Notify(
            "Verification",
            "Verification UI is ready for your own backend.",
            "Info"
        )
    end
end)

--==================================================
-- COMING SOON
--==================================================

Header(
    ComingSoonPage,
    "Coming Soon",
    "Future CH3A5 HUB features."
)

for _, item in ipairs({
    "Advanced Dashboard",
    "More Script Categories",
    "Custom Layouts",
    "Cloud Preferences",
}) do
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 70)
    Card.BackgroundColor3 = Theme.Card
    Card.BorderSizePixel = 0
    Card.Parent = ComingSoonPage
    Corner(Card, 12)
    Stroke(Card, Theme.Border, 0.3)

    local Lock = Instance.new("TextLabel")
    Lock.Position = UDim2.fromOffset(18, 0)
    Lock.Size = UDim2.fromOffset(40, 70)
    Lock.BackgroundTransparency = 1
    Lock.Text = "◇"
    Lock.Font = Enum.Font.GothamBold
    Lock.TextSize = 20
    Lock.TextColor3 = Theme.Accent
    Lock.Parent = Card

    local Text = Instance.new("TextLabel")
    Text.Position = UDim2.fromOffset(65, 10)
    Text.Size = UDim2.new(1, -80, 0, 24)
    Text.BackgroundTransparency = 1
    Text.Text = item
    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 13
    Text.TextColor3 = Theme.Text
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Card

    local Status = Instance.new("TextLabel")
    Status.Position = UDim2.fromOffset(65, 35)
    Status.Size = UDim2.new(1, -80, 0, 20)
    Status.BackgroundTransparency = 1
    Status.Text = "In development"
    Status.Font = Enum.Font.Gotham
    Status.TextSize = 10
    Status.TextColor3 = Theme.Muted
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.Parent = Card
end

--==================================================
-- THEME PAGE
--==================================================

Header(
    ThemesPage,
    "Theme Engine",
    "Preview and apply a CH3A5 visual theme."
)

local ThemeGrid = Instance.new("Frame")
ThemeGrid.Size = UDim2.new(1, 0, 0, 0)
ThemeGrid.AutomaticSize = Enum.AutomaticSize.Y
ThemeGrid.BackgroundTransparency = 1
ThemeGrid.Parent = ThemesPage

local ThemeLayout = Instance.new("UIGridLayout")
ThemeLayout.CellSize = UDim2.new(0.31, -6, 0, 58)
ThemeLayout.CellPadding = UDim2.fromOffset(9, 9)
ThemeLayout.Parent = ThemeGrid

local ThemeButtons = {}

--==================================================
-- NOTIFICATION SYSTEM
--==================================================

local NotificationHolder = Instance.new("Frame")
NotificationHolder.AnchorPoint = Vector2.new(1, 0)
NotificationHolder.Position = UDim2.new(1, -20, 0, 20)
NotificationHolder.Size = UDim2.fromOffset(300, 0)
NotificationHolder.AutomaticSize = Enum.AutomaticSize.Y
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.ZIndex = 100
NotificationHolder.Parent = ScreenGui

local NotificationLayout = Instance.new("UIListLayout")
NotificationLayout.Padding = UDim.new(0, 8)
NotificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotificationLayout.Parent = NotificationHolder

function Notify(title, message, kind)
    if not State.Notifications then
        return
    end

    local colors = {
        Success = Color3.fromRGB(45, 220, 120),
        Info = Theme.Accent,
        Warning = Color3.fromRGB(245, 180, 55),
        Error = Color3.fromRGB(245, 60, 75),
    }

    local accent = colors[kind] or Theme.Accent

    local Toast = Instance.new("Frame")
    Toast.Size = UDim2.fromOffset(290, 72)
    Toast.BackgroundColor3 = Theme.Surface
    Toast.BorderSizePixel = 0
    Toast.ZIndex = 101
    Toast.Parent = NotificationHolder
    Corner(Toast, 12)
    Stroke(Toast, Theme.Border, 0.15)

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.fromOffset(3, 72)
    Bar.BackgroundColor3 = accent
    Bar.BorderSizePixel = 0
    Bar.ZIndex = 102
    Bar.Parent = Toast
    Corner(Bar, 4)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Position = UDim2.fromOffset(15, 10)
    TitleLabel.Size = UDim2.new(1, -25, 0, 20)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 12
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 102
    TitleLabel.Parent = Toast

    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Position = UDim2.fromOffset(15, 31)
    MessageLabel.Size = UDim2.new(1, -25, 0, 25)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.TextSize = 10
    MessageLabel.TextWrapped = true
    MessageLabel.TextColor3 = Theme.Muted
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.ZIndex = 102
    MessageLabel.Parent = Toast

    local Progress = Instance.new("Frame")
    Progress.Position = UDim2.new(0, 0, 1, -3)
    Progress.Size = UDim2.new(1, 0, 0, 3)
    Progress.BackgroundColor3 = accent
    Progress.BorderSizePixel = 0
    Progress.ZIndex = 102
    Progress.Parent = Toast

    Tween(Toast, {
        Position = UDim2.fromOffset(0, 0)
    }, 0.2)

    Tween(
        Progress,
        {Size = UDim2.new(0, 0, 0, 3)},
        3
    )

    task.delay(3, function()
        if Toast and Toast.Parent then
            Tween(
                Toast,
                {BackgroundTransparency = 1},
                0.2
            )

            task.wait(0.2)

            if Toast then
                Toast:Destroy()
            end
        end
    end)
end

--==================================================
-- THEME APPLY
--==================================================

local function ApplyTheme(name)
    local NewTheme = Themes[name]
    if not NewTheme then
        return
    end

    State.CurrentTheme = name
    Theme = NewTheme

    -- Core
    Tween(Main, {
        BackgroundColor3 = Theme.Background
    }, 0.35)

    Tween(Topbar, {
        BackgroundColor3 = Theme.Surface
    }, 0.35)

    Tween(Sidebar, {
        BackgroundColor3 = Theme.Sidebar
    }, 0.35)

    Tween(Content, {
        BackgroundColor3 = Theme.Background
    }, 0.35)

    Tween(MainStroke, {
        Color = Theme.Border
    }, 0.35)

    Tween(Glow, {
        ImageColor3 = Theme.Glow
    }, 0.35)

    -- Navigation
    for pageName, data in pairs(NavButtons) do
        data.Button.BackgroundColor3 =
            State.CurrentPage == pageName
            and Theme.Card
            or Theme.Sidebar

        data.Label.TextColor3 =
            State.CurrentPage == pageName
            and Theme.Text
            or Theme.Muted

        data.Icon.TextColor3 =
            State.CurrentPage == pageName
            and Theme.Accent
            or Theme.Muted

        data.Active.BackgroundColor3 = Theme.Accent
    end

    -- Theme buttons
    for themeName, button in pairs(ThemeButtons) do
        local t = Themes[themeName]
        button.BackgroundColor3 = t.Card
        button.TextColor3 = t.Text
    end

    RefreshCards()

    Notify(
        "Theme Applied",
        name .. " theme activated.",
        "Success"
    )
end

for name, themeData in pairs(Themes) do
    local Button = Instance.new("TextButton")
    Button.BackgroundColor3 = themeData.Card
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 10
    Button.TextColor3 = themeData.Text
    Button.AutoButtonColor = false
    Button.Parent = ThemeGrid
    Corner(Button, 10)

    ThemeButtons[name] = Button

    Connect(Button.MouseButton1Click, function()
        ApplyTheme(name)
    end)

    Connect(Button.MouseEnter, function()
        Tween(Button, {
            BackgroundColor3 = themeData.Surface
        }, 0.15)
    end)

    Connect(Button.MouseLeave, function()
        Tween(Button, {
            BackgroundColor3 = themeData.Card
        }, 0.15)
    end)
end

--==================================================
-- SETTINGS PAGE
--==================================================

Header(
    SettingsPage,
    "Settings",
    "Customize the CH3A5 HUB experience."
)

local function SettingToggle(title, description, default, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, 0, 0, 65)
    Row.BackgroundColor3 = Theme.Card
    Row.BorderSizePixel = 0
    Row.Parent = SettingsPage
    Corner(Row, 11)
    Stroke(Row, Theme.Border, 0.3)

    local T = Instance.new("TextLabel")
    T.Position = UDim2.fromOffset(15, 10)
    T.Size = UDim2.new(1, -80, 0, 20)
    T.BackgroundTransparency = 1
    T.Text = title
    T.Font = Enum.Font.GothamBold
    T.TextSize = 12
    T.TextColor3 = Theme.Text
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.Parent = Row

    local D = Instance.new("TextLabel")
    D.Position = UDim2.fromOffset(15, 32)
    D.Size = UDim2.new(1, -90, 0, 22)
    D.BackgroundTransparency = 1
    D.Text = description
    D.Font = Enum.Font.Gotham
    D.TextSize = 9
    D.TextColor3 = Theme.Muted
    D.TextXAlignment = Enum.TextXAlignment.Left
    D.Parent = Row

    local Toggle = Instance.new("TextButton")
    Toggle.Position = UDim2.new(1, -65, 0.5, -14)
    Toggle.Size = UDim2.fromOffset(50, 28)
    Toggle.BackgroundColor3 =
        default and Theme.Accent or Theme.Surface
    Toggle.BorderSizePixel = 0
    Toggle.Text = ""
    Toggle.Parent = Row
    Corner(Toggle, 20)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.fromOffset(20, 20)
    Knob.Position = default
        and UDim2.new(1, -24, 0.5, -10)
        or UDim2.fromOffset(4, 4)
    Knob.BackgroundColor3 = Color3.new(1, 1, 1)
    Knob.BorderSizePixel = 0
    Knob.Parent = Toggle
    Corner(Knob, 20)

    local Value = default

    Connect(Toggle.MouseButton1Click, function()
        Value = not Value

        Tween(
            Toggle,
            {
                BackgroundColor3 =
                    Value and Theme.Accent or Theme.Surface
            },
            0.2
        )

        Tween(
            Knob,
            {
                Position =
                    Value
                    and UDim2.new(1, -24, 0.5, -10)
                    or UDim2.fromOffset(4, 4)
            },
            0.2
        )

        callback(Value)
    end)

    return Row
end

SettingToggle(
    "Animations",
    "Enable smooth UI animations.",
    true,
    function(value)
        State.Animations = value
    end
)

SettingToggle(
    "Notifications",
    "Show toast notifications.",
    true,
    function(value)
        State.Notifications = value
    end
)

SettingToggle(
    "Compact Mode",
    "Reduce spacing for smaller screens.",
    false,
    function(value)
        State.CompactMode = value
    end
)

SettingToggle(
    "Auto Open",
    "Open the interface automatically.",
    true,
    function(value)
        State.AutoOpen = value
    end
)

local Reset = Instance.new("TextButton")
Reset.Size = UDim2.new(1, 0, 0, 45)
Reset.BackgroundColor3 = Theme.Card
Reset.BorderSizePixel = 0
Reset.Text = "RESET SETTINGS"
Reset.Font = Enum.Font.GothamBold
Reset.TextSize = 10
Reset.TextColor3 = Theme.Muted
Reset.Parent = SettingsPage
Corner(Reset, 10)

Connect(Reset.MouseButton1Click, function()
    State.Animations = true
    State.Notifications = true
    State.CompactMode = false
    State.AutoOpen = true
    State.CurrentCategory = "All"
    State.Search = ""

    SearchBox.Text = ""

    ApplyTheme("Midnight")

    Notify(
        "Settings Reset",
        "Default settings restored.",
        "Success"
    )
end)

local About = Instance.new("TextLabel")
About.Size = UDim2.new(1, 0, 0, 60)
About.BackgroundTransparency = 1
About.Text = "CH3A5 HUB V2\nPremium Interface Framework • UI Build"
About.Font = Enum.Font.Gotham
About.TextSize = 10
About.TextColor3 = Theme.Muted
About.TextXAlignment = Enum.TextXAlignment.Center
About.Parent = SettingsPage

--==================================================
-- WINDOW SYSTEM
--==================================================

local OriginalSize = UDim2.fromOffset(900, 570)
local MinimizedSize = UDim2.fromOffset(900, 66)

Connect(Minimize.MouseButton1Click, function()
    State.Minimized = not State.Minimized

    if State.Minimized then
        Tween(Main, {
            Size = MinimizedSize
        }, 0.3)

        Sidebar.Visible = false
        Content.Visible = false

        Minimize.Text = "+"
    else
        Tween(Main, {
            Size = OriginalSize
        }, 0.3)

        task.delay(0.15, function()
            Sidebar.Visible = true
            Content.Visible = true
        end)

        Minimize.Text = "−"
    end
end)

--==================================================
-- FLOATING TOGGLE
--==================================================

local Floating = Instance.new("TextButton")
Floating.Name = "FloatingToggle"
Floating.AnchorPoint = Vector2.new(1, 1)
Floating.Position = UDim2.new(1, -20, 1, -20)
Floating.Size = UDim2.fromOffset(55, 55)
Floating.BackgroundColor3 = Theme.Accent
Floating.BorderSizePixel = 0
Floating.Text = "C3"
Floating.Font = Enum.Font.GothamBlack
Floating.TextSize = 14
Floating.TextColor3 = Color3.new(1, 1, 1)
Floating.Visible = false
Floating.ZIndex = 150
Floating.Parent = ScreenGui
Corner(Floating, 16)

Connect(Floating.MouseButton1Click, function()
    Floating.Visible = false
    Main.Visible = true
    State.Open = true

    Tween(Main, {
        Size = OriginalSize
    }, 0.3)
end)

Connect(Close.MouseButton1Click, function()
    State.Open = false

    Tween(Main, {
        Size = UDim2.fromOffset(0, 0)
    }, 0.25)

    task.delay(0.25, function()
        Main.Visible = false
        Floating.Visible = true
    end)
end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

Connect(Topbar.InputBegan, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position
    end
end)

Connect(Topbar.InputEnded, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
    end
end)

Connect(UserInputService.InputChanged, function(input)
    if not Dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = input.Position - DragStart

    local Camera = workspace.CurrentCamera
    local Viewport = Camera.ViewportSize

    local NewX =
        StartPosition.X.Offset + Delta.X

    local NewY =
        StartPosition.Y.Offset + Delta.Y

    local Size = Main.AbsoluteSize

    local MinX = -Viewport.X / 2 + 80
    local MaxX = Viewport.X / 2 - 80
    local MinY = -Viewport.Y / 2 + 45
    local MaxY = Viewport.Y / 2 - 45

    NewX = math.clamp(NewX, MinX, MaxX)
    NewY = math.clamp(NewY, MinY, MaxY)

    Main.Position = UDim2.new(
        0.5,
        NewX,
        0.5,
        NewY
    )
end)

--==================================================
-- RESPONSIVE SYSTEM
--==================================================

local function Responsive()
    local Camera = workspace.CurrentCamera
    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize
    local Width = Viewport.X
    local Height = Viewport.Y

    if Width <= 500 then

        Main.Size = UDim2.new(
            0.94,
            0,
            0.82,
            0
        )

        Sidebar.Size = UDim2.fromOffset(
            65,
            Main.AbsoluteSize.Y - 66
        )

        Content.Position =
            UDim2.fromOffset(65, 66)

        Content.Size =
            UDim2.new(1, -65, 1, -66)

        for _, data in pairs(NavButtons) do
            data.Label.Visible = false
        end

        Grid.CellSize =
            UDim2.new(1, 0, 0, 150)

    elseif Width <= 900 then

        Main.Size = UDim2.new(
            0.90,
            0,
            0.82,
            0
        )

        Sidebar.Size =
            UDim2.fromOffset(
                150,
                Main.AbsoluteSize.Y - 66
            )

        Content.Position =
            UDim2.fromOffset(150, 66)

        Content.Size =
            UDim2.new(1, -150, 1, -66)

        for _, data in pairs(NavButtons) do
            data.Label.Visible = true
        end

        Grid.CellSize =
            UDim2.new(1, 0, 0, 150)

    else

        Main.Size = OriginalSize

        Sidebar.Size =
            UDim2.fromOffset(
                185,
                Main.AbsoluteSize.Y - 66
            )

        Content.Position =
            UDim2.fromOffset(185, 66)

        Content.Size =
            UDim2.new(1, -185, 1, -66)

        for _, data in pairs(NavButtons) do
            data.Label.Visible = true
        end

        Grid.CellSize =
            UDim2.new(0.48, -6, 0, 150)
    end
end

Connect(
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),
    Responsive
)

--==================================================
-- INITIALIZATION
--==================================================

for page, object in pairs(Pages) do
    object.Visible = false
end

HomePage.Visible = true

NavButtons.Home.Active.Visible = true
NavButtons.Home.Label.TextColor3 = Theme.Text
NavButtons.Home.Icon.TextColor3 = Theme.Accent

RefreshCards()
Responsive()

--==================================================
-- SPLASH SCREEN
--==================================================

local Splash = Instance.new("Frame")
Splash.Name = "Splash"
Splash.Size = UDim2.fromScale(1, 1)
Splash.BackgroundColor3 = Theme.Background
Splash.ZIndex = 500
Splash.Parent = ScreenGui

local SplashLogo = Instance.new("TextLabel")
SplashLogo.AnchorPoint = Vector2.new(0.5, 0.5)
SplashLogo.Position = UDim2.fromScale(0.5, 0.42)
SplashLogo.Size = UDim2.fromOffset(250, 60)
SplashLogo.BackgroundTransparency = 1
SplashLogo.Text = "CH3A5"
SplashLogo.Font = Enum.Font.GothamBlack
SplashLogo.TextSize = 40
SplashLogo.TextColor3 = Theme.Accent
SplashLogo.ZIndex = 501
SplashLogo.Parent = Splash

local SplashSub = Instance.new("TextLabel")
SplashSub.AnchorPoint = Vector2.new(0.5, 0.5)
SplashSub.Position = UDim2.fromScale(0.5, 0.51)
SplashSub.Size = UDim2.fromOffset(250, 30)
SplashSub.BackgroundTransparency = 1
SplashSub.Text = "HUB V2 • INITIALIZING"
SplashSub.Font = Enum.Font.GothamMedium
SplashSub.TextSize = 10
SplashSub.TextColor3 = Theme.Muted
SplashSub.ZIndex = 501
SplashSub.Parent = Splash

local LoadingBar = Instance.new("Frame")
LoadingBar.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingBar.Position = UDim2.fromScale(0.5, 0.58)
LoadingBar.Size = UDim2.fromOffset(220, 4)
LoadingBar.BackgroundColor3 = Theme.Card
LoadingBar.BorderSizePixel = 0
LoadingBar.ZIndex = 501
LoadingBar.Parent = Splash
Corner(LoadingBar, 5)

local LoadingFill = Instance.new("Frame")
LoadingFill.Size = UDim2.new(0, 0, 1, 0)
LoadingFill.BackgroundColor3 = Theme.Accent
LoadingFill.BorderSizePixel = 0
LoadingFill.ZIndex = 502
LoadingFill.Parent = LoadingBar
Corner(LoadingFill, 5)

Tween(
    LoadingFill,
    {
        Size = UDim2.fromScale(1, 1)
    },
    1.2
)

task.wait(1.25)

Tween(
    Splash,
    {
        BackgroundTransparency = 1
    },
    0.35
)

Tween(
    SplashLogo,
    {
        TextTransparency = 1
    },
    0.25
)

Tween(
    SplashSub,
    {
        TextTransparency = 1
    },
    0.25
)

task.wait(0.4)

Splash:Destroy()

Notify(
    "CH3A5 HUB",
    "Interface loaded successfully.",
    "Success"
)

--==================================================
-- CLEANUP
--==================================================

ScreenGui.Destroying:Connect(function()
    for _, connection in ipairs(Connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    table.clear(Connections)
end)
