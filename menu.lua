--// CH3A5 HUB
--// GUI ONLY • Client-side

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local THEMES = {
    Dark = {
        Background = Color3.fromRGB(15,15,18),
        Panel = Color3.fromRGB(24,24,29),
        Accent = Color3.fromRGB(140,90,255),
        Text = Color3.fromRGB(245,245,245),
        SubText = Color3.fromRGB(160,160,170)
    },

    Midnight = {
        Background = Color3.fromRGB(7,12,22),
        Panel = Color3.fromRGB(14,22,38),
        Accent = Color3.fromRGB(70,130,255),
        Text = Color3.fromRGB(240,245,255),
        SubText = Color3.fromRGB(145,155,175)
    },

    Purple = {
        Background = Color3.fromRGB(20,10,30),
        Panel = Color3.fromRGB(34,18,48),
        Accent = Color3.fromRGB(190,80,255),
        Text = Color3.fromRGB(250,240,255),
        SubText = Color3.fromRGB(175,145,190)
    },

    Cyber = {
        Background = Color3.fromRGB(5,15,17),
        Panel = Color3.fromRGB(10,27,30),
        Accent = Color3.fromRGB(0,255,210),
        Text = Color3.fromRGB(235,255,250),
        SubText = Color3.fromRGB(125,175,170)
    },

    Red = {
        Background = Color3.fromRGB(20,8,10),
        Panel = Color3.fromRGB(35,14,17),
        Accent = Color3.fromRGB(255,65,80),
        Text = Color3.fromRGB(255,240,240),
        SubText = Color3.fromRGB(180,140,145)
    },

    Blue = {
        Background = Color3.fromRGB(7,14,25),
        Panel = Color3.fromRGB(15,27,45),
        Accent = Color3.fromRGB(45,150,255),
        Text = Color3.fromRGB(240,248,255),
        SubText = Color3.fromRGB(145,165,185)
    },

    Green = {
        Background = Color3.fromRGB(7,18,12),
        Panel = Color3.fromRGB(13,32,21),
        Accent = Color3.fromRGB(50,220,120),
        Text = Color3.fromRGB(235,255,242),
        SubText = Color3.fromRGB(135,175,150)
    },

    Gold = {
        Background = Color3.fromRGB(18,15,8),
        Panel = Color3.fromRGB(32,27,14),
        Accent = Color3.fromRGB(235,185,65),
        Text = Color3.fromRGB(255,248,225),
        SubText = Color3.fromRGB(180,165,125)
    },

    Angkor = {
        Background = Color3.fromRGB(18,13,9),
        Panel = Color3.fromRGB(35,25,17),
        Accent = Color3.fromRGB(205,145,65),
        Text = Color3.fromRGB(255,241,210),
        SubText = Color3.fromRGB(175,150,115)
    },

    Glass = {
        Background = Color3.fromRGB(12,15,20),
        Panel = Color3.fromRGB(28,32,40),
        Accent = Color3.fromRGB(120,200,255),
        Text = Color3.fromRGB(245,250,255),
        SubText = Color3.fromRGB(160,170,185)
    },

    AMOLED = {
        Background = Color3.fromRGB(0,0,0),
        Panel = Color3.fromRGB(8,8,8),
        Accent = Color3.fromRGB(255,255,255),
        Text = Color3.fromRGB(255,255,255),
        SubText = Color3.fromRGB(130,130,130)
    }
}

local CurrentTheme = "Angkor"

--==================================================
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(620,400)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,16)
Corner.Parent = Main

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(25,15)
Title.Size = UDim2.fromOffset(400,35)
Title.Font = Enum.Font.GothamBold
Title.Text = "CH3A5 HUB"
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Subtitle = Instance.new("TextLabel")
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.fromOffset(27,48)
Subtitle.Size = UDim2.fromOffset(400,25)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Premium Script Interface"
Subtitle.TextSize = 12
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Main

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Position = UDim2.fromOffset(15,85)
Sidebar.Size = UDim2.fromOffset(160,295)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0,12)
SideCorner.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(190,85)
Content.Size = UDim2.fromOffset(415,295)
Content.BackgroundTransparency = 1
Content.Parent = Main

--==================================================
-- HELPERS
--==================================================

local function makeButton(parent,text,y)
    local Button = Instance.new("TextButton")

    Button.Position = UDim2.fromOffset(10,y)
    Button.Size = UDim2.new(1,-20,0,42)
    Button.Text = text
    Button.Font = Enum.Font.GothamMedium
    Button.TextSize = 14
    Button.AutoButtonColor = false
    Button.BorderSizePixel = 0
    Button.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,9)
    c.Parent = Button

    return Button
end

local function clearContent()
    for _,v in ipairs(Content:GetChildren()) do
        v:Destroy()
    end
end

