--//==================================================
--// CH3A5 HUB V3
--// PROFESSIONAL GUI ENGINE
--// GUI ONLY / ROBLOX STUDIO SAFE
--//==================================================

if not game:IsLoaded() then
    game.Loaded:Wait()
end

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local VERSION = "V3.1"

local CONFIG = {
    DesktopWidth = 720,
    DesktopHeight = 460,

    TabletWidth = 680,
    TabletHeight = 450,

    MobileWidthScale = 0.94,
    MobileHeightScale = 0.88,

    MinWidth = 300,
    MinHeight = 300,

    MaxWidth = 1100,
    MaxHeight = 750,

    AnimationTime = 0.20,

    CornerRadius = 14,

    SidebarDesktop = 170,
    SidebarMobile = 62,

    TopbarDesktop = 58,
    TopbarMobile = 58,

    FloatingSize = 50,
}

--==================================================
-- REDUCED MOTION
--==================================================

local ReducedMotion = false

pcall(function()
    ReducedMotion = GuiService.ReducedMotionEnabled
end)

local function GetTweenTime(Time)
    if ReducedMotion then
        return 0
    end

    return Time
end

local function Tween(Object, Time, Properties, Style, Direction)

    if not Object then
        return nil
    end

    local Duration = GetTweenTime(Time)

    if Duration <= 0 then

        for Property, Value in pairs(Properties) do
            pcall(function()
                Object[Property] = Value
            end)
        end

        return nil
    end

    return TweenService:Create(
        Object,
        TweenInfo.new(
            Duration,
            Style or Enum.EasingStyle.Quad,
            Direction or Enum.EasingDirection.Out
        ),
        Properties
    )
end

local function PlayTween(Object, Time, Properties, Style, Direction)

    local Animation = Tween(
        Object,
        Time,
        Properties,
        Style,
        Direction
    )

    if Animation then
        Animation:Play()
    end

    return Animation
end

--==================================================
-- THEMES
--==================================================

local Themes = {

    Midnight = {
        Background = Color3.fromRGB(11, 12, 18),
        Surface = Color3.fromRGB(19, 20, 29),
        Surface2 = Color3.fromRGB(27, 28, 40),
        Accent = Color3.fromRGB(124, 92, 255),
        Text = Color3.fromRGB(245, 245, 255),
        Muted = Color3.fromRGB(145, 148, 165),
        Border = Color3.fromRGB(124, 92, 255),
    },

    Discord = {
        Background = Color3.fromRGB(25, 27, 31),
        Surface = Color3.fromRGB(32, 34, 39),
        Surface2 = Color3.fromRGB(42, 44, 52),
        Accent = Color3.fromRGB(88, 101, 242),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 182, 192),
        Border = Color3.fromRGB(88, 101, 242),
    },

    GitHub = {
        Background = Color3.fromRGB(13, 17, 23),
        Surface = Color3.fromRGB(22, 27, 34),
        Surface2 = Color3.fromRGB(30, 36, 44),
        Accent = Color3.fromRGB(46, 160, 67),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158),
        Border = Color3.fromRGB(46, 160, 67),
    },

    Spotify = {
        Background = Color3.fromRGB(12, 12, 12),
        Surface = Color3.fromRGB(24, 24, 24),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(30, 215, 96),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(170, 170, 170),
        Border = Color3.fromRGB(30, 215, 96),
    },

    YouTube = {
        Background = Color3.fromRGB(15, 15, 15),
        Surface = Color3.fromRGB(30, 30, 30),
        Surface2 = Color3.fromRGB(43, 43, 43),
        Accent = Color3.fromRGB(255, 45, 45),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(255, 45, 45),
    },

    Telegram = {
        Background = Color3.fromRGB(15, 23, 30),
        Surface = Color3.fromRGB(25, 38, 50),
        Surface2 = Color3.fromRGB(32, 49, 64),
        Accent = Color3.fromRGB(42, 171, 238),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(160, 180, 195),
        Border = Color3.fromRGB(42, 171, 238),
    },

    Twitter = {
        Background = Color3.fromRGB(10, 10, 10),
        Surface = Color3.fromRGB(24, 24, 24),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(29, 155, 240),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(160, 170, 180),
        Border = Color3.fromRGB(29, 155, 240),
    },

    Twitch = {
        Background = Color3.fromRGB(14, 12, 20),
        Surface = Color3.fromRGB(25, 22, 35),
        Surface2 = Color3.fromRGB(36, 31, 48),
        Accent = Color3.fromRGB(145, 70, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 170, 195),
        Border = Color3.fromRGB(145, 70, 255),
    },

    Dracula = {
        Background = Color3.fromRGB(24, 24, 37),
        Surface = Color3.fromRGB(40, 42, 54),
        Surface2 = Color3.fromRGB(50, 52, 66),
        Accent = Color3.fromRGB(189, 147, 249),
        Text = Color3.fromRGB(248, 248, 242),
        Muted = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(189, 147, 249),
    },

    Ocean = {
        Background = Color3.fromRGB(7, 18, 28),
        Surface = Color3.fromRGB(12, 32, 48),
        Surface2 = Color3.fromRGB(18, 45, 64),
        Accent = Color3.fromRGB(0, 190, 255),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(145, 180, 195),
        Border = Color3.fromRGB(0, 190, 255),
    },

    Crimson = {
        Background = Color3.fromRGB(20, 10, 12),
        Surface = Color3.fromRGB(35, 16, 20),
        Surface2 = Color3.fromRGB(48, 21, 27),
        Accent = Color3.fromRGB(235, 55, 75),
        Text = Color3.fromRGB(255, 240, 242),
        Muted = Color3.fromRGB(185, 155, 160),
        Border = Color3.fromRGB(235, 55, 75),
    },

    Emerald = {
        Background = Color3.fromRGB(8, 18, 14),
        Surface = Color3.fromRGB(14, 32, 25),
        Surface2 = Color3.fromRGB(20, 44, 34),
        Accent = Color3.fromRGB(40, 210, 130),
        Text = Color3.fromRGB(235, 255, 245),
        Muted = Color3.fromRGB(145, 180, 160),
        Border = Color3.fromRGB(40, 210, 130),
    },

    Angkor = {
        Background = Color3.fromRGB(18, 14, 10),
        Surface = Color3.fromRGB(35, 27, 18),
        Surface2 = Color3.fromRGB(48, 37, 24),
        Accent = Color3.fromRGB(214, 157, 65),
        Text = Color3.fromRGB(255, 245, 220),
        Muted = Color3.fromRGB(185, 160, 125),
        Border = Color3.fromRGB(214, 157, 65),
    },
}

