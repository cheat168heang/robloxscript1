--========================================================
-- TOATOA HUB v4.0
-- Modern Hacker UI
-- Mobile + Desktop
-- Roblox Studio / LocalScript
--========================================================

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local Stats = game:GetService("Stats")

--// PLAYER
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================
-- CONFIG
--========================================================

local CONFIG = {
    Title = "TOATOA HUB",
    Version = "v4.0",

    Colors = {
        Background = Color3.fromRGB(7, 9, 12),
        Panel = Color3.fromRGB(12, 15, 19),
        Panel2 = Color3.fromRGB(17, 21, 26),
        Text = Color3.fromRGB(235, 240, 240),
        Muted = Color3.fromRGB(105, 115, 120),
        Success = Color3.fromRGB(35, 255, 130),
        Danger = Color3.fromRGB(255, 85, 95),
        Warning = Color3.fromRGB(255, 190, 70),
    },

    AnimationSpeed = 0.18,
    NotificationTime = 2.5,
}

--========================================================
-- THEMES
--========================================================

local THEMES = {
    Matrix = {
        Accent = Color3.fromRGB(35, 255, 130),
        AccentDark = Color3.fromRGB(20, 50, 32),
    },

    Cyber = {
        Accent = Color3.fromRGB(50, 200, 255),
        AccentDark = Color3.fromRGB(18, 42, 55),
    },

    Purple = {
        Accent = Color3.fromRGB(180, 100, 255),
        AccentDark = Color3.fromRGB(42, 25, 58),
    },

    Amber = {
        Accent = Color3.fromRGB(255, 180, 55),
        AccentDark = Color3.fromRGB(55, 40, 18),
    },
}

local CurrentTheme = "Matrix"

--========================================================
-- STATE
--========================================================

local State = {
    Open = true,
    Minimized = false,

    UIScale = 0.88,

    PerformanceMode = true,
    ShowFPS = true,
    ShowPing = true,
    Animations = true,

    CurrentPage = "Dashboard",

    Connections = {},
}

--========================================================
-- CLEAN OLD UI
--========================================================

local Old = PlayerGui:FindFirstChild("ToatoaHubV4")

if Old then
    Old:Destroy()
end

--========================================================
-- CONNECTION MANAGER
--========================================================

local function Connect(signal, callback)
    local connection = signal:Connect(callback)

    table.insert(State.Connections, connection)

    return connection
end

local function Cleanup()
    for _, connection in ipairs(State.Connections) do
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    table.clear(State.Connections)
end

--========================================================
-- HELPERS
--========================================================

local function New(class, properties, parent)

    local object = Instance.new(class)

    for property, value in pairs(properties) do
        object[property] = value
    end

    object.Parent = parent

    return object
end

local function Corner(parent, radius)

    return New("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, parent)
end

local function Stroke(parent, color, transparency)

    return New("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = 1
    }, parent)
end

local function Tween(object, properties, duration)

    if not State.Animations then
        for property, value in pairs(properties) do
            object[property] = value
        end

        return nil
    end

    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            duration or CONFIG.AnimationSpeed,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()

    return tween
end

--========================================================
-- GUI
--========================================================

