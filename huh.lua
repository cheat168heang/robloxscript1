--==================================================
-- CH3A5 HUB V3
-- GUI-ONLY EXECUTOR-COMPATIBLE VERSION
--==================================================

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    return
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
    Name = "CH3A5_HUB_V3",

    Width = 820,
    Height = 520,

    MinWidth = 320,
    MinHeight = 380,

    MaxWidth = 920,
    MaxHeight = 650,

    SidebarWidth = 190,
    MobileSidebarWidth = 250,

    TopbarHeight = 64,

    Corner = 16,

    Animation = 0.20,

    MobileBreakpoint = 650,
}

--==================================================
-- DUPLICATE PROTECTION
--==================================================

local Existing = PlayerGui:FindFirstChild(CONFIG.Name)

if Existing then
    Existing:Destroy()
end

--==================================================
-- STATE
--==================================================

local State = {
    Page = "Home",
    Theme = "Midnight",

    Minimized = false,
    SidebarOpen = true,

    Mobile = false,
    Tablet = false,

    Closed = false,
}

--==================================================
-- CONNECTIONS
--==================================================

local Connections = {}

local function Connect(signal, callback)
    local connection = signal:Connect(callback)

    table.insert(Connections, connection)

    return connection
end

local function Cleanup()
    for _, connection in ipairs(Connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end

    table.clear(Connections)
end

--==================================================
-- THEMES
--==================================================

local Themes = {

    Midnight = {
        Background = Color3.fromRGB(9, 11, 17),
        Surface = Color3.fromRGB(15, 18, 27),
        Surface2 = Color3.fromRGB(23, 27, 39),
        Accent = Color3.fromRGB(115, 95, 255),
        Border = Color3.fromRGB(48, 53, 72),
        Text = Color3.fromRGB(245, 247, 255),
        Muted = Color3.fromRGB(145, 153, 174),
    },

    Discord = {
        Background = Color3.fromRGB(20, 21, 25),
        Surface = Color3.fromRGB(30, 31, 34),
        Surface2 = Color3.fromRGB(43, 45, 49),
        Accent = Color3.fromRGB(88, 101, 242),
        Border = Color3.fromRGB(65, 68, 75),
        Text = Color3.fromRGB(242, 243, 245),
        Muted = Color3.fromRGB(148, 155, 164),
    },

    GitHub = {
        Background = Color3.fromRGB(13, 17, 23),
        Surface = Color3.fromRGB(22, 27, 34),
        Surface2 = Color3.fromRGB(33, 38, 45),
        Accent = Color3.fromRGB(46, 164, 79),
        Border = Color3.fromRGB(48, 54, 61),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158),
    },

    Spotify = {
        Background = Color3.fromRGB(12, 12, 12),
        Surface = Color3.fromRGB(24, 24, 24),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(30, 215, 96),
        Border = Color3.fromRGB(55, 55, 55),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(165, 165, 165),
    },

    YouTube = {
        Background = Color3.fromRGB(15, 15, 15),
        Surface = Color3.fromRGB(25, 25, 25),
        Surface2 = Color3.fromRGB(40, 40, 40),
        Accent = Color3.fromRGB(255, 0, 0),
        Border = Color3.fromRGB(55, 55, 55),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(170, 170, 170),
    },

    Telegram = {
        Background = Color3.fromRGB(11, 22, 31),
        Surface = Color3.fromRGB(18, 36, 50),
        Surface2 = Color3.fromRGB(25, 49, 67),
        Accent = Color3.fromRGB(42, 171, 238),
        Border = Color3.fromRGB(40, 70, 88),
        Text = Color3.fromRGB(245, 250, 255),
        Muted = Color3.fromRGB(150, 175, 190),
    },

    Twitter = {
        Background = Color3.fromRGB(10, 15, 20),
        Surface = Color3.fromRGB(20, 28, 36),
        Surface2 = Color3.fromRGB(30, 40, 50),
        Accent = Color3.fromRGB(29, 155, 240),
        Border = Color3.fromRGB(48, 62, 75),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(145, 160, 175),
    },

    Twitch = {
        Background = Color3.fromRGB(14, 12, 20),
        Surface = Color3.fromRGB(24, 20, 34),
        Surface2 = Color3.fromRGB(37, 30, 51),
        Accent = Color3.fromRGB(145, 70, 255),
        Border = Color3.fromRGB(55, 44, 75),
        Text = Color3.fromRGB(245, 242, 255),
        Muted = Color3.fromRGB(160, 150, 175),
    },

    Dracula = {
        Background = Color3.fromRGB(40, 42, 54),
        Surface = Color3.fromRGB(48, 50, 65),
        Surface2 = Color3.fromRGB(68, 70, 85),
        Accent = Color3.fromRGB(189, 147, 249),
        Border = Color3.fromRGB(75, 77, 94),
        Text = Color3.fromRGB(248, 248, 242),
        Muted = Color3.fromRGB(170, 170, 180),
    },

    Ocean = {
        Background = Color3.fromRGB(5, 18, 27),
        Surface = Color3.fromRGB(8, 30, 43),
        Surface2 = Color3.fromRGB(12, 43, 58),
        Accent = Color3.fromRGB(0, 200, 255),
        Border = Color3.fromRGB(25, 65, 80),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(135, 170, 185),
    },

    Crimson = {
        Background = Color3.fromRGB(18, 8, 12),
        Surface = Color3.fromRGB(31, 12, 18),
        Surface2 = Color3.fromRGB(47, 17, 25),
        Accent = Color3.fromRGB(235, 55, 75),
        Border = Color3.fromRGB(70, 28, 38),
        Text = Color3.fromRGB(255, 242, 245),
        Muted = Color3.fromRGB(180, 145, 153),
    },

    Emerald = {
        Background = Color3.fromRGB(7, 18, 14),
        Surface = Color3.fromRGB(11, 30, 23),
        Surface2 = Color3.fromRGB(17, 45, 34),
        Accent = Color3.fromRGB(46, 220, 140),
        Border = Color3.fromRGB(28, 70, 55),
        Text = Color3.fromRGB(237, 255, 247),
        Muted = Color3.fromRGB(140, 175, 160),
    },

    Angkor = {
        Background = Color3.fromRGB(15, 11, 7),
        Surface = Color3.fromRGB(29, 21, 13),
        Surface2 = Color3.fromRGB(45, 31, 17),
        Accent = Color3.fromRGB(214, 163, 74),
        Border = Color3.fromRGB(83, 61, 30),
        Text = Color3.fromRGB(255, 244, 220),
        Muted = Color3.fromRGB(180, 157, 120),
    },

    Cyber = {
        Background = Color3.fromRGB(5, 8, 14),
        Surface = Color3.fromRGB(10, 16, 25),
        Surface2 = Color3.fromRGB(17, 27, 40),
        Accent = Color3.fromRGB(0, 220, 255),
        Border = Color3.fromRGB(25, 75, 90),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(120, 160, 175),
    },

    Rose = {
        Background = Color3.fromRGB(20, 10, 16),
        Surface = Color3.fromRGB(32, 16, 25),
        Surface2 = Color3.fromRGB(48, 23, 37),
        Accent = Color3.fromRGB(255, 105, 170),
        Border = Color3.fromRGB(78, 35, 58),
        Text = Color3.fromRGB(255, 240, 248),
        Muted = Color3.fromRGB(185, 145, 165),
    },

    Solar = {
        Background = Color3.fromRGB(20, 15, 6),
        Surface = Color3.fromRGB(34, 25, 9),
        Surface2 = Color3.fromRGB(52, 38, 12),
        Accent = Color3.fromRGB(255, 190, 55),
        Border = Color3.fromRGB(88, 65, 24),
        Text = Color3.fromRGB(255, 248, 225),
        Muted = Color3.fromRGB(190, 165, 115),
    },

    Ice = {
        Background = Color3.fromRGB(7, 15, 23),
        Surface = Color3.fromRGB(13, 27, 40),
        Surface2 = Color3.fromRGB(20, 42, 59),
        Accent = Color3.fromRGB(110, 220, 255),
        Border = Color3.fromRGB(42, 80, 100),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(145, 175, 190),
    },

    Violet = {
        Background = Color3.fromRGB(13, 8, 20),
        Surface = Color3.fromRGB(23, 14, 34),
        Surface2 = Color3.fromRGB(38, 22, 55),
        Accent = Color3.fromRGB(180, 90, 255),
        Border = Color3.fromRGB(65, 40, 90),
        Text = Color3.fromRGB(248, 240, 255),
        Muted = Color3.fromRGB(165, 145, 185),
    },

    Mono = {
        Background = Color3.fromRGB(10, 10, 10),
        Surface = Color3.fromRGB(22, 22, 22),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(220, 220, 220),
        Border = Color3.fromRGB(65, 65, 65),
        Text = Color3.fromRGB(250, 250, 250),
        Muted = Color3.fromRGB(155, 155, 155),
    },

    Neon = {
        Background = Color3.fromRGB(5, 5, 12),
        Surface = Color3.fromRGB(12, 10, 24),
        Surface2 = Color3.fromRGB(23, 18, 42),
        Accent = Color3.fromRGB(255, 45, 210),
        Border = Color3.fromRGB(85, 35, 100),
        Text = Color3.fromRGB(255, 245, 255),
        Muted = Color3.fromRGB(180, 145, 180),
    },

    Forest = {
        Background = Color3.fromRGB(7, 15, 9),
        Surface = Color3.fromRGB(13, 27, 16),
        Surface2 = Color3.fromRGB(20, 42, 24),
        Accent = Color3.fromRGB(85, 205, 100),
        Border = Color3.fromRGB(40, 80, 45),
        Text = Color3.fromRGB(238, 255, 240),
        Muted = Color3.fromRGB(145, 175, 150),
    },
}

