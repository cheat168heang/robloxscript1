--========================================================
-- TOATOA HUB v3.0
-- Modern Hacker UI / Mobile Responsive
-- Roblox Studio LocalScript
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================
-- CONFIG
--========================================================

local Config = {
    Title = "TOATOA HUB",
    Version = "v3.0",

    Accent = Color3.fromRGB(35,255,130),
    Background = Color3.fromRGB(7,9,12),
    Panel = Color3.fromRGB(13,16,20),
    Panel2 = Color3.fromRGB(18,22,27),

    Text = Color3.fromRGB(235,240,240),
    Muted = Color3.fromRGB(110,120,125),

    Animation = 0.18
}

--========================================================
-- STATE
--========================================================

local State = {
    Open = true,
    Minimized = false,
    Performance = true,
    CurrentPage = "Dashboard"
}

--========================================================
-- CLEAN OLD UI
--========================================================

local OldUI = PlayerGui:FindFirstChild("ToatoaHubV3")

if OldUI then
    OldUI:Destroy()
end

--========================================================
-- HELPERS
--========================================================

local function New(class, props, parent)
    local obj = Instance.new(class)

    for property, value in pairs(props) do
        obj[property] = value
    end

    obj.Parent = parent
    return obj
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

local function Tween(obj, properties, duration)
    local tween = TweenService:Create(
        obj,
        TweenInfo.new(
            duration or Config.Animation,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()
    return tween
end

--========================================================
-- SCREEN GUI
--========================================================

local GUI = New("ScreenGui", {
    Name = "ToatoaHubV3",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, PlayerGui)

--========================================================
-- MOBILE / DESKTOP SIZE
--========================================================

local Camera = workspace.CurrentCamera

local function GetMainSize()
    local viewport = Camera.ViewportSize

    if viewport.X <= 600 then
        return UDim2.new(0.88,0,0,390)
    else
        return UDim2.fromOffset(650,420)
    end
end

--========================================================
-- MAIN
--========================================================

local Main = New("Frame", {
    Size = GetMainSize(),
    Position = UDim2.fromScale(0.5,0.5),
    AnchorPoint = Vector2.new(0.5,0.5),
    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0
}, GUI)

Corner(Main,14)
Stroke(Main,Config.Accent,0.72)

--========================================================
-- TOP BAR
--========================================================

local Top = New("Frame", {
    Size = UDim2.new(1,0,0,52),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
}, Main)

Corner(Top,14)

local Title = New("TextLabel", {
    Size = UDim2.new(1,-130,1,0),
    Position = UDim2.fromOffset(15,0),
    BackgroundTransparency = 1,
    Text = ">_ "..Config.Title,
    TextColor3 = Config.Accent,
    Font = Enum.Font.Code,
    TextSize = 19,
    TextXAlignment = Enum.TextXAlignment.Left
},Top)

local Minimize = New("TextButton", {
    Size = UDim2.fromOffset(34,30),
    Position = UDim2.new(1,-78,0,11),
    BackgroundColor3 = Config.Panel2,
    Text = "−",
    TextColor3 = Config.Text,
    Font = Enum.Font.Code,
    TextSize = 20,
    AutoButtonColor = false
},Top)

Corner(Minimize,7)

local Close = New("TextButton", {
    Size = UDim2.fromOffset(34,30),
    Position = UDim2.new(1,-40,0,11),
    BackgroundColor3 = Color3.fromRGB(45,20,24),
    Text = "×",
    TextColor3 = Color3.fromRGB(255,90,100),
    Font = Enum.Font.Code,
    TextSize = 20,
    AutoButtonColor = false
},Top)

Corner(Close,7)

--========================================================
-- SIDEBAR
--========================================================

local Sidebar = New("Frame", {
    Size = UDim2.new(0,145,1,-65),
    Position = UDim2.fromOffset(10,58),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
},Main)

Corner(Sidebar,10)

local SideLayout = New("UIListLayout", {
    Padding = UDim.new(0,6),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder
},Sidebar)

New("UIPadding",{
    PaddingTop = UDim.new(0,10)
},Sidebar)

--========================================================
-- CONTENT
--========================================================

local Content = New("Frame", {
    Size = UDim2.new(1,-165,1,-65),
    Position = UDim2.fromOffset(155,58),
    BackgroundTransparency = 1
},Main)

--========================================================
-- PAGE SYSTEM
--========================================================

local Pages = {}

local function CreatePage(name)

    local page = New("Frame", {
        Name = name,
        Size = UDim2.fromScale(1,1),
        BackgroundTransparency = 1,
        Visible = false
    },Content)

    Pages[name] = page

    return page
end

local Dashboard = CreatePage("Dashboard")
local Games = CreatePage("Games")
local Scripts = CreatePage("Scripts")
local Settings = CreatePage("Settings")

Dashboard.Visible = true

--========================================================
-- PAGE TITLE
--========================================================

local function PageHeader(parent,title,subtitle)

    New("TextLabel",{
        Size = UDim2.new(1,-10,0,30),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Config.Text,
        Font = Enum.Font.Code,
        TextSize = 19,
        TextXAlignment = Enum.TextXAlignment.Left
    },parent)

    New("TextLabel",{
        Size = UDim2.new(1,-10,0,22),
        Position = UDim2.fromOffset(0,30),
        BackgroundTransparency = 1,
        Text = subtitle,
        TextColor3 = Config.Muted,
        Font = Enum.Font.Code,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    },parent)

end

--========================================================
-- DASHBOARD
--========================================================

PageHeader(
    Dashboard,
    "SYSTEM DASHBOARD",
    "Modern interface / optimized mode"
)

local StatusCard = New("Frame",{
    Size = UDim2.new(1,-10,0,95),
    Position = UDim2.fromOffset(0,62),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
},Dashboard)

Corner(StatusCard,10)
Stroke(StatusCard,Config.Accent,0.82)

New("TextLabel",{
    Size = UDim2.new(1,-20,0,25),
    Position = UDim2.fromOffset(12,10),
    BackgroundTransparency = 1,
    Text = "● SYSTEM ONLINE",
    TextColor3 = Config.Accent,
    Font = Enum.Font.Code,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
},StatusCard)

local PlayerInfo = New("TextLabel",{
    Size = UDim2.new(1,-20,0,45),
    Position = UDim2.fromOffset(12,38),
    BackgroundTransparency = 1,
    Text = "USER: "..Player.DisplayName..
        "\nPLACE: "..tostring(game.PlaceId),
    TextColor3 = Config.Muted,
    Font = Enum.Font.Code,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
},StatusCard)

--========================================================
-- PERFORMANCE CARD
--========================================================

local PerfCard = New("Frame",{
    Size = UDim2.new(1,-10,0,80),
    Position = UDim2.fromOffset(0,168),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
},Dashboard)

Corner(PerfCard,10)

local FPSLabel = New("TextLabel",{
    Size = UDim2.new(0.5,-10,1,0),
    Position = UDim2.fromOffset(10,0),
    BackgroundTransparency = 1,
    Text = "FPS: --",
    TextColor3 = Config.Accent,
    Font = Enum.Font.Code,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
},PerfCard)

local PingLabel = New("TextLabel",{
    Size = UDim2.new(0.5,-10,1,0),
    Position = UDim2.new(0.5,0,0,0),
    BackgroundTransparency = 1,
    Text = "PING: --",
    TextColor3 = Config.Text,
    Font = Enum.Font.Code,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
},PerfCard)

--========================================================
-- GAMES
--========================================================

PageHeader(
    Games,
    "GAME CENTER",
    "Available game profiles"
)

local GameContainer = New("ScrollingFrame",{
    Size = UDim2.new(1,-10,1,-65),
    Position = UDim2.fromOffset(0,62),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    CanvasSize = UDim2.new(0,0,0,0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
},Games)

local GameLayout = New("UIListLayout",{
    Padding = UDim.new(0,7)
},GameContainer)

local function AddGame(name,id)

    local Button = New("TextButton",{
        Size = UDim2.new(1,0,0,52),
        BackgroundColor3 = Config.Panel,
        Text = "",
        AutoButtonColor = false
    },GameContainer)

    Corner(Button,9)

    New("TextLabel",{
        Size = UDim2.new(1,-20,0,24),
        Position = UDim2.fromOffset(10,5),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Config.Text,
        Font = Enum.Font.Code,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    },Button)

    New("TextLabel",{
        Size = UDim2.new(1,-20,0,18),
        Position = UDim2.fromOffset(10,29),
        BackgroundTransparency = 1,
        Text = "ID: "..tostring(id),
        TextColor3 = Config.Muted,
        Font = Enum.Font.Code,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    },Button)

    Button.Activated:Connect(function()
        PlayerInfo.Text =
            "USER: "..Player.DisplayName..
            "\nSELECTED: "..name

        Notify("Selected "..name)
    end)

    Button.MouseEnter:Connect(function()
        Tween(Button,{
            BackgroundColor3 = Color3.fromRGB(20,38,28)
        },0.12)
    end)

    Button.MouseLeave:Connect(function()
        Tween(Button,{
            BackgroundColor3 = Config.Panel
        },0.12)
    end)
end

AddGame("Murder Mystery 2",142823291)
AddGame("99 Nights in the Forest",79546208627805)
AddGame("Grow a Garden",126987765280963)
AddGame("Steal an Egg",107778070777162)

--========================================================
-- SCRIPTS PAGE
--========================================================

PageHeader(
    Scripts,
    "SCRIPT MANAGER",
    "Local Studio script tools"
)

local ScriptStatus = New("Frame",{
    Size = UDim2.new(1,-10,0,150),
    Position = UDim2.fromOffset(0,62),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0
},Scripts)

Corner(ScriptStatus,10)

New("TextLabel",{
    Size = UDim2.new(1,-20,0,30),
    Position = UDim2.fromOffset(10,10),
    BackgroundTransparency = 1,
    Text = "LOCAL STATUS",
    TextColor3 = Config.Accent,
    Font = Enum.Font.Code,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
},ScriptStatus)

New("TextLabel",{
    Size = UDim2.new(1,-20,0,90),
    Position = UDim2.fromOffset(10,45),
    BackgroundTransparency = 1,
    Text =
        "✓ Interface loaded\n"..
        "✓ Events initialized\n"..
        "✓ Performance mode ready\n"..
        "✓ Mobile layout enabled",
    TextColor3 = Config.Text,
    Font = Enum.Font.Code,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
},ScriptStatus)

--========================================================
-- SETTINGS
--========================================================

PageHeader(
    Settings,
    "SETTINGS",
    "Customize your interface"
)

local PerformanceButton = New("TextButton",{
    Size = UDim2.new(1,-10,0,48),
    Position = UDim2.fromOffset(0,62),
    BackgroundColor3 = Color3.fromRGB(20,42,29),
    Text = "⚡ PERFORMANCE MODE  •  ON",
    TextColor3 = Config.Accent,
    Font = Enum.Font.Code,
    TextSize = 12,
    AutoButtonColor = false
},Settings)

Corner(PerformanceButton,9)

PerformanceButton.Activated:Connect(function()

    State.Performance = not State.Performance

    if State.Performance then
        PerformanceButton.Text =
            "⚡ PERFORMANCE MODE  •  ON"

        PerformanceButton.TextColor3 =
            Config.Accent
    else
        PerformanceButton.Text =
            "⚡ PERFORMANCE MODE  •  OFF"

        PerformanceButton.TextColor3 =
            Config.Muted
    end

    Notify(
        "Performance mode: "..
        (State.Performance and "ON" or "OFF")
    )
end)

--========================================================
-- NAVIGATION
--========================================================

local NavButtons = {}

local function AddNav(text,pageName)

    local Button = New("TextButton",{
        Size = UDim2.new(1,-16,0,40),
        BackgroundColor3 = Config.Panel2,
        Text = text,
        TextColor3 = Config.Muted,
        Font = Enum.Font.Code,
        TextSize = 11,
        AutoButtonColor = false,
        LayoutOrder = #NavButtons + 1
    },Sidebar)

    Corner(Button,8)

    table.insert(NavButtons,Button)

    Button.Activated:Connect(function()

        State.CurrentPage = pageName

        for name,page in pairs(Pages) do
            page.Visible = (name == pageName)
        end

        for _,nav in ipairs(NavButtons) do
            nav.BackgroundColor3 = Config.Panel2
            nav.TextColor3 = Config.Muted
        end

        Button.BackgroundColor3 =
            Color3.fromRGB(20,42,29)

        Button.TextColor3 =
            Config.Accent
    end)

end

AddNav("▣  DASHBOARD","Dashboard")
AddNav("◈  GAMES","Games")
AddNav("⌘  SCRIPTS","Scripts")
AddNav("⚙  SETTINGS","Settings")

NavButtons[1].BackgroundColor3 =
    Color3.fromRGB(20,42,29)

NavButtons[1].TextColor3 =
    Config.Accent

--========================================================
-- OPEN BUTTON
--========================================================

local OpenButton = New("TextButton",{
    Size = UDim2.fromOffset(52,52),
    Position = UDim2.new(0,15,0.5,0),
    AnchorPoint = Vector2.new(0,0.5),
    BackgroundColor3 = Config.Panel,
    Text = ">_",
    TextColor3 = Config.Accent,
    Font = Enum.Font.Code,
    TextSize = 18,
    Visible = false,
    AutoButtonColor = false
},GUI)

Corner(OpenButton,12)
Stroke(OpenButton,Config.Accent,0.6)

--========================================================
-- NOTIFICATIONS
--========================================================

local Notifications = New("Frame",{
    Size = UDim2.fromOffset(260,180),
    Position = UDim2.new(1,-275,1,-195),
    BackgroundTransparency = 1
},GUI)

local NotificationLayout = New("UIListLayout",{
    Padding = UDim.new(0,6),
    VerticalAlignment = Enum.VerticalAlignment.Bottom
},Notifications)

function Notify(message)

    local Note = New("Frame",{
        Size = UDim2.fromOffset(260,45),
        BackgroundColor3 = Config.Panel2,
        BorderSizePixel = 0
    },Notifications)

    Corner(Note,8)
    Stroke(Note,Config.Accent,0.75)

    New("TextLabel",{
        Size = UDim2.new(1,-15,1,0),
        Position = UDim2.fromOffset(8,0),
        BackgroundTransparency = 1,
        Text = "● "..message,
        TextColor3 = Config.Text,
        Font = Enum.Font.Code,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    },Note)

    task.delay(2.5,function()

        if Note and Note.Parent then
            Tween(Note,{
                BackgroundTransparency = 1
            },0.15)

            task.wait(0.16)

            if Note then
                Note:Destroy()
            end
        end

    end)
end

--========================================================
-- OPEN / CLOSE
--========================================================

local FullSize = Main.Size

local function OpenUI()

    State.Open = true

    OpenButton.Visible = false
    Main.Visible = true

    Main.Size = UDim2.fromOffset(0,0)

    Tween(Main,{
        Size = FullSize
    },0.25)

end

local function CloseUI()

    State.Open = false

    local tween = Tween(Main,{
        Size = UDim2.fromOffset(0,0)
    },0.22)

    tween.Completed:Connect(function()

        Main.Visible = false
        OpenButton.Visible = true

    end)
end

Close.Activated:Connect(CloseUI)
OpenButton.Activated:Connect(OpenUI)

--========================================================
-- MINIMIZE
--========================================================

Minimize.Activated:Connect(function()

    State.Minimized = not State.Minimized

    Sidebar.Visible = not State.Minimized
    Content.Visible = not State.Minimized

    if State.Minimized then
        Minimize.Text = "+"
        Main.Size = UDim2.new(
            Main.Size.X.Scale,
            Main.Size.X.Offset,
            0,52
        )
    else
        Minimize.Text = "−"
        Main.Size = FullSize
    end

end)

--========================================================
-- DRAG SYSTEM
--========================================================

local Dragging = false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState ==
                Enum.UserInputState.End then

                Dragging = false
            end

        end)

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        local Delta =
            input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

--========================================================
-- RESPONSIVE RESIZE
--========================================================

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()

    if not State.Minimized then
        Main.Size = GetMainSize()
        FullSize = Main.Size
    end

end)

--========================================================
-- FPS / PING
--========================================================

local Frames = 0
local LastFPSUpdate = os.clock()

RunService.RenderStepped:Connect(function()

    Frames += 1

    local now = os.clock()

    if now - LastFPSUpdate >= 1 then

        FPSLabel.Text =
            "FPS: "..tostring(Frames)

        Frames = 0
        LastFPSUpdate = now

        local ping = 0

        pcall(function()
            ping = math.floor(
                Player:GetNetworkPing() * 1000
            )
        end)

        PingLabel.Text =
            "PING: "..tostring(ping).."ms"

    end
end)

--========================================================
-- START
--========================================================

Main.Size = UDim2.fromOffset(0,0)

Tween(Main,{
    Size = FullSize
},0.3)

task.delay(0.35,function()
    Notify("TOATOA HUB v3.0 loaded")
end)
