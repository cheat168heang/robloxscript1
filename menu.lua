--//==================================================
--// CH3A5 HUB V3
--// GUI SYSTEM REMAKE
--// Responsive • Safe Area • Themes • Accessibility
--//==================================================

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
    Name = "CH3A5 HUB",
    Version = "V3.0",
    Subtitle = "Premium Script Hub",

    DesktopWidth = 820,
    DesktopHeight = 520,

    TabletWidth = 720,
    TabletHeight = 480,

    MobileWidthScale = 0.94,
    MobileHeightScale = 0.90,

    MinWidth = 300,
    MinHeight = 360,

    AnimationTime = 0.22,
}

--==================================================
-- THEMES
--==================================================

local Themes = {

    Midnight = {
        Background = Color3.fromRGB(10, 11, 17),
        Sidebar = Color3.fromRGB(15, 16, 24),
        Topbar = Color3.fromRGB(17, 18, 27),
        Card = Color3.fromRGB(22, 23, 34),
        CardHover = Color3.fromRGB(30, 31, 45),
        Accent = Color3.fromRGB(125, 92, 255),
        AccentSoft = Color3.fromRGB(72, 55, 145),
        Text = Color3.fromRGB(245, 245, 255),
        Muted = Color3.fromRGB(150, 153, 170),
        Border = Color3.fromRGB(48, 48, 65),
        Success = Color3.fromRGB(55, 220, 125),
    },

    Discord = {
        Background = Color3.fromRGB(22, 24, 29),
        Sidebar = Color3.fromRGB(30, 32, 38),
        Topbar = Color3.fromRGB(35, 37, 43),
        Card = Color3.fromRGB(40, 42, 49),
        CardHover = Color3.fromRGB(50, 52, 60),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentSoft = Color3.fromRGB(55, 63, 150),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 182, 192),
        Border = Color3.fromRGB(65, 67, 76),
        Success = Color3.fromRGB(35, 210, 120),
    },

    GitHub = {
        Background = Color3.fromRGB(10, 14, 19),
        Sidebar = Color3.fromRGB(14, 18, 24),
        Topbar = Color3.fromRGB(18, 22, 28),
        Card = Color3.fromRGB(22, 27, 34),
        CardHover = Color3.fromRGB(30, 36, 44),
        Accent = Color3.fromRGB(46, 160, 67),
        AccentSoft = Color3.fromRGB(31, 100, 45),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158),
        Border = Color3.fromRGB(48, 54, 61),
        Success = Color3.fromRGB(46, 200, 100),
    },

    Spotify = {
        Background = Color3.fromRGB(10, 10, 10),
        Sidebar = Color3.fromRGB(16, 16, 16),
        Topbar = Color3.fromRGB(20, 20, 20),
        Card = Color3.fromRGB(27, 27, 27),
        CardHover = Color3.fromRGB(38, 38, 38),
        Accent = Color3.fromRGB(30, 215, 96),
        AccentSoft = Color3.fromRGB(25, 120, 60),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(170, 170, 170),
        Border = Color3.fromRGB(48, 48, 48),
        Success = Color3.fromRGB(30, 215, 96),
    },

    YouTube = {
        Background = Color3.fromRGB(12, 12, 12),
        Sidebar = Color3.fromRGB(18, 18, 18),
        Topbar = Color3.fromRGB(24, 24, 24),
        Card = Color3.fromRGB(30, 30, 30),
        CardHover = Color3.fromRGB(42, 42, 42),
        Accent = Color3.fromRGB(255, 45, 45),
        AccentSoft = Color3.fromRGB(140, 30, 30),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(52, 52, 52),
        Success = Color3.fromRGB(50, 210, 110),
    },

    Telegram = {
        Background = Color3.fromRGB(11, 19, 26),
        Sidebar = Color3.fromRGB(16, 27, 36),
        Topbar = Color3.fromRGB(20, 33, 44),
        Card = Color3.fromRGB(25, 40, 52),
        CardHover = Color3.fromRGB(34, 53, 67),
        Accent = Color3.fromRGB(42, 171, 238),
        AccentSoft = Color3.fromRGB(30, 105, 150),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(160, 180, 195),
        Border = Color3.fromRGB(48, 70, 84),
        Success = Color3.fromRGB(50, 215, 130),
    },

    Twitter = {
        Background = Color3.fromRGB(10, 12, 14),
        Sidebar = Color3.fromRGB(15, 17, 20),
        Topbar = Color3.fromRGB(20, 22, 25),
        Card = Color3.fromRGB(25, 28, 32),
        CardHover = Color3.fromRGB(34, 38, 43),
        Accent = Color3.fromRGB(29, 155, 240),
        AccentSoft = Color3.fromRGB(25, 100, 155),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(160, 170, 180),
        Border = Color3.fromRGB(48, 52, 58),
        Success = Color3.fromRGB(45, 215, 125),
    },

    Twitch = {
        Background = Color3.fromRGB(13, 11, 19),
        Sidebar = Color3.fromRGB(19, 16, 27),
        Topbar = Color3.fromRGB(24, 20, 33),
        Card = Color3.fromRGB(30, 25, 40),
        CardHover = Color3.fromRGB(42, 34, 55),
        Accent = Color3.fromRGB(145, 70, 255),
        AccentSoft = Color3.fromRGB(90, 45, 155),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 170, 195),
        Border = Color3.fromRGB(57, 48, 70),
        Success = Color3.fromRGB(50, 215, 130),
    },

    Dracula = {
        Background = Color3.fromRGB(24, 24, 37),
        Sidebar = Color3.fromRGB(32, 32, 47),
        Topbar = Color3.fromRGB(40, 42, 54),
        Card = Color3.fromRGB(44, 45, 58),
        CardHover = Color3.fromRGB(56, 57, 72),
        Accent = Color3.fromRGB(189, 147, 249),
        AccentSoft = Color3.fromRGB(115, 90, 155),
        Text = Color3.fromRGB(248, 248, 242),
        Muted = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(70, 70, 85),
        Success = Color3.fromRGB(80, 220, 150),
    },

    Ocean = {
        Background = Color3.fromRGB(5, 15, 24),
        Sidebar = Color3.fromRGB(8, 23, 35),
        Topbar = Color3.fromRGB(10, 29, 43),
        Card = Color3.fromRGB(13, 38, 55),
        CardHover = Color3.fromRGB(19, 53, 72),
        Accent = Color3.fromRGB(0, 190, 255),
        AccentSoft = Color3.fromRGB(0, 105, 150),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(145, 180, 195),
        Border = Color3.fromRGB(35, 75, 92),
        Success = Color3.fromRGB(50, 220, 160),
    },

    Crimson = {
        Background = Color3.fromRGB(18, 8, 11),
        Sidebar = Color3.fromRGB(27, 12, 16),
        Topbar = Color3.fromRGB(34, 15, 20),
        Card = Color3.fromRGB(43, 19, 25),
        CardHover = Color3.fromRGB(57, 24, 32),
        Accent = Color3.fromRGB(235, 55, 75),
        AccentSoft = Color3.fromRGB(145, 35, 48),
        Text = Color3.fromRGB(255, 240, 242),
        Muted = Color3.fromRGB(185, 155, 160),
        Border = Color3.fromRGB(72, 35, 42),
        Success = Color3.fromRGB(50, 220, 130),
    },

    Emerald = {
        Background = Color3.fromRGB(6, 16, 12),
        Sidebar = Color3.fromRGB(10, 25, 19),
        Topbar = Color3.fromRGB(13, 31, 24),
        Card = Color3.fromRGB(17, 40, 30),
        CardHover = Color3.fromRGB(23, 54, 40),
        Accent = Color3.fromRGB(40, 210, 130),
        AccentSoft = Color3.fromRGB(30, 120, 78),
        Text = Color3.fromRGB(235, 255, 245),
        Muted = Color3.fromRGB(145, 180, 160),
        Border = Color3.fromRGB(38, 78, 60),
        Success = Color3.fromRGB(50, 225, 140),
    },

    Angkor = {
        Background = Color3.fromRGB(17, 12, 8),
        Sidebar = Color3.fromRGB(27, 20, 13),
        Topbar = Color3.fromRGB(35, 26, 17),
        Card = Color3.fromRGB(42, 31, 20),
        CardHover = Color3.fromRGB(57, 42, 26),
        Accent = Color3.fromRGB(214, 157, 65),
        AccentSoft = Color3.fromRGB(130, 92, 38),
        Text = Color3.fromRGB(255, 245, 220),
        Muted = Color3.fromRGB(185, 160, 125),
        Border = Color3.fromRGB(78, 59, 35),
        Success = Color3.fromRGB(80, 210, 130),
    },
}

