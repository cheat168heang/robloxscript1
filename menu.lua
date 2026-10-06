--// CH3A5 HUB GUI
--// GUI ONLY + User-provided script loaders

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local Themes = {
    ["Midnight"] = {
        Background = Color3.fromRGB(9, 10, 15),
        Surface = Color3.fromRGB(16, 18, 25),
        Surface2 = Color3.fromRGB(21, 23, 31),
        Accent = Color3.fromRGB(124, 92, 255),
        AccentDark = Color3.fromRGB(91, 65, 205),
        Text = Color3.fromRGB(245, 247, 255),
        Muted = Color3.fromRGB(145, 150, 165),
        Border = Color3.fromRGB(48, 51, 65)
    },

    ["Discord"] = {
        Background = Color3.fromRGB(22, 24, 29),
        Surface = Color3.fromRGB(30, 32, 38),
        Surface2 = Color3.fromRGB(38, 40, 48),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentDark = Color3.fromRGB(71, 82, 200),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(170, 173, 182),
        Border = Color3.fromRGB(55, 58, 68)
    },

    ["GitHub"] = {
        Background = Color3.fromRGB(10, 14, 19),
        Surface = Color3.fromRGB(20, 25, 32),
        Surface2 = Color3.fromRGB(28, 34, 42),
        Accent = Color3.fromRGB(46, 160, 67),
        AccentDark = Color3.fromRGB(32, 120, 50),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158),
        Border = Color3.fromRGB(48, 58, 68)
    },

    ["Spotify"] = {
        Background = Color3.fromRGB(9, 11, 10),
        Surface = Color3.fromRGB(18, 21, 19),
        Surface2 = Color3.fromRGB(27, 31, 28),
        Accent = Color3.fromRGB(30, 215, 96),
        AccentDark = Color3.fromRGB(22, 160, 72),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(165, 172, 168),
        Border = Color3.fromRGB(45, 55, 48)
    },

    ["YouTube"] = {
        Background = Color3.fromRGB(12, 12, 13),
        Surface = Color3.fromRGB(23, 23, 25),
        Surface2 = Color3.fromRGB(32, 32, 35),
        Accent = Color3.fromRGB(255, 45, 45),
        AccentDark = Color3.fromRGB(195, 25, 25),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(175, 175, 180),
        Border = Color3.fromRGB(50, 50, 54)
    },

    ["Telegram"] = {
        Background = Color3.fromRGB(10, 19, 27),
        Surface = Color3.fromRGB(18, 30, 40),
        Surface2 = Color3.fromRGB(25, 42, 54),
        Accent = Color3.fromRGB(42, 171, 238),
        AccentDark = Color3.fromRGB(28, 130, 190),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(155, 180, 195),
        Border = Color3.fromRGB(42, 63, 76)
    },

    ["Twitter"] = {
        Background = Color3.fromRGB(9, 11, 13),
        Surface = Color3.fromRGB(19, 22, 25),
        Surface2 = Color3.fromRGB(27, 31, 35),
        Accent = Color3.fromRGB(29, 155, 240),
        AccentDark = Color3.fromRGB(20, 110, 180),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(155, 165, 175),
        Border = Color3.fromRGB(45, 52, 60)
    },

    ["Twitch"] = {
        Background = Color3.fromRGB(13, 11, 19),
        Surface = Color3.fromRGB(23, 19, 32),
        Surface2 = Color3.fromRGB(32, 27, 44),
        Accent = Color3.fromRGB(145, 70, 255),
        AccentDark = Color3.fromRGB(105, 45, 190),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 170, 195),
        Border = Color3.fromRGB(55, 45, 70)
    },

    ["Dracula"] = {
        Background = Color3.fromRGB(24, 24, 37),
        Surface = Color3.fromRGB(40, 42, 54),
        Surface2 = Color3.fromRGB(50, 52, 67),
        Accent = Color3.fromRGB(189, 147, 249),
        AccentDark = Color3.fromRGB(145, 110, 200),
        Text = Color3.fromRGB(248, 248, 242),
        Muted = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(65, 67, 82)
    },

    ["Ocean"] = {
        Background = Color3.fromRGB(6, 16, 25),
        Surface = Color3.fromRGB(10, 28, 42),
        Surface2 = Color3.fromRGB(15, 39, 56),
        Accent = Color3.fromRGB(0, 190, 255),
        AccentDark = Color3.fromRGB(0, 135, 190),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(145, 180, 195),
        Border = Color3.fromRGB(25, 58, 75)
    },

    ["Crimson"] = {
        Background = Color3.fromRGB(18, 8, 11),
        Surface = Color3.fromRGB(31, 14, 18),
        Surface2 = Color3.fromRGB(43, 19, 24),
        Accent = Color3.fromRGB(235, 55, 75),
        AccentDark = Color3.fromRGB(175, 35, 52),
        Text = Color3.fromRGB(255, 240, 242),
        Muted = Color3.fromRGB(185, 155, 160),
        Border = Color3.fromRGB(67, 35, 41)
    },

    ["Emerald"] = {
        Background = Color3.fromRGB(7, 16, 12),
        Surface = Color3.fromRGB(13, 29, 22),
        Surface2 = Color3.fromRGB(19, 41, 31),
        Accent = Color3.fromRGB(40, 210, 130),
        AccentDark = Color3.fromRGB(27, 155, 94),
        Text = Color3.fromRGB(235, 255, 245),
        Muted = Color3.fromRGB(145, 180, 160),
        Border = Color3.fromRGB(35, 65, 50)
    },

    ["Angkor"] = {
        Background = Color3.fromRGB(16, 11, 7),
        Surface = Color3.fromRGB(30, 22, 14),
        Surface2 = Color3.fromRGB(43, 31, 19),
        Accent = Color3.fromRGB(214, 157, 65),
        AccentDark = Color3.fromRGB(155, 108, 38),
        Text = Color3.fromRGB(255, 245, 220),
        Muted = Color3.fromRGB(185, 160, 125),
        Border = Color3.fromRGB(68, 51, 32)
    }
}