local CurrentTheme = Themes.Midnight

--==================================================
-- CONNECTION MANAGER
--==================================================

local Connections = {}

local function Connect(Connection)
    table.insert(Connections, Connection)
    return Connection
end

local function DisconnectAll()

    for _, Connection in ipairs(Connections) do

        pcall(function()
            Connection:Disconnect()
        end)

    end

    table.clear(Connections)
end

--==================================================
-- SAFE ACTION PLACEHOLDER
--==================================================

local function ExecuteScript(url)

    -- GUI ONLY
    -- Add your own Studio-safe ModuleScript
    -- callback here if needed.

    warn(
        "[CH3A5 HUB]",
        "Selected:",
        tostring(url)
    )

end

--==================================================
-- REMOVE OLD GUI
--==================================================

local OldGUI = PlayerGui:FindFirstChild("CH3A5_HUB")

if OldGUI then
    OldGUI:Destroy()
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "CH3A5_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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

Main.Size = UDim2.fromOffset(
    CONFIG.DesktopWidth,
    CONFIG.DesktopHeight
)

Main.Position = UDim2.fromScale(
    0.5,
    0.5
)

Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(
    0,
    CONFIG.CornerRadius
)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")

MainStroke.Color = CurrentTheme.Border
MainStroke.Transparency = 0.58
MainStroke.Thickness = 1

MainStroke.Parent = Main

local MainConstraint = Instance.new("UISizeConstraint")

MainConstraint.MinSize = Vector2.new(
    CONFIG.MinWidth,
    CONFIG.MinHeight
)

MainConstraint.MaxSize = Vector2.new(
    CONFIG.MaxWidth,
    CONFIG.MaxHeight
)

MainConstraint.Parent = Main

local MainScale = Instance.new("UIScale")
MainScale.Scale = 1
MainScale.Parent = Main

--==================================================
-- TOPBAR
--==================================================

local Topbar = Instance.new("Frame")

Topbar.Name = "Topbar"

Topbar.Size = UDim2.new(
    1,
    0,
    0,
    CONFIG.TopbarDesktop
)

Topbar.BackgroundColor3 = CurrentTheme.Surface
Topbar.BorderSizePixel = 0

Topbar.Parent = Main

--==================================================
-- TOPBAR SEPARATOR
--==================================================

local TopbarLine = Instance.new("Frame")

TopbarLine.Size = UDim2.new(
    1,
    -24,
    0,
    1
)

TopbarLine.Position = UDim2.new(
    0,
    12,
    1,
    -1
)

TopbarLine.BackgroundColor3 = CurrentTheme.Border
TopbarLine.BackgroundTransparency = 0.85
TopbarLine.BorderSizePixel = 0

TopbarLine.Parent = Topbar

--==================================================
-- LOGO
--==================================================

local Logo = Instance.new("TextLabel")

Logo.Name = "Logo"

Logo.Size = UDim2.fromOffset(
    40,
    40
)

Logo.Position = UDim2.fromOffset(
    10,
    9
)

Logo.BackgroundColor3 = CurrentTheme.Accent

Logo.Text = "C5"
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 14
Logo.TextColor3 = CurrentTheme.Text

Logo.BorderSizePixel = 0

Logo.Parent = Topbar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 11)
LogoCorner.Parent = Logo

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")

Title.Name = "Title"

Title.Size = UDim2.new(
    1,
    -280,
    0,
    23
)

Title.Position = UDim2.fromOffset(
    60,
    7
)

Title.BackgroundTransparency = 1

Title.Text = "CH3A5 HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = CurrentTheme.Text

Title.Parent = Topbar

local TitleConstraint = Instance.new("UITextSizeConstraint")

TitleConstraint.MinTextSize = 13
TitleConstraint.MaxTextSize = 20

TitleConstraint.Parent = Title

--==================================================
-- SUBTITLE
--==================================================

local Subtitle = Instance.new("TextLabel")

Subtitle.Name = "Subtitle"

Subtitle.Size = UDim2.new(
    1,
    -280,
    0,
    18
)

Subtitle.Position = UDim2.fromOffset(
    60,
    30
)

Subtitle.BackgroundTransparency = 1

Subtitle.Text = "Premium interface  •  Fast  •  Responsive"

Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 9

Subtitle.TextXAlignment =
    Enum.TextXAlignment.Left

Subtitle.TextColor3 =
    CurrentTheme.Muted

Subtitle.Parent = Topbar

--==================================================
-- VERSION
--==================================================

local VersionBadge = Instance.new("TextLabel")

VersionBadge.Name = "Version"

VersionBadge.Size = UDim2.fromOffset(
    46,
    23
)

VersionBadge.Position = UDim2.new(
    1,
    -262,
    0,
    17
)

VersionBadge.BackgroundColor3 =
    CurrentTheme.Background

VersionBadge.Text = VERSION

VersionBadge.Font =
    Enum.Font.GothamBold

VersionBadge.TextSize = 8

VersionBadge.TextColor3 =
    CurrentTheme.Accent

VersionBadge.Parent = Topbar

local VersionCorner = Instance.new("UICorner")

VersionCorner.CornerRadius =
    UDim.new(0, 7)

VersionCorner.Parent =
    VersionBadge

--==================================================
-- ONLINE
--==================================================

local Online = Instance.new("TextLabel")

Online.Name = "Online"

Online.Size = UDim2.fromOffset(
    68,
    23
)

Online.Position = UDim2.new(
    1,
    -210,
    0,
    17
)

Online.BackgroundTransparency = 1

Online.Text = "● Online"

Online.Font =
    Enum.Font.GothamMedium

Online.TextSize = 9

Online.TextColor3 =
    CurrentTheme.Accent

Online.Parent = Topbar

--==================================================
-- HIDE BUTTON
--==================================================

local HideButton = Instance.new("TextButton")

HideButton.Name = "Hide"

HideButton.Size = UDim2.fromOffset(
    54,
    27
)

HideButton.Position = UDim2.new(
    1,
    -143,
    0,
    15
)

HideButton.BackgroundColor3 =
    CurrentTheme.Background

HideButton.BorderSizePixel = 0

HideButton.Text = "HIDE"

HideButton.Font =
    Enum.Font.GothamBold

HideButton.TextSize = 8

