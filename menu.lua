--//==================================================
--// CH3A5 HUB V3
--// GUI ENGINE UPGRADE
--// KEYLESS / KEY / SCRIPT LOADER PRESERVED
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

local VERSION = "V3.0"

local CONFIG = {
    DesktopWidth = 720,
    DesktopHeight = 460,

    TabletWidth = 680,
    TabletHeight = 450,

    MobileWidthScale = 0.94,
    MobileHeightScale = 0.88,

    MinWidth = 300,
    MinHeight = 300,

    AnimationTime = 0.22,

    CornerRadius = 14,

    SidebarDesktop = 170,
    SidebarMobile = 62,

    TopbarDesktop = 58,
    TopbarMobile = 58,
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

local function Tween(Object, Info, Properties)
    if not Object then
        return nil
    end

    local Duration = GetTweenTime(Info.Time)

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
            Info.EasingStyle or Enum.EasingStyle.Quad,
            Info.EasingDirection or Enum.EasingDirection.Out
        ),
        Properties
    )
end

local function PlayTween(Object, Info, Properties)
    local Animation = Tween(Object, Info, Properties)

    if Animation then
        Animation:Play()
    end

    return Animation
end

--==================================================
-- THEMES
--==================================================

local Themes = {

    ["Midnight"] = {
        Background = Color3.fromRGB(12, 12, 18),
        Surface = Color3.fromRGB(20, 20, 30),
        Surface2 = Color3.fromRGB(27, 27, 40),
        Accent = Color3.fromRGB(120, 90, 255),
        Text = Color3.fromRGB(245, 245, 255),
        Muted = Color3.fromRGB(150, 150, 170),
        Border = Color3.fromRGB(120, 90, 255)
    },

    ["Discord"] = {
        Background = Color3.fromRGB(25, 27, 31),
        Surface = Color3.fromRGB(32, 34, 39),
        Surface2 = Color3.fromRGB(40, 42, 48),
        Accent = Color3.fromRGB(88, 101, 242),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(88, 101, 242)
    },

    ["GitHub"] = {
        Background = Color3.fromRGB(13, 17, 23),
        Surface = Color3.fromRGB(22, 27, 34),
        Surface2 = Color3.fromRGB(30, 36, 44),
        Accent = Color3.fromRGB(46, 160, 67),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158),
        Border = Color3.fromRGB(46, 160, 67)
    },

    ["Spotify"] = {
        Background = Color3.fromRGB(12, 12, 12),
        Surface = Color3.fromRGB(24, 24, 24),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(30, 215, 96),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(170, 170, 170),
        Border = Color3.fromRGB(30, 215, 96)
    },

    ["YouTube"] = {
        Background = Color3.fromRGB(15, 15, 15),
        Surface = Color3.fromRGB(30, 30, 30),
        Surface2 = Color3.fromRGB(42, 42, 42),
        Accent = Color3.fromRGB(255, 0, 0),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(255, 0, 0)
    },

    ["Telegram"] = {
        Background = Color3.fromRGB(15, 23, 30),
        Surface = Color3.fromRGB(25, 38, 50),
        Surface2 = Color3.fromRGB(32, 49, 64),
        Accent = Color3.fromRGB(42, 171, 238),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(160, 180, 195),
        Border = Color3.fromRGB(42, 171, 238)
    },

    ["Twitter"] = {
        Background = Color3.fromRGB(10, 10, 10),
        Surface = Color3.fromRGB(24, 24, 24),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(29, 155, 240),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(160, 170, 180),
        Border = Color3.fromRGB(29, 155, 240)
    },

    ["Twitch"] = {
        Background = Color3.fromRGB(14, 12, 20),
        Surface = Color3.fromRGB(25, 22, 35),
        Surface2 = Color3.fromRGB(35, 31, 47),
        Accent = Color3.fromRGB(145, 70, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 170, 195),
        Border = Color3.fromRGB(145, 70, 255)
    },

    ["Dracula"] = {
        Background = Color3.fromRGB(24, 24, 37),
        Surface = Color3.fromRGB(40, 42, 54),
        Surface2 = Color3.fromRGB(50, 52, 66),
        Accent = Color3.fromRGB(189, 147, 249),
        Text = Color3.fromRGB(248, 248, 242),
        Muted = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(189, 147, 249)
    },

    ["Ocean"] = {
        Background = Color3.fromRGB(7, 18, 28),
        Surface = Color3.fromRGB(12, 32, 48),
        Surface2 = Color3.fromRGB(18, 45, 64),
        Accent = Color3.fromRGB(0, 190, 255),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(145, 180, 195),
        Border = Color3.fromRGB(0, 190, 255)
    },

    ["Crimson"] = {
        Background = Color3.fromRGB(20, 10, 12),
        Surface = Color3.fromRGB(35, 16, 20),
        Surface2 = Color3.fromRGB(48, 21, 27),
        Accent = Color3.fromRGB(235, 55, 75),
        Text = Color3.fromRGB(255, 240, 242),
        Muted = Color3.fromRGB(185, 155, 160),
        Border = Color3.fromRGB(235, 55, 75)
    },

    ["Emerald"] = {
        Background = Color3.fromRGB(8, 18, 14),
        Surface = Color3.fromRGB(14, 32, 25),
        Surface2 = Color3.fromRGB(20, 44, 34),
        Accent = Color3.fromRGB(40, 210, 130),
        Text = Color3.fromRGB(235, 255, 245),
        Muted = Color3.fromRGB(145, 180, 160),
        Border = Color3.fromRGB(40, 210, 130)
    },

    ["Angkor"] = {
        Background = Color3.fromRGB(18, 14, 10),
        Surface = Color3.fromRGB(35, 27, 18),
        Surface2 = Color3.fromRGB(48, 37, 24),
        Accent = Color3.fromRGB(214, 157, 65),
        Text = Color3.fromRGB(255, 245, 220),
        Muted = Color3.fromRGB(185, 160, 125),
        Border = Color3.fromRGB(214, 157, 65)
    }
}