local CurrentTheme = Themes.Midnight

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
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(780, 500)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = CurrentTheme.Border
MainStroke.Transparency = 0.15
MainStroke.Thickness = 1
MainStroke.Parent = Main

local MainGradient = Instance.new("UIGradient")
MainGradient.Rotation = 135
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, CurrentTheme.Background),
    ColorSequenceKeypoint.new(1, CurrentTheme.Surface)
})
MainGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 0.25)
})
MainGradient.Parent = Main

--==================================================
-- TOPBAR
--==================================================

local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 68)
Topbar.BackgroundColor3 = CurrentTheme.Surface
Topbar.BorderSizePixel = 0
Topbar.Parent = Main

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 18)
TopbarCorner.Parent = Topbar

local TopbarLine = Instance.new("Frame")
TopbarLine.Size = UDim2.new(1, -32, 0, 1)
TopbarLine.Position = UDim2.new(0, 16, 1, -1)
TopbarLine.BackgroundColor3 = CurrentTheme.Border
TopbarLine.BorderSizePixel = 0
TopbarLine.Parent = Topbar

local Logo = Instance.new("Frame")
Logo.Size = UDim2.fromOffset(40, 40)
Logo.Position = UDim2.fromOffset(16, 14)
Logo.BackgroundColor3 = CurrentTheme.Accent
Logo.BorderSizePixel = 0
Logo.Parent = Topbar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 11)
LogoCorner.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.fromScale(1, 1)
LogoText.BackgroundTransparency = 1
LogoText.Text = "C"
LogoText.Font = Enum.Font.GothamBlack
LogoText.TextSize = 21
LogoText.TextColor3 = Color3.fromRGB(255,255,255)
LogoText.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 0, 25)
Title.Position = UDim2.fromOffset(68, 12)
Title.BackgroundTransparency = 1
Title.Text = "CH3A5 HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = CurrentTheme.Text
Title.Parent = Topbar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 300, 0, 18)
Subtitle.Position = UDim2.fromOffset(68, 35)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Premium Script Hub  •  V2"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.TextColor3 = CurrentTheme.Muted
Subtitle.Parent = Topbar

local Status = Instance.new("Frame")
Status.Size = UDim2.fromOffset(92, 27)
Status.Position = UDim2.new(1, -190, 0, 20)
Status.BackgroundColor3 = CurrentTheme.Background
Status.BorderSizePixel = 0
Status.Parent = Topbar

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(1, 0)
StatusCorner.Parent = Status

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(7, 7)
StatusDot.Position = UDim2.fromOffset(10, 10)
StatusDot.BackgroundColor3 = CurrentTheme.Accent
StatusDot.BorderSizePixel = 0
StatusDot.Parent = Status