local CurrentTheme = Themes.Midnight

--==================================================
-- REDUCED MOTION
--==================================================

local ReducedMotion = false

pcall(function()
    local settings = UserSettings()
    local gameSettings = settings.GameSettings

    if gameSettings.ReducedMotion then
        ReducedMotion = true
    end
end)

local function Tween(instance, info, properties)
    if ReducedMotion then
        for property, value in pairs(properties) do
            instance[property] = value
        end
        return
    end

    return TweenService:Create(instance, info, properties)
end

local function PlayTween(instance, duration, properties)
    local tween = Tween(
        instance,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )

    if tween then
        tween:Play()
    end
end

--==================================================
-- SCRIPT LOADER
--==================================================

local function ExecuteScript(url)
    task.spawn(function()
        local success, source = pcall(function()
            return game:HttpGet(url)
        end)

        if not success or not source then
            warn("[CH3A5 HUB] Failed to download script")
            return
        end

        local runSuccess, err = pcall(function()
            local fn = loadstring(source)
            if fn then
                fn()
            end
        end)

        if not runSuccess then
            warn("[CH3A5 HUB] Script Error:", err)
        end
    end)
end

--==================================================
-- SCREEN GUI / SAFE AREA
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_HUB_V3"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = false

pcall(function()
    ScreenGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
end)