local GUI = New("ScreenGui", {
    Name = "ToatoaHubV4",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PlayerGui)

--========================================================
-- MAIN WINDOW
--========================================================

local Main = New("Frame", {
    BackgroundColor3 = CONFIG.Colors.Background,
    BorderSizePixel = 0,
    AnchorPoint = Vector2.new(0.5, 0.5),
}, GUI)

Corner(Main, 14)

local MainStroke = Stroke(
    Main,
    THEMES[CurrentTheme].Accent,
    0.72
)

--========================================================
-- RESPONSIVE SIZE
--========================================================

local Camera = workspace.CurrentCamera

local function IsMobile()

    local viewport = Camera.ViewportSize

    return viewport.X <= 600
end

local function GetMainSize()

    local viewport = Camera.ViewportSize

    if viewport.X <= 400 then

        return UDim2.new(
            0.91,
            0,
            0,
            math.clamp(
                viewport.Y * 0.72,
                330,
                420
            )
        )

    elseif viewport.X <= 600 then

        return UDim2.new(
            0.88,
            0,
            0,
            math.clamp(
                viewport.Y * 0.68,
                350,
                440
            )
        )

    else

        return UDim2.fromOffset(
            680,
            430
        )
    end
end

local FullSize = GetMainSize()

Main.Size = FullSize
Main.Position = UDim2.fromScale(0.5, 0.5)

--========================================================
-- TOP BAR
--========================================================

local Top = New("Frame", {
    Size = UDim2.new(1, 0, 0, 54),
    BackgroundColor3 = CONFIG.Colors.Panel,
    BorderSizePixel = 0,
}, Main)

Corner(Top, 14)

local Title = New("TextLabel", {
    Size = UDim2.new(1, -125, 1, 0),
    Position = UDim2.fromOffset(15, 0),
    BackgroundTransparency = 1,

    Text = ">_ " .. CONFIG.Title,

    TextColor3 = THEMES[CurrentTheme].Accent,

    Font = Enum.Font.Code,
    TextSize = 19,

    TextXAlignment = Enum.TextXAlignment.Left,
}, Top)

local Version = New("TextLabel", {
    Size = UDim2.fromOffset(48, 20),
    Position = UDim2.new(1, -115, 0, 4),

    BackgroundTransparency = 1,

    Text = CONFIG.Version,

    TextColor3 = CONFIG.Colors.Muted,

    Font = Enum.Font.Code,
    TextSize = 9,
}, Top)

local Minimize = New("TextButton", {
    Size = UDim2.fromOffset(32, 30),
    Position = UDim2.new(1, -78, 0, 12),

    BackgroundColor3 = CONFIG.Colors.Panel2,

    Text = "−",

    TextColor3 = CONFIG.Colors.Text,

    Font = Enum.Font.Code,
    TextSize = 20,

    AutoButtonColor = false,
}, Top)

Corner(Minimize, 7)

local Close = New("TextButton", {
    Size = UDim2.fromOffset(32, 30),
    Position = UDim2.new(1, -40, 0, 12),

    BackgroundColor3 = Color3.fromRGB(45, 20, 24),

    Text = "×",

    TextColor3 = CONFIG.Colors.Danger,

    Font = Enum.Font.Code,
    TextSize = 20,

    AutoButtonColor = false,
}, Top)

Corner(Close, 7)

--========================================================
-- SIDEBAR
--========================================================

local Sidebar = New("Frame", {
    Size = UDim2.new(0, 145, 1, -66),
    Position = UDim2.fromOffset(10, 58),

    BackgroundColor3 = CONFIG.Colors.Panel,

    BorderSizePixel = 0,
}, Main)

Corner(Sidebar, 10)

local SidebarPadding = New("UIPadding", {
    PaddingTop = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
}, Sidebar)

local SidebarLayout = New("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, Sidebar)

--========================================================
-- CONTENT
--========================================================

local Content = New("Frame", {
    Size = UDim2.new(1, -165, 1, -66),
    Position = UDim2.fromOffset(155, 58),

    BackgroundTransparency = 1,
}, Main)

--========================================================
-- PAGES
--========================================================

local Pages = {}

local function CreatePage(name)

    local Page = New("Frame", {
        Name = name,

        Size = UDim2.fromScale(1, 1),

        BackgroundTransparency = 1,

        Visible = false,
    }, Content)

    Pages[name] = Page

    return Page
end

local Dashboard = CreatePage("Dashboard")
local Games = CreatePage("Games")
local Tools = CreatePage("Tools")
local Scripts = CreatePage("Scripts")
local Settings = CreatePage("Settings")

Dashboard.Visible = true

--========================================================
-- PAGE HEADER
--========================================================

local function PageHeader(parent, title, subtitle)

    New("TextLabel", {
        Size = UDim2.new(1, -8, 0, 30),

        BackgroundTransparency = 1,

        Text = title,

        TextColor3 = CONFIG.Colors.Text,

        Font = Enum.Font.Code,
        TextSize = 18,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, parent)

    New("TextLabel", {
        Size = UDim2.new(1, -8, 0, 22),

        Position = UDim2.fromOffset(0, 30),

        BackgroundTransparency = 1,

        Text = subtitle,

        TextColor3 = CONFIG.Colors.Muted,

        Font = Enum.Font.Code,
        TextSize = 10,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, parent)
end

--========================================================
-- NOTIFICATION SYSTEM
--========================================================

local Notifications = New("Frame", {
    Size = UDim2.fromOffset(270, 190),

    Position = UDim2.new(
        1,
        -285,
        1,
        -205
    ),

    BackgroundTransparency = 1,
}, GUI)

local NotificationLayout = New("UIListLayout", {
    Padding = UDim.new(0, 6),

    VerticalAlignment =
        Enum.VerticalAlignment.Bottom,
}, Notifications)

local function Notify(message)

    local Note = New("Frame", {
        Size = UDim2.fromOffset(270, 44),

        BackgroundColor3 = CONFIG.Colors.Panel2,

        BorderSizePixel = 0,
    }, Notifications)

    Corner(Note, 8)

    local NoteStroke = Stroke(
        Note,
        THEMES[CurrentTheme].Accent,
        0.75
    )

    New("TextLabel", {
        Size = UDim2.new(1, -15, 1, 0),

        Position = UDim2.fromOffset(8, 0),

        BackgroundTransparency = 1,

        Text = "●  " .. tostring(message),

        TextColor3 = CONFIG.Colors.Text,

        Font = Enum.Font.Code,
        TextSize = 11,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, Note)

    Note.Position = UDim2.new(1, 30, 0, 0)

    Tween(Note, {
        Position = UDim2.new(0, 0, 0, 0)
    }, 0.2)

    task.delay(
        CONFIG.NotificationTime,
        function()

            if not Note.Parent then
                return
            end

            local tween = Tween(Note, {
                Position = UDim2.new(1, 30, 0, 0)
            }, 0.18)

            if tween then
                tween.Completed:Wait()
            end

            if Note then
                Note:Destroy()
            end
        end
    )
end

--========================================================
-- DASHBOARD
--========================================================

PageHeader(
    Dashboard,
    "SYSTEM DASHBOARD",
    "Modern interface / performance monitor"
)

local StatusCard = New("Frame", {
    Size = UDim2.new(1, -8, 0, 95),

    Position = UDim2.fromOffset(0, 62),

    BackgroundColor3 = CONFIG.Colors.Panel,

    BorderSizePixel = 0,
}, Dashboard)

Corner(StatusCard, 10)

Stroke(
    StatusCard,
    THEMES[CurrentTheme].Accent,
    0.82
)

local StatusTitle = New("TextLabel", {
    Size = UDim2.new(1, -20, 0, 25),

    Position = UDim2.fromOffset(10, 9),

    BackgroundTransparency = 1,

    Text = "● SYSTEM ONLINE",

    TextColor3 = THEMES[CurrentTheme].Accent,

    Font = Enum.Font.Code,
    TextSize = 14,

    TextXAlignment = Enum.TextXAlignment.Left,
}, StatusCard)

local PlayerInfo = New("TextLabel", {
    Size = UDim2.new(1, -20, 0, 48),

    Position = UDim2.fromOffset(10, 37),

    BackgroundTransparency = 1,

    Text =
        "USER: " .. Player.DisplayName ..
        "\nPLACE: " .. tostring(game.PlaceId),

    TextColor3 = CONFIG.Colors.Muted,

    Font = Enum.Font.Code,
    TextSize = 10,

    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
}, StatusCard)

--========================================================
-- PERFORMANCE CARD
--========================================================

local PerformanceCard = New("Frame", {
    Size = UDim2.new(1, -8, 0, 76),

    Position = UDim2.fromOffset(0, 168),

    BackgroundColor3 = CONFIG.Colors.Panel,

    BorderSizePixel = 0,
}, Dashboard)

Corner(PerformanceCard, 10)

local FPSLabel = New("TextLabel", {
    Size = UDim2.new(0.33, 0, 1, 0),

    Position = UDim2.fromOffset(10, 0),

    BackgroundTransparency = 1,

    Text = "FPS: --",

    TextColor3 = THEMES[CurrentTheme].Accent,

    Font = Enum.Font.Code,
    TextSize = 12,

    TextXAlignment = Enum.TextXAlignment.Left,
}, PerformanceCard)

local PingLabel = New("TextLabel", {
    Size = UDim2.new(0.33, 0, 1, 0),

    Position = UDim2.new(0.34, 0, 0, 0),

    BackgroundTransparency = 1,

    Text = "PING: --",

    TextColor3 = CONFIG.Colors.Text,

    Font = Enum.Font.Code,
    TextSize = 12,

    TextXAlignment = Enum.TextXAlignment.Left,
}, PerformanceCard)

local DeviceLabel = New("TextLabel", {
    Size = UDim2.new(0.33, -10, 1, 0),

    Position = UDim2.new(0.67, 0, 0, 0),

    BackgroundTransparency = 1,

    Text = IsMobile() and "MOBILE" or "DESKTOP",

    TextColor3 = CONFIG.Colors.Muted,

    Font = Enum.Font.Code,
    TextSize = 11,

    TextXAlignment = Enum.TextXAlignment.Left,
}, PerformanceCard)

--========================================================
-- GAMES PAGE
--========================================================

PageHeader(
    Games,
    "GAME CENTER",
    "Search and select a game profile"
)

local SearchBox = New("TextBox", {
    Size = UDim2.new(1, -8, 0, 38),

    Position = UDim2.fromOffset(0, 62),

    BackgroundColor3 = CONFIG.Colors.Panel,

    BorderSizePixel = 0,

    PlaceholderText = "Search games...",

    PlaceholderColor3 = CONFIG.Colors.Muted,

    Text = "",

    TextColor3 = CONFIG.Colors.Text,

    Font = Enum.Font.Code,
    TextSize = 11,

    ClearTextOnFocus = false,
}, Games)

Corner(SearchBox, 8)

local GameContainer = New("ScrollingFrame", {
    Size = UDim2.new(1, -8, 1, -110),

    Position = UDim2.fromOffset(0, 108),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 2,

    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    CanvasSize = UDim2.new(0, 0, 0, 0),
}, Games)

local GameLayout = New("UIListLayout", {
    Padding = UDim.new(0, 7),
}, GameContainer)

local GameCards = {}

local function AddGame(name, id)

    local Card = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 54),

        BackgroundColor3 = CONFIG.Colors.Panel,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,
    }, GameContainer)

    Corner(Card, 9)

    local NameLabel = New("TextLabel", {
        Size = UDim2.new(1, -20, 0, 24),

        Position = UDim2.fromOffset(10, 5),

        BackgroundTransparency = 1,

        Text = name,

        TextColor3 = CONFIG.Colors.Text,

        Font = Enum.Font.Code,
        TextSize = 12,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, Card)

    local IDLabel = New("TextLabel", {
        Size = UDim2.new(1, -20, 0, 18),

        Position = UDim2.fromOffset(10, 29),

        BackgroundTransparency = 1,

        Text = "ID: " .. tostring(id),

        TextColor3 = CONFIG.Colors.Muted,

        Font = Enum.Font.Code,
        TextSize = 9,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, Card)

    table.insert(GameCards, {
        Card = Card,
        Name = name,
        ID = tostring(id),
    })

    Connect(Card.MouseEnter, function()

        Tween(Card, {
            BackgroundColor3 =
                THEMES[CurrentTheme].AccentDark
        }, 0.1)
    end)

    Connect(Card.MouseLeave, function()

        Tween(Card, {
            BackgroundColor3 =
                CONFIG.Colors.Panel
        }, 0.1)
    end)

    Connect(Card.Activated, function()

        PlayerInfo.Text =
            "USER: " .. Player.DisplayName ..
            "\nSELECTED: " .. name

        Notify("Selected " .. name)
    end)
end

AddGame("Murder Mystery 2", 142823291)
AddGame("99 Nights in the Forest", 79546208627805)
AddGame("Grow a Garden", 126987765280963)
AddGame("Steal an Egg", 107778070777162)

--========================================================
-- GAME SEARCH
--========================================================

Connect(
    SearchBox:GetPropertyChangedSignal("Text"),
    function()

        local query =
            string.lower(SearchBox.Text)

        for _, data in ipairs(GameCards) do

            local visible =
                query == ""
                or string.find(
                    string.lower(data.Name),
                    query,
                    1,
                    true
                ) ~= nil
                or string.find(
                    data.ID,
                    query,
                    1,
                    true
                ) ~= nil

            data.Card.Visible = visible
        end
    end
)

--========================================================
-- TOOLS PAGE
--========================================================

PageHeader(
    Tools,
    "CLIENT TOOLS",
    "Useful local information"
)

local ToolsContainer = New("ScrollingFrame", {
    Size = UDim2.new(1, -8, 1, -65),

    Position = UDim2.fromOffset(0, 62),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 2,

    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, Tools)

local ToolsLayout = New("UIListLayout", {
    Padding = UDim.new(0, 7),
}, ToolsContainer)

local function ToolButton(title, subtitle, callback)

    local Button = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 55),

        BackgroundColor3 = CONFIG.Colors.Panel,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,
    }, ToolsContainer)

    Corner(Button, 9)

    New("TextLabel", {
        Size = UDim2.new(1, -20, 0, 23),

        Position = UDim2.fromOffset(10, 5),

        BackgroundTransparency = 1,

        Text = title,

        TextColor3 = CONFIG.Colors.Text,

        Font = Enum.Font.Code,
        TextSize = 12,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, Button)

    New("TextLabel", {
        Size = UDim2.new(1, -20, 0, 18),

        Position = UDim2.fromOffset(10, 30),

        BackgroundTransparency = 1,

        Text = subtitle,

        TextColor3 = CONFIG.Colors.Muted,

        Font = Enum.Font.Code,
        TextSize = 9,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, Button)

    Connect(Button.Activated, callback)

    Connect(Button.MouseEnter, function()

        Tween(Button, {
            BackgroundColor3 =
                THEMES[CurrentTheme].AccentDark
        }, 0.1)
    end)

    Connect(Button.MouseLeave, function()

        Tween(Button, {
            BackgroundColor3 =
                CONFIG.Colors.Panel
        }, 0.1)
    end)

    return Button
end

--========================================================
-- COPY FUNCTION
--========================================================

local function CopyText(text)

    local success = pcall(function()

        if setclipboard then
            setclipboard(tostring(text))
        else
            error("Clipboard unavailable")
        end

    end)

    if success then
        Notify("Copied to clipboard")
    else
        Notify("Clipboard unavailable")
    end
end

--========================================================
-- TOOLS
--========================================================

ToolButton(
    "COPY PLACE ID",
    tostring(game.PlaceId),
    function()
        CopyText(game.PlaceId)
    end
)

ToolButton(
    "COPY JOB ID",
    tostring(game.JobId),
    function()
        CopyText(game.JobId)
    end
)

ToolButton(
    "PLAYER INFORMATION",
    Player.DisplayName,
    function()

        Notify(
            "User: " ..
            Player.DisplayName
        )
    end
)

ToolButton(
    "SERVER INFORMATION",
    "Current server session",
    function()

        Notify(
            "Players: " ..
            tostring(#Players:GetPlayers())
        )
    end
)

--========================================================
-- SCRIPTS PAGE
--========================================================

PageHeader(
    Scripts,
    "SCRIPT MANAGER",
    "Local Studio tools"
)

local ScriptPanel = New("Frame", {
    Size = UDim2.new(1, -8, 0, 165),

    Position = UDim2.fromOffset(0, 62),

    BackgroundColor3 = CONFIG.Colors.Panel,

    BorderSizePixel = 0,
}, Scripts)

Corner(ScriptPanel, 10)

New("TextLabel", {
    Size = UDim2.new(1, -20, 0, 30),

    Position = UDim2.fromOffset(10, 10),

    BackgroundTransparency = 1,

    Text = "LOCAL ENVIRONMENT",

    TextColor3 = THEMES[CurrentTheme].Accent,

    Font = Enum.Font.Code,
    TextSize = 13,

    TextXAlignment = Enum.TextXAlignment.Left,
}, ScriptPanel)

New("TextLabel", {
    Size = UDim2.new(1, -20, 0, 105),

    Position = UDim2.fromOffset(10, 45),

    BackgroundTransparency = 1,

    Text =
        "✓ UI initialized\n" ..
        "✓ Responsive layout enabled\n" ..
        "✓ Performance monitor active\n" ..
        "✓ Connection manager active\n" ..
        "✓ Notification manager active",

    TextColor3 = CONFIG.Colors.Text,

    Font = Enum.Font.Code,
    TextSize = 10,

    TextXAlignment = Enum.TextXAlignment.Left,

    TextYAlignment = Enum.TextYAlignment.Top,
}, ScriptPanel)

--========================================================
-- SETTINGS PAGE
--========================================================

PageHeader(
    Settings,
    "SETTINGS",
    "Customize your interface"
)

local SettingsContainer = New("ScrollingFrame", {
    Size = UDim2.new(1, -8, 1, -65),

    Position = UDim2.fromOffset(0, 62),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 2,

    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, Settings)

local SettingsLayout = New("UIListLayout", {
    Padding = UDim.new(0, 7),
}, SettingsContainer)

local function SettingButton(text, value, callback)

    local Button = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 48),

        BackgroundColor3 = CONFIG.Colors.Panel,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,
    }, SettingsContainer)

    Corner(Button, 8)

    New("TextLabel", {
        Size = UDim2.new(0.65, 0, 1, 0),

        Position = UDim2.fromOffset(10, 0),

        BackgroundTransparency = 1,

        Text = text,

        TextColor3 = CONFIG.Colors.Text,

        Font = Enum.Font.Code,
        TextSize = 11,

        TextXAlignment = Enum.TextXAlignment.Left,
    }, Button)

    local ValueLabel = New("TextLabel", {
        Size = UDim2.new(0.35, -10, 1, 0),

        Position = UDim2.new(0.65, 0, 0, 0),

        BackgroundTransparency = 1,

        Text = value,

        TextColor3 = THEMES[CurrentTheme].Accent,

        Font = Enum.Font.Code,
        TextSize = 10,

        TextXAlignment = Enum.TextXAlignment.Right,
    }, Button)

    Connect(Button.Activated, function()

        local newValue = callback()

        if newValue ~= nil then
            ValueLabel.Text = tostring(newValue)
        end
    end)

    return Button, ValueLabel
end

--========================================================
-- THEME
--========================================================

local ThemeNames = {
    "Matrix",
    "Cyber",
    "Purple",
    "Amber"
}

local ThemeIndex = 1

local ThemeButton, ThemeValue =
    SettingButton(
        "THEME",
        CurrentTheme,
        function()

            ThemeIndex += 1

            if ThemeIndex > #ThemeNames then
                ThemeIndex = 1
            end

            CurrentTheme =
                ThemeNames[ThemeIndex]

            local Theme =
                THEMES[CurrentTheme]

            MainStroke.Color =
                Theme.Accent

            Title.TextColor3 =
                Theme.Accent

            StatusTitle.TextColor3 =
                Theme.Accent

            FPSLabel.TextColor3 =
                Theme.Accent

            return CurrentTheme
        end
    )

--========================================================
-- UI SCALE
--========================================================

local ScaleButton, ScaleValue =
    SettingButton(
        "UI SCALE",
        tostring(
            math.floor(
                State.UIScale * 100
            )
        ) .. "%",
        function()

            State.UIScale += 0.05

            if State.UIScale > 1.05 then
                State.UIScale = 0.75
            end

            return tostring(
                math.floor(
                    State.UIScale * 100
                )
            ) .. "%"
        end
    )

--========================================================
-- PERFORMANCE
--========================================================

local PerfButton, PerfValue =
    SettingButton(
        "PERFORMANCE MODE",
        "ON",
        function()

            State.PerformanceMode =
                not State.PerformanceMode

            return State.PerformanceMode
                and "ON"
                or "OFF"
        end
    )

--========================================================
-- FPS
--========================================================

local FPSButton, FPSValue =
    SettingButton(
        "FPS COUNTER",
        "ON",
        function()

            State.ShowFPS =
                not State.ShowFPS

            FPSLabel.Visible =
                State.ShowFPS

            return State.ShowFPS
                and "ON"
                or "OFF"
        end
    )

--========================================================
-- PING
--========================================================

local PingButton, PingValue =
    SettingButton(
        "PING COUNTER",
        "ON",
        function()

            State.ShowPing =
                not State.ShowPing

            PingLabel.Visible =
                State.ShowPing

            return State.ShowPing
                and "ON"
                or "OFF"
        end
    )

--========================================================
-- ANIMATIONS
--========================================================

local AnimationButton, AnimationValue =
    SettingButton(
        "ANIMATIONS",
        "ON",
        function()

            State.Animations =
                not State.Animations

            return State.Animations
                and "ON"
                or "OFF"
        end
    )

--========================================================
-- NAVIGATION
--========================================================

local NavButtons = {}

local function AddNav(text, pageName)

    local Button = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 39),

        BackgroundColor3 =
            CONFIG.Colors.Panel2,

        BorderSizePixel = 0,

        Text = text,

        TextColor3 =
            CONFIG.Colors.Muted,

        Font = Enum.Font.Code,
        TextSize = 10,

        AutoButtonColor = false,

        LayoutOrder =
            #NavButtons + 1,
    }, Sidebar)

    Corner(Button, 8)

    table.insert(
        NavButtons,
        Button
    )

    Connect(
        Button.Activated,
        function()

            State.CurrentPage =
                pageName

            for name, page in pairs(Pages) do
                page.Visible =
                    name == pageName
            end

            for _, nav in ipairs(NavButtons) do

                nav.BackgroundColor3 =
                    CONFIG.Colors.Panel2

                nav.TextColor3 =
                    CONFIG.Colors.Muted
            end

            Button.BackgroundColor3 =
                THEMES[CurrentTheme].AccentDark

            Button.TextColor3 =
                THEMES[CurrentTheme].Accent
        end
    )

    return Button