local CurrentTheme = Themes[State.Theme]

--==================================================
-- HELPERS
--==================================================

local function New(class, properties, parent)
    local object = Instance.new(class)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent

    return object
end

local function AddCorner(object, radius)
    return New("UICorner", {
        CornerRadius = UDim.new(0, radius or CONFIG.Corner),
    }, object)
end

local function AddStroke(object, color, transparency)
    return New("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = 1,
    }, object)
end

local function AddPadding(object, amount)
    return New("UIPadding", {
        PaddingLeft = UDim.new(0, amount),
        PaddingRight = UDim.new(0, amount),
        PaddingTop = UDim.new(0, amount),
        PaddingBottom = UDim.new(0, amount),
    }, object)
end

local function Animate(object, properties, duration)
    if GuiService.ReducedMotionEnabled then
        for property, value in pairs(properties) do
            object[property] = value
        end

        return
    end

    TweenService:Create(
        object,
        TweenInfo.new(
            duration or CONFIG.Animation,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    ):Play()
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = New("ScreenGui", {
    Name = CONFIG.Name,
    ResetOnSpawn = false,
    DisplayOrder = 999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PlayerGui)

pcall(function()
    ScreenGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
end)

--==================================================
-- MAIN
--==================================================

local Main = New("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(CONFIG.Width, CONFIG.Height),
    BackgroundColor3 = CurrentTheme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, ScreenGui)

AddCorner(Main, CONFIG.Corner)

local MainStroke = AddStroke(
    Main,
    CurrentTheme.Border,
    0.15
)

New("UISizeConstraint", {
    MinSize = Vector2.new(
        CONFIG.MinWidth,
        CONFIG.MinHeight
    ),

    MaxSize = Vector2.new(
        CONFIG.MaxWidth,
        CONFIG.MaxHeight
    ),
}, Main)

local UIScale = New("UIScale", {
    Scale = 1,
}, Main)

--==================================================
-- TOPBAR
--==================================================

local Topbar = New("Frame", {
    Name = "Topbar",
    Size = UDim2.new(1, 0, 0, CONFIG.TopbarHeight),
    BackgroundColor3 = CurrentTheme.Surface,
    BorderSizePixel = 0,
}, Main)

local TopbarStroke = AddStroke(
    Topbar,
    CurrentTheme.Border,
    0.35
)

--==================================================
-- LOGO
--==================================================

local Logo = New("TextLabel", {
    Position = UDim2.fromOffset(14, 12),
    Size = UDim2.fromOffset(40, 40),
    BackgroundColor3 = CurrentTheme.Accent,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBlack,
    Text = "C",
    TextSize = 20,
    TextColor3 = Color3.new(1, 1, 1),
}, Topbar)

AddCorner(Logo, 11)

--==================================================
-- TITLE
--==================================================

local Title = New("TextLabel", {
    Position = UDim2.fromOffset(65, 9),
    Size = UDim2.new(0, 300, 0, 25),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "CH3A5 HUB",
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Text,
}, Topbar)

local Subtitle = New("TextLabel", {
    Position = UDim2.fromOffset(66, 35),
    Size = UDim2.new(0, 300, 0, 17),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Premium Adaptive Interface",
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Muted,
}, Topbar)

--==================================================
-- STATUS
--==================================================

local Status = New("TextLabel", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -112, 0.5, 0),
    Size = UDim2.fromOffset(70, 26),
    BackgroundColor3 = CurrentTheme.Surface2,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "● ONLINE",
    TextSize = 9,
    TextColor3 = CurrentTheme.Accent,
}, Topbar)