local CurrentTheme = Themes["Midnight"]

--==================================================
-- CONNECTION MANAGEMENT
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
-- GUI ROOT
--==================================================

local OldGUI = PlayerGui:FindFirstChild("CH3A5_HUB")

if OldGUI then
    OldGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = false

pcall(function()
    ScreenGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
end)

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Size = UDim2.fromOffset(
    CONFIG.DesktopWidth,
    CONFIG.DesktopHeight
)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, CONFIG.CornerRadius)
MainCorner.Parent = Main

local MainSizeConstraint = Instance.new("UISizeConstraint")
MainSizeConstraint.MinSize = Vector2.new(
    CONFIG.MinWidth,
    CONFIG.MinHeight
)
MainSizeConstraint.MaxSize = Vector2.new(
    1100,
    750
)
MainSizeConstraint.Parent = Main

local MainScale = Instance.new("UIScale")
MainScale.Scale = 1
MainScale.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = CurrentTheme.Border
Stroke.Transparency = 0.45
Stroke.Thickness = 1
Stroke.Parent = Main

--==================================================
-- TOPBAR
--==================================================

local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, CONFIG.TopbarDesktop)
Topbar.BackgroundColor3 = CurrentTheme.Surface
Topbar.BorderSizePixel = 0
Topbar.Parent = Main

local TopbarPadding = Instance.new("UIPadding")
TopbarPadding.PaddingLeft = UDim.new(0, 16)
TopbarPadding.PaddingRight = UDim.new(0, 10)
TopbarPadding.Parent = Topbar

--==================================================
-- LOGO
--==================================================

local Logo = Instance.new("TextLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.fromOffset(42, 42)
Logo.Position = UDim2.fromOffset(0, 8)
Logo.BackgroundColor3 = CurrentTheme.Accent
Logo.BackgroundTransparency = 0.05
Logo.Text = "C5"
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 15
Logo.TextColor3 = CurrentTheme.Text
Logo.Parent = Topbar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 11)
LogoCorner.Parent = Logo

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -190, 0, 25)
Title.Position = UDim2.fromOffset(52, 7)
Title.BackgroundTransparency = 1
Title.Text = "CH3A5 HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = CurrentTheme.Text
Title.Parent = Topbar

local TitleConstraint = Instance.new("UITextSizeConstraint")
TitleConstraint.MinTextSize = 14
TitleConstraint.MaxTextSize = 20
TitleConstraint.Parent = Title

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -190, 0, 17)
Subtitle.Position = UDim2.fromOffset(52, 31)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Premium Script Hub"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.TextColor3 = CurrentTheme.Muted
Subtitle.Parent = Topbar

local SubtitleConstraint = Instance.new("UITextSizeConstraint")
SubtitleConstraint.MinTextSize = 9
SubtitleConstraint.MaxTextSize = 12
SubtitleConstraint.Parent = Subtitle

--==================================================
-- VERSION BADGE
--==================================================

local VersionBadge = Instance.new("TextLabel")
VersionBadge.Name = "VersionBadge"
VersionBadge.Size = UDim2.fromOffset(48, 24)
VersionBadge.Position = UDim2.new(1, -155, 0, 16)
VersionBadge.BackgroundColor3 = CurrentTheme.Background
VersionBadge.Text = VERSION
VersionBadge.Font = Enum.Font.GothamBold
VersionBadge.TextSize = 9
VersionBadge.TextColor3 = CurrentTheme.Accent
VersionBadge.Parent = Topbar

local VersionCorner = Instance.new("UICorner")
VersionCorner.CornerRadius = UDim.new(0, 7)
VersionCorner.Parent = VersionBadge

