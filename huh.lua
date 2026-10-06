--==================================================
-- CH3A5 HUB V3
-- Adaptive Premium UI
-- GUI / UI ARCHITECTURE ONLY
--==================================================

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
-- DUPLICATE GUI PROTECTION
--==================================================

local OldGui = PlayerGui:FindFirstChild("CH3A5_HUB_V3")

if OldGui then
    OldGui:Destroy()
end

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
    Name = "CH3A5_HUB_V3",

    DesktopSize = Vector2.new(820, 520),
    TabletSize = Vector2.new(720, 480),
    MobileSize = Vector2.new(350, 500),

    MinWidth = 320,
    MinHeight = 360,

    MaxWidth = 920,
    MaxHeight = 650,

    SidebarWidth = 190,
    SidebarCollapsedWidth = 68,

    TopbarHeight = 68,

    Corner = 18,

    AnimationTime = 0.22,

    MobileBreakpoint = 650,
    TabletBreakpoint = 900,
}

--==================================================
-- THEMES
--==================================================

local Themes = {

    Midnight = {
        Background = Color3.fromRGB(9, 11, 17),
        Surface = Color3.fromRGB(15, 18, 27),
        Surface2 = Color3.fromRGB(20, 24, 35),
        Accent = Color3.fromRGB(112, 91, 255),
        AccentDark = Color3.fromRGB(73, 59, 180),
        Border = Color3.fromRGB(42, 47, 64),
        Text = Color3.fromRGB(245, 247, 255),
        Muted = Color3.fromRGB(150, 157, 175),
    },

    Discord = {
        Background = Color3.fromRGB(20, 21, 25),
        Surface = Color3.fromRGB(30, 31, 34),
        Surface2 = Color3.fromRGB(43, 45, 49),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentDark = Color3.fromRGB(65, 75, 190),
        Border = Color3.fromRGB(65, 68, 75),
        Text = Color3.fromRGB(242, 243, 245),
        Muted = Color3.fromRGB(148, 155, 164),
    },

    GitHub = {
        Background = Color3.fromRGB(13, 17, 23),
        Surface = Color3.fromRGB(22, 27, 34),
        Surface2 = Color3.fromRGB(33, 38, 45),
        Accent = Color3.fromRGB(46, 164, 79),
        AccentDark = Color3.fromRGB(31, 120, 58),
        Border = Color3.fromRGB(48, 54, 61),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158),
    },

    Spotify = {
        Background = Color3.fromRGB(12, 12, 12),
        Surface = Color3.fromRGB(24, 24, 24),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(30, 215, 96),
        AccentDark = Color3.fromRGB(20, 145, 65),
        Border = Color3.fromRGB(55, 55, 55),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(165, 165, 165),
    },

    YouTube = {
        Background = Color3.fromRGB(15, 15, 15),
        Surface = Color3.fromRGB(25, 25, 25),
        Surface2 = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(255, 0, 0),
        AccentDark = Color3.fromRGB(175, 0, 0),
        Border = Color3.fromRGB(55, 55, 55),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(170, 170, 170),
    },

    Telegram = {
        Background = Color3.fromRGB(11, 22, 31),
        Surface = Color3.fromRGB(18, 36, 50),
        Surface2 = Color3.fromRGB(25, 49, 67),
        Accent = Color3.fromRGB(42, 171, 238),
        AccentDark = Color3.fromRGB(28, 120, 175),
        Border = Color3.fromRGB(40, 70, 88),
        Text = Color3.fromRGB(245, 250, 255),
        Muted = Color3.fromRGB(150, 175, 190),
    },

    Twitter = {
        Background = Color3.fromRGB(10, 15, 20),
        Surface = Color3.fromRGB(20, 28, 36),
        Surface2 = Color3.fromRGB(30, 40, 50),
        Accent = Color3.fromRGB(29, 155, 240),
        AccentDark = Color3.fromRGB(20, 105, 170),
        Border = Color3.fromRGB(48, 62, 75),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(145, 160, 175),
    },

    Twitch = {
        Background = Color3.fromRGB(14, 12, 20),
        Surface = Color3.fromRGB(24, 20, 34),
        Surface2 = Color3.fromRGB(37, 30, 51),
        Accent = Color3.fromRGB(145, 70, 255),
        AccentDark = Color3.fromRGB(95, 45, 175),
        Border = Color3.fromRGB(55, 44, 75),
        Text = Color3.fromRGB(245, 242, 255),
        Muted = Color3.fromRGB(160, 150, 175),
    },

    Dracula = {
        Background = Color3.fromRGB(40, 42, 54),
        Surface = Color3.fromRGB(48, 50, 65),
        Surface2 = Color3.fromRGB(68, 70, 85),
        Accent = Color3.fromRGB(189, 147, 249),
        AccentDark = Color3.fromRGB(135, 100, 190),
        Border = Color3.fromRGB(75, 77, 94),
        Text = Color3.fromRGB(248, 248, 242),
        Muted = Color3.fromRGB(170, 170, 180),
    },

    Ocean = {
        Background = Color3.fromRGB(5, 18, 27),
        Surface = Color3.fromRGB(8, 30, 43),
        Surface2 = Color3.fromRGB(12, 43, 58),
        Accent = Color3.fromRGB(0, 200, 255),
        AccentDark = Color3.fromRGB(0, 125, 170),
        Border = Color3.fromRGB(25, 65, 80),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(135, 170, 185),
    },

    Crimson = {
        Background = Color3.fromRGB(18, 8, 12),
        Surface = Color3.fromRGB(31, 12, 18),
        Surface2 = Color3.fromRGB(47, 17, 25),
        Accent = Color3.fromRGB(235, 55, 75),
        AccentDark = Color3.fromRGB(155, 30, 48),
        Border = Color3.fromRGB(70, 28, 38),
        Text = Color3.fromRGB(255, 242, 245),
        Muted = Color3.fromRGB(180, 145, 153),
    },

    Emerald = {
        Background = Color3.fromRGB(7, 18, 14),
        Surface = Color3.fromRGB(11, 30, 23),
        Surface2 = Color3.fromRGB(17, 45, 34),
        Accent = Color3.fromRGB(46, 220, 140),
        AccentDark = Color3.fromRGB(30, 145, 92),
        Border = Color3.fromRGB(28, 70, 55),
        Text = Color3.fromRGB(237, 255, 247),
        Muted = Color3.fromRGB(140, 175, 160),
    },

    Angkor = {
        Background = Color3.fromRGB(15, 11, 7),
        Surface = Color3.fromRGB(29, 21, 13),
        Surface2 = Color3.fromRGB(45, 31, 17),
        Accent = Color3.fromRGB(214, 163, 74),
        AccentDark = Color3.fromRGB(145, 104, 38),
        Border = Color3.fromRGB(83, 61, 30),
        Text = Color3.fromRGB(255, 244, 220),
        Muted = Color3.fromRGB(180, 157, 120),
    },
}