ScreenGui.Parent = PlayerGui

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1
MainStroke.Transparency = 0.35
MainStroke.Color = CurrentTheme.Accent
MainStroke.Parent = Main

local UIScale = Instance.new("UIScale")
UIScale.Scale = 1
UIScale.Parent = Main

local SizeConstraint = Instance.new("UISizeConstraint")
SizeConstraint.MinSize = Vector2.new(
    CONFIG.MinWidth,
    CONFIG.MinHeight
)
SizeConstraint.Parent = Main

--==================================================
-- TOPBAR
--==================================================

local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 62)
Topbar.BackgroundColor3 = CurrentTheme.Topbar
Topbar.BorderSizePixel = 0
Topbar.Parent = Main

local TopbarPadding = Instance.new("UIPadding")
TopbarPadding.PaddingLeft = UDim.new(0, 16)
TopbarPadding.PaddingRight = UDim.new(0, 10)
TopbarPadding.Parent = Topbar

-- Logo

local Logo = Instance.new("TextLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.fromOffset(42, 42)
Logo.Position = UDim2.fromOffset(0, 10)
Logo.BackgroundColor3 = CurrentTheme.Accent
Logo.Text = "C"
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 20
Logo.TextColor3 = CurrentTheme.Text
Logo.BorderSizePixel = 0
Logo.Parent = Topbar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 11)
LogoCorner.Parent = Logo

-- Title

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 180, 0, 24)
Title.Position = UDim2.fromOffset(54, 9)
Title.BackgroundTransparency = 1
Title.Text = CONFIG.Name
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = CurrentTheme.Text
Title.Parent = Topbar

local TitleConstraint = Instance.new("UITextSizeConstraint")
TitleConstraint.MinTextSize = 13
TitleConstraint.MaxTextSize = 18
TitleConstraint.Parent = Title

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(0, 180, 0, 18)
Subtitle.Position = UDim2.fromOffset(54, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = CONFIG.Subtitle
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.TextColor3 = CurrentTheme.Muted
Subtitle.Parent = Topbar

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.fromOffset(52, 22)
Version.Position = UDim2.fromOffset(225, 20)
Version.BackgroundColor3 = CurrentTheme.Card
Version.Text = CONFIG.Version
Version.Font = Enum.Font.GothamBold
Version.TextSize = 9
Version.TextColor3 = CurrentTheme.Accent
Version.Parent = Topbar

local VersionCorner = Instance.new("UICorner")
VersionCorner.CornerRadius = UDim.new(0, 6)
VersionCorner.Parent = Version

-- Online

local OnlineDot = Instance.new("Frame")
OnlineDot.Size = UDim2.fromOffset(7, 7)
OnlineDot.Position = UDim2.new(1, -190, 0.5, -3)
OnlineDot.BackgroundColor3 = CurrentTheme.Success
OnlineDot.BorderSizePixel = 0
OnlineDot.Parent = Topbar

local OnlineCorner = Instance.new("UICorner")
OnlineCorner.CornerRadius = UDim.new(1, 0)
OnlineCorner.Parent = OnlineDot

local OnlineText = Instance.new("TextLabel")
OnlineText.Size = UDim2.fromOffset(70, 22)
OnlineText.Position = UDim2.new(1, -178, 0.5, -11)
OnlineText.BackgroundTransparency = 1
OnlineText.Text = "ONLINE"
OnlineText.Font = Enum.Font.GothamBold
OnlineText.TextSize = 9
OnlineText.TextColor3 = CurrentTheme.Muted
OnlineText.TextXAlignment = Enum.TextXAlignment.Left
OnlineText.Parent = Topbar

-- Minimize

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(38, 38)
Minimize.Position = UDim2.new(1, -95, 0.5, -19)
Minimize.BackgroundColor3 = CurrentTheme.Card
Minimize.Text = "—"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 17
Minimize.TextColor3 = CurrentTheme.Text
Minimize.AutoButtonColor = false
Minimize.Parent = Topbar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 9)
MinCorner.Parent = Minimize

