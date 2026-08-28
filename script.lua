--// TOATOA HUB
--// Modern Hacker UI - Roblox Studio
--// Performance-focused UI template

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
    Title = "TOATOA HUB",
    Version = "v2.0",
    Accent = Color3.fromRGB(35, 255, 130),
    Background = Color3.fromRGB(8, 10, 13),
    Panel = Color3.fromRGB(13, 16, 20),
    Panel2 = Color3.fromRGB(18, 22, 27),
    Text = Color3.fromRGB(230, 235, 235),
    Muted = Color3.fromRGB(105, 115, 120),
}

--==================================================
-- HELPERS
--==================================================

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

local function Tween(object, time, properties)
    return TweenService:Create(
        object,
        TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    )
end

--==================================================
-- GUI
--==================================================

local Gui = New("ScreenGui", {
    Name = "ToatoaModernUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true
}, PlayerGui)

--==================================================
-- MAIN
--==================================================

local Main = New("Frame", {
    Size = UDim2.fromOffset(720, 440),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = CONFIG.Background,
    BorderSizePixel = 0
}, Gui)

Corner(Main, 14)
Stroke(Main, CONFIG.Accent, 0.7)

--==================================================
-- TOP BAR
--==================================================

local Top = New("Frame", {
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = CONFIG.Panel,
    BorderSizePixel = 0
}, Main)

Corner(Top, 14)

local Title = New("TextLabel", {
    Size = UDim2.new(1, -150, 1, 0),
    Position = UDim2.fromOffset(20, 0),
    BackgroundTransparency = 1,
    Text = ">_ " .. CONFIG.Title,
    TextColor3 = CONFIG.Accent,
    Font = Enum.Font.Code,
    TextSize = 22,
    TextXAlignment = Enum.TextXAlignment.Left
}, Top)

local Version = New("TextLabel", {
    Size = UDim2.fromOffset(80, 30),
    Position = UDim2.new(1, -155, 0, 14),
    BackgroundTransparency = 1,
    Text = CONFIG.Version,
    TextColor3 = CONFIG.Muted,
    Font = Enum.Font.Code,
    TextSize = 12
}, Top)

local Close = New("TextButton", {
    Size = UDim2.fromOffset(38, 32),
    Position = UDim2.new(1, -48, 0, 13),
    BackgroundColor3 = Color3.fromRGB(35, 20, 23),
    Text = "×",
    TextColor3 = Color3.fromRGB(255, 90, 100),
    Font = Enum.Font.Code,
    TextSize = 22,
    AutoButtonColor = false
}, Top)

Corner(Close, 8)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {
    Size = UDim2.new(0, 165, 1, -75),
    Position = UDim2.fromOffset(12, 66),
    BackgroundColor3 = CONFIG.Panel,
    BorderSizePixel = 0
}, Main)

Corner(Sidebar, 11)

New("UIPadding", {
    PaddingTop = UDim.new(0, 14),
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10)
}, Sidebar)

local SidebarLayout = New("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Sidebar)

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
    Size = UDim2.new(1, -190, 1, -75),
    Position = UDim2.fromOffset(180, 66),
    BackgroundTransparency = 1
}, Main)

--==================================================
-- PAGES
--==================================================

local Pages = {}

local function CreatePage(name)
    local page = New("Frame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Visible = false
    }, Content)

    Pages[name] = page
    return page
end

local Dashboard = CreatePage("Dashboard")
local Games = CreatePage("Games")
local Scripts = CreatePage("Scripts")
local Settings = CreatePage("Settings")

Dashboard.Visible = true

--==================================================
-- PAGE TITLE
--==================================================

local function PageTitle(parent, text, subtitle)

    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = CONFIG.Text,
        Font = Enum.Font.Code,
        TextSize = 21,
        TextXAlignment = Enum.TextXAlignment.Left
    }, parent)

    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 25),
        Position = UDim2.fromOffset(0, 35),
        BackgroundTransparency = 1,
        Text = subtitle,
        TextColor3 = CONFIG.Muted,
        Font = Enum.Font.Code,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, parent)
end

PageTitle(
    Dashboard,
    "SYSTEM DASHBOARD",
    "Welcome back, " .. Player.DisplayName
)

--==================================================
-- STATUS CARD
--==================================================