AddCorner(Status, 13)

--==================================================
-- WINDOW CONTROLS
--==================================================

local Minimize = New("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -73, 0.5, 0),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = CurrentTheme.Surface2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "—",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = CurrentTheme.Text,
}, Topbar)

AddCorner(Minimize, 9)

local Close = New("TextButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -35, 0.5, 0),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = CurrentTheme.Surface2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "×",
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextColor3 = CurrentTheme.Text,
}, Topbar)

AddCorner(Close, 9)

--==================================================
-- BODY
--==================================================

local Body = New("Frame", {
    Position = UDim2.fromOffset(0, CONFIG.TopbarHeight),
    Size = UDim2.new(1, 0, 1, -CONFIG.TopbarHeight),
    BackgroundTransparency = 1,
}, Main)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {
    Size = UDim2.new(0, CONFIG.SidebarWidth, 1, 0),
    BackgroundColor3 = CurrentTheme.Surface,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, Body)

AddPadding(Sidebar, 11)

local Navigation = New("TextLabel", {
    Size = UDim2.new(1, 0, 0, 25),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "NAVIGATION",
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Muted,
}, Sidebar)

local TabContainer = New("Frame", {
    Position = UDim2.fromOffset(0, 32),
    Size = UDim2.new(1, 0, 1, -32),
    BackgroundTransparency = 1,
}, Sidebar)