local CurrentTheme = Themes.Midnight

--==================================================
-- STATE
--==================================================

local State = {
    CurrentPage = "Home",
    Minimized = false,
    SidebarOpen = true,
    IsMobile = false,
    IsTablet = false,
    IsDragging = false,
    IsClosing = false,
    WindowSize = nil,
    WindowPosition = nil,
}

--==================================================
-- CONNECTION MANAGER
--==================================================

local Connections = {}

local function Connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(Connections, connection)
    return connection
end

local function CleanupConnections()
    for _, connection in ipairs(Connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    table.clear(Connections)
end

--==================================================
-- GUI ROOT
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = CONFIG.Name
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
end)

ScreenGui.Parent = PlayerGui

--==================================================
-- HELPERS
--==================================================

local function New(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    if parent then
        object.Parent = parent
    end

    return object
end

local function Corner(object, radius)
    return New("UICorner", {
        CornerRadius = UDim.new(0, radius or CONFIG.Corner),
    }, object)
end

local function Stroke(object, color, transparency, thickness)
    return New("UIStroke", {
        Color = color or CurrentTheme.Border,
        Transparency = transparency or 0,
        Thickness = thickness or 1,
    }, object)
end

local function Padding(object, left, right, top, bottom)
    return New("UIPadding", {
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
    }, object)
end

local function Gradient(object, color1, color2, rotation)
    return New("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color1),
            ColorSequenceKeypoint.new(1, color2),
        }),
        Rotation = rotation or 0,
    }, object)
end

--==================================================
-- MOTION
--==================================================

local function TweenTime(defaultTime)
    if GuiService.ReducedMotionEnabled then
        return 0
    end

    return defaultTime or CONFIG.AnimationTime
end

local function Tween(object, properties, duration)
    local info = TweenInfo.new(
        TweenTime(duration),
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    local tween = TweenService:Create(object, info, properties)
    tween:Play()

    return tween
end

--==================================================
-- THEME REGISTRY
--==================================================

local ThemeRegistry = {
    Backgrounds = {},
    Surfaces = {},
    Borders = {},
    Texts = {},
    MutedTexts = {},
    Accents = {},
}

local function RegisterTheme(object, property, category)
    if not object then
        return
    end

    if not ThemeRegistry[category] then
        ThemeRegistry[category] = {}
    end

    table.insert(ThemeRegistry[category], {
        Object = object,
        Property = property,
    })
end

local function ApplyTheme(theme)
    CurrentTheme = theme

    local maps = {
        Backgrounds = theme.Background,
        Surfaces = theme.Surface,
        Borders = theme.Border,
        Texts = theme.Text,
        MutedTexts = theme.Muted,
        Accents = theme.Accent,
    }

    for category, color in pairs(maps) do
        for _, item in ipairs(ThemeRegistry[category] or {}) do
            if item.Object and item.Object.Parent then
                pcall(function()
                    item.Object[item.Property] = color
                end)
            end
        end
    end
end

--==================================================
-- MAIN WINDOW
--==================================================

local Main = New("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(CONFIG.DesktopSize.X, CONFIG.DesktopSize.Y),
    BackgroundColor3 = CurrentTheme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, ScreenGui)

Corner(Main, CONFIG.Corner)

local MainStroke = Stroke(Main, CurrentTheme.Border, 0.15, 1.2)
RegisterTheme(Main, "BackgroundColor3", "Backgrounds")
RegisterTheme(MainStroke, "Color", "Borders")

local MainScale = New("UIScale", {
    Scale = 1,
}, Main)

New("UISizeConstraint", {
    MinSize = Vector2.new(CONFIG.MinWidth, CONFIG.MinHeight),
    MaxSize = Vector2.new(CONFIG.MaxWidth, CONFIG.MaxHeight),
}, Main)

Gradient(
    Main,
    CurrentTheme.Background,
    CurrentTheme.Surface,
    135
)

--==================================================
-- TOPBAR
--==================================================

local Topbar = New("Frame", {
    Name = "Topbar",
    Size = UDim2.new(1, 0, 0, CONFIG.TopbarHeight),
    BackgroundColor3 = CurrentTheme.Surface,
    BorderSizePixel = 0,
}, Main)

RegisterTheme(Topbar, "BackgroundColor3", "Surfaces")

local TopbarLine = New("Frame", {
    Name = "BottomLine",
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 0, 1, 0),
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = CurrentTheme.Border,
    BorderSizePixel = 0,
}, Topbar)