local StatusDotCorner = Instance.new("UICorner")
StatusDotCorner.CornerRadius = UDim.new(1, 0)
StatusDotCorner.Parent = StatusDot

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -25, 1, 0)
StatusText.Position = UDim2.fromOffset(23, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "ONLINE"
StatusText.Font = Enum.Font.GothamBold
StatusText.TextSize = 9
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.TextColor3 = CurrentTheme.Muted
StatusText.Parent = Status

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(36, 36)
Minimize.Position = UDim2.new(1, -88, 0, 16)
Minimize.BackgroundColor3 = CurrentTheme.Background
Minimize.Text = "−"
Minimize.TextSize = 20
Minimize.TextColor3 = CurrentTheme.Text
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.Parent = Topbar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 9)
MinCorner.Parent = Minimize

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(36, 36)
Close.Position = UDim2.new(1, -46, 0, 16)
Close.BackgroundColor3 = CurrentTheme.Background
Close.Text = "×"
Close.TextSize = 21
Close.TextColor3 = CurrentTheme.Text
Close.Font = Enum.Font.GothamBold
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
Sidebar.Size = UDim2.new(0, 190, 1, -68)
Sidebar.Position = UDim2.fromOffset(0, 68)
Sidebar.BackgroundColor3 = CurrentTheme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 16)
SidePadding.PaddingLeft = UDim.new(0, 12)
SidePadding.PaddingRight = UDim.new(0, 12)
SidePadding.PaddingBottom = UDim.new(0, 14)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 7)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

local SideHeader = Instance.new("TextLabel")
SideHeader.Size = UDim2.new(1, 0, 0, 25)
SideHeader.BackgroundTransparency = 1
SideHeader.Text = "NAVIGATION"
SideHeader.Font = Enum.Font.GothamBold
SideHeader.TextSize = 9
SideHeader.TextXAlignment = Enum.TextXAlignment.Left
SideHeader.TextColor3 = CurrentTheme.Muted
SideHeader.LayoutOrder = -10
SideHeader.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -190, 1, -68)
Content.Position = UDim2.fromOffset(190, 68)
Content.BackgroundColor3 = CurrentTheme.Background
Content.BorderSizePixel = 0
Content.Parent = Main

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 16)
ContentPadding.PaddingBottom = UDim.new(0, 16)
ContentPadding.PaddingLeft = UDim.new(0, 18)
ContentPadding.PaddingRight = UDim.new(0, 18)
ContentPadding.Parent = Content

local Pages = {}

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Size = UDim2.fromScale(1, 1)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = CurrentTheme.Accent
    Page.ScrollBarImageTransparency = 0.25
    Page.CanvasSize = UDim2.new()
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 11)
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
-- UI HELPERS
--==================================================

local ThemeObjects = {}

local function RegisterThemeObject(object, property, themeKey)
    table.insert(ThemeObjects, {
        Object = object,
        Property = property,
        Key = themeKey
    })
end

local function AddSection(Page, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -4, 0, 34)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 18
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Text
    Label.Parent = Page

    RegisterThemeObject(Label, "TextColor3", "Text")

    return Label
end

local function AddInfo(Page, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -4, 0, 30)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Muted
    Label.Parent = Page

    RegisterThemeObject(Label, "TextColor3", "Muted")

    return Label
end