New("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, TabContainer)

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
    Position = UDim2.new(
        0,
        CONFIG.SidebarWidth,
        0,
        0
    ),

    Size = UDim2.new(
        1,
        -CONFIG.SidebarWidth,
        1,
        0
    ),

    BackgroundColor3 = CurrentTheme.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, Body)

--==================================================
-- PAGES
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

        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),

        Visible = false,
    }, Content)

    AddPadding(Page, 20)

    New("UIListLayout", {
        Padding = UDim.new(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, Page)

    Pages[name] = Page

    return Page
end

local HomePage = CreatePage("Home")
local ScriptsPage = CreatePage("Scripts")
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")

--==================================================
-- PAGE HELPERS
--==================================================

local function Header(Page, title, description)

    local Container = New("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
    }, Page)

    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = title,
        TextSize = 21,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Text,
    }, Container)

    New("TextLabel", {
        Position = UDim2.fromOffset(0, 31),
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = description,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Container)
end

local function Section(Page, text)

    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = text,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Page)
end

local function Info(Page, text)

    local Box = New("Frame", {
        Size = UDim2.new(1, 0, 0, 55),
        BackgroundColor3 = CurrentTheme.Surface,
        BorderSizePixel = 0,
    }, Page)

    AddCorner(Box, 12)
    AddStroke(Box, CurrentTheme.Border, 0.35)

    New("TextLabel", {
        Position = UDim2.fromOffset(15, 0),
        Size = UDim2.new(1, -30, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = text,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Box)

    return Box
end

--==================================================
-- HOME
--==================================================

Header(
    HomePage,
    "Welcome to CH3A5 HUB",
    "GUI-only executor-compatible interface"
)

local Hero = New("Frame", {
    Size = UDim2.new(1, 0, 0, 145),
    BackgroundColor3 = CurrentTheme.Surface,
    BorderSizePixel = 0,
}, HomePage)

AddCorner(Hero, 15)
AddStroke(Hero, CurrentTheme.Border, 0.25)

New("TextLabel", {
    Position = UDim2.fromOffset(18, 17),
    Size = UDim2.new(1, -36, 0, 30),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "CH3A5 HUB V3",
    TextSize = 23,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Text,
}, Hero)

New("TextLabel", {
    Position = UDim2.fromOffset(19, 53),
    Size = UDim2.new(1, -38, 0, 40),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Premium dark interface designed for desktop and mobile testing.",
    TextSize = 11,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = CurrentTheme.Muted,
}, Hero)

local Version = New("TextLabel", {
    Position = UDim2.fromOffset(19, 103),
    Size = UDim2.fromOffset(60, 22),
    BackgroundColor3 = CurrentTheme.Accent,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "V3.0",
    TextSize = 9,
    TextColor3 = Color3.new(1, 1, 1),
}, Hero)

AddCorner(Version, 11)

Section(HomePage, "SYSTEM")

Info(
    HomePage,
    "Responsive layout • Theme engine • Drag system • Mobile sidebar • UI state"
)

Info(
    HomePage,
    "This build intentionally contains GUI functionality only."
)

--==================================================
-- SCRIPTS PAGE
--==================================================

Header(
    ScriptsPage,
    "Scripts",
    "UI demonstration cards"
)

Section(ScriptsPage, "DEMO CARDS")

local function DemoCard(Page, title, description, badge)

    local Button = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 72),
        BackgroundColor3 = CurrentTheme.Surface,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
    }, Page)

    AddCorner(Button, 13)
    AddStroke(Button, CurrentTheme.Border, 0.35)

    local Accent = New("Frame", {
        Position = UDim2.fromOffset(0, 12),
        Size = UDim2.fromOffset(3, 48),
        BackgroundColor3 = CurrentTheme.Accent,
        BorderSizePixel = 0,
    }, Button)

    AddCorner(Accent, 3)

    New("TextLabel", {
        Position = UDim2.fromOffset(17, 10),
        Size = UDim2.new(1, -130, 0, 25),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = title,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Text,
    }, Button)

    New("TextLabel", {
        Position = UDim2.fromOffset(17, 37),
        Size = UDim2.new(1, -130, 0, 20),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = description,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Button)

    local Badge = New("TextLabel", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -15, 0.5, 0),
        Size = UDim2.fromOffset(70, 24),
        BackgroundColor3 = CurrentTheme.Surface2,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamBold,
        Text = badge,
        TextSize = 8,
        TextColor3 = CurrentTheme.Accent,
    }, Button)

    AddCorner(Badge, 12)

    Connect(Button.MouseEnter, function()
        Animate(Button, {
            BackgroundColor3 = CurrentTheme.Surface2,
        }, 0.12)
    end)

    Connect(Button.MouseLeave, function()
        Animate(Button, {
            BackgroundColor3 = CurrentTheme.Surface,
        }, 0.12)
    end)

    return Button