HideButton.TextColor3 =
    CurrentTheme.Muted

HideButton.AutoButtonColor = false

HideButton.Parent = Topbar

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 8)
HideCorner.Parent = HideButton

local HideStroke = Instance.new("UIStroke")

HideStroke.Color =
    CurrentTheme.Border

HideStroke.Transparency = 0.72

HideStroke.Thickness = 1

HideStroke.Parent = HideButton

--==================================================
-- MINIMIZE
--==================================================

local Minimize = Instance.new("TextButton")

Minimize.Name = "Minimize"

Minimize.Size = UDim2.fromOffset(
    32,
    32
)

Minimize.Position = UDim2.new(
    1,
    -85,
    0,
    12
)

Minimize.BackgroundTransparency = 1

Minimize.Text = "—"

Minimize.Font =
    Enum.Font.GothamBold

Minimize.TextSize = 18

Minimize.TextColor3 =
    CurrentTheme.Text

Minimize.AutoButtonColor = false

Minimize.Parent = Topbar

--==================================================
-- CLOSE
--==================================================

local Close = Instance.new("TextButton")

Close.Name = "Close"

Close.Size = UDim2.fromOffset(
    32,
    32
)

Close.Position = UDim2.new(
    1,
    -40,
    0,
    12
)

Close.BackgroundTransparency = 1

Close.Text = "×"

Close.Font =
    Enum.Font.GothamBold

Close.TextSize = 22

Close.TextColor3 =
    CurrentTheme.Text

Close.AutoButtonColor = false

Close.Parent = Topbar

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")

Sidebar.Name = "Sidebar"

Sidebar.Size = UDim2.new(
    0,
    CONFIG.SidebarDesktop,
    1,
    -CONFIG.TopbarDesktop
)

Sidebar.Position = UDim2.fromOffset(
    0,
    CONFIG.TopbarDesktop
)

Sidebar.BackgroundColor3 =
    CurrentTheme.Surface

Sidebar.BorderSizePixel = 0

Sidebar.Parent = Main

local SidebarPadding = Instance.new("UIPadding")

SidebarPadding.PaddingTop =
    UDim.new(0, 14)

SidebarPadding.PaddingLeft =
    UDim.new(0, 10)

SidebarPadding.PaddingRight =
    UDim.new(0, 10)

SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")

SidebarLayout.Padding =
    UDim.new(0, 6)

SidebarLayout.SortOrder =
    Enum.SortOrder.LayoutOrder

SidebarLayout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")

Content.Name = "Content"

Content.Size = UDim2.new(
    1,
    -CONFIG.SidebarDesktop,
    1,
    -CONFIG.TopbarDesktop
)

Content.Position = UDim2.fromOffset(
    CONFIG.SidebarDesktop,
    CONFIG.TopbarDesktop
)

Content.BackgroundColor3 =
    CurrentTheme.Background

Content.BorderSizePixel = 0

Content.Parent = Main

--==================================================
-- PAGE SYSTEM
--==================================================

local Pages = {}
local Tabs = {}

local CurrentPage = nil

local function CreatePage(
    Name,
    PageTitle,
    PageSubtitle
)

    local Page = Instance.new("ScrollingFrame")

    Page.Name = Name

    Page.Size = UDim2.new(
        1,
        -24,
        1,
        -24
    )

    Page.Position = UDim2.fromOffset(
        12,
        12
    )

    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0

    Page.ScrollBarThickness = 3

    Page.ScrollBarImageColor3 =
        CurrentTheme.Accent

    Page.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Page.CanvasSize =
        UDim2.new()

    Page.ScrollingDirection =
        Enum.ScrollingDirection.Y

    Page.Visible = false

    Page.Parent = Content

    local Padding = Instance.new("UIPadding")

    Padding.PaddingBottom =
        UDim.new(0, 16)

    Padding.Parent = Page

    local Layout = Instance.new("UIListLayout")

    Layout.Padding =
        UDim.new(0, 9)

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Parent = Page

    -- Header

    local Header = Instance.new("Frame")

    Header.Size = UDim2.new(
        1,
        0,
        0,
        58
    )

    Header.BackgroundTransparency = 1

    Header.LayoutOrder = -100

    Header.Parent = Page

    local HeaderTitle = Instance.new("TextLabel")

    HeaderTitle.Size =
        UDim2.new(1, 0, 0, 29)

    HeaderTitle.BackgroundTransparency = 1

    HeaderTitle.Text = PageTitle

    HeaderTitle.Font =
        Enum.Font.GothamBold

    HeaderTitle.TextSize = 19

    HeaderTitle.TextXAlignment =
        Enum.TextXAlignment.Left

    HeaderTitle.TextColor3 =
        CurrentTheme.Text

    HeaderTitle.Parent = Header

    local HeaderSubtitle = Instance.new("TextLabel")

    HeaderSubtitle.Size =
        UDim2.new(1, 0, 0, 20)

    HeaderSubtitle.Position =
        UDim2.fromOffset(0, 31)

    HeaderSubtitle.BackgroundTransparency = 1

    HeaderSubtitle.Text =
        PageSubtitle

    HeaderSubtitle.Font =
        Enum.Font.Gotham

    HeaderSubtitle.TextSize = 10

    HeaderSubtitle.TextXAlignment =
        Enum.TextXAlignment.Left

    HeaderSubtitle.TextColor3 =
        CurrentTheme.Muted

    HeaderSubtitle.Parent = Header

    Pages[Name] = Page

    return Page
end

local HomePage = CreatePage(
    "Home",
    "Welcome to CH3A5 HUB",
    "Premium interface • Fast • Responsive"
)

local KeylessPage = CreatePage(
    "Keyless",
    "Keyless Scripts",
    "No key required."
)

local KeyPage = CreatePage(
    "Key",
    "Key System Scripts",
    "These scripts may require a key."
)

local ThemesPage = CreatePage(
    "Themes",
    "Themes",
    "Customize your interface."
)

local SettingsPage = CreatePage(
    "Settings",
    "Settings",
    "Manage your interface."
)

--==================================================
-- THEME REGISTRY
--==================================================

local ThemeObjects = {}

local function RegisterTheme(
    Object,
    Property,
    Key
)

    table.insert(
        ThemeObjects,
        {
            Object = Object,
            Property = Property,
            Key = Key
        }
    )

end

--==================================================
-- SECTION
--==================================================