-- Close

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -48, 0.5, -19)
Close.BackgroundColor3 = CurrentTheme.Card
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 21
Close.TextColor3 = CurrentTheme.Text
Close.AutoButtonColor = false
Close.Parent = Topbar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 9)
CloseCorner.Parent = Close

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 190, 1, -62)
Sidebar.Position = UDim2.fromOffset(0, 62)
Sidebar.BackgroundColor3 = CurrentTheme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 14)
SidebarPadding.PaddingLeft = UDim.new(0, 12)
SidebarPadding.PaddingRight = UDim.new(0, 12)
SidebarPadding.PaddingBottom = UDim.new(0, 12)
SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 7)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -190, 1, -62)
Content.Position = UDim2.fromOffset(190, 62)
Content.BackgroundColor3 = CurrentTheme.Background
Content.BorderSizePixel = 0
Content.Parent = Main

local Pages = {}
local Tabs = {}
local CurrentPage

--==================================================
-- TEXT HELPER
--==================================================

local function ApplyTextConstraint(label, minSize, maxSize)
    local constraint = Instance.new("UITextSizeConstraint")
    constraint.MinTextSize = minSize
    constraint.MaxTextSize = maxSize
    constraint.Parent = label
end

--==================================================
-- PAGE SYSTEM
--==================================================

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")

    Page.Name = name
    Page.Size = UDim2.new(1, -28, 1, -28)
    Page.Position = UDim2.fromOffset(14, 14)

    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0

    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = CurrentTheme.Accent

    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y

    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.Visible = false

    Page.Parent = Content

    local Padding = Instance.new("UIPadding")
    Padding.PaddingBottom = UDim.new(0, 16)
    Padding.Parent = Page

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 12)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    Pages[name] = Page

    return Page
end

local HomePage = CreatePage("Home")
local KeylessPage = CreatePage("Keyless")
local KeyPage = CreatePage("Key")
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")

--==================================================
-- PAGE HEADER
--==================================================

local function AddPageHeader(Page, title, description)

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 70)
    Container.BackgroundTransparency = 1
    Container.Parent = Page

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 32)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 21
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextColor3 = CurrentTheme.Text
    Title.Parent = Container

    ApplyTextConstraint(Title, 16, 23)

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, 0, 0, 30)
    Desc.Position = UDim2.fromOffset(0, 34)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = CurrentTheme.Muted
    Desc.Parent = Container

    ApplyTextConstraint(Desc, 9, 13)

    return Container
end

--==================================================
-- UI HELPERS
--==================================================

local function AddSection(Page, text)

    local Label = Instance.new("TextLabel")

    Label.Size = UDim2.new(1, 0, 0, 32)
    Label.BackgroundTransparency = 1

    Label.Text = text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 15
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Text

    Label.Parent = Page

    ApplyTextConstraint(Label, 12, 17)

    return Label
end

local function AddInfo(Page, text)

    local Label = Instance.new("TextLabel")

    Label.Size = UDim2.new(1, 0, 0, 28)
    Label.BackgroundTransparency = 1

    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Muted

    Label.Parent = Page

    ApplyTextConstraint(Label, 9, 13)

    return Label
end

--==================================================
-- BUTTON FEEDBACK
--==================================================

local function SetupButtonFeedback(Button, NormalColor, HoverColor)

    Button.MouseEnter:Connect(function()

        if UserInputService.MouseEnabled then
            PlayTween(Button, 0.12, {
                BackgroundColor3 = HoverColor
            })
        end

    end)

    Button.MouseLeave:Connect(function()

        PlayTween(Button, 0.12, {
            BackgroundColor3 = NormalColor
        })

    end)

    Button.MouseButton1Down:Connect(function()

        PlayTween(Button, 0.08, {
            Size = Button.Size
        })

    end)
end

--==================================================
-- SCRIPT CARD
--==================================================