end

DemoCard(
    ScriptsPage,
    "GUI Demo Card",
    "Interface testing",
    "DEMO"
)

DemoCard(
    ScriptsPage,
    "Responsive Test",
    "Desktop / tablet / mobile",
    "TEST"
)

DemoCard(
    ScriptsPage,
    "Theme Preview",
    "Theme engine demonstration",
    "UI"
)

--==================================================
-- THEMES
--==================================================

Header(
    ThemesPage,
    "Themes",
    "Select a visual style"
)

local ThemeContainer = New("Frame", {
    Size = UDim2.new(1, 0, 0, 500),
    BackgroundTransparency = 1,
}, ThemesPage)

New("UIGridLayout", {
    CellSize = UDim2.fromOffset(155, 68),
    CellPadding = UDim2.fromOffset(9, 9),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, ThemeContainer)

--==================================================
-- THEME REGISTRY
--==================================================

local ThemeObjects = {}

local function RegisterThemeObject(object, property, key)

    ThemeObjects[key] = ThemeObjects[key] or {}

    table.insert(
        ThemeObjects[key],
        {
            Object = object,
            Property = property,
        }
    )
end

local function ApplyTheme(name)

    local theme = Themes[name]

    if not theme then
        return
    end

    State.Theme = name
    CurrentTheme = theme

    local Values = {
        Background = theme.Background,
        Surface = theme.Surface,
        Surface2 = theme.Surface2,
        Accent = theme.Accent,
        Border = theme.Border,
        Text = theme.Text,
        Muted = theme.Muted,
    }

    for key, value in pairs(Values) do

        for _, item in ipairs(
            ThemeObjects[key] or {}
        ) do

            if item.Object and item.Object.Parent then
                pcall(function()
                    item.Object[item.Property] = value
                end)
            end
        end
    end

    -- Main
    Main.BackgroundColor3 = theme.Background
    MainStroke.Color = theme.Border

    -- Topbar
    Topbar.BackgroundColor3 = theme.Surface
    TopbarStroke.Color = theme.Border

    -- Sidebar
    Sidebar.BackgroundColor3 = theme.Surface

    -- Content
    Content.BackgroundColor3 = theme.Background

    -- Main controls
    Logo.BackgroundColor3 = theme.Accent

    Title.TextColor3 = theme.Text
    Subtitle.TextColor3 = theme.Muted

    Status.BackgroundColor3 = theme.Surface2
    Status.TextColor3 = theme.Accent

    Minimize.BackgroundColor3 = theme.Surface2
    Minimize.TextColor3 = theme.Text

    Close.BackgroundColor3 = theme.Surface2
    Close.TextColor3 = theme.Text

    Navigation.TextColor3 = theme.Muted
end

for ThemeName, ThemeData in pairs(Themes) do

    local Button = New("TextButton", {
        BackgroundColor3 = ThemeData.Surface,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
    }, ThemeContainer)

    AddCorner(Button, 12)

    AddStroke(
        Button,
        ThemeData.Border,
        0.2
    )

    New("Frame", {
        Position = UDim2.fromOffset(9, 9),
        Size = UDim2.fromOffset(7, 50),
        BackgroundColor3 = ThemeData.Accent,
        BorderSizePixel = 0,
    }, Button)

    New("TextLabel", {
        Position = UDim2.fromOffset(27, 10),
        Size = UDim2.new(1, -35, 0, 23),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = ThemeName,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = ThemeData.Text,
    }, Button)

    New("TextLabel", {
        Position = UDim2.fromOffset(27, 34),
        Size = UDim2.new(1, -35, 0, 18),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = "Theme",
        TextSize = 8,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = ThemeData.Muted,
    }, Button)

    Connect(Button.MouseEnter, function()
        Animate(Button, {
            BackgroundColor3 = ThemeData.Surface2,
        }, 0.12)
    end)

    Connect(Button.MouseLeave, function()
        Animate(Button, {
            BackgroundColor3 = ThemeData.Surface,
        }, 0.12)
    end)

    Connect(Button.Activated, function()
        ApplyTheme(ThemeName)
    end)
end

--==================================================
-- SETTINGS
--==================================================

Header(
    SettingsPage,
    "Settings",
    "Interface preferences"
)

Section(SettingsPage, "UI")

Info(
    SettingsPage,
    "The interface automatically adapts to different viewport sizes."
)

Info(
    SettingsPage,
    "Drag the topbar to move the window."
)

Info(
    SettingsPage,
    "Use the minimize button to hide the main content."
)

--==================================================
-- NAVIGATION
--==================================================

local Tabs = {}

local TabInfo = {
    {"Home", "⌂"},
    {"Scripts", "◇"},
    {"Themes", "◈"},
    {"Settings", "⚙"},
}

local function SelectPage(name)

    if not Pages[name] then
        return
    end

    State.Page = name

    for pageName, page in pairs(Pages) do
        page.Visible = pageName == name
    end

    for pageName, button in pairs(Tabs) do

        local selected = pageName == name

        local indicator = button:FindFirstChild("Indicator")
        local icon = button:FindFirstChild("Icon")
        local label = button:FindFirstChild("Label")

        if selected then

            if indicator then
                indicator.Visible = true
            end

            if icon then
                icon.TextColor3 = CurrentTheme.Accent
            end

            if label then
                label.TextColor3 = CurrentTheme.Text
            end

            Animate(button, {
                BackgroundColor3 = CurrentTheme.Surface2,
            }, 0.12)

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

            Animate(button, {
                BackgroundColor3 = CurrentTheme.Surface,
            }, 0.12)
        end
    end
end

for index, info in ipairs(TabInfo) do

    local name = info[1]
    local iconText = info[2]

    local Button = New("TextButton", {
        LayoutOrder = index,
        Size = UDim2.new(1, 0, 0, 41),
        BackgroundColor3 = CurrentTheme.Surface,
        BorderSizePixel = 0,
        AutoButtonColor = false,
        Text = "",
    }, TabContainer)

    AddCorner(Button, 10)

    local Indicator = New("Frame", {
        Name = "Indicator",
        Position = UDim2.fromOffset(0, 8),
        Size = UDim2.fromOffset(3, 25),
        BackgroundColor3 = CurrentTheme.Accent,
        BorderSizePixel = 0,
        Visible = false,
    }, Button)

    AddCorner(Indicator, 3)

    local Icon = New("TextLabel", {
        Name = "Icon",
        Position = UDim2.fromOffset(11, 0),
        Size = UDim2.fromOffset(25, 41),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = iconText,
        TextSize = 15,
        TextColor3 = CurrentTheme.Muted,
    }, Button)

    local Label = New("TextLabel", {
        Name = "Label",
        Position = UDim2.fromOffset(42, 0),
        Size = UDim2.new(1, -48, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Text = name,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = CurrentTheme.Muted,
    }, Button)

    Tabs[name] = Button

    Connect(Button.MouseEnter, function()

        if State.Page ~= name then
            Animate(Button, {
                BackgroundColor3 = CurrentTheme.Surface2,
            }, 0.1)
        end
    end)

    Connect(Button.MouseLeave, function()

        if State.Page ~= name then
            Animate(Button, {
                BackgroundColor3 = CurrentTheme.Surface,
            }, 0.1)
        end
    end)

    Connect(Button.Activated, function()
        SelectPage(name)
    end)
end

--==================================================
-- MOBILE MENU
--==================================================

local Menu = New("TextButton", {
    Position = UDim2.fromOffset(8, 12),
    Size = UDim2.fromOffset(38, 38),
    BackgroundColor3 = CurrentTheme.Surface2,
    BorderSizePixel = 0,
    AutoButtonColor = false,
    Text = "☰",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = CurrentTheme.Text,
    Visible = false,
}, Topbar)

AddCorner(Menu, 10)

Connect(Menu.Activated, function()

    if not State.Mobile then
        return
    end

    State.SidebarOpen = not State.SidebarOpen

    if State.SidebarOpen then

        Animate(Sidebar, {
            Size = UDim2.new(
                0,
                CONFIG.MobileSidebarWidth,
                1,
                0
            ),
        })

        Animate(Content, {
            Position = UDim2.new(
                0,
                CONFIG.MobileSidebarWidth,
                0,
                0
            ),

            Size = UDim2.new(
                1,
                -CONFIG.MobileSidebarWidth,
                1,
                0
            ),
        })

    else

        Animate(Sidebar, {
            Size = UDim2.new(0, 0, 1, 0),
        })

        Animate(Content, {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
        })
    end
end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

local function ClampWindow()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local viewport = Camera.ViewportSize
    local size = Main.AbsoluteSize

    local halfX = size.X / 2
    local halfY = size.Y / 2

    local margin = 8

    local minX = halfX + margin
    local maxX = viewport.X - halfX - margin

    local minY = halfY + margin
    local maxY = viewport.Y - halfY - margin

    local x = math.clamp(
        Main.Position.X.Offset,
        minX,
        math.max(minX, maxX)
    )

    local y = math.clamp(
        Main.Position.Y.Offset,
        minY,
        math.max(minY, maxY)
    )

    Main.Position = UDim2.fromOffset(x, y)
end

Connect(Topbar.InputBegan, function(input)

    if input.UserInputType ~= Enum.UserInputType.MouseButton1
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    -- Don't drag from window controls.
    if input.Target == Minimize
        or input.Target == Close
        or input.Target == Menu then
        return
    end

    Dragging = true

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

    local Delta = input.Position - DragStart

    Main.Position = UDim2.fromOffset(
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Offset + Delta.Y
    )

    ClampWindow()
end)

Connect(UserInputService.InputEnded, function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
    end
end)

--==================================================
-- RESPONSIVE
--==================================================

local function UpdateResponsive()

    local Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local viewport = Camera.ViewportSize
    local width = viewport.X
    local height = viewport.Y

    State.Mobile = width <= CONFIG.MobileBreakpoint
    State.Tablet = width > CONFIG.MobileBreakpoint and width <= 950

    if State.Mobile then

        UIScale.Scale = 1

        local targetWidth = math.clamp(
            width - 16,
            CONFIG.MinWidth,
            430
        )

        local targetHeight = math.clamp(
            height - 16,
            CONFIG.MinHeight,
            600
        )

        Main.Size = UDim2.fromOffset(
            targetWidth,
            targetHeight
        )

        Menu.Visible = true
        Logo.Visible = false

        Title.Position = UDim2.fromOffset(55, 9)
        Subtitle.Position = UDim2.fromOffset(56, 35)

        Sidebar.Size = UDim2.new(0, 0, 1, 0)

        Content.Position = UDim2.new(0, 0, 0, 0)
        Content.Size = UDim2.new(1, 0, 1, 0)

        State.SidebarOpen = false

    elseif State.Tablet then

        UIScale.Scale = 0.96

        Main.Size = UDim2.fromOffset(
            math.min(width - 40, 740),
            math.min(height - 40, 500)
        )

        Menu.Visible = false
        Logo.Visible = true

        Title.Position = UDim2.fromOffset(65, 9)
        Subtitle.Position = UDim2.fromOffset(66, 35)

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

        State.SidebarOpen = true

    else

        UIScale.Scale = 1

        Main.Size = UDim2.fromOffset(
            math.min(width - 60, CONFIG.Width),
            math.min(height - 60, CONFIG.Height)
        )

        Menu.Visible = false
        Logo.Visible = true

        Title.Position = UDim2.fromOffset(65, 9)
        Subtitle.Position = UDim2.fromOffset(66, 35)

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

        State.SidebarOpen = true
    end

    task.defer(ClampWindow)
end

--==================================================
-- MINIMIZE
--==================================================

local SavedSize = nil
local SavedPosition = nil

local Restore = New("TextButton", {
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -14, 1, -14),
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

AddCorner(Restore, 15)
AddStroke(Restore, CurrentTheme.Border, 0.15)

Connect(Minimize.Activated, function()

    if State.Minimized then
        return
    end

    State.Minimized = true

    SavedSize = Main.AbsoluteSize
    SavedPosition = Main.Position

    Body.Visible = false

    Animate(Main, {
        Size = UDim2.fromOffset(
            math.min(SavedSize.X, 360),
            CONFIG.TopbarHeight
        ),
    })

    task.delay(CONFIG.Animation, function()

        if not State.Closed then
            Restore.Visible = true
        end
    end)
end)

Connect(Restore.Activated, function()

    if not State.Minimized then
        return
    end

    State.Minimized = false

    Restore.Visible = false

    Body.Visible = true

    if SavedSize then
        Animate(Main, {
            Size = UDim2.fromOffset(
                SavedSize.X,
                SavedSize.Y
            ),
        })
    end

    if SavedPosition then
        Main.Position = SavedPosition
    end

    task.defer(ClampWindow)
end)

--==================================================
-- CLOSE
--==================================================

Connect(Close.Activated, function()

    if State.Closed then
        return
    end

    State.Closed = true

    Restore.Visible = false
    Body.Visible = false

    Animate(Main, {
        Size = UDim2.fromOffset(0, 0),
    }, 0.18)

    task.delay(0.2, function()

        Cleanup()

        if ScreenGui then
            ScreenGui:Destroy()
        end
    end)
end)

--==================================================
-- VIEWPORT UPDATE
--==================================================

if workspace.CurrentCamera then

    Connect(
        workspace.CurrentCamera:GetPropertyChangedSignal(
            "ViewportSize"
        ),
        function()

            if not State.Minimized then
                UpdateResponsive()
            end
        end
    )
end

--==================================================
-- INITIAL
--==================================================

SelectPage("Home")

UpdateResponsive()

--==================================================
-- OPEN ANIMATION
--==================================================

local FinalSize = Main.Size

Main.Size = UDim2.fromOffset(
    FinalSize.X * 0.92,
    FinalSize.Y * 0.92
)

Animate(Main, {
    Size = FinalSize,
}, 0.28)

--==================================================
-- END
--==================================================