local function AddSection(Page, Text)

    local Label = Instance.new("TextLabel")

    Label.Size =
        UDim2.new(1, 0, 0, 28)

    Label.BackgroundTransparency = 1

    Label.Text = Text

    Label.Font =
        Enum.Font.GothamBold

    Label.TextSize = 15

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.TextColor3 =
        CurrentTheme.Text

    Label.Parent = Page

    RegisterTheme(
        Label,
        "TextColor3",
        "Text"
    )

    return Label
end

--==================================================
-- INFO
--==================================================

local function AddInfo(Page, Text)

    local Label = Instance.new("TextLabel")

    Label.Size =
        UDim2.new(1, 0, 0, 26)

    Label.BackgroundTransparency = 1

    Label.Text = Text

    Label.Font =
        Enum.Font.Gotham

    Label.TextSize = 11

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.TextColor3 =
        CurrentTheme.Muted

    Label.Parent = Page

    RegisterTheme(
        Label,
        "TextColor3",
        "Muted"
    )

    return Label
end

--==================================================
-- SCRIPT CARD
--==================================================

local function AddScriptButton(
    Page,
    NameText,
    Description,
    Identifier
)

    local Button = Instance.new("TextButton")

    Button.Size =
        UDim2.new(1, 0, 0, 68)

    Button.BackgroundColor3 =
        CurrentTheme.Surface

    Button.BorderSizePixel = 0

    Button.Text = ""

    Button.AutoButtonColor = false

    Button.Selectable = true

    Button.Parent = Page

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, 12)

    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")

    Stroke.Color =
        CurrentTheme.Border

    Stroke.Transparency = 0.84

    Stroke.Thickness = 1

    Stroke.Parent = Button

    local Accent = Instance.new("Frame")

    Accent.Size =
        UDim2.fromOffset(3, 30)

    Accent.Position =
        UDim2.fromOffset(10, 19)

    Accent.BackgroundColor3 =
        CurrentTheme.Accent

    Accent.BorderSizePixel = 0

    Accent.Parent = Button

    local AccentCorner = Instance.new("UICorner")

    AccentCorner.CornerRadius =
        UDim.new(1, 0)

    AccentCorner.Parent = Accent

    local Name = Instance.new("TextLabel")

    Name.Size =
        UDim2.new(1, -80, 0, 24)

    Name.Position =
        UDim2.fromOffset(25, 8)

    Name.BackgroundTransparency = 1

    Name.Text = NameText

    Name.Font =
        Enum.Font.GothamBold

    Name.TextSize = 13

    Name.TextXAlignment =
        Enum.TextXAlignment.Left

    Name.TextColor3 =
        CurrentTheme.Text

    Name.Parent = Button

    local Description = Instance.new("TextLabel")

    Description.Size =
        UDim2.new(1, -80, 0, 20)

    Description.Position =
        UDim2.fromOffset(25, 34)

    Description.BackgroundTransparency = 1

    Description.Text = Description

    Description.Font =
        Enum.Font.Gotham

    Description.TextSize = 10

    Description.TextXAlignment =
        Enum.TextXAlignment.Left

    Description.TextColor3 =
        CurrentTheme.Muted

    Description.Parent = Button

    local Arrow = Instance.new("TextLabel")

    Arrow.Size =
        UDim2.fromOffset(30, 30)

    Arrow.Position =
        UDim2.new(1, -40, 0.5, -15)

    Arrow.BackgroundTransparency = 1

    Arrow.Text = "›"

    Arrow.Font =
        Enum.Font.GothamBold

    Arrow.TextSize = 22

    Arrow.TextColor3 =
        CurrentTheme.Muted

    Arrow.Parent = Button

    RegisterTheme(
        Button,
        "BackgroundColor3",
        "Surface"
    )

    RegisterTheme(
        Stroke,
        "Color",
        "Border"
    )

    RegisterTheme(
        Name,
        "TextColor3",
        "Text"
    )

    RegisterTheme(
        Description,
        "TextColor3",
        "Muted"
    )

    RegisterTheme(
        Arrow,
        "TextColor3",
        "Muted"
    )

    Connect(
        Button.MouseEnter:Connect(
            function()

                if UserInputService.TouchEnabled then
                    return
                end

                PlayTween(
                    Button,
                    0.16,
                    {
                        BackgroundColor3 =
                            CurrentTheme.Surface2
                    }
                )

                PlayTween(
                    Stroke,
                    0.16,
                    {
                        Transparency = 0.35
                    }
                )

                PlayTween(
                    Arrow,
                    0.16,
                    {
                        TextColor3 =
                            CurrentTheme.Accent,
                        Position =
                            UDim2.new(
                                1,
                                -37,
                                0.5,
                                -15
                            )
                    }
                )

            end
        )
    )

    Connect(
        Button.MouseLeave:Connect(
            function()

                PlayTween(
                    Button,
                    0.16,
                    {
                        BackgroundColor3 =
                            CurrentTheme.Surface
                    }
                )

                PlayTween(
                    Stroke,
                    0.16,
                    {
                        Transparency = 0.84
                    }
                )

                PlayTween(
                    Arrow,
                    0.16,
                    {
                        TextColor3 =
                            CurrentTheme.Muted,
                        Position =
                            UDim2.new(
                                1,
                                -40,
                                0.5,
                                -15
                            )
                    }
                )

            end
        )
    )

    Connect(
        Button.Activated:Connect(
            function()

                PlayTween(
                    Button,
                    0.08,
                    {
                        BackgroundColor3 =
                            CurrentTheme.Accent
                    }
                )

                task.delay(
                    GetTweenTime(0.08),
                    function()

                        if Button.Parent then

                            PlayTween(
                                Button,
                                0.14,
                                {
                                    BackgroundColor3 =
                                        CurrentTheme.Surface
                                }
                            )

                        end

                    end
                )

                ExecuteScript(Identifier)

            end
        )
    )

    return Button
end

--==================================================
-- COMING SOON
--==================================================

local function AddComingSoon(
    Page,
    NameText
)

    local Button = Instance.new("TextButton")

    Button.Size =
        UDim2.new(1, 0, 0, 56)

    Button.BackgroundColor3 =
        CurrentTheme.Surface

    Button.BorderSizePixel = 0

    Button.Text =
        "  " .. NameText ..
        "                         SOON"

    Button.Font =
        Enum.Font.GothamBold

    Button.TextSize = 10

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.TextColor3 =
        CurrentTheme.Muted

    Button.AutoButtonColor = false

    Button.Parent = Page

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, 11)

    Corner.Parent = Button

    RegisterTheme(
        Button,
        "BackgroundColor3",
        "Surface"
    )

    RegisterTheme(
        Button,
        "TextColor3",
        "Muted"
    )

    return Button