local function AddScriptButton(Page, name, description, url)

    local Button = Instance.new("TextButton")

    Button.Size = UDim2.new(1, 0, 0, 76)

    Button.BackgroundColor3 = CurrentTheme.Card
    Button.BorderSizePixel = 0

    Button.Text = ""
    Button.AutoButtonColor = false

    Button.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = CurrentTheme.Border
    Stroke.Transparency = 0.35
    Stroke.Thickness = 1
    Stroke.Parent = Button

    local Icon = Instance.new("Frame")
    Icon.Size = UDim2.fromOffset(42, 42)
    Icon.Position = UDim2.fromOffset(14, 17)
    Icon.BackgroundColor3 = CurrentTheme.AccentSoft
    Icon.BorderSizePixel = 0
    Icon.Parent = Button

    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 10)
    IconCorner.Parent = Icon

    local IconText = Instance.new("TextLabel")
    IconText.Size = UDim2.fromScale(1, 1)
    IconText.BackgroundTransparency = 1
    IconText.Text = "›"
    IconText.Font = Enum.Font.GothamBold
    IconText.TextSize = 20
    IconText.TextColor3 = CurrentTheme.Accent
    IconText.Parent = Icon

    local Name = Instance.new("TextLabel")

    Name.Size = UDim2.new(1, -90, 0, 25)
    Name.Position = UDim2.fromOffset(70, 13)

    Name.BackgroundTransparency = 1
    Name.Text = name

    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 14
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = CurrentTheme.Text

    Name.Parent = Button

    ApplyTextConstraint(Name, 11, 15)

    local Desc = Instance.new("TextLabel")

    Desc.Size = UDim2.new(1, -90, 0, 22)
    Desc.Position = UDim2.fromOffset(70, 39)

    Desc.BackgroundTransparency = 1
    Desc.Text = description

    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 10
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = CurrentTheme.Muted

    Desc.Parent = Button

    ApplyTextConstraint(Desc, 9, 12)

    SetupButtonFeedback(
        Button,
        CurrentTheme.Card,
        CurrentTheme.CardHover
    )

    Button.Activated:Connect(function()
        ExecuteScript(url)
    end)

    return Button
end

--==================================================
-- COMING SOON
--==================================================

local function AddComingSoon(Page, name, description)

    local Button = Instance.new("Frame")

    Button.Size = UDim2.new(1, 0, 0, 68)
    Button.BackgroundColor3 = CurrentTheme.Card
    Button.BorderSizePixel = 0
    Button.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Button

    local Text = Instance.new("TextLabel")

    Text.Size = UDim2.new(1, -30, 0, 25)
    Text.Position = UDim2.fromOffset(15, 10)

    Text.BackgroundTransparency = 1
    Text.Text = name .. "  •  COMING SOON"

    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 13
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.TextColor3 = CurrentTheme.Muted

    Text.Parent = Button

    ApplyTextConstraint(Text, 10, 14)

    local Desc = Instance.new("TextLabel")

    Desc.Size = UDim2.new(1, -30, 0, 20)
    Desc.Position = UDim2.fromOffset(15, 36)

    Desc.BackgroundTransparency = 1
    Desc.Text = description or "This feature will be available in a future update."

    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 10
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = CurrentTheme.Muted

    Desc.Parent = Button

    return Button
end

--==================================================
-- HOME
--==================================================

AddPageHeader(
    HomePage,
    "Welcome to CH3A5 HUB",
    "Premium script hub • V3 interface"
)

AddSection(HomePage, "Quick Access")

AddComingSoon(
    HomePage,
    "More Scripts",
    "Additional script categories are coming soon."
)

--==================================================
-- KEYLESS
--==================================================

AddSection(KeylessPage, "Keyless Scripts")
AddInfo(KeylessPage, "No key required.")

AddScriptButton(
    KeylessPage,
    "Sources Hub",
    "Keyless",
    "https://pastefy.app/Lk0vDMmN/raw"
)

AddScriptButton(
    KeylessPage,
    "Limbo Hub",
    "Keyless",
    "https://limbohub.my.id/loader.lua"
)

AddScriptButton(
    KeylessPage,
    "Virexx",
    "Keyless",
    "https://gist.githubusercontent.com/virexx55/b4e8b16201904da5ab7b554aa71c378f/raw/b9524b701b35ec97603ff0a32227b24461479c5c/virex.lua"
)

--==================================================
-- KEY
--==================================================

AddSection(KeyPage, "Key System Scripts")
AddInfo(KeyPage, "These scripts may require a key.")

AddScriptButton(
    KeyPage,
    "Wzeus Hub",
    "Key System",
    "https://raw.githubusercontent.com/Wzeus-NTH/Wzeusno1/main/Wzeus/nthzz"
)

AddScriptButton(
    KeyPage,
    "Pulse Hub",
    "Key System",
    "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua"
)


--==================================================
-- THEME PREVIEW
--==================================================