end

AddNav("▣  DASHBOARD", "Dashboard")
AddNav("◈  GAMES", "Games")
AddNav("◆  TOOLS", "Tools")
AddNav("⌘  SCRIPTS", "Scripts")
AddNav("⚙  SETTINGS", "Settings")

NavButtons[1].BackgroundColor3 =
    THEMES[CurrentTheme].AccentDark

NavButtons[1].TextColor3 =
    THEMES[CurrentTheme].Accent

--========================================================
-- OPEN BUTTON
--========================================================

local OpenButton = New("TextButton", {
    Size = UDim2.fromOffset(50, 50),

    Position = UDim2.new(
        0,
        15,
        0.5,
        0
    ),

    AnchorPoint =
        Vector2.new(0, 0.5),

    BackgroundColor3 =
        CONFIG.Colors.Panel,

    Text = ">_",

    TextColor3 =
        THEMES[CurrentTheme].Accent,

    Font = Enum.Font.Code,
    TextSize = 17,

    Visible = false,

    AutoButtonColor = false,
}, GUI)

Corner(OpenButton, 12)

local OpenStroke = Stroke(
    OpenButton,
    THEMES[CurrentTheme].Accent,
    0.6
)

--========================================================
-- OPEN / CLOSE
--========================================================

local function OpenUI()

    State.Open = true

    OpenButton.Visible = false

    Main.Visible = true

    Main.Size =
        UDim2.fromOffset(0, 0)

    Tween(Main, {
        Size = FullSize
    }, 0.25)