end

--==================================================
-- HOME
--==================================================

AddSection(
    HomePage,
    "Dashboard"
)

AddInfo(
    HomePage,
    "Choose a section from the sidebar to continue."
)

AddComingSoon(
    HomePage,
    "More Scripts"
)

--==================================================
-- KEYLESS
--==================================================

AddSection(
    KeylessPage,
    "Available Scripts"
)

AddInfo(
    KeylessPage,
    "Scripts that do not require a key."
)

AddScriptButton(
    KeylessPage,
    "Sources Hub",
    "Keyless",
    "Sources Hub"
)

AddScriptButton(
    KeylessPage,
    "Limbo Hub",
    "Keyless",
    "Limbo Hub"
)

AddScriptButton(
    KeylessPage,
    "Virexx",
    "Keyless",
    "Virexx"
)

--==================================================
-- KEY
--==================================================

AddSection(
    KeyPage,
    "Key System"
)

AddInfo(
    KeyPage,
    "These scripts may require a key."
)

AddScriptButton(
    KeyPage,
    "Wzeus Hub",
    "Key System",
    "Wzeus Hub"
)

AddScriptButton(
    KeyPage,
    "Pulse Hub",
    "Key System",
    "Pulse Hub"
)

--==================================================
-- THEMES
--==================================================

AddSection(
    ThemesPage,
    "Appearance"
)

AddInfo(
    ThemesPage,
    "Select a theme to change the interface."
)

local ThemeGrid = Instance.new("UIGridLayout")

ThemeGrid.CellPadding =
    UDim2.fromOffset(8, 8)

ThemeGrid.CellSize =
    UDim2.new(
        0.5,
        -4,
        0,
        50
    )

ThemeGrid.SortOrder =
    Enum.SortOrder.LayoutOrder

ThemeGrid.Parent = ThemesPage

local ThemeButtons = {}

for ThemeName, ThemeData in pairs(Themes) do

    local Button = Instance.new("TextButton")

    Button.Name = ThemeName

    Button.BackgroundColor3 =
        ThemeData.Surface

    Button.BorderSizePixel = 0

    Button.Text = ThemeName

    Button.Font =
        Enum.Font.GothamBold

    Button.TextSize = 11

    Button.TextColor3 =
        ThemeData.Text

    Button.AutoButtonColor = false

    Button.Selectable = true

    Button.Parent = ThemesPage

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, 10)

    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")

    Stroke.Color =
        ThemeData.Accent

    Stroke.Transparency = 0.75

    Stroke.Thickness = 1

    Stroke.Parent = Button

    local Dot = Instance.new("Frame")

    Dot.Size =
        UDim2.fromOffset(8, 8)

    Dot.Position =
        UDim2.new(
            1,
            -17,
            0.5,
            -4
        )

    Dot.BackgroundColor3 =
        ThemeData.Accent

    Dot.BorderSizePixel = 0

    Dot.Parent = Button

    local DotCorner = Instance.new("UICorner")

    DotCorner.CornerRadius =
        UDim.new(1, 0)

    DotCorner.Parent = Dot

    ThemeButtons[ThemeName] = {
        Button = Button,
        Stroke = Stroke,
        Dot = Dot,
        Data = ThemeData,
    }

end

--==================================================
-- SETTINGS
--==================================================

AddSection(
    SettingsPage,
    "Interface"
)

AddInfo(
    SettingsPage,
    "More interface controls will be available soon."
)

AddComingSoon(
    SettingsPage,
    "Notifications"
)

AddComingSoon(
    SettingsPage,
    "Interface Customization"
)

AddComingSoon(
    SettingsPage,
    "More Settings"
)

--==================================================
-- SIDEBAR
--==================================================

local function UpdateTabVisual(
    Button,
    Selected
)

    local Data = Tabs[Button]

    if not Data then
        return
    end

    if Selected then

        PlayTween(
            Button,
            0.16,
            {
                BackgroundColor3 =
                    CurrentTheme.Surface2
            }
        )

        PlayTween(
            Data.Indicator,
            0.16,
            {
                BackgroundColor3 =
                    CurrentTheme.Accent,
                Size =
                    UDim2.fromOffset(3, 25)
            }
        )

        Data.Icon.TextColor3 =
            CurrentTheme.Accent

        Data.Label.TextColor3 =
            CurrentTheme.Text

    else

        PlayTween(
            Button,
            0.16,
            {
                BackgroundColor3 =
                    CurrentTheme.Surface
            }
        )

        PlayTween(
            Data.Indicator,
            0.16,
            {
                BackgroundColor3 =
                    CurrentTheme.Surface,
                Size =
                    UDim2.fromOffset(3, 8)
            }
        )

        Data.Icon.TextColor3 =
            CurrentTheme.Muted

        Data.Label.TextColor3 =
            CurrentTheme.Muted

    end

end

local function SelectPage(Page)

    if not Page then
        return
    end

    if CurrentPage == Page then
        return
    end

    if CurrentPage then
        CurrentPage.Visible = false
    end

    Page.Visible = true

    CurrentPage = Page

    for Button in pairs(Tabs) do

        UpdateTabVisual(
            Button,
            Tabs[Button].Page == Page
        )

    end

end