local function AddThemeButton(Page, ThemeName, ThemeData)

    local Button = Instance.new("TextButton")

    Button.Size = UDim2.new(1, 0, 0, 58)

    Button.BackgroundColor3 = ThemeData.Card
    Button.BorderSizePixel = 0

    Button.Text = ""
    Button.AutoButtonColor = false

    Button.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button

    local Preview = Instance.new("Frame")

    Preview.Size = UDim2.fromOffset(42, 42)
    Preview.Position = UDim2.fromOffset(8, 8)

    Preview.BackgroundColor3 = ThemeData.Background
    Preview.BorderSizePixel = 0
    Preview.Parent = Button

    local PreviewCorner = Instance.new("UICorner")
    PreviewCorner.CornerRadius = UDim.new(0, 9)
    PreviewCorner.Parent = Preview

    local PreviewAccent = Instance.new("Frame")

    PreviewAccent.Size = UDim2.fromOffset(18, 18)
    PreviewAccent.Position = UDim2.new(1, -23, 1, -23)

    PreviewAccent.BackgroundColor3 = ThemeData.Accent
    PreviewAccent.BorderSizePixel = 0
    PreviewAccent.Parent = Preview

    local PreviewAccentCorner = Instance.new("UICorner")
    PreviewAccentCorner.CornerRadius = UDim.new(1, 0)
    PreviewAccentCorner.Parent = PreviewAccent

    local Name = Instance.new("TextLabel")

    Name.Size = UDim2.new(1, -65, 1, 0)
    Name.Position = UDim2.fromOffset(60, 0)

    Name.BackgroundTransparency = 1
    Name.Text = ThemeName

    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 12
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = ThemeData.Text

    Name.Parent = Button

    ApplyTextConstraint(Name, 10, 14)

    Button.Activated:Connect(function()

        CurrentTheme = ThemeData

        local function ColorObject(Object, property, color)
            pcall(function()
                Object[property] = color
            end)
        end

        ColorObject(Main, "BackgroundColor3", ThemeData.Background)
        ColorObject(MainStroke, "Color", ThemeData.Accent)

        ColorObject(Topbar, "BackgroundColor3", ThemeData.Topbar)

        ColorObject(Sidebar, "BackgroundColor3", ThemeData.Sidebar)

        ColorObject(Content, "BackgroundColor3", ThemeData.Background)

        ColorObject(Logo, "BackgroundColor3", ThemeData.Accent)

        ColorObject(Version, "BackgroundColor3", ThemeData.Card)
        ColorObject(Version, "TextColor3", ThemeData.Accent)

        ColorObject(OnlineDot, "BackgroundColor3", ThemeData.Success)

        ColorObject(Minimize, "BackgroundColor3", ThemeData.Card)
        ColorObject(Close, "BackgroundColor3", ThemeData.Card)

        for _, Page in pairs(Pages) do
            Page.ScrollBarImageColor3 = ThemeData.Accent

            for _, Object in ipairs(Page:GetDescendants()) do

                if Object:IsA("TextLabel") then

                    if Object.Name == "Title"
                        or Object.Name == "Logo" then

                        ColorObject(
                            Object,
                            "TextColor3",
                            ThemeData.Text
                        )

                    end

                elseif Object:IsA("TextButton") then

                    ColorObject(
                        Object,
                        "BackgroundColor3",
                        ThemeData.Card
                    )

                elseif Object:IsA("UIStroke") then

                    ColorObject(
                        Object,
                        "Color",
                        ThemeData.Border
                    )

                end

            end
        end

        -- Rebuild all theme-sensitive UI colors
        for _, Object in ipairs(ScreenGui:GetDescendants()) do

            if Object:IsA("UIStroke") then
                Object.Color = ThemeData.Border
            end

        end

        MainStroke.Color = ThemeData.Accent

    end)

    return Button
end

--==================================================
-- THEMES
--==================================================

AddPageHeader(
    ThemesPage,
    "Themes",
    "Choose a visual style for CH3A5 HUB."
)

for ThemeName, ThemeData in pairs(Themes) do
    AddThemeButton(
        ThemesPage,
        ThemeName,
        ThemeData
    )
end

--==================================================
-- SETTINGS
--==================================================

AddPageHeader(
    SettingsPage,
    "Settings",
    "Customize your CH3A5 HUB interface."
)

AddComingSoon(
    SettingsPage,
    "Notifications",
    "Notification preferences."
)

AddComingSoon(
    SettingsPage,
    "Interface Customization",
    "Customize interface behavior."
)

AddComingSoon(
    SettingsPage,
    "Accessibility",
    "Accessibility controls."
)

--==================================================
-- SIDEBAR BUTTON
--==================================================

local ActiveIndicator

local function SelectTab(Button, Page)

    for _, Data in pairs(Tabs) do

        Data.Page.Visible = false

        PlayTween(
            Data.Button,
            0.12,
            {
                BackgroundColor3 = CurrentTheme.Sidebar
            }
        )

        Data.Icon.TextColor3 = CurrentTheme.Muted

    end

    Page.Visible = true

    PlayTween(
        Button,
        0.14,
        {
            BackgroundColor3 = CurrentTheme.Card
        }
    )

    local Data = Tabs[Button]

    if Data then
        Data.Icon.TextColor3 = CurrentTheme.Accent
    end

    CurrentPage = Page
end