RegisterTheme(TopbarLine, "BackgroundColor3", "Borders")

--==================================================
-- LOGO
--==================================================

local Logo = New("Frame", {
    Name = "Logo",
    Position = UDim2.fromOffset(16, 14),
    Size = UDim2.fromOffset(40, 40),
    BackgroundColor3 = CurrentTheme.Accent,
    BorderSizePixel = 0,
}, Topbar)

Corner(Logo, 12)
RegisterTheme(Logo, "BackgroundColor3", "Accents")

local LogoText = New("TextLabel", {
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    Font = Enum.Font.GothamBold,
    Text = "C",
    TextSize = 22,
    TextColor3 = Color3.new(1, 1, 1),
}, Logo)

--==================================================
-- TITLE
--==================================================

local Title = New("TextLabel", {
    Name = "Title",
    Position = UDim2.fromOffset(68, 11),
    Size = UDim2.new(0, 300, 0, 25),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "CH3A5 HUB",
    TextSize = 19,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Text,
}, Topbar)

RegisterTheme(Title, "TextColor3", "Texts")

local Subtitle = New("TextLabel", {
    Position = UDim2.fromOffset(69, 37),
    Size = UDim2.new(0, 330, 0, 18),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Adaptive Premium Interface",
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Muted,
}, Topbar)

RegisterTheme(Subtitle, "TextColor3", "MutedTexts")

--==================================================
-- ONLINE STATUS
--==================================================

local Status = New("Frame", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -130, 0.5, 0),
    Size = UDim2.fromOffset(82, 30),
    BackgroundColor3 = CurrentTheme.Surface2,
    BorderSizePixel = 0,
}, Topbar)

Corner(Status, 15)
RegisterTheme(Status, "BackgroundColor3", "Surfaces")

local StatusDot = New("Frame", {
    Position = UDim2.fromOffset(10, 11),
    Size = UDim2.fromOffset(8, 8),
    BackgroundColor3 = Color3.fromRGB(65, 220, 125),
    BorderSizePixel = 0,
}, Status)

Corner(StatusDot, 8)

local StatusText = New("TextLabel", {
    Position = UDim2.fromOffset(23, 0),
    Size = UDim2.new(1, -28, 1, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamMedium,
    Text = "ONLINE",
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Text,
}, Status)

RegisterTheme(StatusText, "TextColor3", "Texts")

--==================================================
-- WINDOW BUTTONS
--==================================================

local MinimizeButton = New("TextButton", {
    Name = "Minimize",
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -75, 0.5, 0),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = CurrentTheme.Surface2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "—",
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextColor3 = CurrentTheme.Text,
}, Topbar)

Corner(MinimizeButton, 9)
RegisterTheme(MinimizeButton, "BackgroundColor3", "Surfaces")
RegisterTheme(MinimizeButton, "TextColor3", "Texts")

local CloseButton = New("TextButton", {
    Name = "Close",
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -37, 0.5, 0),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = CurrentTheme.Surface2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "×",
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextColor3 = CurrentTheme.Text,
}, Topbar)

Corner(CloseButton, 9)
RegisterTheme(CloseButton, "BackgroundColor3", "Surfaces")
RegisterTheme(CloseButton, "TextColor3", "Texts")

--==================================================
-- BODY
--==================================================

local Body = New("Frame", {
    Name = "Body",
    Position = UDim2.fromOffset(0, CONFIG.TopbarHeight),
    Size = UDim2.new(1, 0, 1, -CONFIG.TopbarHeight),
    BackgroundTransparency = 1,
}, Main)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, CONFIG.SidebarWidth, 1, 0),
    BackgroundColor3 = CurrentTheme.Surface,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, Body)