local function AddTab(
    Name,
    IconText,
    Page
)

    local Button = Instance.new("TextButton")

    Button.Name = Name

    Button.Size =
        UDim2.new(1, 0, 0, 43)

    Button.BackgroundColor3 =
        CurrentTheme.Surface

    Button.BorderSizePixel = 0

    Button.Text = ""

    Button.AutoButtonColor = false

    Button.Selectable = true

    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")

    Corner.CornerRadius =
        UDim.new(0, 10)

    Corner.Parent = Button

    local Indicator = Instance.new("Frame")

    Indicator.Size =
        UDim2.fromOffset(3, 8)

    Indicator.Position =
        UDim2.new(
            0,
            0,
            0.5,
            -4
        )

    Indicator.BackgroundColor3 =
        CurrentTheme.Surface

    Indicator.BorderSizePixel = 0

    Indicator.Parent = Button

    local IndicatorCorner =
        Instance.new("UICorner")

    IndicatorCorner.CornerRadius =
        UDim.new(1, 0)

    IndicatorCorner.Parent =
        Indicator

    local Icon = Instance.new("TextLabel")

    Icon.Size =
        UDim2.fromOffset(32, 43)

    Icon.Position =
        UDim2.fromOffset(8, 0)

    Icon.BackgroundTransparency = 1

    Icon.Text = IconText

    Icon.Font =
        Enum.Font.GothamBold

    Icon.TextSize = 15

    Icon.TextColor3 =
        CurrentTheme.Muted

    Icon.Parent = Button

    local Label = Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            1,
            -50,
            1,
            0
        )

    Label.Position =
        UDim2.fromOffset(45, 0)

    Label.BackgroundTransparency = 1

    Label.Text = Name

    Label.Font =
        Enum.Font.GothamMedium

    Label.TextSize = 11

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.TextColor3 =
        CurrentTheme.Muted

    Label.Parent = Button

    Tabs[Button] = {
        Button = Button,
        Indicator = Indicator,
        Icon = Icon,
        Label = Label,
        Page = Page,
    }

    RegisterTheme(
        Button,
        "BackgroundColor3",
        "Surface"
    )

    Connect(
        Button.MouseEnter:Connect(
            function()

                if UserInputService.TouchEnabled then
                    return
                end

                if CurrentPage ~= Page then

                    PlayTween(
                        Button,
                        0.15,
                        {
                            BackgroundColor3 =
                                CurrentTheme.Surface2
                        }
                    )

                end

            end
        )
    )

    Connect(
        Button.MouseLeave:Connect(
            function()

                if CurrentPage ~= Page then

                    PlayTween(
                        Button,
                        0.15,
                        {
                            BackgroundColor3 =
                                CurrentTheme.Surface
                        }
                    )

                end

            end
        )
    )

    Connect(
        Button.Activated:Connect(
            function()
                SelectPage(Page)
            end
        )
    )

    return Button
end

AddTab(
    "Home",
    "⌂",
    HomePage
)

AddTab(
    "Keyless",
    "⚡",
    KeylessPage
)

AddTab(
    "Key Scripts",
    "◆",
    KeyPage
)

AddTab(
    "Themes",
    "◇",
    ThemesPage
)

AddTab(
    "Settings",
    "⚙",
    SettingsPage
)

--==================================================
-- FLOATING TOGGLE
--==================================================

local GUIEnabled = true

local FloatingToggle = Instance.new("TextButton")

FloatingToggle.Name =
    "FloatingToggle"

FloatingToggle.AnchorPoint =
    Vector2.new(1, 1)

FloatingToggle.Size =
    UDim2.fromOffset(
        CONFIG.FloatingSize,
        CONFIG.FloatingSize
    )

FloatingToggle.Position =
    UDim2.new(
        1,
        -18,
        1,
        -18
    )

FloatingToggle.BackgroundColor3 =
    CurrentTheme.Accent

FloatingToggle.BorderSizePixel = 0

FloatingToggle.Text = "C5"

FloatingToggle.Font =
    Enum.Font.GothamBlack

FloatingToggle.TextSize = 13

FloatingToggle.TextColor3 =
    CurrentTheme.Text

FloatingToggle.AutoButtonColor = false

FloatingToggle.Visible = false

FloatingToggle.ZIndex = 100

FloatingToggle.Parent = ScreenGui

local FloatingCorner = Instance.new("UICorner")

FloatingCorner.CornerRadius =
    UDim.new(0, 14)

FloatingCorner.Parent =
    FloatingToggle

local FloatingStroke = Instance.new("UIStroke")

FloatingStroke.Color =
    CurrentTheme.Text

FloatingStroke.Transparency = 0.80

FloatingStroke.Thickness = 1

FloatingStroke.Parent =
    FloatingToggle

local FloatingScale = Instance.new("UIScale")

FloatingScale.Scale = 1

FloatingScale.Parent =
    FloatingToggle

local function SetGUIVisible(State)

    GUIEnabled = State

    if State then

        Main.Visible = true
        FloatingToggle.Visible = false

        Main.BackgroundTransparency = 1

        PlayTween(
            Main,
            0.20,
            {
                BackgroundTransparency = 0
            },
            Enum.EasingStyle.Quart
        )

    else

        FloatingToggle.Visible = true

        PlayTween(
            Main,
            0.18,
            {
                BackgroundTransparency = 1
            },
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In
        )

        task.delay(
            GetTweenTime(0.18),
            function()

                if not GUIEnabled then
                    Main.Visible = false
                end

            end
        )

    end

end

Connect(
    FloatingToggle.Activated:Connect(
        function()
            SetGUIVisible(true)
        end
    )
)

Connect(
    FloatingToggle.MouseEnter:Connect(
        function()

            if UserInputService.TouchEnabled then
                return
            end

            PlayTween(
                FloatingScale,
                0.15,
                {
                    Scale = 1.08
                }
            )

        end
    )
)

Connect(
    FloatingToggle.MouseLeave:Connect(
        function()

            PlayTween(
                FloatingScale,
                0.15,
                {
                    Scale = 1
                }
            )

        end
    )
)

Connect(
    HideButton.Activated:Connect(
        function()
            SetGUIVisible(false)
        end
    )
)

--==================================================
-- MOBILE SIDEBAR
--==================================================

local SidebarToggle = Instance.new("TextButton")

SidebarToggle.Name =
    "SidebarToggle"

SidebarToggle.Size =
    UDim2.fromOffset(38, 38)

SidebarToggle.Position =
    UDim2.fromOffset(9, 10)

SidebarToggle.BackgroundColor3 =
    CurrentTheme.Surface2

SidebarToggle.BorderSizePixel = 0

SidebarToggle.Text = "☰"

SidebarToggle.Font =
    Enum.Font.GothamBold

SidebarToggle.TextSize = 16

SidebarToggle.TextColor3 =
    CurrentTheme.Text

SidebarToggle.AutoButtonColor = false

SidebarToggle.Visible = false

SidebarToggle.Parent = Topbar

local SidebarToggleCorner =
    Instance.new("UICorner")

SidebarToggleCorner.CornerRadius =
    UDim.new(0, 10)

SidebarToggleCorner.Parent =
    SidebarToggle

--==================================================
-- SIDEBAR COLLAPSE
--==================================================

local SidebarCollapsed = false