local function AddScriptButton(Page, name, description, url)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -4, 0, 74)
    Button.BackgroundColor3 = CurrentTheme.Surface2
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = CurrentTheme.Border
    Stroke.Transparency = 0.25
    Stroke.Thickness = 1
    Stroke.Parent = Button

    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.fromOffset(3, 38)
    Accent.Position = UDim2.fromOffset(0, 18)
    Accent.BackgroundColor3 = CurrentTheme.Accent
    Accent.BorderSizePixel = 0
    Accent.Parent = Button

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(1, 0)
    AccentCorner.Parent = Accent

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -65, 0, 24)
    NameLabel.Position = UDim2.fromOffset(17, 10)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 14
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextColor3 = CurrentTheme.Text
    NameLabel.Parent = Button

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -65, 0, 20)
    Desc.Position = UDim2.fromOffset(17, 37)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 10
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = CurrentTheme.Muted
    Desc.Parent = Button

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.fromOffset(30, 30)
    Arrow.Position = UDim2.new(1, -42, 0.5, -15)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "›"
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 22
    Arrow.TextColor3 = CurrentTheme.Muted
    Arrow.Parent = Button

    RegisterThemeObject(Button, "BackgroundColor3", "Surface2")
    RegisterThemeObject(Stroke, "Color", "Border")
    RegisterThemeObject(Accent, "BackgroundColor3", "Accent")
    RegisterThemeObject(NameLabel, "TextColor3", "Text")
    RegisterThemeObject(Desc, "TextColor3", "Muted")
    RegisterThemeObject(Arrow, "TextColor3", "Muted")

    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.18),
            {BackgroundColor3 = CurrentTheme.Surface}
        ):Play()

        TweenService:Create(
            Arrow,
            TweenInfo.new(0.18),
            {
                TextColor3 = CurrentTheme.Accent,
                Position = UDim2.new(1, -38, 0.5, -15)
            }
        ):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.18),
            {BackgroundColor3 = CurrentTheme.Surface2}
        ):Play()

        TweenService:Create(
            Arrow,
            TweenInfo.new(0.18),
            {
                TextColor3 = CurrentTheme.Muted,
                Position = UDim2.new(1, -42, 0.5, -15)
            }
        ):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        ExecuteScript(url)
    end)

    return Button
end

local function AddComingSoon(Page, name)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -4, 0, 62)
    Button.BackgroundColor3 = CurrentTheme.Surface2
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Button

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.fromOffset(35, 35)
    Icon.Position = UDim2.fromOffset(12, 13)
    Icon.BackgroundColor3 = CurrentTheme.Background
    Icon.Text = "⋯"
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 16
    Icon.TextColor3 = CurrentTheme.Muted
    Icon.Parent = Button

    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 9)
    IconCorner.Parent = Icon

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -65, 0, 24)
    Label.Position = UDim2.fromOffset(58, 9)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Text
    Label.Parent = Button

    local Sub = Instance.new("TextLabel")
    Sub.Size = UDim2.new(1, -65, 0, 18)
    Sub.Position = UDim2.fromOffset(58, 32)
    Sub.BackgroundTransparency = 1
    Sub.Text = "Available in a future update"
    Sub.Font = Enum.Font.Gotham
    Sub.TextSize = 9
    Sub.TextXAlignment = Enum.TextXAlignment.Left
    Sub.TextColor3 = CurrentTheme.Muted
    Sub.Parent = Button

    RegisterThemeObject(Button, "BackgroundColor3", "Surface2")
    RegisterThemeObject(Icon, "BackgroundColor3", "Background")
    RegisterThemeObject(Icon, "TextColor3", "Muted")
    RegisterThemeObject(Label, "TextColor3", "Text")
    RegisterThemeObject(Sub, "TextColor3", "Muted")

    return Button
end

--==================================================
-- HOME
--==================================================

local Hero = Instance.new("Frame")
Hero.Size = UDim2.new(1, -4, 0, 125)
Hero.BackgroundColor3 = CurrentTheme.Surface
Hero.BorderSizePixel = 0
Hero.Parent = HomePage

local HeroCorner = Instance.new("UICorner")
HeroCorner.CornerRadius = UDim.new(0, 14)
HeroCorner.Parent = Hero

local HeroStroke = Instance.new("UIStroke")
HeroStroke.Color = CurrentTheme.Border
HeroStroke.Transparency = 0.2
HeroStroke.Parent = Hero

local HeroTitle = Instance.new("TextLabel")
HeroTitle.Size = UDim2.new(1, -35, 0, 30)
HeroTitle.Position = UDim2.fromOffset(18, 18)
HeroTitle.BackgroundTransparency = 1
HeroTitle.Text = "Welcome to CH3A5 HUB"
HeroTitle.Font = Enum.Font.GothamBold
HeroTitle.TextSize = 20
HeroTitle.TextXAlignment = Enum.TextXAlignment.Left
HeroTitle.TextColor3 = CurrentTheme.Text
HeroTitle.Parent = Hero