local StatusCard = New("Frame", {
    Size = UDim2.new(1, 0, 0, 105),
    Position = UDim2.fromOffset(0, 70),
    BackgroundColor3 = CONFIG.Panel,
    BorderSizePixel = 0
}, Dashboard)

Corner(StatusCard, 10)
Stroke(StatusCard, CONFIG.Accent, 0.8)

New("TextLabel", {
    Size = UDim2.new(1, -25, 0, 30),
    Position = UDim2.fromOffset(15, 12),
    BackgroundTransparency = 1,
    Text = "● SYSTEM ONLINE",
    TextColor3 = CONFIG.Accent,
    Font = Enum.Font.Code,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
}, StatusCard)

New("TextLabel", {
    Size = UDim2.new(1, -30, 0, 45),
    Position = UDim2.fromOffset(15, 45),
    BackgroundTransparency = 1,
    Text = "Interface initialized successfully.\nPerformance mode: ENABLED",
    TextColor3 = CONFIG.Muted,
    Font = Enum.Font.Code,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
}, StatusCard)

--==================================================
-- GAMES PAGE
--==================================================

PageTitle(
    Games,
    "GAME CENTER",
    "Select a supported game"
)

local GameList = New("Frame", {
    Size = UDim2.new(1, 0, 1, -70),
    Position = UDim2.fromOffset(0, 70),
    BackgroundTransparency = 1
}, Games)

local GameLayout = New("UIListLayout", {
    Padding = UDim.new(0, 8)
}, GameList)