local VersionConstraint = Instance.new("UITextSizeConstraint")
VersionConstraint.MinTextSize = 8
VersionConstraint.MaxTextSize = 11
VersionConstraint.Parent = VersionBadge

--==================================================
-- ONLINE INDICATOR
--==================================================

local Online = Instance.new("TextLabel")
Online.Name = "Online"
Online.Size = UDim2.fromOffset(72, 24)
Online.Position = UDim2.new(1, -103, 0, 16)
Online.BackgroundTransparency = 1
Online.Text = "● Online"
Online.Font = Enum.Font.GothamMedium
Online.TextSize = 10
Online.TextColor3 = CurrentTheme.Accent
Online.Parent = Topbar

--==================================================
-- MINIMIZE / CLOSE
--==================================================

local Minimize = Instance.new("TextButton")
Minimize.Name = "Minimize"
Minimize.Size = UDim2.fromOffset(36, 36)
Minimize.Position = UDim2.new(1, -77, 0, 10)
Minimize.BackgroundTransparency = 1
Minimize.Text = "—"
Minimize.TextSize = 21
Minimize.TextColor3 = CurrentTheme.Text
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.Parent = Topbar

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Size = UDim2.fromOffset(36, 36)
Close.Position = UDim2.new(1, -38, 0, 10)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextSize = 24
Close.TextColor3 = CurrentTheme.Text
Close.Font = Enum.Font.GothamBold
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
Sidebar.BackgroundColor3 = CurrentTheme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 14)
SidePadding.PaddingLeft = UDim.new(0, 10)
SidePadding.PaddingRight = UDim.new(0, 10)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 7)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

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
Content.BackgroundColor3 = CurrentTheme.Background
Content.BorderSizePixel = 0
Content.Parent = Main

--==================================================
-- PAGES
--==================================================

local Pages = {}
local PageHeaders = {}
local PageObjects = {}

local function CreatePage(name, title, subtitle)

    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Size = UDim2.new(1, -20, 1, -20)
    Page.Position = UDim2.fromOffset(10, 10)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0

    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = CurrentTheme.Accent

    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new()

    Page.ScrollingDirection = Enum.ScrollingDirection.Y
    Page.Visible = false

    Page.Parent = Content

    local Padding = Instance.new("UIPadding")
    Padding.PaddingBottom = UDim.new(0, 12)
    Padding.Parent = Page

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 58)
    Header.BackgroundTransparency = 1
    Header.LayoutOrder = -100
    Header.Parent = Page

    local HeaderTitle = Instance.new("TextLabel")
    HeaderTitle.Name = "Title"
    HeaderTitle.Size = UDim2.new(1, 0, 0, 30)
    HeaderTitle.BackgroundTransparency = 1
    HeaderTitle.Text = title
    HeaderTitle.Font = Enum.Font.GothamBold
    HeaderTitle.TextSize = 19
    HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
    HeaderTitle.TextColor3 = CurrentTheme.Text
    HeaderTitle.Parent = Header

    local HeaderTitleConstraint = Instance.new("UITextSizeConstraint")
    HeaderTitleConstraint.MinTextSize = 14
    HeaderTitleConstraint.MaxTextSize = 22
    HeaderTitleConstraint.Parent = HeaderTitle

    local HeaderSubtitle = Instance.new("TextLabel")
    HeaderSubtitle.Name = "Subtitle"
    HeaderSubtitle.Size = UDim2.new(1, 0, 0, 22)
    HeaderSubtitle.Position = UDim2.fromOffset(0, 31)
    HeaderSubtitle.BackgroundTransparency = 1
    HeaderSubtitle.Text = subtitle
    HeaderSubtitle.Font = Enum.Font.Gotham
    HeaderSubtitle.TextSize = 11
    HeaderSubtitle.TextXAlignment = Enum.TextXAlignment.Left
    HeaderSubtitle.TextColor3 = CurrentTheme.Muted
    HeaderSubtitle.Parent = Header

    local HeaderSubtitleConstraint = Instance.new("UITextSizeConstraint")
    HeaderSubtitleConstraint.MinTextSize = 9
    HeaderSubtitleConstraint.MaxTextSize = 13
    HeaderSubtitleConstraint.Parent = HeaderSubtitle

    Pages[name] = Page
    PageHeaders[name] = Header
    PageObjects[name] = {
        Title = HeaderTitle,
        Subtitle = HeaderSubtitle
    }

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
    "Customize the appearance of CH3A5 HUB."
)

local SettingsPage = CreatePage(
    "Settings",
    "Settings",
    "CH3A5 HUB interface settings."
)

--==================================================
-- UI REGISTRY
--==================================================

local ThemeObjects = {}

local function RegisterThemeObject(Object, Property, ThemeKey)
    table.insert(ThemeObjects, {
        Object = Object,
        Property = Property,
        ThemeKey = ThemeKey
    })