local HeroDesc = Instance.new("TextLabel")
HeroDesc.Size = UDim2.new(1, -35, 0, 42)
HeroDesc.Position = UDim2.fromOffset(18, 52)
HeroDesc.BackgroundTransparency = 1
HeroDesc.Text = "A clean and premium script hub interface.\nSelect a category from the sidebar to continue."
HeroDesc.Font = Enum.Font.Gotham
HeroDesc.TextSize = 11
HeroDesc.TextWrapped = true
HeroDesc.TextXAlignment = Enum.TextXAlignment.Left
HeroDesc.TextYAlignment = Enum.TextYAlignment.Top
HeroDesc.TextColor3 = CurrentTheme.Muted
HeroDesc.Parent = Hero

local HeroBadge = Instance.new("TextLabel")
HeroBadge.Size = UDim2.fromOffset(70, 24)
HeroBadge.Position = UDim2.new(1, -88, 0, 17)
HeroBadge.BackgroundColor3 = CurrentTheme.Background
HeroBadge.Text = "V2"
HeroBadge.Font = Enum.Font.GothamBold
HeroBadge.TextSize = 10
HeroBadge.TextColor3 = CurrentTheme.Accent
HeroBadge.Parent = Hero

local HeroBadgeCorner = Instance.new("UICorner")
HeroBadgeCorner.CornerRadius = UDim.new(1, 0)
HeroBadgeCorner.Parent = HeroBadge

RegisterThemeObject(Hero, "BackgroundColor3", "Surface")
RegisterThemeObject(HeroStroke, "Color", "Border")
RegisterThemeObject(HeroTitle, "TextColor3", "Text")
RegisterThemeObject(HeroDesc, "TextColor3", "Muted")
RegisterThemeObject(HeroBadge, "BackgroundColor3", "Background")
RegisterThemeObject(HeroBadge, "TextColor3", "Accent")

AddSection(HomePage, "Quick Access")
AddInfo(HomePage, "Choose a script category.")

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
-- THEMES
--==================================================

AddSection(ThemesPage, "Appearance")
AddInfo(ThemesPage, "Choose a visual theme for CH3A5 HUB.")

local ThemeGrid = Instance.new("Frame")
ThemeGrid.Size = UDim2.new(1, -4, 0, 1)
ThemeGrid.AutomaticSize = Enum.AutomaticSize.Y
ThemeGrid.BackgroundTransparency = 1
ThemeGrid.Parent = ThemesPage

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0.5, -6, 0, 58)
Grid.CellPadding = UDim2.fromOffset(10, 10)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = ThemeGrid

for ThemeName, ThemeData in pairs(Themes) do
    local Button = Instance.new("TextButton")
    Button.BackgroundColor3 = ThemeData.Surface
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = ThemeGrid

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Button

    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.fromOffset(5, 34)
    AccentBar.Position = UDim2.fromOffset(10, 12)
    AccentBar.BackgroundColor3 = ThemeData.Accent
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Button

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(1, 0)
    AccentCorner.Parent = AccentBar

    local Name = Instance.new("TextLabel")
    Name.Size = UDim2.new(1, -35, 1, 0)
    Name.Position = UDim2.fromOffset(25, 0)
    Name.BackgroundTransparency = 1
    Name.Text = ThemeName
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 11
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = ThemeData.Text
    Name.Parent = Button

    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = ThemeData.Surface2}
        ):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = ThemeData.Surface}
        ):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        CurrentTheme = ThemeData

        Main.BackgroundColor3 = ThemeData.Background
        MainStroke.Color = ThemeData.Border
        MainGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, ThemeData.Background),
            ColorSequenceKeypoint.new(1, ThemeData.Surface)
        })

        for _, item in ipairs(ThemeObjects) do
            if item.Object and item.Object.Parent then
                local value = ThemeData[item.Key]

                if value then
                    TweenService:Create(
                        item.Object,
                        TweenInfo.new(0.25),
                        {[item.Property] = value}
                    ):Play()
                end
            end
        end

        Topbar.BackgroundColor3 = ThemeData.Surface
        Sidebar.BackgroundColor3 = ThemeData.Surface
        Content.BackgroundColor3 = ThemeData.Background
        Status.BackgroundColor3 = ThemeData.Background
        StatusDot.BackgroundColor3 = ThemeData.Accent
        TopbarLine.BackgroundColor3 = ThemeData.Border

        Title.TextColor3 = ThemeData.Text
        Subtitle.TextColor3 = ThemeData.Muted
        StatusText.TextColor3 = ThemeData.Muted
        Minimize.BackgroundColor3 = ThemeData.Background
        Minimize.TextColor3 = ThemeData.Text
        Close.BackgroundColor3 = ThemeData.Background
        Close.TextColor3 = ThemeData.Text
        Logo.BackgroundColor3 = ThemeData.Accent
        SideHeader.TextColor3 = ThemeData.Muted
    end)