end

local function CloseUI()

    State.Open = false

    local tween = Tween(
        Main,
        {
            Size =
                UDim2.fromOffset(0, 0)
        },
        0.22
    )

    if tween then

        tween.Completed:Connect(function()

            Main.Visible = false

            OpenButton.Visible = true
        end)

    else

        Main.Visible = false
        OpenButton.Visible = true
    end
end

Connect(
    Close.Activated,
    CloseUI
)

Connect(
    OpenButton.Activated,
    OpenUI
)

--========================================================
-- MINIMIZE
--========================================================

Connect(
    Minimize.Activated,
    function()

        State.Minimized =
            not State.Minimized

        Sidebar.Visible =
            not State.Minimized

        Content.Visible =
            not State.Minimized

        if State.Minimized then

            Minimize.Text = "+"

            Tween(Main, {
                Size = UDim2.new(
                    Main.Size.X.Scale,
                    Main.Size.X.Offset,
                    0,
                    54
                )
            }, 0.18)

        else

            Minimize.Text = "−"

            FullSize =
                GetMainSize()

            Tween(Main, {
                Size = FullSize
            }, 0.18)
        end
    end
)

--========================================================
-- DRAG SYSTEM
--========================================================

local Dragging = false
local DragStart
local StartPosition

Connect(
    Top.InputBegan,
    function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = true

            DragStart =
                input.Position

            StartPosition =
                Main.Position

            local releaseConnection

            releaseConnection =
                input.Changed:Connect(
                    function()

                        if input.UserInputState ==
                            Enum.UserInputState.End then

                            Dragging = false

                            if releaseConnection then
                                releaseConnection:Disconnect()
                            end
                        end
                    end
                )
        end
    end
)