local function AddTab(name, icon, page)

    local Button = Instance.new("TextButton")

    Button.Size = UDim2.new(1, 0, 0, 44)

    Button.BackgroundColor3 = CurrentTheme.Sidebar
    Button.BorderSizePixel = 0

    Button.Text = ""
    Button.AutoButtonColor = false

    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Button

    local Indicator = Instance.new("Frame")

    Indicator.Size = UDim2.fromOffset(3, 24)
    Indicator.Position = UDim2.fromOffset(0, 10)

    Indicator.BackgroundColor3 = CurrentTheme.Accent
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false

    Indicator.Parent = Button

    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator

    local Icon = Instance.new("TextLabel")

    Icon.Size = UDim2.fromOffset(32, 44)
    Icon.Position = UDim2.fromOffset(9, 0)

    Icon.BackgroundTransparency = 1
    Icon.Text = icon

    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 15
    Icon.TextColor3 = CurrentTheme.Muted

    Icon.Parent = Button

    local Label = Instance.new("TextLabel")

    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.fromOffset(47, 0)

    Label.BackgroundTransparency = 1
    Label.Text = name

    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Text

    Label.Parent = Button

    ApplyTextConstraint(Label, 9, 13)

    Tabs[Button] = {
        Button = Button,
        Page = page,
        Icon = Icon,
        Indicator = Indicator,
    }

    Button.MouseEnter:Connect(function()

        if CurrentPage ~= page then
            PlayTween(
                Button,
                0.12,
                {
                    BackgroundColor3 = CurrentTheme.Card
                }
            )
        end

    end)

    Button.MouseLeave:Connect(function()

        if CurrentPage ~= page then
            PlayTween(
                Button,
                0.12,
                {
                    BackgroundColor3 = CurrentTheme.Sidebar
                }
            )
        end

    end)

    Button.Activated:Connect(function()

        for _, Data in pairs(Tabs) do
            Data.Indicator.Visible = false
        end

        Indicator.Visible = true

        SelectTab(Button, page)

    end)

    return Button
end

local HomeTab = AddTab("Home", "⌂", HomePage)
local KeylessTab = AddTab("Keyless", "⚡", KeylessPage)
local KeyTab = AddTab("Key Scripts", "◆", KeyPage)
local ThemesTab = AddTab("Themes", "✦", ThemesPage)
local SettingsTab = AddTab("Settings", "⚙", SettingsPage)

--==================================================
-- MOBILE SIDEBAR
--==================================================

local SidebarOpen = true

local MobileMenu = Instance.new("TextButton")

MobileMenu.Size = UDim2.fromOffset(40, 40)
MobileMenu.Position = UDim2.fromOffset(10, 11)

MobileMenu.BackgroundColor3 = CurrentTheme.Card
MobileMenu.Text = "☰"

MobileMenu.Font = Enum.Font.GothamBold
MobileMenu.TextSize = 17
MobileMenu.TextColor3 = CurrentTheme.Text

MobileMenu.AutoButtonColor = false
MobileMenu.Visible = false

MobileMenu.Parent = Topbar

local MobileCorner = Instance.new("UICorner")
MobileCorner.CornerRadius = UDim.new(0, 9)
MobileCorner.Parent = MobileMenu

MobileMenu.Activated:Connect(function()

    SidebarOpen = not SidebarOpen

    if SidebarOpen then

        PlayTween(
            Sidebar,
            0.2,
            {
                Position = UDim2.fromOffset(0, 62)
            }
        )

    else

        PlayTween(
            Sidebar,
            0.2,
            {
                Position = UDim2.fromOffset(-205, 62)
            }
        )

    end
end)

--==================================================
-- DRAG V3
--==================================================

local Dragging = false
local DragStart
local StartPosition

local function IsInput(input)

    return input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
end

Topbar.InputBegan:Connect(function(input)

    if not IsInput(input) then
        return
    end

    if input.Target == Minimize
        or input.Target == Close
        or input.Target == MobileMenu then
        return
    end

    Dragging = true
    DragStart = input.Position
    StartPosition = Main.Position

end)

Topbar.InputEnded:Connect(function(input)

    if IsInput(input) then
        Dragging = false
    end

end)

local function ClampPosition(position)

    local Camera = workspace.CurrentCamera

    if not Camera then
        return position
    end

    local viewport = Camera.ViewportSize

    local absoluteSize = Main.AbsoluteSize

    local halfX = absoluteSize.X / 2
    local halfY = absoluteSize.Y / 2

    local minX = halfX
    local maxX = viewport.X - halfX

    local minY = halfY
    local maxY = viewport.Y - halfY

    local x = math.clamp(
        position.X.Offset,
        minX,
        math.max(minX, maxX)
    )

    local y = math.clamp(
        position.Y.Offset,
        minY,
        math.max(minY, maxY)
    )

    return UDim2.fromOffset(x, y)