end

--==================================================
-- UI HELPERS
--==================================================

local function AddSection(Page, text)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 34)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Text
    Label.Parent = Page

    local Constraint = Instance.new("UITextSizeConstraint")
    Constraint.MinTextSize = 13
    Constraint.MaxTextSize = 19
    Constraint.Parent = Label

    RegisterThemeObject(Label, "TextColor3", "Text")

    return Label
end

local function AddInfo(Page, text)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Muted
    Label.Parent = Page

    local Constraint = Instance.new("UITextSizeConstraint")
    Constraint.MinTextSize = 10
    Constraint.MaxTextSize = 14
    Constraint.Parent = Label

    RegisterThemeObject(Label, "TextColor3", "Muted")

    return Label
end

--==================================================
-- CARD
--==================================================

local function AddScriptButton(Page, name, description, url)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 70)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Selectable = true
    Button.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = CurrentTheme.Border
    Stroke.Transparency = 0.82
    Stroke.Thickness = 1
    Stroke.Parent = Button

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 15)
    Padding.PaddingRight = UDim.new(0, 15)
    Button.Parent = Page

    local Name = Instance.new("TextLabel")
    Name.Size = UDim2.new(1, 0, 0, 27)
    Name.Position = UDim2.fromOffset(15, 8)
    Name.BackgroundTransparency = 1
    Name.Text = name
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 14
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = CurrentTheme.Text
    Name.Parent = Button

    local NameConstraint = Instance.new("UITextSizeConstraint")
    NameConstraint.MinTextSize = 11
    NameConstraint.MaxTextSize = 16
    NameConstraint.Parent = Name

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -25, 0, 22)
    Desc.Position = UDim2.fromOffset(15, 37)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = CurrentTheme.Muted
    Desc.Parent = Button

    local DescConstraint = Instance.new("UITextSizeConstraint")
    DescConstraint.MinTextSize = 9
    DescConstraint.MaxTextSize = 13
    DescConstraint.Parent = Desc

    RegisterThemeObject(Button, "BackgroundColor3", "Surface")
    RegisterThemeObject(Name, "TextColor3", "Text")
    RegisterThemeObject(Desc, "TextColor3", "Muted")
    RegisterThemeObject(Stroke, "Color", "Border")

    Connect(Button.MouseEnter:Connect(function()

        if UserInputService.TouchEnabled then
            return
        end

        PlayTween(
            Button,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                BackgroundColor3 = CurrentTheme.Surface2
            }
        )

        PlayTween(
            Stroke,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                Transparency = 0.35
            }
        )
    end))

    Connect(Button.MouseLeave:Connect(function()

        PlayTween(
            Button,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                BackgroundColor3 = CurrentTheme.Surface
            }
        )

        PlayTween(
            Stroke,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                Transparency = 0.82
            }
        )
    end))

    Connect(Button.Activated:Connect(function()

        PlayTween(
            Button,
            TweenInfo.new(0.08),
            {
                BackgroundColor3 = CurrentTheme.Accent
            }
        )

        task.delay(GetTweenTime(0.1), function()

            if Button.Parent then

                PlayTween(
                    Button,
                    TweenInfo.new(0.15),
                    {
                        BackgroundColor3 = CurrentTheme.Surface
                    }
                )

            end
        end)

        ExecuteScript(url)
    end))

    return Button
end

--==================================================
-- COMING SOON
--==================================================

local function AddComingSoon(Page, name)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 60)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = name .. "  •  COMING SOON"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.TextColor3 = CurrentTheme.Muted
    Button.AutoButtonColor = false
    Button.Selectable = true
    Button.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button

    local Constraint = Instance.new("UITextSizeConstraint")
    Constraint.MinTextSize = 10
    Constraint.MaxTextSize = 14
    Constraint.Parent = Button

    RegisterThemeObject(Button, "BackgroundColor3", "Surface")
    RegisterThemeObject(Button, "TextColor3", "Muted")

    return Button
end

--==================================================
-- HOME
--==================================================

AddSection(HomePage, "Welcome to CH3A5 HUB")
AddInfo(HomePage, "Select a category from the sidebar.")

AddComingSoon(HomePage, "More Scripts")

--==================================================
-- KEYLESS
--==================================================

AddSection(KeylessPage, "Keyless Scripts")
AddInfo(KeylessPage, "No key required.")

AddScriptButton(
    KeylessPage,
    "Sources Hub",
    "Keyless",
    "none"
)

AddScriptButton(
    KeylessPage,
    "Limbo Hub",
    "Keyless",
    "none"
)

AddScriptButton(
    KeylessPage,
    "Virexx",
    "Keyless",
    "none"
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
    "none"
)

AddScriptButton(
    KeyPage,
    "Pulse Hub",
    "Key System",
    "none"
)