local function SetSidebarCollapsed(State)

    SidebarCollapsed = State

    local Width =
        State
        and CONFIG.SidebarMobile
        or CONFIG.SidebarDesktop

    PlayTween(
        Sidebar,
        0.20,
        {
            Size = UDim2.new(
                0,
                Width,
                1,
                -CONFIG.TopbarDesktop
            )
        }
    )

    PlayTween(
        Content,
        0.20,
        {
            Position =
                UDim2.fromOffset(
                    Width,
                    CONFIG.TopbarDesktop
                ),

            Size =
                UDim2.new(
                    1,
                    -Width,
                    1,
                    -CONFIG.TopbarDesktop
                )
        }
    )

    for _, Data in pairs(Tabs) do

        Data.Label.Visible =
            not State

        Data.Icon.Position =
            State
            and UDim2.fromOffset(15, 0)
            or UDim2.fromOffset(8, 0)

    end

end

Connect(
    SidebarToggle.Activated:Connect(
        function()

            SetSidebarCollapsed(
                not SidebarCollapsed
            )

        end
    )
)

--==================================================
-- THEME ENGINE
--==================================================

local function ApplyTheme(Theme)

    CurrentTheme = Theme

    -- Main
    Main.BackgroundColor3 =
        Theme.Background

    MainStroke.Color =
        Theme.Border

    -- Topbar
    Topbar.BackgroundColor3 =
        Theme.Surface

    TopbarLine.BackgroundColor3 =
        Theme.Border

    Logo.BackgroundColor3 =
        Theme.Accent

    Title.TextColor3 =
        Theme.Text

    Subtitle.TextColor3 =
        Theme.Muted

    VersionBadge.BackgroundColor3 =
        Theme.Background

    VersionBadge.TextColor3 =
        Theme.Accent

    Online.TextColor3 =
        Theme.Accent

    HideButton.BackgroundColor3 =
        Theme.Background

    HideButton.TextColor3 =
        Theme.Muted

    HideStroke.Color =
        Theme.Border

    Minimize.TextColor3 =
        Theme.Text

    Close.TextColor3 =
        Theme.Text

    -- Sidebar
    Sidebar.BackgroundColor3 =
        Theme.Surface

    -- Content
    Content.BackgroundColor3 =
        Theme.Background

    -- Floating
    FloatingToggle.BackgroundColor3 =
        Theme.Accent

    FloatingToggle.TextColor3 =
        Theme.Text

    FloatingStroke.Color =
        Theme.Text

    -- Mobile toggle
    SidebarToggle.BackgroundColor3 =
        Theme.Surface2

    SidebarToggle.TextColor3 =
        Theme.Text

    -- Registered objects
    for _, Data in ipairs(ThemeObjects) do

        if Data.Object
            and Data.Object.Parent then

            local Value =
                Theme[Data.Key]

            if Value then

                pcall(
                    function()
                        Data.Object[
                            Data.Property
                        ] = Value
                    end
                )

            end

        end

    end

    -- Tabs
    for Button, Data in pairs(Tabs) do

        local Selected =
            CurrentPage == Data.Page

        Data.Button.BackgroundColor3 =
            Selected
            and Theme.Surface2
            or Theme.Surface

        Data.Icon.TextColor3 =
            Selected
            and Theme.Accent
            or Theme.Muted

        Data.Label.TextColor3 =
            Selected
            and Theme.Text
            or Theme.Muted

        Data.Indicator.BackgroundColor3 =
            Selected
            and Theme.Accent
            or Theme.Surface

    end

    -- Theme buttons
    for _, Data in pairs(ThemeButtons) do

        Data.Button.BackgroundColor3 =
            Data.Data.Surface

        Data.Button.TextColor3 =
            Data.Data.Text

        Data.Stroke.Color =
            Data.Data.Accent

        Data.Dot.BackgroundColor3 =
            Data.Data.Accent

    end

end

for _, Data in pairs(ThemeButtons) do

    Connect(
        Data.Button.Activated:Connect(
            function()
                ApplyTheme(Data.Data)
            end
        )
    )

end

--==================================================
-- MINIMIZE
--==================================================

local Minimized = false

local SavedSize =
    Main.Size

local SavedPosition =
    Main.Position

Connect(
    Minimize.Activated:Connect(
        function()

            Minimized =
                not Minimized

            if Minimized then

                SavedSize =
                    Main.Size

                SavedPosition =
                    Main.Position

                Sidebar.Visible =
                    false

                Content.Visible =
                    false

                PlayTween(
                    Main,
                    0.22,
                    {
                        Size =
                            UDim2.new(
                                Main.Size.X.Scale,
                                Main.Size.X.Offset,
                                0,
                                CONFIG.TopbarMobile
                            )
                    },
                    Enum.EasingStyle.Quart,
                    Enum.EasingDirection.InOut
                )

                Minimize.Text = "□"

            else

                PlayTween(
                    Main,
                    0.22,
                    {
                        Size = SavedSize
                    },
                    Enum.EasingStyle.Quart,
                    Enum.EasingDirection.Out
                )

                Main.Position =
                    SavedPosition

                task.delay(
                    GetTweenTime(0.22),
                    function()

                        if Minimized then
                            return
                        end

                        Sidebar.Visible =
                            true

                        Content.Visible =
                            true

                    end
                )

                Minimize.Text = "—"

            end

        end
    )
)

--==================================================
-- CLOSE
--==================================================

local Closing = false

Connect(
    Close.Activated:Connect(
        function()

            if Closing then
                return
            end

            Closing = true

            DisconnectAll()

            local Animation =
                Tween(
                    Main,
                    0.22,
                    {
                        Size =
                            UDim2.fromOffset(
                                0,
                                0
                            )
                    },
                    Enum.EasingStyle.Back,
                    Enum.EasingDirection.In
                )

            if Animation then

                Animation:Play()
                Animation.Completed:Wait()

            end

            if ScreenGui then
                ScreenGui:Destroy()
            end

        end
    )
)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

Connect(
    Topbar.InputBegan:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                Dragging = true

                DragStart =
                    Input.Position

                StartPosition =
                    Main.Position

            end

        end
    )
)

Connect(
    Topbar.InputEnded:Connect(
        function(Input)

            if Input.UserInputType ==
                Enum.UserInputType.MouseButton1
                or Input.UserInputType ==
                Enum.UserInputType.Touch then

                Dragging = false

            end

        end
    )
)