end

--==================================================
-- SETTINGS
--==================================================

AddSection(SettingsPage, "Settings")
AddInfo(SettingsPage, "Interface preferences for CH3A5 HUB.")

AddComingSoon(SettingsPage, "Notifications")
AddComingSoon(SettingsPage, "Interface Customization")
AddComingSoon(SettingsPage, "More Settings")

--==================================================
-- SIDEBAR BUTTON
--==================================================

local Tabs = {}
local ActiveTab

local function AddTab(name, icon, page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 43)
    Button.BackgroundColor3 = CurrentTheme.Background
    Button.BackgroundTransparency = 0.35
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.fromOffset(3, 22)
    Indicator.Position = UDim2.fromOffset(0, 10)
    Indicator.BackgroundColor3 = CurrentTheme.Accent
    Indicator.BorderSizePixel = 0
    Indicator.BackgroundTransparency = 1
    Indicator.Parent = Button

    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.fromOffset(28, 43)
    Icon.Position = UDim2.fromOffset(10, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 14
    Icon.TextColor3 = CurrentTheme.Muted
    Icon.Parent = Button

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -48, 1, 0)
    Label.Position = UDim2.fromOffset(42, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Muted
    Label.Parent = Button

    Tabs[Button] = {
        Page = page,
        Indicator = Indicator,
        Icon = Icon,
        Label = Label
    }

    Button.MouseEnter:Connect(function()
        if ActiveTab ~= Button then
            TweenService:Create(
                Button,
                TweenInfo.new(0.15),
                {BackgroundTransparency = 0.05}
            ):Play()
        end
    end)

    Button.MouseLeave:Connect(function()
        if ActiveTab ~= Button then
            TweenService:Create(
                Button,
                TweenInfo.new(0.15),
                {BackgroundTransparency = 0.35}
            ):Play()
        end
    end)

    Button.MouseButton1Click:Connect(function()
        for _, Page in pairs(Pages) do
            Page.Visible = false
        end

        page.Visible = true

        if ActiveTab then
            local Old = Tabs[ActiveTab]

            TweenService:Create(
                ActiveTab,
                TweenInfo.new(0.18),
                {BackgroundTransparency = 0.35}
            ):Play()

            TweenService:Create(
                Old.Indicator,
                TweenInfo.new(0.18),
                {BackgroundTransparency = 1}
            ):Play()

            TweenService:Create(
                Old.Icon,
                TweenInfo.new(0.18),
                {TextColor3 = CurrentTheme.Muted}
            ):Play()

            TweenService:Create(
                Old.Label,
                TweenInfo.new(0.18),
                {TextColor3 = CurrentTheme.Muted}
            ):Play()
        end

        ActiveTab = Button

        TweenService:Create(
            Button,
            TweenInfo.new(0.18),
            {BackgroundTransparency = 0}
        ):Play()

        TweenService:Create(
            Indicator,
            TweenInfo.new(0.18),
            {BackgroundTransparency = 0}
        ):Play()

        TweenService:Create(
            Icon,
            TweenInfo.new(0.18),
            {TextColor3 = CurrentTheme.Accent}
        ):Play()

        TweenService:Create(
            Label,
            TweenInfo.new(0.18),
            {TextColor3 = CurrentTheme.Text}
        ):Play()
    end)

    return Button
end

local HomeTab = AddTab("Home", "⌂", HomePage)
AddTab("Keyless", "⚡", KeylessPage)
AddTab("Key Scripts", "🔑", KeyPage)
AddTab("Themes", "◆", ThemesPage)
AddTab("Settings", "⚙", SettingsPage)

HomePage.Visible = true
ActiveTab = HomeTab

Tabs[HomeTab].Indicator.BackgroundTransparency = 0
Tabs[HomeTab].Icon.TextColor3 = CurrentTheme.Accent
Tabs[HomeTab].Label.TextColor3 = CurrentTheme.Text
HomeTab.BackgroundTransparency = 0

--==================================================
-- DRAG
--==================================================

local Dragging = false
local DragStart
local StartPosition

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position
    end
end)