--==================================================
-- THEMES
--==================================================

AddSection(ThemesPage, "Themes")
AddInfo(ThemesPage, "Choose a theme for CH3A5 HUB.")

local ThemeGrid = Instance.new("UIGridLayout")
ThemeGrid.CellPadding = UDim2.fromOffset(8, 8)
ThemeGrid.CellSize = UDim2.new(0.5, -4, 0, 52)
ThemeGrid.SortOrder = Enum.SortOrder.LayoutOrder
ThemeGrid.Parent = ThemesPage

--==================================================
-- THEME BUTTONS
--==================================================

local ThemeButtons = {}

for ThemeName, ThemeData in pairs(Themes) do

    local Button = Instance.new("TextButton")

    Button.Size = UDim2.new(1, 0, 0, 48)
    Button.BackgroundColor3 = ThemeData.Surface
    Button.BorderSizePixel = 0
    Button.Text = ThemeName
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.TextColor3 = ThemeData.Text
    Button.AutoButtonColor = false
    Button.Selectable = true
    Button.Parent = ThemesPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Button

    local ThemeStroke = Instance.new("UIStroke")
    ThemeStroke.Color = ThemeData.Accent
    ThemeStroke.Transparency = 0.75
    ThemeStroke.Thickness = 1
    ThemeStroke.Parent = Button

    local Preview = Instance.new("Frame")
    Preview.Size = UDim2.fromOffset(8, 28)
    Preview.Position = UDim2.new(1, -18, 0.5, -14)
    Preview.BackgroundColor3 = ThemeData.Accent
    Preview.BorderSizePixel = 0
    Preview.Parent = Button

    local PreviewCorner = Instance.new("UICorner")
    PreviewCorner.CornerRadius = UDim.new(1, 0)
    PreviewCorner.Parent = Preview

    ThemeButtons[ThemeName] = {
        Button = Button,
        Stroke = ThemeStroke,
        Preview = Preview,
        Data = ThemeData
    }
end

--==================================================
-- SETTINGS
--==================================================

AddSection(SettingsPage, "Settings")
AddInfo(SettingsPage, "CH3A5 HUB interface settings.")

AddComingSoon(SettingsPage, "Notifications")
AddComingSoon(SettingsPage, "Interface Customization")
AddComingSoon(SettingsPage, "More Settings")

--==================================================
-- SIDEBAR SYSTEM
--==================================================

local Tabs = {}
local CurrentPage = HomePage
local CurrentTab = nil
local SidebarCollapsed = false

local function UpdateTabVisual(Tab, Selected)

    local Data = Tabs[Tab]

    if not Data then
        return
    end

    local Button = Data.Button
    local Indicator = Data.Indicator
    local Icon = Data.Icon
    local Label = Data.Label

    if Selected then

        PlayTween(
            Button,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                BackgroundColor3 = CurrentTheme.Surface2
            }
        )

        PlayTween(
            Indicator,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                BackgroundColor3 = CurrentTheme.Accent,
                Size = UDim2.fromOffset(3, 24)
            }
        )

        Icon.TextColor3 = CurrentTheme.Accent
        Label.TextColor3 = CurrentTheme.Text

    else

        PlayTween(
            Button,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                BackgroundColor3 = CurrentTheme.Surface
            }
        )

        PlayTween(
            Indicator,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                BackgroundColor3 = CurrentTheme.Surface,
                Size = UDim2.fromOffset(3, 8)
            }
        )

        Icon.TextColor3 = CurrentTheme.Muted
        Label.TextColor3 = CurrentTheme.Muted
    end
end

local function SelectPage(Page)

    if not Page then
        return
    end

    if CurrentPage == Page then
        return
    end

    local OldPage = CurrentPage

    if OldPage then
        OldPage.Visible = false
    end

    Page.Visible = true
    CurrentPage = Page

    for Tab, Data in pairs(Tabs) do
        UpdateTabVisual(
            Tab,
            Data.Page == Page
        )
    end
end