RegisterTheme(Sidebar, "BackgroundColor3", "Surfaces")

Padding(Sidebar, 12, 12, 14, 14)

local NavTitle = New("TextLabel", {
    Size = UDim2.new(1, 0, 0, 20),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "NAVIGATION",
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Muted,
}, Sidebar)

RegisterTheme(NavTitle, "TextColor3", "MutedTexts")

--==================================================
-- SIDEBAR BUTTON HOLDER
--==================================================

local SidebarList = New("Frame", {
    Position = UDim2.fromOffset(0, 32),
    Size = UDim2.new(1, 0, 1, -32),
    BackgroundTransparency = 1,
}, Sidebar)

New("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, SidebarList)

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
    Name = "Content",
    Position = UDim2.new(0, CONFIG.SidebarWidth, 0, 0),
    Size = UDim2.new(1, -CONFIG.SidebarWidth, 1, 0),
    BackgroundColor3 = CurrentTheme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, Body)

RegisterTheme(Content, "BackgroundColor3", "Backgrounds")

--==================================================
-- PAGE CONTAINER
--==================================================

local Pages = {}

local function CreatePage(name)
    local Page = New("ScrollingFrame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = CurrentTheme.Accent,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = false,
    }, Content)

    Padding(Page, 22, 22, 22, 22)

    New("UIListLayout", {
        Padding = UDim.new(0, 14),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, Page)

    Pages[name] = Page

    return Page
end

local HomePage = CreatePage("Home")
local KeylessPage = CreatePage("Keyless")
local KeyPage = CreatePage("Key")
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")

--==================================================
-- TEXT HELPERS
--==================================================

local function AddHeader(Page, title, description)
    local Header = New("Frame", {
        Size = UDim2.new(1, 0, 0, 58),
        BackgroundTransparency = 1,
    }, Page)

    local TitleLabel = New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = title,
        TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Text,
    }, Header)

    RegisterTheme(TitleLabel, "TextColor3", "Texts")

    local DescriptionLabel = New("TextLabel", {
        Position = UDim2.fromOffset(0, 31),
        Size = UDim2.new(1, 0, 0, 22),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = description or "",
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Header)

    RegisterTheme(DescriptionLabel, "TextColor3", "MutedTexts")

    return Header
end

local function AddSection(Page, text)
    local Label = New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 22),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = text,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Page)

    RegisterTheme(Label, "TextColor3", "MutedTexts")

    return Label
end

local function AddInfo(Page, text)
    local Info = New("Frame", {
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = CurrentTheme.Surface,
        BorderSizePixel = 0,
    }, Page)

    Corner(Info, 12)
    Stroke(Info, CurrentTheme.Border, 0.35, 1)

    RegisterTheme(Info, "BackgroundColor3", "Surfaces")

    local Label = New("TextLabel", {
        Position = UDim2.fromOffset(15, 0),
        Size = UDim2.new(1, -30, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Info)

    RegisterTheme(Label, "TextColor3", "MutedTexts")

    return Info
end

--==================================================
-- SCRIPT CARD
--==================================================

local function AddScriptButton(Page, title, description, callback, badge)
    local Card = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 76),
        BackgroundColor3 = CurrentTheme.Surface,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
    }, Page)

    Corner(Card, 14)

    local CardStroke = Stroke(Card, CurrentTheme.Border, 0.35, 1)

    RegisterTheme(Card, "BackgroundColor3", "Surfaces")
    RegisterTheme(CardStroke, "Color", "Borders")

    local AccentBar = New("Frame", {
        Position = UDim2.fromOffset(0, 13),
        Size = UDim2.fromOffset(3, 50),
        BackgroundColor3 = CurrentTheme.Accent,
        BorderSizePixel = 0,
    }, Card)

    Corner(AccentBar, 3)
    RegisterTheme(AccentBar, "BackgroundColor3", "Accents")

    local NameLabel = New("TextLabel", {
        Position = UDim2.fromOffset(17, 11),
        Size = UDim2.new(1, -145, 0, 24),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = title,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Text,
    }, Card)

    RegisterTheme(NameLabel, "TextColor3", "Texts")

    local DescriptionLabel = New("TextLabel", {
        Position = UDim2.fromOffset(17, 37),
        Size = UDim2.new(1, -145, 0, 22),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = description or "Ready",
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Card)

    RegisterTheme(DescriptionLabel, "TextColor3", "MutedTexts")

    if badge then
        local Badge = New("TextLabel", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -42, 0.5, 0),
            Size = UDim2.fromOffset(72, 24),
            BackgroundColor3 = CurrentTheme.Surface2,
            BorderSizePixel = 0,
            Font = Enum.Font.GothamBold,
            Text = badge,
            TextSize = 9,
            TextColor3 = CurrentTheme.Accent,
        }, Card)

        Corner(Badge, 12)
        RegisterTheme(Badge, "BackgroundColor3", "Surfaces")
        RegisterTheme(Badge, "TextColor3", "Accents")
    end

    local Arrow = New("TextLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -14, 0.5, 0),
        Size = UDim2.fromOffset(20, 25),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = "›",
        TextSize = 20,
        TextColor3 = CurrentTheme.Muted,
    }, Card)

    RegisterTheme(Arrow, "TextColor3", "MutedTexts")

    Connect(Card.MouseEnter, function()
        Tween(Card, {
            BackgroundColor3 = CurrentTheme.Surface2,
        }, 0.14)

        Tween(Arrow, {
            TextColor3 = CurrentTheme.Accent,
        }, 0.14)
    end)

    Connect(Card.MouseLeave, function()
        Tween(Card, {
            BackgroundColor3 = CurrentTheme.Surface,
        }, 0.14)

        Tween(Arrow, {
            TextColor3 = CurrentTheme.Muted,
        }, 0.14)
    end)

    Connect(Card.Activated, function()
        if callback then
            callback()
        end
    end)

    return Card