Connect(
    UserInputService.InputChanged,
    function(input)

        if not Dragging then
            return
        end

        if input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or input.UserInputType ==
            Enum.UserInputType.Touch then

            local Delta =
                input.Position - DragStart

            local viewport =
                Camera.ViewportSize

            local size =
                Main.AbsoluteSize

            local x =
                StartPosition.X.Offset
                + Delta.X

            local y =
                StartPosition.Y.Offset
                + Delta.Y

            local margin = 8

            local halfWidth =
                size.X / 2

            local halfHeight =
                size.Y / 2

            local centerX =
                viewport.X / 2

            local centerY =
                viewport.Y / 2

            local minX =
                -centerX
                + halfWidth
                + margin

            local maxX =
                centerX
                - halfWidth
                - margin

            local minY =
                -centerY
                + halfHeight
                + margin

            local maxY =
                centerY
                - halfHeight
                - margin

            x =
                math.clamp(
                    x,
                    minX,
                    maxX
                )

            y =
                math.clamp(
                    y,
                    minY,
                    maxY
                )

            Main.Position =
                UDim2.new(
                    0.5,
                    x,
                    0.5,
                    y
                )
        end
    end
)

--========================================================
-- RESPONSIVE RESIZE
--========================================================

Connect(
    Camera:GetPropertyChangedSignal(
        "ViewportSize"
    ),
    function()

        if State.Minimized then
            return
        end

        FullSize =
            GetMainSize()

        Main.Size =
            FullSize

        DeviceLabel.Text =
            IsMobile()
            and "MOBILE"
            or "DESKTOP"
    end
)