local function AddTab(name, icon, page)

    local Button = Instance.new("TextButton")

    Button.Name = name
    Button.Size = UDim2.new(1, 0, 0, 44)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Selectable = true
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Button

    local Indicator = Instance.new("Frame")
    Indicator.Name = "ActiveIndicator"
    Indicator.Size = UDim2.fromOffset(3, 8)
    Indicator.Position = UDim2.new(0, 0, 0.5, -4)
    Indicator.BackgroundColor3 = CurrentTheme.Surface
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Button

    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.fromOffset(32, 44)
    Icon.Position = UDim2.fromOffset(8, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 16
    Icon.TextColor3 = CurrentTheme.Muted
    Icon.Parent = Button

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -48, 1, 0)
    Label.Position = UDim2.fromOffset(45, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Muted
    Label.Parent = Button

    local TextConstraint = Instance.new("UITextSizeConstraint")
    TextConstraint.MinTextSize = 10
    TextConstraint.MaxTextSize = 14
    TextConstraint.Parent = Label

    Tabs[Button] = {
        Button = Button,
        Indicator = Indicator,
        Icon = Icon,
        Label = Label,
        Page = page,
        Name = name
    }

    RegisterThemeObject(Button, "BackgroundColor3", "Surface")
    RegisterThemeObject(Icon, "TextColor3", "Muted")
    RegisterThemeObject(Label, "TextColor3", "Muted")

    Connect(Button.MouseEnter:Connect(function()

        if UserInputService.TouchEnabled then
            return
        end

        if CurrentPage ~= page then
            PlayTween(
                Button,
                TweenInfo.new(CONFIG.AnimationTime),
                {
                    BackgroundColor3 = CurrentTheme.Surface2
                }
            )
        end
    end))

    Connect(Button.MouseLeave:Connect(function()

        if CurrentPage ~= page then
            PlayTween(
                Button,
                TweenInfo.new(CONFIG.AnimationTime),
                {
                    BackgroundColor3 = CurrentTheme.Surface
                }
            )
        end
    end))

    Connect(Button.Activated:Connect(function()
        SelectPage(page)
    end))

    return Button
end

AddTab("Home", "⌂", HomePage)
AddTab("Keyless", "⚡", KeylessPage)
AddTab("Key Scripts", "🔑", KeyPage)
AddTab("Themes", "◆", ThemesPage)
AddTab("Settings", "⚙", SettingsPage)

--==================================================
-- MOBILE SIDEBAR TOGGLE
--==================================================

local SidebarToggle = Instance.new("TextButton")
SidebarToggle.Name = "SidebarToggle"
SidebarToggle.Size = UDim2.fromOffset(38, 38)
SidebarToggle.Position = UDim2.fromOffset(10, 10)
SidebarToggle.BackgroundColor3 = CurrentTheme.Surface2
SidebarToggle.BorderSizePixel = 0
SidebarToggle.Text = "☰"
SidebarToggle.Font = Enum.Font.GothamBold
SidebarToggle.TextSize = 17
SidebarToggle.TextColor3 = CurrentTheme.Text
SidebarToggle.AutoButtonColor = false
SidebarToggle.Visible = false
SidebarToggle.Parent = Topbar

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 9)
ToggleCorner.Parent = SidebarToggle

RegisterThemeObject(
    SidebarToggle,
    "BackgroundColor3",
    "Surface2"
)

RegisterThemeObject(
    SidebarToggle,
    "TextColor3",
    "Text"
)

local function SetSidebarCollapsed(State)

    SidebarCollapsed = State

    local Width = State
        and CONFIG.SidebarMobile
        or CONFIG.SidebarDesktop

    PlayTween(
        Sidebar,
        TweenInfo.new(0.2),
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
        TweenInfo.new(0.2),
        {
            Position = UDim2.fromOffset(
                Width,
                CONFIG.TopbarDesktop
            ),

            Size = UDim2.new(
                1,
                -Width,
                1,
                -CONFIG.TopbarDesktop
            )
        }
    )

    for _, Data in pairs(Tabs) do
        Data.Label.Visible = not State
        Data.Icon.Position = State
            and UDim2.fromOffset(15, 0)
            or UDim2.fromOffset(8, 0)
    end
end

Connect(SidebarToggle.Activated:Connect(function()

    SetSidebarCollapsed(
        not SidebarCollapsed
    )

end))

--==================================================
-- THEME ENGINE V3
--==================================================

local function ApplyTheme(Theme)

    CurrentTheme = Theme

    -- Main
    Main.BackgroundColor3 = Theme.Background
    Stroke.Color = Theme.Border

    -- Topbar
    Topbar.BackgroundColor3 = Theme.Surface

    -- Sidebar
    Sidebar.BackgroundColor3 = Theme.Surface

    -- Content
    Content.BackgroundColor3 = Theme.Background

    -- Topbar
    Logo.BackgroundColor3 = Theme.Accent
    Title.TextColor3 = Theme.Text
    Subtitle.TextColor3 = Theme.Muted

    VersionBadge.BackgroundColor3 = Theme.Background
    VersionBadge.TextColor3 = Theme.Accent

    Online.TextColor3 = Theme.Accent

    Minimize.TextColor3 = Theme.Text
    Close.TextColor3 = Theme.Text

    -- Pages
    for _, Object in pairs(ThemeObjects) do

        if Object.Object
            and Object.Object.Parent then

            local Value = Theme[Object.ThemeKey]

            if Value then
                pcall(function()
                    Object.Object[Object.Property] = Value
                end)
            end

        end
    end

    -- Tabs
    for Tab, Data in pairs(Tabs) do

        Data.Icon.TextColor3 =
            CurrentPage == Data.Page
            and Theme.Accent
            or Theme.Muted

        Data.Label.TextColor3 =
            CurrentPage == Data.Page
            and Theme.Text
            or Theme.Muted

        Data.Button.BackgroundColor3 =
            CurrentPage == Data.Page
            and Theme.Surface2
            or Theme.Surface

        Data.Indicator.BackgroundColor3 =
            CurrentPage == Data.Page
            and Theme.Accent
            or Theme.Surface
    end

    -- Theme preview
    for ThemeName, Data in pairs(ThemeButtons) do

        Data.Button.BackgroundColor3 =
            Data.Data.Surface

        Data.Button.TextColor3 =
            Data.Data.Text

        Data.Stroke.Color =
            Data.Data.Accent

        Data.Preview.BackgroundColor3 =
            Data.Data.Accent
    end