end

local function AddComingSoon(Page, title, description)
    return AddScriptButton(
        Page,
        title,
        description or "This section is under development.",
        nil,
        "SOON"
    )
end

--==================================================
-- HOME
--==================================================

AddHeader(
    HomePage,
    "Welcome to CH3A5 HUB",
    "Premium adaptive interface • V3"
)

local Hero = New("Frame", {
    Size = UDim2.new(1, 0, 0, 135),
    BackgroundColor3 = CurrentTheme.Surface,
    BorderSizePixel = 0,
}, HomePage)

Corner(Hero, 16)

local HeroStroke = Stroke(Hero, CurrentTheme.Border, 0.25, 1)

RegisterTheme(Hero, "BackgroundColor3", "Surfaces")
RegisterTheme(HeroStroke, "Color", "Borders")

Gradient(
    Hero,
    CurrentTheme.Surface,
    CurrentTheme.Surface2,
    20
)

local HeroTitle = New("TextLabel", {
    Position = UDim2.fromOffset(18, 17),
    Size = UDim2.new(1, -36, 0, 30),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "CH3A5 HUB V3",
    TextSize = 23,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Text,
}, Hero)

RegisterTheme(HeroTitle, "TextColor3", "Texts")

local HeroDescription = New("TextLabel", {
    Position = UDim2.fromOffset(19, 52),
    Size = UDim2.new(1, -38, 0, 38),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Adaptive • Responsive • Premium • Clean",
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Muted,
}, Hero)

RegisterTheme(HeroDescription, "TextColor3", "MutedTexts")

local VersionBadge = New("TextLabel", {
    Position = UDim2.fromOffset(19, 98),
    Size = UDim2.fromOffset(72, 22),
    BackgroundColor3 = CurrentTheme.Accent,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "V3.0",
    TextSize = 9,
    TextColor3 = Color3.new(1, 1, 1),
}, Hero)

Corner(VersionBadge, 11)
RegisterTheme(VersionBadge, "BackgroundColor3", "Accents")

AddSection(HomePage, "QUICK ACCESS")

AddScriptButton(
    HomePage,
    "Keyless Scripts",
    "Browse available keyless sections.",
    function()
        -- Sidebar navigation handles the page
    end,
    "OPEN"
)

AddScriptButton(
    HomePage,
    "Key Scripts",
    "Browse key-required sections.",
    function()
    end,
    "OPEN"
)

--==================================================
-- KEYLESS
--==================================================

AddHeader(
    KeylessPage,
    "Keyless Scripts",
    "Available script sections"
)

AddSection(KeylessPage, "AVAILABLE")

-- Keep your existing URLs here.
AddScriptButton(
    KeylessPage,
    "Sources Hub",
    "Keyless",
    nil,
    "KEYLESS"
)

AddScriptButton(
    KeylessPage,
    "Limbo Hub",
    "Keyless",
    nil,
    "KEYLESS"
)

AddScriptButton(
    KeylessPage,
    "Virexx",
    "Keyless",
    nil,
    "KEYLESS"
)

--==================================================
-- KEY
--==================================================

AddHeader(
    KeyPage,
    "Key Scripts",
    "Scripts using a key system"
)

AddSection(KeyPage, "AVAILABLE")

AddScriptButton(
    KeyPage,
    "Wzeus Hub",
    "Key System",
    nil,
    "KEY"
)

AddScriptButton(
    KeyPage,
    "Pulse Hub",
    "Key System",
    nil,
    "KEY"
)

--==================================================
-- THEMES
--==================================================

AddHeader(
    ThemesPage,
    "Themes",
    "Choose a visual style for CH3A5 HUB."
)

local ThemeGrid = New("Frame", {
    Size = UDim2.new(1, 0, 0, 400),
    BackgroundTransparency = 1,
}, ThemesPage)