--========================================================
-- UI SCALE
--========================================================

local UIScale =
    New("UIScale", {
        Scale = State.UIScale
    }, Main)

-- Update scale when setting changes
local LastScale =
    State.UIScale

Connect(
    RunService.Heartbeat,
    function()

        if LastScale ~= State.UIScale then

            LastScale =
                State.UIScale

            UIScale.Scale =
                State.UIScale
        end
    end
)

--========================================================
-- FPS MONITOR
--========================================================

local FrameCount = 0
local LastFPS = os.clock()

Connect(
    RunService.RenderStepped,
    function()

        FrameCount += 1

        local now =
            os.clock()

        if now - LastFPS >= 1 then

            if State.ShowFPS then

                FPSLabel.Text =
                    "FPS: " ..
                    tostring(FrameCount)
            end

            if State.ShowPing then

                local ping = 0

                pcall(
                    function()

                        ping =
                            math.floor(
                                Player:GetNetworkPing()
                                * 1000
                            )
                    end
                )

                PingLabel.Text =
                    "PING: " ..
                    tostring(ping) ..
                    "ms"
            end

            FrameCount = 0
            LastFPS = now
        end
    end
)

--========================================================
-- KEYBOARD TOGGLE
--========================================================

Connect(
    UserInputService.InputBegan,
    function(input, processed)

        if processed then
            return
        end

        if input.KeyCode ==
            Enum.KeyCode.RightShift then

            if State.Open then
                CloseUI()
            else
                OpenUI()
            end
        end
    end
)

--========================================================
-- FINAL INITIALIZATION
--========================================================

Main.Size =
    UDim2.fromOffset(0, 0)

Tween(Main, {
    Size = FullSize
}, 0.3)

task.delay(
    0.35,
    function()

        Notify(
            "TOATOA HUB v4.0 initialized"
        )

        Notify(
            IsMobile()
            and "Mobile mode enabled"
            or "Desktop mode enabled"
        )
    end
)

--========================================================
-- CLEANUP
--========================================================

GUI.Destroying:Connect(function()
    Cleanup()
end)