end

for ThemeName, Data in pairs(ThemeButtons) do

    Connect(Data.Button.Activated:Connect(function()

        ApplyTheme(Data.Data)

    end))

end

--==================================================
-- INITIAL PAGE
--==================================================

HomePage.Visible = true

for Tab, Data in pairs(Tabs) do
    UpdateTabVisual(
        Tab,
        Data.Page == HomePage
    )
end

--==================================================
-- RESPONSIVE ENGINE
--==================================================

local CurrentLayout = "Desktop"

local function GetViewport()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return Vector2.new(720, 460)
    end

    return Camera.ViewportSize
end

local function ClampMainPosition()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize
    local Size = Main.AbsoluteSize

    local SafePadding = 6

    local MinX = Size.X / 2 + SafePadding
    local MaxX = Viewport.X - Size.X / 2 - SafePadding

    local MinY = Size.Y / 2 + SafePadding
    local MaxY = Viewport.Y - Size.Y / 2 - SafePadding

    local CenterX = Viewport.X / 2
    local CenterY = Viewport.Y / 2

    if MaxX < MinX then
        CenterX = Viewport.X / 2
    else
        CenterX = math.clamp(
            Main.AbsolutePosition.X + Size.X / 2,
            MinX,
            MaxX
        )
    end

    if MaxY < MinY then
        CenterY = Viewport.Y / 2
    else
        CenterY = math.clamp(
            Main.AbsolutePosition.Y + Size.Y / 2,
            MinY,
            MaxY
        )
    end

    Main.Position = UDim2.fromOffset(
        CenterX,
        CenterY
    )

    Main.AnchorPoint = Vector2.new(0.5, 0.5)
end

local function UpdateResponsive()

    local Viewport = GetViewport()

    local Width = Viewport.X
    local Height = Viewport.Y

    local IsMobile = Width < 600
    local IsTablet = Width >= 600 and Width < 900
    local IsLandscape = Width > Height

    if IsMobile then

        CurrentLayout = "Mobile"

        Main.Size = UDim2.new(
            CONFIG.MobileWidthScale,
            0,
            CONFIG.MobileHeightScale,
            0
        )

        MainScale.Scale = 1

        SidebarToggle.Visible = true

        Sidebar.Size = UDim2.new(
            0,
            CONFIG.SidebarMobile,
            1,
            -CONFIG.TopbarMobile
        )

        Content.Position = UDim2.fromOffset(
            CONFIG.SidebarMobile,
            CONFIG.TopbarMobile
        )

        Content.Size = UDim2.new(
            1,
            -CONFIG.SidebarMobile,
            1,
            -CONFIG.TopbarMobile
        )

        Topbar.Size = UDim2.new(
            1,
            0,
            0,
            CONFIG.TopbarMobile
        )

        Title.Position = UDim2.fromOffset(55, 8)
        Title.Size = UDim2.new(1, -105, 0, 22)

        Subtitle.Visible = false
        Logo.Visible = false

        VersionBadge.Visible = false
        Online.Visible = false

        Minimize.Position = UDim2.new(1, -77, 0, 10)
        Close.Position = UDim2.new(1, -38, 0, 10)

        for _, Data in pairs(Tabs) do
            Data.Label.Visible = false
            Data.Icon.Position = UDim2.fromOffset(15, 0)
        end

        if IsLandscape then
            Main.Size = UDim2.new(
                0.86,
                0,
                0.90,
                0
            )
        end

    elseif IsTablet then

        CurrentLayout = "Tablet"

        Main.Size = UDim2.fromOffset(
            CONFIG.TabletWidth,
            CONFIG.TabletHeight
        )

        MainScale.Scale = 0.92

        SidebarToggle.Visible = false

        SidebarCollapsed = false

        Sidebar.Size = UDim2.new(
            0,
            CONFIG.SidebarDesktop,
            1,
            -CONFIG.TopbarDesktop
        )

        Content.Position = UDim2.fromOffset(
            CONFIG.SidebarDesktop,
            CONFIG.TopbarDesktop
        )

        Content.Size = UDim2.new(
            1,
            -CONFIG.SidebarDesktop,
            1,
            -CONFIG.TopbarDesktop
        )

        Topbar.Size = UDim2.new(
            1,
            0,
            0,
            CONFIG.TopbarDesktop
        )

        Logo.Visible = true
        Subtitle.Visible = true
        VersionBadge.Visible = true
        Online.Visible = true

        for _, Data in pairs(Tabs) do
            Data.Label.Visible = true
            Data.Icon.Position = UDim2.fromOffset(8, 0)
        end

    else

        CurrentLayout = "Desktop"

        Main.Size = UDim2.fromOffset(
            CONFIG.DesktopWidth,
            CONFIG.DesktopHeight
        )

        MainScale.Scale = 1

        SidebarToggle.Visible = false

        SidebarCollapsed = false

        Sidebar.Size = UDim2.new(
            0,
            CONFIG.SidebarDesktop,
            1,
            -CONFIG.TopbarDesktop
        )

        Content.Position = UDim2.fromOffset(
            CONFIG.SidebarDesktop,
            CONFIG.TopbarDesktop
        )

        Content.Size = UDim2.new(
            1,
            -CONFIG.SidebarDesktop,
            1,
            -CONFIG.TopbarDesktop
        )

        Topbar.Size = UDim2.new(
            1,
            0,
            0,
            CONFIG.TopbarDesktop
        )

        Logo.Visible = true
        Subtitle.Visible = true
        VersionBadge.Visible = true
        Online.Visible = true

        for _, Data in pairs(Tabs) do
            Data.Label.Visible = true
            Data.Icon.Position = UDim2.fromOffset(8, 0)
        end

    end

    task.defer(function()
        ClampMainPosition()
    end)