New("UIGridLayout", {
    CellSize = UDim2.fromOffset(160, 70),
    CellPadding = UDim2.fromOffset(10, 10),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, ThemeGrid)

for ThemeName, ThemeData in pairs(Themes) do

    local ThemeButton = New("TextButton", {
        BackgroundColor3 = ThemeData.Surface,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
    }, ThemeGrid)

    Corner(ThemeButton, 13)

    local ThemeStroke = Stroke(
        ThemeButton,
        ThemeData.Border,
        0.15,
        1
    )

    local ThemeAccent = New("Frame", {
        Position = UDim2.fromOffset(10, 10),
        Size = UDim2.fromOffset(8, 50),
        BackgroundColor3 = ThemeData.Accent,
        BorderSizePixel = 0,
    }, ThemeButton)

    Corner(ThemeAccent, 4)

    local ThemeLabel = New("TextLabel", {
        Position = UDim2.fromOffset(29, 10),
        Size = UDim2.new(1, -38, 0, 25),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = ThemeName,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = ThemeData.Text,
    }, ThemeButton)

    local ThemeSub = New("TextLabel", {
        Position = UDim2.fromOffset(29, 35),
        Size = UDim2.new(1, -38, 0, 18),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = "Theme",
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = ThemeData.Muted,
    }, ThemeButton)

    Connect(ThemeButton.MouseEnter, function()
        Tween(ThemeButton, {
            BackgroundColor3 = ThemeData.Surface2,
        }, 0.14)
    end)

    Connect(ThemeButton.MouseLeave, function()
        Tween(ThemeButton, {
            BackgroundColor3 = ThemeData.Surface,
        }, 0.14)
    end)

    Connect(ThemeButton.Activated, function()
        ApplyTheme(ThemeData)
    end)
end

--==================================================
-- SETTINGS
--==================================================

AddHeader(
    SettingsPage,
    "Settings",
    "Interface preferences"
)

AddSection(SettingsPage, "INTERFACE")

AddInfo(
    SettingsPage,
    "CH3A5 HUB V3 automatically adapts its layout based on the available viewport."
)

AddInfo(
    SettingsPage,
    "Reduced Motion is supported through Roblox's accessibility preference."
)

AddInfo(
    SettingsPage,
    "Drag the topbar to move the window. The window is clamped to the safe viewport."
)

--==================================================
-- SIDEBAR BUTTONS
--==================================================

local SidebarButtons = {}

local function SetActiveTab(name)
    for pageName, button in pairs(SidebarButtons) do

        local indicator = button:FindFirstChild("Indicator")
        local icon = button:FindFirstChild("Icon")
        local label = button:FindFirstChild("Label")

        if pageName == name then

            if indicator then
                indicator.Visible = true
            end

            if icon then
                icon.TextColor3 = CurrentTheme.Accent
            end

            if label then
                label.TextColor3 = CurrentTheme.Text
            end

            Tween(button, {
                BackgroundColor3 = CurrentTheme.Surface2,
            }, 0.14)

        else

            if indicator then
                indicator.Visible = false
            end

            if icon then
                icon.TextColor3 = CurrentTheme.Muted
            end

            if label then
                label.TextColor3 = CurrentTheme.Muted
            end

            Tween(button, {
                BackgroundColor3 = CurrentTheme.Surface,
            }, 0.14)
        end
    end
end

local function OpenPage(name)
    if not Pages[name] then
        return
    end

    State.CurrentPage = name

    for pageName, page in pairs(Pages) do
        page.Visible = pageName == name

        if pageName == name then
            page.CanvasPosition = Vector2.new(0, 0)
        end
    end

    SetActiveTab(name)

    if State.IsMobile then
        State.SidebarOpen = false

        Tween(Sidebar, {
            Size = UDim2.new(0, 0, 1, 0),
        }, 0.18)

        Tween(Content, {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
        }, 0.18)
    end
end

local TabData = {
    {"Home", "⌂"},
    {"Keyless", "◇"},
    {"Key", "◆"},
    {"Themes", "◈"},
    {"Settings", "⚙"},
}

for index, data in ipairs(TabData) do

    local name = data[1]
    local iconText = data[2]

    local Button = New("TextButton", {
        Name = name,
        LayoutOrder = index,
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = CurrentTheme.Surface,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
    }, SidebarList)

    Corner(Button, 10)

    RegisterTheme(Button, "BackgroundColor3", "Surfaces")

    local Indicator = New("Frame", {
        Name = "Indicator",
        Position = UDim2.fromOffset(0, 8),
        Size = UDim2.fromOffset(3, 26),
        BackgroundColor3 = CurrentTheme.Accent,
        BorderSizePixel = 0,
        Visible = false,
    }, Button)

    Corner(Indicator, 3)
    RegisterTheme(Indicator, "BackgroundColor3", "Accents")

    local Icon = New("TextLabel", {
        Name = "Icon",
        Position = UDim2.fromOffset(12, 0),
        Size = UDim2.fromOffset(25, 42),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = iconText,
        TextSize = 16,
        TextColor3 = CurrentTheme.Muted,
    }, Button)

    RegisterTheme(Icon, "TextColor3", "MutedTexts")

    local Label = New("TextLabel", {
        Name = "Label",
        Position = UDim2.fromOffset(43, 0),
        Size = UDim2.new(1, -50, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Button)

    RegisterTheme(Label, "TextColor3", "MutedTexts")

    SidebarButtons[name] = Button

    Connect(Button.MouseEnter, function()
        if State.CurrentPage ~= name then
            Tween(Button, {
                BackgroundColor3 = CurrentTheme.Surface2,
            }, 0.12)
        end
    end)

    Connect(Button.MouseLeave, function()
        if State.CurrentPage ~= name then
            Tween(Button, {
                BackgroundColor3 = CurrentTheme.Surface,
            }, 0.12)
        end
    end)

    Connect(Button.Activated, function()
        OpenPage(name)
    end)
end

--==================================================
-- MOBILE MENU BUTTON
--==================================================

local MenuButton = New("TextButton", {
    Name = "MobileMenu",
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.fromOffset(7, CONFIG.TopbarHeight / 2),
    Size = UDim2.fromOffset(40, 40),
    BackgroundColor3 = CurrentTheme.Surface2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "☰",
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextColor3 = CurrentTheme.Text,
    Visible = false,
}, Topbar)

Corner(MenuButton, 10)
RegisterTheme(MenuButton, "BackgroundColor3", "Surfaces")
RegisterTheme(MenuButton, "TextColor3", "Texts")

Connect(MenuButton.Activated, function()

    if not State.IsMobile then
        return
    end

    State.SidebarOpen = not State.SidebarOpen

    if State.SidebarOpen then

        Tween(Sidebar, {
            Size = UDim2.new(0, CONFIG.SidebarWidth, 1, 0),
        }, 0.18)

        Tween(Content, {
            Position = UDim2.new(0, CONFIG.SidebarWidth, 0, 0),
            Size = UDim2.new(1, -CONFIG.SidebarWidth, 1, 0),
        }, 0.18)

    else

        Tween(Sidebar, {
            Size = UDim2.new(0, 0, 1, 0),
        }, 0.18)

        Tween(Content, {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
        }, 0.18)
    end
end)

--==================================================
-- RESPONSIVE ENGINE
--==================================================

local function GetViewport()
    local Camera = workspace.CurrentCamera

    if not Camera then
        return Vector2.new(1280, 720)
    end

    return Camera.ViewportSize
end

local function ClampWindow()
    local viewport = GetViewport()

    local absoluteSize = Main.AbsoluteSize

    local margin = 8

    local halfX = absoluteSize.X / 2
    local halfY = absoluteSize.Y / 2

    local minX = halfX + margin
    local maxX = viewport.X - halfX - margin

    local minY = halfY + margin
    local maxY = viewport.Y - halfY - margin

    local current = Main.Position

    local x = math.clamp(
        current.X.Offset,
        minX,
        math.max(minX, maxX)
    )

    local y = math.clamp(
        current.Y.Offset,
        minY,
        math.max(minY, maxY)
    )

    Main.Position = UDim2.fromOffset(x, y)
end

local function SetWindowSize(size)
    size = Vector2.new(
        math.clamp(size.X, CONFIG.MinWidth, CONFIG.MaxWidth),
        math.clamp(size.Y, CONFIG.MinHeight, CONFIG.MaxHeight)
    )

    State.WindowSize = size

    Tween(Main, {
        Size = UDim2.fromOffset(size.X, size.Y),
    }, 0.2)
end

local function UpdateResponsive()

    local viewport = GetViewport()
    local width = viewport.X
    local height = viewport.Y

    local displaySize = GuiService.ViewportDisplaySize

    State.IsMobile =
        width <= CONFIG.MobileBreakpoint
        or displaySize == Enum.DisplaySize.Small

    State.IsTablet =
        not State.IsMobile
        and width <= CONFIG.TabletBreakpoint

    if State.IsMobile then

        local targetWidth = math.min(
            width - 16,
            CONFIG.MobileSize.X
        )

        local targetHeight = math.min(
            height - 16,
            CONFIG.MobileSize.Y
        )

        SetWindowSize(Vector2.new(
            math.max(targetWidth, CONFIG.MinWidth),
            math.max(targetHeight, CONFIG.MinHeight)
        ))

        MainScale.Scale = 1

        MenuButton.Visible = true

        Sidebar.Size = UDim2.new(0, 0, 1, 0)

        Content.Position = UDim2.new(0, 0, 0, 0)
        Content.Size = UDim2.new(1, 0, 1, 0)

        State.SidebarOpen = false

        Title.Position = UDim2.fromOffset(56, 11)
        Subtitle.Position = UDim2.fromOffset(57, 37)

        Logo.Visible = false

    elseif State.IsTablet then

        SetWindowSize(Vector2.new(
            math.min(width - 40, CONFIG.TabletSize.X),
            math.min(height - 40, CONFIG.TabletSize.Y)
        ))

        MainScale.Scale = 0.96

        MenuButton.Visible = false
        Logo.Visible = true

        Sidebar.Size = UDim2.new(
            0,
            CONFIG.SidebarWidth,
            1,
            0
        )

        Content.Position = UDim2.new(
            0,
            CONFIG.SidebarWidth,
            0,
            0
        )

        Content.Size = UDim2.new(
            1,
            -CONFIG.SidebarWidth,
            1,
            0
        )

        Title.Position = UDim2.fromOffset(68, 11)
        Subtitle.Position = UDim2.fromOffset(69, 37)

    else

        SetWindowSize(Vector2.new(
            math.min(width - 60, CONFIG.DesktopSize.X),
            math.min(height - 60, CONFIG.DesktopSize.Y)
        ))

        MainScale.Scale = 1

        MenuButton.Visible = false
        Logo.Visible = true

        Sidebar.Size = UDim2.new(
            0,
            CONFIG.SidebarWidth,
            1,
            0
        )

        Content.Position = UDim2.new(
            0,
            CONFIG.SidebarWidth,
            0,
            0
        )

        Content.Size = UDim2.new(
            1,
            -CONFIG.SidebarWidth,
            1,
            0
        )

        Title.Position = UDim2.fromOffset(68, 11)
        Subtitle.Position = UDim2.fromOffset(69, 37)
    end

    task.defer(ClampWindow)
end

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

Connect(Topbar.InputBegan, function(input)

    if input.UserInputType ~= Enum.UserInputType.MouseButton1
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    if input.Target == MinimizeButton
        or input.Target == CloseButton
        or input.Target == MenuButton then
        return
    end

    Dragging = true
    State.IsDragging = true

    DragStart = input.Position
    StartPosition = Main.Position
end)

Connect(UserInputService.InputChanged, function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - DragStart

    Main.Position = UDim2.fromOffset(
        StartPosition.X.Offset + delta.X,
        StartPosition.Y.Offset + delta.Y
    )

    ClampWindow()
end)

Connect(UserInputService.InputEnded, function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
        State.IsDragging = false

        State.WindowPosition = Main.Position
    end
end)

--==================================================
-- MINIMIZE
--==================================================

local RestoreButton = New("TextButton", {
    Name = "Restore",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -15, 1, -15),
    Size = UDim2.fromOffset(52, 52),
    BackgroundColor3 = CurrentTheme.Surface,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "▣",
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextColor3 = CurrentTheme.Text,
    Visible = false,
}, ScreenGui)

Corner(RestoreButton, 16)
Stroke(RestoreButton, CurrentTheme.Border, 0.15, 1)

RegisterTheme(RestoreButton, "BackgroundColor3", "Surfaces")
RegisterTheme(RestoreButton, "TextColor3", "Texts")

Connect(MinimizeButton.Activated, function()

    if State.Minimized then
        return
    end

    State.Minimized = true

    State.WindowSize = Main.AbsoluteSize
    State.WindowPosition = Main.Position

    Body.Visible = false

    Tween(Main, {
        Size = UDim2.fromOffset(
            math.min(State.WindowSize.X, 360),
            CONFIG.TopbarHeight
        ),
    }, 0.2)

    task.delay(TweenTime(0.2), function()
        RestoreButton.Visible = true
    end)
end)

Connect(RestoreButton.Activated, function()

    if not State.Minimized then
        return
    end

    State.Minimized = false
    RestoreButton.Visible = false

    Body.Visible = true

    local restoreSize = State.WindowSize

    if not restoreSize then
        restoreSize = CONFIG.DesktopSize
    end

    Tween(Main, {
        Size = UDim2.fromOffset(
            restoreSize.X,
            restoreSize.Y
        ),
    }, 0.2)

    if State.WindowPosition then
        Main.Position = State.WindowPosition
    end

    task.defer(ClampWindow)
end)

--==================================================
-- CLOSE
--==================================================

Connect(CloseButton.Activated, function()

    if State.IsClosing then
        return
    end

    State.IsClosing = true

    Tween(Main, {
        Size = UDim2.fromOffset(0, 0),
    }, 0.22)

    task.delay(TweenTime(0.22), function()

        CleanupConnections()

        if ScreenGui then
            ScreenGui:Destroy()
        end
    end)
end)

--==================================================
-- INITIAL STATE
--==================================================

for name, page in pairs(Pages) do
    page.Visible = name == "Home"
end

State.CurrentPage = "Home"

SetActiveTab("Home")

UpdateResponsive()

--==================================================
-- VIEWPORT CHANGE
--==================================================

Connect(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), function()
    if not State.Minimized then
        UpdateResponsive()
    end
end)

Connect(GuiService:GetPropertyChangedSignal("ViewportDisplaySize"), function()
    if not State.Minimized then
        UpdateResponsive()
    end
end)

--==================================================
-- REDUCED MOTION CHANGE
--==================================================

Connect(GuiService:GetPropertyChangedSignal("ReducedMotionEnabled"), function()
    -- Future animations automatically use 0 duration.
end)

--==================================================
-- FINAL THEME APPLY
--==================================================

ApplyTheme(CurrentTheme)

--==================================================
-- OPEN ANIMATION
--==================================================

local FinalSize = Main.Size

Main.Size = UDim2.fromOffset(
    FinalSize.X * 0.92,
    FinalSize.Y * 0.92
)

Tween(Main, {
    Size = FinalSize,
}, 0.28)

--==================================================
-- END
--==================================================