end

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = input.Position - DragStart

    local NewPosition = UDim2.fromOffset(
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Offset + Delta.Y
    )

    Main.Position = ClampPosition(NewPosition)

end)

--==================================================
-- MINIMIZE V3
--==================================================

local Minimized = false

local SavedSize
local SavedPosition

Minimize.Activated:Connect(function()

    Minimized = not Minimized

    if Minimized then

        SavedSize = Main.Size
        SavedPosition = Main.Position

        Sidebar.Visible = false
        Content.Visible = false

        PlayTween(
            Main,
            CONFIG.AnimationTime,
            {
                Size = UDim2.new(
                    SavedSize.X.Scale,
                    SavedSize.X.Offset,
                    0,
                    62
                )
            }
        )

    else

        PlayTween(
            Main,
            CONFIG.AnimationTime,
            {
                Size = SavedSize
            }
        )

        Main.Position = SavedPosition

        task.delay(
            ReducedMotion and 0 or CONFIG.AnimationTime,
            function()

                if not Minimized then
                    Sidebar.Visible = true
                    Content.Visible = true
                end

            end
        )

    end

end)

--==================================================
-- CLOSE V3
--==================================================

local Connections = {}

local function TrackConnection(connection)
    table.insert(Connections, connection)
    return connection
end

Close.Activated:Connect(function()

    PlayTween(
        Main,
        0.2,
        {
            Size = UDim2.fromOffset(20, 20)
        }
    )

    PlayTween(
        Main,
        0.2,
        {
            BackgroundTransparency = 1
        }
    )

    task.delay(
        ReducedMotion and 0 or 0.22,
        function()

            for _, connection in ipairs(Connections) do
                pcall(function()
                    connection:Disconnect()
                end)
            end

            if ScreenGui then
                ScreenGui:Destroy()
            end

        end
    )

end)

--==================================================
-- RESPONSIVE ENGINE
--==================================================

local LastLayout = ""

local function UpdateResponsive()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize

    local Width = Viewport.X
    local Height = Viewport.Y

    local IsPortrait = Height > Width

    local LayoutType

    if Width < 600 then
        LayoutType = "Mobile"
    elseif Width < 900 then
        LayoutType = "Tablet"
    else
        LayoutType = "Desktop"
    end

    if LayoutType == LastLayout
        and not IsPortrait then
        return
    end

    LastLayout = LayoutType

    if LayoutType == "Mobile" then

        Main.Size = UDim2.new(
            CONFIG.MobileWidthScale,
            0,
            CONFIG.MobileHeightScale,
            0
        )

        Sidebar.Visible = false
        MobileMenu.Visible = true

        Content.Size = UDim2.new(
            1,
            0,
            1,
            -62
        )

        Content.Position = UDim2.fromOffset(0, 62)

    elseif LayoutType == "Tablet" then

        Main.Size = UDim2.fromOffset(
            CONFIG.TabletWidth,
            CONFIG.TabletHeight
        )

        Sidebar.Visible = true
        MobileMenu.Visible = false

        Content.Size = UDim2.new(
            1,
            -190,
            1,
            -62
        )

        Content.Position = UDim2.fromOffset(190, 62)

    else

        Main.Size = UDim2.fromOffset(
            CONFIG.DesktopWidth,
            CONFIG.DesktopHeight
        )

        Sidebar.Visible = true
        MobileMenu.Visible = false

        Content.Size = UDim2.new(
            1,
            -190,
            1,
            -62
        )

        Content.Position = UDim2.fromOffset(190, 62)

    end

    -- Portrait adjustment

    if IsPortrait and LayoutType == "Mobile" then

        Main.Size = UDim2.new(
            0.94,
            0,
            0.88,
            0
        )

    end

    Main.Position = ClampPosition(
        UDim2.fromOffset(
            Width / 2,
            Height / 2
        )
    )

end

--==================================================
-- VIEWPORT CONNECTION
--==================================================

local function ConnectViewport()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    TrackConnection(
        Camera:GetPropertyChangedSignal(
            "ViewportSize"
        ):Connect(UpdateResponsive)
    )

end

ConnectViewport()

--==================================================
-- INITIAL STATE
--==================================================

HomePage.Visible = true
CurrentPage = HomePage

Tabs[HomeTab].Indicator.Visible = true
Tabs[HomeTab].Button.BackgroundColor3 = CurrentTheme.Card
Tabs[HomeTab].Icon.TextColor3 = CurrentTheme.Accent

UpdateResponsive()

--==================================================
-- FINAL
--==================================================

print("[CH3A5 HUB V3] Loaded successfully")