end

--==================================================
-- DRAG V3
--==================================================

local Dragging = false
local DragStart
local StartPosition

Connect(Topbar.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true

        DragStart = Input.Position
        StartPosition = Main.Position

    end

end))

Connect(Topbar.InputEnded:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false

    end

end))

Connect(UserInputService.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType ~= Enum.UserInputType.MouseMovement
        and Input.UserInputType ~= Enum.UserInputType.Touch then

        return
    end

    local Delta =
        Input.Position - DragStart

    local NewX =
        StartPosition.X.Offset + Delta.X

    local NewY =
        StartPosition.Y.Offset + Delta.Y

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        NewX,
        StartPosition.Y.Scale,
        NewY
    )

    ClampMainPosition()

end))

--==================================================
-- MINIMIZE V3
--==================================================

local Minimized = false
local SavedSize = Main.Size
local SavedPosition = Main.Position

Connect(Minimize.Activated:Connect(function()

    Minimized = not Minimized

    if Minimized then

        SavedSize = Main.Size
        SavedPosition = Main.Position

        Sidebar.Visible = false
        Content.Visible = false

        PlayTween(
            Main,
            TweenInfo.new(0.22),
            {
                Size = UDim2.new(
                    Main.Size.X.Scale,
                    Main.Size.X.Offset,
                    0,
                    CONFIG.TopbarMobile
                )
            }
        )

        Minimize.Text = "□"

    else

        PlayTween(
            Main,
            TweenInfo.new(0.22),
            {
                Size = SavedSize
            }
        )

        Main.Position = SavedPosition

        task.delay(
            GetTweenTime(0.22),
            function()

                if Mainimized then
                    return
                end

                Sidebar.Visible = true
                Content.Visible = true

                UpdateResponsive()
            end
        )

        Minimize.Text = "—"

    end

end))

--==================================================
-- CLOSE V3
--==================================================

local Closing = false

Connect(Close.Activated:Connect(function()

    if Closing then
        return
    end

    Closing = true
    Dragging = false

    DisconnectAll()

    Sidebar.Visible = false
    Content.Visible = false

    local CloseTween = Tween(
        Main,
        TweenInfo.new(
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In
        ),
        {
            Size = UDim2.fromOffset(0, 0)
        }
    )

    if CloseTween then
        CloseTween:Play()
        CloseTween.Completed:Wait()
    end

    if ScreenGui then
        ScreenGui:Destroy()
    end

end))

--==================================================
-- KEYBOARD / GAMEPAD
--==================================================

ScreenGui.Enabled = true

pcall(function()
    GuiService.SelectedObject = nil
end)

--==================================================
-- VIEWPORT LISTENER
--==================================================

Connect(
    workspace.CurrentCamera:GetPropertyChangedSignal(
        "ViewportSize"
    ):Connect(function()

        UpdateResponsive()

    end)
)

--==================================================
-- FINALIZE
--==================================================

ApplyTheme(CurrentTheme)
UpdateResponsive()

Main.Visible = true