local function makeCard(name,description,y,status)
    local Card = Instance.new("TextButton")

    Card.Position = UDim2.fromOffset(5,y)
    Card.Size = UDim2.new(1,-10,0,70)
    Card.Text = ""
    Card.AutoButtonColor = false
    Card.BorderSizePixel = 0
    Card.Parent = Content

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,11)
    c.Parent = Card

    local Name = Instance.new("TextLabel")
    Name.BackgroundTransparency = 1
    Name.Position = UDim2.fromOffset(15,10)
    Name.Size = UDim2.new(1,-100,0,22)
    Name.Text = name
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 14
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.Parent = Card

    local Desc = Instance.new("TextLabel")
    Desc.BackgroundTransparency = 1
    Desc.Position = UDim2.fromOffset(15,35)
    Desc.Size = UDim2.new(1,-100,0,20)
    Desc.Text = description
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.Parent = Card

    local Status = Instance.new("TextLabel")
    Status.BackgroundTransparency = 1
    Status.Position = UDim2.new(1,-90,0,25)
    Status.Size = UDim2.fromOffset(75,20)
    Status.Text = status or "READY"
    Status.Font = Enum.Font.GothamBold
    Status.TextSize = 10
    Status.Parent = Card

    return Card
end

--==================================================
-- PAGES
--==================================================

local function KeylessPage()

    clearContent()

    local Header = Instance.new("TextLabel")
    Header.BackgroundTransparency = 1
    Header.Size = UDim2.new(1,0,0,35)
    Header.Text = "KEYLESS SCRIPTS"
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 18
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Content

    makeCard("Sources Hub","Keyless script",45,"KEYLESS")
    makeCard("Limbo Hub","Keyless script",125,"KEYLESS")
    makeCard("Virexx","Keyless script",205,"KEYLESS")
end

local function KeyPage()

    clearContent()

    local Header = Instance.new("TextLabel")
    Header.BackgroundTransparency = 1
    Header.Size = UDim2.new(1,0,0,35)
    Header.Text = "KEY SYSTEM"
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 18
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Content

    makeCard("Wzeus Hub","Key system script",45,"KEY")
    makeCard("Pulse Hub","Key system script",125,"KEY")
end

local function ComingSoonPage()

    clearContent()

    local Header = Instance.new("TextLabel")
    Header.BackgroundTransparency = 1
    Header.Size = UDim2.new(1,0,0,35)
    Header.Text = "POWERFUL SCRIPTS"
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 18
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Content

    local Card = makeCard(
        "Premium Powerful Scripts",
        "More powerful scripts are coming soon",
        55,
        "SOON"
    )

    Card.MouseButton1Click:Connect(function()
        warn("CH3A5 HUB: Coming Soon")
    end)
end

local function SettingsPage()

    clearContent()

    local Header = Instance.new("TextLabel")
    Header.BackgroundTransparency = 1
    Header.Size = UDim2.new(1,0,0,35)
    Header.Text = "SETTINGS • THEMES"
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 18
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Content

    local y = 45

    for ThemeName,_ in pairs(THEMES) do

        local Button = makeButton(Content,ThemeName,y)
        y += 45

        Button.MouseButton1Click:Connect(function()
            CurrentTheme = ThemeName
            applyTheme()
        end)
    end
end

--==================================================
-- SIDEBAR BUTTONS
--==================================================

local B1 = makeButton(Sidebar,"KEYLESS",10)
local B2 = makeButton(Sidebar,"KEY SYSTEM",60)
local B3 = makeButton(Sidebar,"COMING SOON",110)
local B4 = makeButton(Sidebar,"SETTINGS",160)
local B5 = makeButton(Sidebar,"CLOSE",220)

B1.MouseButton1Click:Connect(KeylessPage)
B2.MouseButton1Click:Connect(KeyPage)
B3.MouseButton1Click:Connect(ComingSoonPage)
B4.MouseButton1Click:Connect(SettingsPage)

--==================================================
-- OPEN / CLOSE
--==================================================

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.fromOffset(125,42)
OpenButton.Position = UDim2.fromOffset(20,20)
OpenButton.Text = "CH3A5 HUB"
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 14
OpenButton.BorderSizePixel = 0
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0,10)
OpenCorner.Parent = OpenButton

B5.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

OpenButton.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

--==================================================
-- THEME ENGINE
--==================================================

function applyTheme()

    local T = THEMES[CurrentTheme]

    Main.BackgroundColor3 = T.Background
    Sidebar.BackgroundColor3 = T.Panel

    Title.TextColor3 = T.Text
    Subtitle.TextColor3 = T.SubText

    OpenButton.BackgroundColor3 = T.Accent
    OpenButton.TextColor3 = T.Background

    for _,obj in ipairs(ScreenGui:GetDescendants()) do

        if obj:IsA("TextButton") then
            if obj ~= OpenButton then
                obj.BackgroundColor3 = T.Panel
                obj.TextColor3 = T.Text
            end
        end

        if obj:IsA("TextLabel") then
            if obj ~= Title then
                obj.TextColor3 = T.Text
            end
        end
    end
end

--==================================================
-- START
--==================================================

KeylessPage()
applyTheme()