local function ClampMain()

    local Camera =
        workspace.CurrentCamera

    if not Camera then
        return
    end

    local Viewport =
        Camera.ViewportSize

    local Size =
        Main.AbsoluteSize

    local Padding = 6

    local HalfX =
        Size.X / 2

    local HalfY =
        Size.Y / 2

    local X =
        math.clamp(
            Main.AbsolutePosition.X +
                HalfX,
            HalfX + Padding,
            math.max(
                HalfX + Padding,
                Viewport.X -
                    HalfX -
                    Padding
            )
        )

    local Y =
        math.clamp(
            Main.AbsolutePosition.Y +
                HalfY,
            HalfY + Padding,
            math.max(
                HalfY + Padding,
                Viewport.Y -
                    HalfY -
                    Padding
            )
        )

    Main.AnchorPoint =
        Vector2.new(0.5, 0.5)

    Main.Position =
        UDim2.fromOffset(
            X,
            Y
        )

end

Connect(
    UserInputService.InputChanged:Connect(
        function(Input)

            if not Dragging then
                return
            end

            if Input.UserInputType ~=
                Enum.UserInputType.MouseMovement
                and Input.UserInputType ~=
                Enum.UserInputType.Touch then

                return
            end

            local Delta =
                Input.Position -
                DragStart

            Main.Position =
                UDim2.new(
                    StartPosition.X.Scale,
                    StartPosition.X.Offset +
                        Delta.X,

                    StartPosition.Y.Scale,
                    StartPosition.Y.Offset +
                        Delta.Y
                )

            ClampMain()

        end
    )
)

--==================================================
-- RESPONSIVE ENGINE
--==================================================

local function UpdateResponsive()

    local Camera =
        workspace.CurrentCamera

    if not Camera then
        return
    end

    local Viewport =
        Camera.ViewportSize

    local Width =
        Viewport.X

    local Height =
        Viewport.Y

    local Mobile =
        Width < 600

    local Tablet =
        Width >= 600
        and Width < 900

    local Landscape =
        Width > Height

    if Mobile then

        Main.Size =
            UDim2.new(
                CONFIG.MobileWidthScale,
                0,
                CONFIG.MobileHeightScale,
                0
            )

        MainScale.Scale = 1

        SidebarToggle.Visible =
            true

        Sidebar.Size =
            UDim2.new(
                0,
                CONFIG.SidebarMobile,
                1,
                -CONFIG.TopbarMobile
            )

        Content.Position =
            UDim2.fromOffset(
                CONFIG.SidebarMobile,
                CONFIG.TopbarMobile
            )

        Content.Size =
            UDim2.new(
                1,
                -CONFIG.SidebarMobile,
                1,
                -CONFIG.TopbarMobile
            )

        Topbar.Size =
            UDim2.new(
                1,
                0,
                0,
                CONFIG.TopbarMobile
            )

        Logo.Visible = false
        Subtitle.Visible = false
        VersionBadge.Visible = false
        Online.Visible = false

        HideButton.Visible = false

        Title.Position =
            UDim2.fromOffset(
                54,
                8
            )

        Title.Size =
            UDim2.new(
                1,
                -130,
                0,
                24
            )

        Minimize.Position =
            UDim2.new(
                1,
                -78,
                0,
                12
            )

        Close.Position =
            UDim2.new(
                1,
                -40,
                0,
                12
            )

        for _, Data in pairs(Tabs) do

            Data.Label.Visible =
                false

            Data.Icon.Position =
                UDim2.fromOffset(
                    15,
                    0
                )

        end

        if Landscape then

            Main.Size =
                UDim2.new(
                    0.86,
                    0,
                    0.90,
                    0
                )

        end

    elseif Tablet then

        Main.Size =
            UDim2.fromOffset(
                CONFIG.TabletWidth,
                CONFIG.TabletHeight
            )

        MainScale.Scale = 0.92

        SidebarToggle.Visible =
            false

        HideButton.Visible =
            true

        Logo.Visible =
            true

        Subtitle.Visible =
            true

        VersionBadge.Visible =
            true

        Online.Visible =
            true

        Sidebar.Size =
            UDim2.new(
                0,
                CONFIG.SidebarDesktop,
                1,
                -CONFIG.TopbarDesktop
            )

        Content.Position =
            UDim2.fromOffset(
                CONFIG.SidebarDesktop,
                CONFIG.TopbarDesktop
            )

        Content.Size =
            UDim2.new(
                1,
                -CONFIG.SidebarDesktop,
                1,
                -CONFIG.TopbarDesktop
            )

        for _, Data in pairs(Tabs) do

            Data.Label.Visible =
                true

            Data.Icon.Position =
                UDim2.fromOffset(
                    8,
                    0
                )

        end

    else

        Main.Size =
            UDim2.fromOffset(
                CONFIG.DesktopWidth,
                CONFIG.DesktopHeight
            )

        MainScale.Scale = 1

        SidebarToggle.Visible =
            false

        HideButton.Visible =
            true

        Logo.Visible =
            true

        Subtitle.Visible =
            true

        VersionBadge.Visible =
            true

        Online.Visible =
            true

        Sidebar.Size =
            UDim2.new(
                0,
                CONFIG.SidebarDesktop,
                1,
                -CONFIG.TopbarDesktop
            )

        Content.Position =
            UDim2.fromOffset(
                CONFIG.SidebarDesktop,
                CONFIG.TopbarDesktop
            )

        Content.Size =
            UDim2.new(
                1,
                -CONFIG.SidebarDesktop,
                1,
                -CONFIG.TopbarDesktop
            )

        for _, Data in pairs(Tabs) do

            Data.Label.Visible =
                true

            Data.Icon.Position =
                UDim2.fromOffset(
                    8,
                    0
                )

        end

    end

    task.defer(
        function()
            ClampMain()
        end
    )

end

--==================================================
-- VIEWPORT LISTENER
--==================================================

local Camera =
    workspace.CurrentCamera

if Camera then

    Connect(
        Camera:GetPropertyChangedSignal(
            "ViewportSize"
        ):Connect(
            UpdateResponsive
        )
    )

end

--==================================================
-- INITIAL STATE
--==================================================

CurrentPage =
    HomePage

HomePage.Visible =
    true

for Button in pairs(Tabs) do

    UpdateTabVisual(
        Button,
        Tabs[Button].Page ==
            HomePage
    )

end

ApplyTheme(
    CurrentTheme
)

UpdateResponsive()

Main.Visible = true

--==================================================
-- FINAL
--==================================================

print(
    "[CH3A5 HUB] Professional GUI loaded:",
    VERSION
)