Topbar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not Dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local Delta = input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

--==================================================
-- MINIMIZE / CLOSE
--==================================================

local Minimized = false
local OriginalSize = UDim2.fromOffset(780, 500)

Minimize.MouseEnter:Connect(function()
    TweenService:Create(
        Minimize,
        TweenInfo.new(0.15),
        {BackgroundColor3 = CurrentTheme.Surface2}
    ):Play()
end)

Minimize.MouseLeave:Connect(function()
    TweenService:Create(
        Minimize,
        TweenInfo.new(0.15),
        {BackgroundColor3 = CurrentTheme.Background}
    ):Play()
end)

Close.MouseEnter:Connect(function()
    TweenService:Create(
        Close,
        TweenInfo.new(0.15),
        {BackgroundColor3 = CurrentTheme.Accent}
    ):Play()
end)

Close.MouseLeave:Connect(function()
    TweenService:Create(
        Close,
        TweenInfo.new(0.15),
        {BackgroundColor3 = CurrentTheme.Background}
    ):Play()
end)

Minimize.MouseButton1Click:Connect(function()
    Minimized = not Minimized

    if Minimized then
        TweenService:Create(
            Main,
            TweenInfo.new(
                0.25,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.Out
            ),
            {Size = UDim2.new(Main.Size.X.Scale, Main.Size.X.Offset, 0, 68)}
        ):Play()

        Sidebar.Visible = false
        Content.Visible = false
        Minimize.Text = "+"
    else
        Sidebar.Visible = true
        Content.Visible = true

        TweenService:Create(
            Main,
            TweenInfo.new(
                0.25,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.Out
            ),
            {Size = OriginalSize}
        ):Play()

        Minimize.Text = "−"
    end
end)

Close.MouseButton1Click:Connect(function()
    local CloseTween = TweenService:Create(
        Main,
        TweenInfo.new(
            0.25,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.In
        ),
        {
            Size = UDim2.fromOffset(20, 20),
            BackgroundTransparency = 1
        }
    )

    CloseTween:Play()
    CloseTween.Completed:Wait()

    ScreenGui:Destroy()
end)

--==================================================
-- RESPONSIVE
--==================================================

local function UpdateResponsive()
    local Camera = workspace.CurrentCamera
    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize
    local Width = Viewport.X
    local Height = Viewport.Y

    if Width <= 600 then
        Main.Size = UDim2.new(0.94, 0, 0, math.min(500, Height - 35))
        Main.Position = UDim2.fromScale(0.5, 0.5)

        Sidebar.Size = UDim2.new(0, 145, 1, -68)
        Content.Size = UDim2.new(1, -145, 1, -68)
        Content.Position = UDim2.fromOffset(145, 68)

        SidePadding.PaddingLeft = UDim.new(0, 8)
        SidePadding.PaddingRight = UDim.new(0, 8)

        Title.TextSize = 16
        Subtitle.TextSize = 9

        Status.Visible = false

        HeroTitle.TextSize = 16
        HeroDesc.TextSize = 9

    elseif Width <= 850 then
        Main.Size = UDim2.new(0.92, 0, 0, 480)
        Main.Position = UDim2.fromScale(0.5, 0.5)

        Sidebar.Size = UDim2.new(0, 165, 1, -68)
        Content.Size = UDim2.new(1, -165, 1, -68)
        Content.Position = UDim2.fromOffset(165, 68)

        Status.Visible = false

    else
        Main.Size = UDim2.fromOffset(780, 500)
        Main.Position = UDim2.fromScale(0.5, 0.5)

        Sidebar.Size = UDim2.new(0, 190, 1, -68)
        Content.Size = UDim2.new(1, -190, 1, -68)
        Content.Position = UDim2.fromOffset(190, 68)

        Status.Visible = true
    end
end

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(
    UpdateResponsive
)

UpdateResponsive()

--==================================================
-- OPEN ANIMATION
--==================================================

local FinalSize = Main.Size

Main.Size = UDim2.fromOffset(50, 50)
Main.BackgroundTransparency = 1

task.defer(function()
    TweenService:Create(
        Main,
        TweenInfo.new(
            0.45,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = FinalSize,
            BackgroundTransparency = 0
        }
    ):Play()
end)