local function GameCard(name, id)

    local card = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 55),
        BackgroundColor3 = CONFIG.Panel,
        Text = "",
        AutoButtonColor = false
    }, GameList)

    Corner(card, 9)

    New("TextLabel", {
        Size = UDim2.new(1, -20, 0, 25),
        Position = UDim2.fromOffset(12, 6),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = CONFIG.Text,
        Font = Enum.Font.Code,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    New("TextLabel", {
        Size = UDim2.new(1, -20, 0, 18),
        Position = UDim2.fromOffset(12, 30),
        BackgroundTransparency = 1,
        Text = "PlaceID: " .. tostring(id),
        TextColor3 = CONFIG.Muted,
        Font = Enum.Font.Code,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    card.MouseEnter:Connect(function()
        Tween(card, 0.12, {
            BackgroundColor3 = Color3.fromRGB(20, 40, 29)
        }):Play()
    end)

    card.MouseLeave:Connect(function()
        Tween(card, 0.12, {
            BackgroundColor3 = CONFIG.Panel
        }):Play()
    end)

    return card
end

GameCard("Murder Mystery 2", 142823291)
GameCard("99 Nights in the Forest", 79546208627805)
GameCard("Grow a Garden", 126987765280963)
GameCard("Steal an Egg", 107778070777162)

--==================================================
-- SCRIPTS PAGE
--==================================================

PageTitle(
    Scripts,
    "SCRIPT MANAGER",
    "Manage your legitimate Studio scripts"
)

local ScriptBox = New("Frame", {
    Size = UDim2.new(1, 0, 0, 180),
    Position = UDim2.fromOffset(0, 70),
    BackgroundColor3 = CONFIG.Panel,
    BorderSizePixel = 0
}, Scripts)

Corner(ScriptBox, 10)

New("TextLabel", {
    Size = UDim2.new(1, -25, 0, 30),
    Position = UDim2.fromOffset(15, 12),
    BackgroundTransparency = 1,
    Text = "LOCAL SCRIPT STATUS",
    TextColor3 = CONFIG.Accent,
    Font = Enum.Font.Code,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left
}, ScriptBox)

New("TextLabel", {
    Size = UDim2.new(1, -30, 0, 90),
    Position = UDim2.fromOffset(15, 48),
    BackgroundTransparency = 1,
    Text = "✓ UI loaded\n✓ Animations optimized\n✓ Event connections active\n✓ Performance mode enabled",
    TextColor3 = CONFIG.Text,
    Font = Enum.Font.Code,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
}, ScriptBox)

--==================================================
-- SETTINGS
--==================================================

PageTitle(
    Settings,
    "SETTINGS",
    "Interface preferences"
)

local SettingsBox = New("Frame", {
    Size = UDim2.new(1, 0, 0, 180),
    Position = UDim2.fromOffset(0, 70),
    BackgroundColor3 = CONFIG.Panel,
    BorderSizePixel = 0
}, Settings)

Corner(SettingsBox, 10)

local PerfButton = New("TextButton", {
    Size = UDim2.new(1, -30, 0, 45),
    Position = UDim2.fromOffset(15, 15),
    BackgroundColor3 = Color3.fromRGB(20, 45, 31),
    Text = "⚡  PERFORMANCE MODE     ON",
    TextColor3 = CONFIG.Accent,
    Font = Enum.Font.Code,
    TextSize = 13,
    AutoButtonColor = false
}, SettingsBox)

Corner(PerfButton, 8)

PerfButton.Activated:Connect(function()

    local enabled = PerfButton:GetAttribute("Enabled")

    if enabled == nil then
        enabled = true
    end

    enabled = not enabled
    PerfButton:SetAttribute("Enabled", enabled)

    if enabled then
        PerfButton.Text = "⚡  PERFORMANCE MODE     ON"
        PerfButton.TextColor3 = CONFIG.Accent
    else
        PerfButton.Text = "⚡  PERFORMANCE MODE     OFF"
        PerfButton.TextColor3 = CONFIG.Muted
    end
end)

--==================================================
-- NOTIFICATION
--==================================================

local NotificationHolder = New("Frame", {
    Size = UDim2.fromOffset(280, 200),
    Position = UDim2.new(1, -300, 1, -220),
    BackgroundTransparency = 1
}, Gui)

local NotificationLayout = New("UIListLayout", {
    Padding = UDim.new(0, 8),
    VerticalAlignment = Enum.VerticalAlignment.Bottom
}, NotificationHolder)

local function Notify(text)

    local notification = New("Frame", {
        Size = UDim2.fromOffset(280, 50),
        BackgroundColor3 = CONFIG.Panel2,
        BorderSizePixel = 0
    }, NotificationHolder)

    Corner(notification, 9)
    Stroke(notification, CONFIG.Accent, 0.75)

    New("TextLabel", {
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.fromOffset(10, 0),
        BackgroundTransparency = 1,
        Text = "●  " .. text,
        TextColor3 = CONFIG.Text,
        Font = Enum.Font.Code,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, notification)

    notification.Position = UDim2.new(1, 40, 0, 0)

    Tween(notification, 0.2, {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()

    task.delay(3, function()

        if notification.Parent then
            local tween = Tween(notification, 0.2, {
                Position = UDim2.new(1, 40, 0, 0)
            })

            tween:Play()
            tween.Completed:Wait()

            notification:Destroy()
        end

    end)
end

--==================================================
-- NAVIGATION
--==================================================

local Buttons = {}

local function NavButton(text, page)

    local button = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = CONFIG.Panel2,
        Text = text,
        TextColor3 = CONFIG.Muted,
        Font = Enum.Font.Code,
        TextSize = 13,
        AutoButtonColor = false,
        LayoutOrder = #Buttons + 1
    }, Sidebar)

    Corner(button, 8)

    table.insert(Buttons, button)

    button.Activated:Connect(function()

        for pageName, pageObject in pairs(Pages) do
            pageObject.Visible = pageName == page
        end

        for _, b in ipairs(Buttons) do
            b.TextColor3 = CONFIG.Muted
            b.BackgroundColor3 = CONFIG.Panel2
        end

        button.TextColor3 = CONFIG.Accent
        button.BackgroundColor3 = Color3.fromRGB(20, 40, 29)

        Notify("Opened " .. page)
    end)

    return button
end

NavButton("▣  DASHBOARD", "Dashboard")
NavButton("◈  GAMES", "Games")
NavButton("⌘  SCRIPTS", "Scripts")
NavButton("⚙  SETTINGS", "Settings")

Buttons[1].TextColor3 = CONFIG.Accent
Buttons[1].BackgroundColor3 = Color3.fromRGB(20, 40, 29)

--==================================================
-- DRAG SYSTEM
--==================================================

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

--==================================================
-- CLOSE
--==================================================

Close.Activated:Connect(function()

    local tween = Tween(
        Main,
        0.2,
        {
            Size = UDim2.fromOffset(0, 0)
        }
    )

    tween:Play()
    tween.Completed:Wait()

    Gui:Destroy()
end)

--==================================================
-- START ANIMATION
--==================================================

local originalSize = Main.Size

Main.Size = UDim2.fromOffset(0, 0)

Tween(Main, 0.35, {
    Size = originalSize
}):Play()

task.delay(0.4, function()
    Notify("TOATOA HUB initialized")
end)
