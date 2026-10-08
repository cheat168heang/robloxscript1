--// CH3A5 HUB GUI [ULTRA EDITION V6.8]
--// Added Trending Hub Tab + Key System Rename + Square Main Frame & Rounded Bottom Edge

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local StartSessionTime = tick()
local ConfigFile = "CH3A5_Config_V6_8.json"

--==================================================
-- LOCAL DATA PERSISTENCE
--==================================================

local SavedConfig = {
    DefaultTheme = "Neon Cyan",
    AutoShowGUI = true,
    Favorites = {}
}

local function LoadSavedConfig()
    pcall(function()
        if readfile and isfile and isfile(ConfigFile) then
            local decoded = HttpService:JSONDecode(readfile(ConfigFile))
            if type(decoded) == "table" then
                for k, v in pairs(decoded) do
                    SavedConfig[k] = v
                end
            end
        end
    end)
end

local function SaveConfig()
    pcall(function()
        if writefile then
            writefile(ConfigFile, HttpService:JSONEncode(SavedConfig))
        end
    end)
end

LoadSavedConfig()

--==================================================
-- SOUND EFFECTS & BLUR
--==================================================

local function PlaySound(soundId, pitch)
    task.spawn(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. tostring(soundId)
        sound.Volume = 0.25
        sound.Pitch = pitch or 1
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end)
end

local Blur = Lighting:FindFirstChild("CH3A5_CyberBlur") or Instance.new("BlurEffect")
Blur.Name = "CH3A5_CyberBlur"
Blur.Size = 0
Blur.Parent = Lighting

local function SetBlur(enabled)
    TweenService:Create(Blur, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = enabled and 10 or 0}):Play()
end

--==================================================
-- OPTIMIZED HIGH-CONTRAST THEMES
--==================================================

local Themes = {
    ["Neon Cyan"] = { Background = Color3.fromRGB(12, 16, 24), Surface = Color3.fromRGB(18, 24, 36), SurfaceAlt = Color3.fromRGB(28, 38, 56), Accent = Color3.fromRGB(0, 240, 255), AccentAlt = Color3.fromRGB(255, 0, 110), Text = Color3.fromRGB(245, 250, 255), Muted = Color3.fromRGB(130, 160, 180) },
    ["Matrix Green"] = { Background = Color3.fromRGB(10, 18, 12), Surface = Color3.fromRGB(16, 28, 20), SurfaceAlt = Color3.fromRGB(26, 44, 32), Accent = Color3.fromRGB(0, 255, 128), AccentAlt = Color3.fromRGB(0, 180, 255), Text = Color3.fromRGB(235, 255, 240), Muted = Color3.fromRGB(120, 170, 140) },
    ["Overdrive Pink"] = { Background = Color3.fromRGB(20, 12, 18), Surface = Color3.fromRGB(32, 18, 28), SurfaceAlt = Color3.fromRGB(50, 28, 44), Accent = Color3.fromRGB(255, 0, 128), AccentAlt = Color3.fromRGB(255, 210, 0), Text = Color3.fromRGB(255, 240, 250), Muted = Color3.fromRGB(180, 130, 160) },
    ["Synth Yellow"] = { Background = Color3.fromRGB(18, 16, 10), Surface = Color3.fromRGB(30, 26, 16), SurfaceAlt = Color3.fromRGB(48, 42, 26), Accent = Color3.fromRGB(255, 210, 0), AccentAlt = Color3.fromRGB(0, 240, 255), Text = Color3.fromRGB(255, 252, 235), Muted = Color3.fromRGB(170, 160, 120) },
    ["Void Purple"] = { Background = Color3.fromRGB(14, 10, 22), Surface = Color3.fromRGB(22, 16, 36), SurfaceAlt = Color3.fromRGB(38, 26, 58), Accent = Color3.fromRGB(170, 0, 255), AccentAlt = Color3.fromRGB(0, 240, 255), Text = Color3.fromRGB(245, 235, 255), Muted = Color3.fromRGB(150, 120, 180) },
    ["Red Alert"] = { Background = Color3.fromRGB(20, 10, 12), Surface = Color3.fromRGB(32, 15, 18), SurfaceAlt = Color3.fromRGB(52, 24, 28), Accent = Color3.fromRGB(255, 35, 60), AccentAlt = Color3.fromRGB(255, 170, 0), Text = Color3.fromRGB(255, 235, 238), Muted = Color3.fromRGB(180, 130, 135) },

    ["Discord Dark"] = { Background = Color3.fromRGB(40, 43, 48), Surface = Color3.fromRGB(54, 57, 63), SurfaceAlt = Color3.fromRGB(72, 76, 85), Accent = Color3.fromRGB(114, 137, 218), AccentAlt = Color3.fromRGB(235, 69, 158), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(190, 195, 200) },
    ["TikTok Dark"] = { Background = Color3.fromRGB(22, 22, 22), Surface = Color3.fromRGB(34, 34, 34), SurfaceAlt = Color3.fromRGB(52, 52, 52), Accent = Color3.fromRGB(254, 44, 85), AccentAlt = Color3.fromRGB(37, 244, 238), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(170, 170, 170) },
    ["YouTube Dark"] = { Background = Color3.fromRGB(18, 18, 18), Surface = Color3.fromRGB(38, 38, 38), SurfaceAlt = Color3.fromRGB(56, 56, 56), Accent = Color3.fromRGB(255, 0, 0), AccentAlt = Color3.fromRGB(62, 166, 255), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(180, 180, 180) },
    ["Spotify Green"] = { Background = Color3.fromRGB(20, 20, 20), Surface = Color3.fromRGB(30, 30, 30), SurfaceAlt = Color3.fromRGB(46, 46, 46), Accent = Color3.fromRGB(29, 185, 84), AccentAlt = Color3.fromRGB(30, 215, 96), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(175, 175, 175) },
    ["Instagram Dark"] = { Background = Color3.fromRGB(10, 10, 10), Surface = Color3.fromRGB(24, 24, 24), SurfaceAlt = Color3.fromRGB(42, 42, 42), Accent = Color3.fromRGB(225, 48, 108), AccentAlt = Color3.fromRGB(245, 96, 64), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(170, 170, 170) },
    ["X Twitter"] = { Background = Color3.fromRGB(12, 14, 18), Surface = Color3.fromRGB(26, 29, 36), SurfaceAlt = Color3.fromRGB(44, 48, 58), Accent = Color3.fromRGB(29, 161, 242), AccentAlt = Color3.fromRGB(255, 255, 255), Text = Color3.fromRGB(247, 249, 249), Muted = Color3.fromRGB(150, 160, 170) },
    ["Twitch Purple"] = { Background = Color3.fromRGB(18, 18, 22), Surface = Color3.fromRGB(32, 32, 38), SurfaceAlt = Color3.fromRGB(50, 48, 64), Accent = Color3.fromRGB(145, 70, 255), AccentAlt = Color3.fromRGB(0, 230, 118), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(180, 180, 195) },
    ["Telegram Blue"] = { Background = Color3.fromRGB(28, 40, 52), Surface = Color3.fromRGB(40, 54, 70), SurfaceAlt = Color3.fromRGB(56, 74, 96), Accent = Color3.fromRGB(42, 171, 238), AccentAlt = Color3.fromRGB(114, 219, 114), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(160, 180, 200) },
    ["Reddit Orange"] = { Background = Color3.fromRGB(16, 24, 28), Surface = Color3.fromRGB(30, 44, 50), SurfaceAlt = Color3.fromRGB(46, 64, 72), Accent = Color3.fromRGB(255, 69, 0), AccentAlt = Color3.fromRGB(0, 121, 211), Text = Color3.fromRGB(240, 240, 240), Muted = Color3.fromRGB(160, 175, 180) },
    ["WhatsApp Dark"] = { Background = Color3.fromRGB(20, 32, 38), Surface = Color3.fromRGB(36, 50, 58), SurfaceAlt = Color3.fromRGB(52, 70, 80), Accent = Color3.fromRGB(37, 211, 102), AccentAlt = Color3.fromRGB(0, 168, 132), Text = Color3.fromRGB(240, 245, 245), Muted = Color3.fromRGB(160, 180, 190) },
    ["Pinterest Red"] = { Background = Color3.fromRGB(22, 22, 22), Surface = Color3.fromRGB(36, 36, 36), SurfaceAlt = Color3.fromRGB(54, 54, 54), Accent = Color3.fromRGB(230, 0, 35), AccentAlt = Color3.fromRGB(255, 90, 96), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(180, 180, 180) },
    ["Snapchat Dark"] = { Background = Color3.fromRGB(18, 18, 18), Surface = Color3.fromRGB(32, 32, 32), SurfaceAlt = Color3.fromRGB(50, 50, 50), Accent = Color3.fromRGB(255, 252, 0), AccentAlt = Color3.fromRGB(0, 209, 255), Text = Color3.fromRGB(255, 255, 255), Muted = Color3.fromRGB(180, 180, 180) }
}

local CurrentTheme = Themes[SavedConfig.DefaultTheme] or Themes["Neon Cyan"]
local RegisteredElements = {}

local function RegisterThemeElement(instance, property, themeKey)
    table.insert(RegisteredElements, {Instance = instance, Property = property, Key = themeKey})
    instance[property] = CurrentTheme[themeKey]
end

local function ApplyTheme(newTheme)
    CurrentTheme = newTheme
    for _, item in ipairs(RegisteredElements) do
        if item.Instance and item.Instance.Parent then
            TweenService:Create(item.Instance, TweenInfo.new(0.3), {
                [item.Property] = CurrentTheme[item.Key]
            }):Play()
        end
    end
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_CYBER_MASTER_V6_8"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local NotifContainer = Instance.new("Frame")
NotifContainer.Size = UDim2.new(0, 210, 1, -30)
NotifContainer.Position = UDim2.new(1, -220, 0, 10)
NotifContainer.BackgroundTransparency = 1
NotifContainer.ZIndex = 100
NotifContainer.Parent = ScreenGui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 6)
NotifLayout.Parent = NotifContainer

local function Notify(titleText, descText, duration)
    duration = duration or 3
    PlaySound(6042053626, 1.2)

    local Toast = Instance.new("Frame")
    Toast.Size = UDim2.new(1, 0, 0, 42)
    Toast.BackgroundColor3 = CurrentTheme.Surface
    Toast.BorderSizePixel = 0
    Toast.BackgroundTransparency = 1
    Toast.ZIndex = 101
    Toast.Parent = NotifContainer
    RegisterThemeElement(Toast, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Toast

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = CurrentTheme.Accent
    Stroke.Thickness = 1
    Stroke.Parent = Toast
    RegisterThemeElement(Stroke, "Color", "Accent")

    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 3, 1, 0)
    AccentBar.BackgroundColor3 = CurrentTheme.Accent
    AccentBar.BorderSizePixel = 0
    AccentBar.ZIndex = 102
    AccentBar.Parent = Toast
    RegisterThemeElement(AccentBar, "BackgroundColor3", "Accent")

    local TTitle = Instance.new("TextLabel")
    TTitle.Size = UDim2.new(1, -12, 0, 16)
    TTitle.Position = UDim2.fromOffset(8, 3)
    TTitle.BackgroundTransparency = 1
    TTitle.Text = "// " .. titleText
    TTitle.Font = Enum.Font.Code
    TTitle.TextSize = 10
    TTitle.TextColor3 = CurrentTheme.Accent
    TTitle.TextXAlignment = Enum.TextXAlignment.Left
    TTitle.ZIndex = 102
    TTitle.Parent = Toast
    RegisterThemeElement(TTitle, "TextColor3", "Accent")

    local TDesc = Instance.new("TextLabel")
    TDesc.Size = UDim2.new(1, -12, 0, 18)
    TDesc.Position = UDim2.fromOffset(8, 19)
    TDesc.BackgroundTransparency = 1
    TDesc.Text = descText
    TDesc.Font = Enum.Font.Gotham
    TDesc.TextSize = 9
    TDesc.TextColor3 = CurrentTheme.Text
    TDesc.TextXAlignment = Enum.TextXAlignment.Left
    TDesc.ZIndex = 102
    TDesc.Parent = Toast
    RegisterThemeElement(TDesc, "TextColor3", "Text")

    TweenService:Create(Toast, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()

    task.delay(duration, function()
        local t = TweenService:Create(Toast, TweenInfo.new(0.25), {BackgroundTransparency = 1})
        t:Play()
        t.Completed:Connect(function() Toast:Destroy() end)
    end)
end

-- DRAGGING
local function MakeDraggable(gui, handle)
    handle = handle or gui
    local dragging = false
    local dragInput, dragStart, startPos
    local hasMoved = false

    local function update(input)
        local delta = input.Position - dragStart
        if delta.Magnitude > 5 then
            hasMoved = true
        end
        gui.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            hasMoved = false
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    return function()
        return hasMoved
    end
end

-- SCRIPT EXECUTOR
local function ExecuteScript(scriptName, url)
    Notify("EXECUTE", "Downloading " .. scriptName .. "...", 2)
    task.spawn(function()
        local success, source = pcall(function() return game:HttpGet(url) end)
        if not success or not source then
            Notify("ERROR", "Failed download: " .. scriptName, 3)
            return
        end
        local runSuccess, err = pcall(function()
            local fn = loadstring(source)
            if fn then fn() end
        end)
        if not runSuccess then
            Notify("ERROR", "Error in " .. scriptName, 3)
        else
            Notify("SYSTEM", scriptName .. " Executed!", 3)
        end
    end)
end

--==================================================
-- MAIN FRAME
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(464, 312)
Main.Position = UDim2.new(0.5, -232, 0.5, -156)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = false
Main.ZIndex = 10
Main.Visible = false
Main.Parent = ScreenGui
RegisterThemeElement(Main, "BackgroundColor3", "Background")

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = CurrentTheme.Accent
MainStroke.Thickness = 1.2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = Main
RegisterThemeElement(MainStroke, "Color", "Accent")

local BottomWrapper = Instance.new("Frame")
BottomWrapper.Size = UDim2.new(1, 0, 0, 8)
BottomWrapper.Position = UDim2.new(0, 0, 1, -8)
BottomWrapper.BackgroundColor3 = CurrentTheme.Background
BottomWrapper.BorderSizePixel = 0
BottomWrapper.ZIndex = 10
BottomWrapper.Parent = Main
RegisterThemeElement(BottomWrapper, "BackgroundColor3", "Background")

local BWCorner = Instance.new("UICorner")
BWCorner.CornerRadius = UDim.new(0, 8)
BWCorner.Parent = BottomWrapper

local isGuiOpen = false
local isGuiAnimating = false

local function ToggleGUI(visible)
    if isGuiAnimating then return end
    isGuiAnimating = true
    isGuiOpen = visible

    if visible then
        Main.Visible = true
        Main.Size = UDim2.fromOffset(0, 0)
        Main.Position = UDim2.new(0.5, 0, 0.5, 0)
        SetBlur(true)
        local tw = TweenService:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(464, 312),
            Position = UDim2.new(0.5, -232, 0.5, -156)
        })
        tw:Play()
        tw.Completed:Connect(function()
            isGuiAnimating = false
        end)
    else
        SetBlur(false)
        local tw = TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        tw:Play()
        tw.Completed:Connect(function()
            Main.Visible = false
            isGuiAnimating = false
        end)
    end
end

-- TOPBAR
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 32)
Topbar.BackgroundColor3 = CurrentTheme.Surface
Topbar.BorderSizePixel = 0
Topbar.ZIndex = 11
Topbar.Parent = Main
RegisterThemeElement(Topbar, "BackgroundColor3", "Surface")

MakeDraggable(Main, Topbar)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -140, 1, 0)
Title.Position = UDim2.fromOffset(10, 0)
Title.BackgroundTransparency = 1
Title.Text = "[ CH3A5 // HUB ] V6.8"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = CurrentTheme.Accent
Title.ZIndex = 12
Title.Parent = Topbar
RegisterThemeElement(Title, "TextColor3", "Accent")

local StatusBadge = Instance.new("Frame")
StatusBadge.Size = UDim2.fromOffset(60, 16)
StatusBadge.Position = UDim2.new(1, -120, 0.5, -8)
StatusBadge.BackgroundColor3 = CurrentTheme.Background
StatusBadge.BorderSizePixel = 0
StatusBadge.ZIndex = 12
StatusBadge.Parent = Topbar
RegisterThemeElement(StatusBadge, "BackgroundColor3", "Background")

local SCorner = Instance.new("UICorner")
SCorner.CornerRadius = UDim.new(0, 4)
SCorner.Parent = StatusBadge

local SDot = Instance.new("Frame")
SDot.Size = UDim2.fromOffset(5, 5)
SDot.Position = UDim2.fromOffset(6, 6)
SDot.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
SDot.BorderSizePixel = 0
SDot.ZIndex = 13
SDot.Parent = StatusBadge

local SDotCorner = Instance.new("UICorner")
SDotCorner.CornerRadius = UDim.new(1, 0)
SDotCorner.Parent = SDot

local SText = Instance.new("TextLabel")
SText.Size = UDim2.new(1, -15, 1, 0)
SText.Position = UDim2.fromOffset(14, 0)
SText.BackgroundTransparency = 1
SText.Text = "ONLINE"
SText.Font = Enum.Font.Code
SText.TextSize = 8
SText.TextColor3 = CurrentTheme.Text
SText.TextXAlignment = Enum.TextXAlignment.Left
SText.ZIndex = 13
SText.Parent = StatusBadge
RegisterThemeElement(SText, "TextColor3", "Text")

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(26, 26)
CloseBtn.Position = UDim2.new(1, -29, 0.5, -13)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.TextColor3 = CurrentTheme.AccentAlt
CloseBtn.ZIndex = 13
CloseBtn.Parent = Topbar
RegisterThemeElement(CloseBtn, "TextColor3", "AccentAlt")

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 60, 60)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.15), {TextColor3 = CurrentTheme.AccentAlt}):Play()
end)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 115, 1, -32)
Sidebar.Position = UDim2.fromOffset(0, 32)
Sidebar.BackgroundColor3 = CurrentTheme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Sidebar.Parent = Main
RegisterThemeElement(Sidebar, "BackgroundColor3", "Surface")

local TabHolder = Instance.new("ScrollingFrame")
TabHolder.Size = UDim2.new(1, 0, 1, -42)
TabHolder.BackgroundTransparency = 1
TabHolder.BorderSizePixel = 0
TabHolder.ScrollBarThickness = 1
TabHolder.CanvasSize = UDim2.new()
TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabHolder.ZIndex = 12
TabHolder.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 4)
SideLayout.Parent = TabHolder

local SidePad = Instance.new("UIPadding")
SidePad.PaddingTop = UDim.new(0, 6)
SidePad.PaddingLeft = UDim.new(0, 5)
SidePad.PaddingRight = UDim.new(0, 5)
SidePad.Parent = TabHolder

-- PROFILE CARD (TRANSPARENT BACKGROUND)
local ProfileCard = Instance.new("Frame")
ProfileCard.Size = UDim2.new(1, -10, 0, 36)
ProfileCard.Position = UDim2.new(0, 5, 1, -38)
ProfileCard.BackgroundTransparency = 1
ProfileCard.BorderSizePixel = 0
ProfileCard.ZIndex = 12
ProfileCard.Parent = Sidebar

local PAvatar = Instance.new("ImageLabel")
PAvatar.Size = UDim2.fromOffset(24, 24)
PAvatar.Position = UDim2.fromOffset(6, 6)
PAvatar.BackgroundTransparency = 1
PAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150"
PAvatar.ZIndex = 13
PAvatar.Parent = ProfileCard

local PACorner = Instance.new("UICorner")
PACorner.CornerRadius = UDim.new(1, 0)
PACorner.Parent = PAvatar

local PName = Instance.new("TextLabel")
PName.Size = UDim2.new(1, -38, 0, 14)
PName.Position = UDim2.fromOffset(34, 5)
PName.BackgroundTransparency = 1
PName.Text = Player.DisplayName
PName.Font = Enum.Font.GothamBold
PName.TextSize = 9
PName.TextTruncate = Enum.TextTruncate.AtEnd
PName.TextColor3 = CurrentTheme.Text
PName.TextXAlignment = Enum.TextXAlignment.Left
PName.ZIndex = 13
PName.Parent = ProfileCard
RegisterThemeElement(PName, "TextColor3", "Text")

local PUser = Instance.new("TextLabel")
PUser.Size = UDim2.new(1, -38, 0, 12)
PUser.Position = UDim2.fromOffset(34, 18)
PUser.BackgroundTransparency = 1
PUser.Text = "@" .. Player.Name
PUser.Font = Enum.Font.Code
PUser.TextSize = 8
PUser.TextTruncate = Enum.TextTruncate.AtEnd
PUser.TextColor3 = CurrentTheme.Muted
PUser.TextXAlignment = Enum.TextXAlignment.Left
PUser.ZIndex = 13
PUser.Parent = ProfileCard
RegisterThemeElement(PUser, "TextColor3", "Muted")

-- CONTENT & PAGES
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -115, 1, -32)
Content.Position = UDim2.fromOffset(115, 32)
Content.BackgroundColor3 = CurrentTheme.Background
Content.BorderSizePixel = 0
Content.ZIndex = 11
Content.Parent = Main
RegisterThemeElement(Content, "BackgroundColor3", "Background")

local Pages = {}

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Size = UDim2.new(1, -12, 1, -12)
    Page.Position = UDim2.fromOffset(6, 6)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = CurrentTheme.Accent
    Page.CanvasSize = UDim2.new()
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.ZIndex = 12
    Page.Parent = Content
    RegisterThemeElement(Page, "ScrollBarImageColor3", "Accent")

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 6)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    Pages[name] = Page
    return Page
end

local HomePage = CreatePage("Home")
local TrendingPage = CreatePage("Trending")
local KeylessPage = CreatePage("Keyless")
local KeyPage = CreatePage("Key")
local FavoritesPage = CreatePage("Favorites")
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")
local AboutPage = CreatePage("About")

--==================================================
-- DEDICATED PERSISTENT FAVORITES SYSTEM
--==================================================

local RegisteredStarBtns = {}

local function RefreshFavoritesUI()
    for _, child in ipairs(FavoritesPage:GetChildren()) do
        if child:IsA("Frame") and child.Name == "ScriptFrame" then
            child:Destroy()
        end
    end

    local count = 0
    for scriptName, scriptData in pairs(SavedConfig.Favorites) do
        count = count + 1
        local Frame = Instance.new("Frame")
        Frame.Name = "ScriptFrame"
        Frame.Size = UDim2.new(1, 0, 0, 44)
        Frame.BackgroundColor3 = CurrentTheme.Surface
        Frame.BorderSizePixel = 0
        Frame.ZIndex = 13
        Frame.Parent = FavoritesPage
        RegisterThemeElement(Frame, "BackgroundColor3", "Surface")

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 4)
        Corner.Parent = Frame

        local NameLabel = Instance.new("TextLabel")
        NameLabel.Name = "ScriptName"
        NameLabel.Size = UDim2.new(1, -135, 0, 18)
        NameLabel.Position = UDim2.fromOffset(8, 4)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = scriptData.Name
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 10
        NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
        NameLabel.TextColor3 = CurrentTheme.Text
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.ZIndex = 14
        NameLabel.Parent = Frame
        RegisterThemeElement(NameLabel, "TextColor3", "Text")

        local DescLabel = Instance.new("TextLabel")
        DescLabel.Size = UDim2.new(1, -135, 0, 16)
        DescLabel.Position = UDim2.fromOffset(8, 22)
        DescLabel.BackgroundTransparency = 1
        DescLabel.Text = "[ " .. scriptData.Desc .. " ]"
        DescLabel.Font = Enum.Font.Code
        DescLabel.TextSize = 8
        DescLabel.TextTruncate = Enum.TextTruncate.AtEnd
        DescLabel.TextColor3 = CurrentTheme.Muted
        DescLabel.TextXAlignment = Enum.TextXAlignment.Left
        DescLabel.ZIndex = 14
        DescLabel.Parent = Frame
        RegisterThemeElement(DescLabel, "TextColor3", "Muted")

        local ExecBtn = Instance.new("TextButton")
        ExecBtn.Size = UDim2.fromOffset(72, 22)
        ExecBtn.Position = UDim2.new(1, -100, 0.5, -11)
        ExecBtn.BackgroundColor3 = CurrentTheme.SurfaceAlt
        ExecBtn.Text = "▶ Execute"
        ExecBtn.Font = Enum.Font.Code
        ExecBtn.TextSize = 8
        ExecBtn.TextColor3 = CurrentTheme.Accent
        ExecBtn.ZIndex = 15
        ExecBtn.Parent = Frame
        RegisterThemeElement(ExecBtn, "BackgroundColor3", "SurfaceAlt")
        RegisterThemeElement(ExecBtn, "TextColor3", "Accent")

        local ECorner = Instance.new("UICorner")
        ECorner.CornerRadius = UDim.new(0, 4)
        ECorner.Parent = ExecBtn

        ExecBtn.MouseButton1Click:Connect(function()
            ExecuteScript(scriptData.Name, scriptData.Url)
        end)

        local StarBtn = Instance.new("TextButton")
        StarBtn.Size = UDim2.fromOffset(22, 22)
        StarBtn.Position = UDim2.new(1, -26, 0.5, -11)
        StarBtn.BackgroundTransparency = 1
        StarBtn.Text = "⭐"
        StarBtn.Font = Enum.Font.Code
        StarBtn.TextSize = 12
        StarBtn.TextColor3 = CurrentTheme.Accent
        StarBtn.ZIndex = 15
        StarBtn.Parent = Frame
        RegisterThemeElement(StarBtn, "TextColor3", "Accent")

        StarBtn.MouseButton1Click:Connect(function()
            SavedConfig.Favorites[scriptName] = nil
            SaveConfig()
            if RegisteredStarBtns[scriptName] then
                RegisteredStarBtns[scriptName].TextColor3 = CurrentTheme.Muted
            end
            RefreshFavoritesUI()
            Notify("FAVORITE", "Removed " .. scriptName, 2)
        end)
    end

    local NoFavLabel = FavoritesPage:FindFirstChild("NoFavLabel")
    if NoFavLabel then
        NoFavLabel.Visible = (count == 0)
    end
end

--==================================================
-- UI HELPERS
--==================================================

local function AddSection(Page, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.BackgroundTransparency = 1
    Label.Text = "// " .. text
    Label.Font = Enum.Font.Code
    Label.TextSize = 10
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Accent
    Label.ZIndex = 13
    Label.Parent = Page
    RegisterThemeElement(Label, "TextColor3", "Accent")
    return Label
end

local function AddInfo(Page, text)
    local Label = Instance.new("TextLabel")
    if text == "[ NO FAVORITE MODULES ]" then Label.Name = "NoFavLabel" end
    Label.Size = UDim2.new(1, 0, 0, 14)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 9
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Muted
    Label.ZIndex = 13
    Label.Parent = Page
    RegisterThemeElement(Label, "TextColor3", "Muted")
    return Label
end

local function AddSearchBar(Page)
    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(1, 0, 0, 24)
    SearchBox.BackgroundColor3 = CurrentTheme.Surface
    SearchBox.BorderSizePixel = 0
    SearchBox.Font = Enum.Font.Code
    SearchBox.TextSize = 9
    SearchBox.Text = ""
    SearchBox.PlaceholderText = "🔍 Search modules..."
    SearchBox.TextColor3 = CurrentTheme.Text
    SearchBox.PlaceholderColor3 = CurrentTheme.Muted
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.ZIndex = 13
    SearchBox.Parent = Page
    RegisterThemeElement(SearchBox, "BackgroundColor3", "Surface")
    RegisterThemeElement(SearchBox, "TextColor3", "Text")
    RegisterThemeElement(SearchBox, "PlaceholderColor3", "Muted")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = SearchBox

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 8)
    Padding.Parent = SearchBox

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = string.lower(SearchBox.Text)
        for _, child in ipairs(Page:GetChildren()) do
            if child:IsA("Frame") and child:FindFirstChild("ScriptName") then
                local scriptName = string.lower(child.ScriptName.Text)
                if query == "" or string.find(scriptName, query, 1, true) then
                    child.Visible = true
                else
                    child.Visible = false
                end
            end
        end
    end)
end

local function AddScriptButton(Page, name, description, url)
    local Frame = Instance.new("Frame")
    Frame.Name = "ScriptFrame"
    Frame.Size = UDim2.new(1, 0, 0, 44)
    Frame.BackgroundColor3 = CurrentTheme.Surface
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 13
    Frame.Parent = Page
    RegisterThemeElement(Frame, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Frame

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "ScriptName"
    NameLabel.Size = UDim2.new(1, -135, 0, 18)
    NameLabel.Position = UDim2.fromOffset(8, 4)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 10
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextColor3 = CurrentTheme.Text
    NameLabel.ZIndex = 14
    NameLabel.Parent = Frame
    RegisterThemeElement(NameLabel, "TextColor3", "Text")

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -135, 0, 16)
    DescLabel.Position = UDim2.fromOffset(8, 22)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = "[ " .. description .. " ]"
    DescLabel.Font = Enum.Font.Code
    DescLabel.TextSize = 8
    DescLabel.TextTruncate = Enum.TextTruncate.AtEnd
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.TextColor3 = CurrentTheme.Muted
    DescLabel.ZIndex = 14
    DescLabel.Parent = Frame
    RegisterThemeElement(DescLabel, "TextColor3", "Muted")

    local ExecBtn = Instance.new("TextButton")
    ExecBtn.Size = UDim2.fromOffset(72, 22)
    ExecBtn.Position = UDim2.new(1, -100, 0.5, -11)
    ExecBtn.BackgroundColor3 = CurrentTheme.SurfaceAlt
    ExecBtn.Text = "▶ Execute"
    ExecBtn.Font = Enum.Font.Code
    ExecBtn.TextSize = 8
    ExecBtn.TextColor3 = CurrentTheme.Accent
    ExecBtn.ZIndex = 15
    ExecBtn.Parent = Frame
    RegisterThemeElement(ExecBtn, "BackgroundColor3", "SurfaceAlt")
    RegisterThemeElement(ExecBtn, "TextColor3", "Accent")

    local ECorner = Instance.new("UICorner")
    ECorner.CornerRadius = UDim.new(0, 4)
    ECorner.Parent = ExecBtn

    ExecBtn.MouseEnter:Connect(function()
        TweenService:Create(ExecBtn, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Accent, TextColor3 = CurrentTheme.Background}):Play()
    end)
    ExecBtn.MouseLeave:Connect(function()
        TweenService:Create(ExecBtn, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.SurfaceAlt, TextColor3 = CurrentTheme.Accent}):Play()
    end)

    ExecBtn.MouseButton1Click:Connect(function()
        ExecuteScript(name, url)
    end)

    local StarBtn = Instance.new("TextButton")
    StarBtn.Size = UDim2.fromOffset(22, 22)
    StarBtn.Position = UDim2.new(1, -26, 0.5, -11)
    StarBtn.BackgroundTransparency = 1
    StarBtn.Text = "⭐"
    StarBtn.Font = Enum.Font.Code
    StarBtn.TextSize = 12
    StarBtn.TextColor3 = SavedConfig.Favorites[name] and CurrentTheme.Accent or CurrentTheme.Muted
    StarBtn.ZIndex = 15
    StarBtn.Parent = Frame

    RegisteredStarBtns[name] = StarBtn

    StarBtn.MouseButton1Click:Connect(function()
        if SavedConfig.Favorites[name] then
            SavedConfig.Favorites[name] = nil
            StarBtn.TextColor3 = CurrentTheme.Muted
            Notify("FAVORITE", "Removed " .. name, 2)
        else
            SavedConfig.Favorites[name] = {Name = name, Desc = description, Url = url}
            StarBtn.TextColor3 = CurrentTheme.Accent
            Notify("FAVORITE", "Added " .. name, 2)
        end
        SaveConfig()
        RefreshFavoritesUI()
    end)

    return Frame
end

local function AddToggle(Page, text, defaultState, callback)
    local state = defaultState or false

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 28)
    ToggleFrame.BackgroundColor3 = CurrentTheme.Surface
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.ZIndex = 13
    ToggleFrame.Parent = Page
    RegisterThemeElement(ToggleFrame, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.fromOffset(8, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Code
    Label.TextSize = 9
    Label.TextColor3 = CurrentTheme.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 14
    Label.Parent = ToggleFrame
    RegisterThemeElement(Label, "TextColor3", "Text")

    local SwitchBtn = Instance.new("TextButton")
    SwitchBtn.Size = UDim2.fromOffset(36, 16)
    SwitchBtn.Position = UDim2.new(1, -42, 0.5, -8)
    SwitchBtn.BackgroundColor3 = state and CurrentTheme.Accent or CurrentTheme.Background
    SwitchBtn.Text = state and "ON" or "OFF"
    SwitchBtn.Font = Enum.Font.Code
    SwitchBtn.TextSize = 8
    SwitchBtn.TextColor3 = state and CurrentTheme.Background or CurrentTheme.Muted
    SwitchBtn.ZIndex = 14
    SwitchBtn.Parent = ToggleFrame

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(0, 4)
    SwitchCorner.Parent = SwitchBtn

    SwitchBtn.MouseButton1Click:Connect(function()
        PlaySound(6042053626, 1.1)
        state = not state
        SwitchBtn.Text = state and "ON" or "OFF"
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = state and CurrentTheme.Accent or CurrentTheme.Background,
            TextColor3 = state and CurrentTheme.Background or CurrentTheme.Muted
        }):Play()

        if callback then callback(state) end
    end)
end

--==================================================
-- REDESIGNED HOME DASHBOARD
--==================================================

local HomeHeader = Instance.new("Frame")
HomeHeader.Size = UDim2.new(1, 0, 0, 32)
HomeHeader.BackgroundTransparency = 1
HomeHeader.ZIndex = 13
HomeHeader.Parent = HomePage

local HomeTitle = Instance.new("TextLabel")
HomeTitle.Size = UDim2.new(1, 0, 0, 18)
HomeTitle.Position = UDim2.fromOffset(0, 0)
HomeTitle.BackgroundTransparency = 1
HomeTitle.Text = "[ CH3A5 // HUB ] V6.8"
HomeTitle.Font = Enum.Font.GothamBold
HomeTitle.TextSize = 13
HomeTitle.TextColor3 = CurrentTheme.Text
HomeTitle.TextXAlignment = Enum.TextXAlignment.Left
HomeTitle.ZIndex = 14
HomeTitle.Parent = HomeHeader
RegisterThemeElement(HomeTitle, "TextColor3", "Text")

-- WELCOME CARD
local WelcomeCard = Instance.new("Frame")
WelcomeCard.Size = UDim2.new(1, 0, 0, 64)
WelcomeCard.BackgroundColor3 = CurrentTheme.Surface
WelcomeCard.BorderSizePixel = 0
WelcomeCard.ZIndex = 13
WelcomeCard.Parent = HomePage
RegisterThemeElement(WelcomeCard, "BackgroundColor3", "Surface")

local WCorner = Instance.new("UICorner")
WCorner.CornerRadius = UDim.new(0, 4)
WCorner.Parent = WelcomeCard

local WAvatar = Instance.new("ImageLabel")
WAvatar.Size = UDim2.fromOffset(44, 44)
WAvatar.Position = UDim2.fromOffset(10, 10)
WAvatar.BackgroundTransparency = 1
WAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150"
WAvatar.ZIndex = 14
WAvatar.Parent = WelcomeCard

local WACorner = Instance.new("UICorner")
WACorner.CornerRadius = UDim.new(1, 0)
WACorner.Parent = WAvatar

local WTag = Instance.new("TextLabel")
WTag.Size = UDim2.new(1, -120, 0, 12)
WTag.Position = UDim2.fromOffset(62, 10)
WTag.BackgroundTransparency = 1
WTag.Text = "WELCOME BACK"
WTag.Font = Enum.Font.Code
WTag.TextSize = 8
WTag.TextColor3 = CurrentTheme.Accent
WTag.TextXAlignment = Enum.TextXAlignment.Left
WTag.ZIndex = 14
WTag.Parent = WelcomeCard
RegisterThemeElement(WTag, "TextColor3", "Accent")

local WName = Instance.new("TextLabel")
WName.Size = UDim2.new(1, -120, 0, 16)
WName.Position = UDim2.fromOffset(62, 22)
WName.BackgroundTransparency = 1
WName.Text = Player.DisplayName
WName.Font = Enum.Font.GothamBold
WName.TextSize = 11
WName.TextTruncate = Enum.TextTruncate.AtEnd
WName.TextColor3 = CurrentTheme.Text
WName.TextXAlignment = Enum.TextXAlignment.Left
WName.ZIndex = 14
WName.Parent = WelcomeCard
RegisterThemeElement(WName, "TextColor3", "Text")

local WUser = Instance.new("TextLabel")
WUser.Size = UDim2.new(1, -120, 0, 14)
WUser.Position = UDim2.fromOffset(62, 38)
WUser.BackgroundTransparency = 1
WUser.Text = "@" .. Player.Name
WUser.Font = Enum.Font.Code
WUser.TextSize = 8
WUser.TextTruncate = Enum.TextTruncate.AtEnd
WUser.TextColor3 = CurrentTheme.Muted
WUser.TextXAlignment = Enum.TextXAlignment.Left
WUser.ZIndex = 14
WUser.Parent = WelcomeCard
RegisterThemeElement(WUser, "TextColor3", "Muted")

-- PERFORMANCE STATS
local PerfCard = Instance.new("Frame")
PerfCard.Size = UDim2.new(1, 0, 0, 60)
PerfCard.BackgroundColor3 = CurrentTheme.Surface
PerfCard.BorderSizePixel = 0
PerfCard.ZIndex = 13
PerfCard.Parent = HomePage
RegisterThemeElement(PerfCard, "BackgroundColor3", "Surface")

local PCorner2 = Instance.new("UICorner")
PCorner2.CornerRadius = UDim.new(0, 4)
PCorner2.Parent = PerfCard

local PGrid = Instance.new("UIGridLayout")
PGrid.CellSize = UDim2.new(0.25, -5, 1, -8)
PGrid.CellPadding = UDim2.fromOffset(6, 0)
PGrid.Parent = PerfCard

local PPad = Instance.new("UIPadding")
PPad.PaddingTop = UDim.new(0, 4)
PPad.PaddingLeft = UDim.new(0, 6)
PPad.PaddingRight = UDim.new(0, 6)
PPad.Parent = PerfCard

local function CreatePerfItem(title, initialValue)
    local Item = Instance.new("Frame")
    Item.BackgroundColor3 = CurrentTheme.Background
    Item.BorderSizePixel = 0
    Item.ZIndex = 14
    Item.Parent = PerfCard
    RegisterThemeElement(Item, "BackgroundColor3", "Background")

    local ICorner = Instance.new("UICorner")
    ICorner.CornerRadius = UDim.new(0, 4)
    ICorner.Parent = Item

    local ITitle = Instance.new("TextLabel")
    ITitle.Size = UDim2.new(1, -8, 0, 14)
    ITitle.Position = UDim2.fromOffset(6, 4)
    ITitle.BackgroundTransparency = 1
    ITitle.Text = title
    ITitle.Font = Enum.Font.Code
    ITitle.TextSize = 8
    ITitle.TextColor3 = CurrentTheme.Muted
    ITitle.TextXAlignment = Enum.TextXAlignment.Left
    ITitle.ZIndex = 15
    ITitle.Parent = Item
    RegisterThemeElement(ITitle, "TextColor3", "Muted")

    local IVal = Instance.new("TextLabel")
    IVal.Size = UDim2.new(1, -8, 0, 18)
    IVal.Position = UDim2.fromOffset(6, 18)
    IVal.BackgroundTransparency = 1
    IVal.Text = initialValue
    IVal.Font = Enum.Font.Code
    IVal.TextSize = 11
    IVal.TextColor3 = CurrentTheme.Text
    IVal.TextXAlignment = Enum.TextXAlignment.Left
    IVal.ZIndex = 15
    IVal.Parent = Item
    RegisterThemeElement(IVal, "TextColor3", "Text")

    return IVal
end

local FPSVal = CreatePerfItem("FPS", "60")
local PingVal = CreatePerfItem("PING", "0ms")
local PlayersVal = CreatePerfItem("PLAYERS", "1/1")
local SessionVal = CreatePerfItem("SESSION", "00m 00s")

task.spawn(function()
    local frameCount = 0
    local lastCheck = os.clock()
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = os.clock()
        if now - lastCheck >= 0.5 then
            local fps = math.floor(frameCount / (now - lastCheck))
            frameCount = 0
            lastCheck = now
            local ping = 0
            pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
            FPSVal.Text = tostring(fps)
            PingVal.Text = tostring(ping) .. "ms"
            PlayersVal.Text = tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers)
            local elapsed = math.floor(tick() - StartSessionTime)
            SessionVal.Text = string.format("%02dm %02ds", math.floor(elapsed/60), elapsed%60)
        end
    end)
end)

-- SERVER ACTIONS
local GameCard = Instance.new("Frame")
GameCard.Size = UDim2.new(1, 0, 0, 48)
GameCard.BackgroundColor3 = CurrentTheme.Surface
GameCard.BorderSizePixel = 0
GameCard.ZIndex = 13
GameCard.Parent = HomePage
RegisterThemeElement(GameCard, "BackgroundColor3", "Surface")

local GCorner = Instance.new("UICorner")
GCorner.CornerRadius = UDim.new(0, 4)
GCorner.Parent = GameCard

local ActGrid = Instance.new("Frame")
ActGrid.Size = UDim2.new(1, -12, 0, 28)
ActGrid.Position = UDim2.fromOffset(6, 10)
ActGrid.BackgroundTransparency = 1
ActGrid.ZIndex = 14
ActGrid.Parent = GameCard

local ALayout = Instance.new("UIGridLayout")
ALayout.CellSize = UDim2.new(0.25, -5, 1, 0)
ALayout.CellPadding = UDim2.fromOffset(6, 0)
ALayout.Parent = ActGrid

local function CreateActionButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.BackgroundColor3 = CurrentTheme.Background
    Btn.Text = text
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 8
    Btn.TextColor3 = CurrentTheme.Text
    Btn.ZIndex = 15
    Btn.Parent = ActGrid
    RegisterThemeElement(Btn, "BackgroundColor3", "Background")
    RegisterThemeElement(Btn, "TextColor3", "Text")

    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 4)
    BCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

CreateActionButton("⚡ Rejoin", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
end)

local function ServerHop(lowest)
    Notify("SERVER", "Searching...", 3)
    task.spawn(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=" .. (lowest and "Asc" or "Desc") .. "&limit=100"
        local success, result = pcall(function() return game:HttpGet(url) end)
        if success and result then
            local data = HttpService:JSONDecode(result)
            if data and data.data then
                for _, s in ipairs(data.data) do
                    if s.playing and s.playing < s.maxPlayers and s.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, Player)
                        return
                    end
                end
            end
        end
        Notify("SERVER", "No server found!", 3)
    end)
end

CreateActionButton("🚀 Hop", function() ServerHop(false) end)
CreateActionButton("📉 Low Hop", function() ServerHop(true) end)
CreateActionButton("📋 Job ID", function()
    pcall(function() setclipboard(game.JobId) end)
    Notify("SERVER", "Copied Job ID", 2)
end)

--==================================================
-- TRENDING, KEYLESS & KEYED LOADERS
--==================================================

AddSection(TrendingPage, "TRENDING MODULES")
AddSearchBar(TrendingPage)
AddScriptButton(TrendingPage, "CHILLY HUB", "Keyless", "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
AddScriptButton(TrendingPage, "Forge Hub", "Key System", "https://cdn.forgehub.store/loade")

AddSection(KeylessPage, "KEYLESS MODULES")
AddSearchBar(KeylessPage)AddScriptButton(KeylessPage, "SourcesHub New", "Keyless", "https://gist.githubusercontent.com/sourceshubs/1737c14cdba5c6fb472a995d555a50f1/raw/SourcesHubInstantStealNew") 
AddScriptButton(KeylessPage, "SKRR HUB", "Keyless", "https://flowauth.net/v1/loaders/52aa9854f4fad5068bbead01ce10c7a6.lua") 
AddScriptButton(KeylessPage, "CHILLI HUB", "Keyless", "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua") 
AddScriptButton(KeylessPage, "SOURCES HUB", "Keyless", "https://gist.githubusercontent.com/sourceshubs/df6e17b3672213791b47a0a8c5398b6e/raw/SourcesHubAntiHitNewest") 
AddScriptButton(KeylessPage, "MIRANDA HUB", "Keyless", "https://raw.githubusercontent.com/kadit9999/stealanegg/refs/heads/main/kaitunmirage.lua")

AddSection(KeyPage, "KEY SYSTEM MODULES")
AddSearchBar(KeyPage)
AddScriptButton(KeyPage, "FYY", "Key System", "https://fyycommunity.com/") 
AddScriptButton(KeyPage, "REALKID HUB", "Key System", "https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua") 
AddScriptButton(KeyPage, "Zeroin(ZN)", "Key System", "https://zeroinhub.com/api/script") 
AddScriptButton(KeyPage, "Forge Hub", "Key System", "https://cdn.forgehub.store/loader") 
AddScriptButton(KeyPage, "DryNyx Hub", "Key System", "https://synex.lat/loaders/stealegg.lua") 
AddScriptButton(KeyPage, "Rift Hub", "Key System", "https://rifton.top/loader.lua") 
AddScriptButton(KeyPage, "Frost Hub", "Key System", "https://frostgg.pages.dev/loader.luau") 
AddScriptButton(KeyPage, "Tsuo Hub", "Key System", "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/stealanegg") 
AddScriptButton(KeyPage, "Lennon Hub", "Key System", "https://api.jnkie.com/api/v1/luascripts/public/bf52181bce5c28e6ecd16eebfa1a88ddaf646c7acb10015fbaa7b30dc7bad0a8/download") 
AddScriptButton(KeyPage, "Nasi Rendang Hub", "Key System", "https://raw.githubusercontent.com/JualNasiRendang/loader/refs/heads/main/main.lua") 
AddScriptButton(KeyPage, "OMG Hub", "Key System", "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua") 
AddScriptButton(KeyPage, "NEOX Hub", "Key System", "https://raw.githubusercontent.com/hassanxzayn-lua/NEOXHUBMAIN/refs/heads/main/loader")

AddSection(FavoritesPage, "FAVORITED MODULES")
AddInfo(FavoritesPage, "[ NO FAVORITE MODULES ]")
AddSearchBar(FavoritesPage)
RefreshFavoritesUI()

--==================================================
-- THEMES PAGE
--==================================================

AddSection(ThemesPage, "COLOR SCHEMES")

local RegisteredDefaultBtns = {}

local function UpdateThemeButtonsUI()
    for tName, btnRef in pairs(RegisteredDefaultBtns) do
        if tName == SavedConfig.DefaultTheme then
            btnRef.Text = "[DEFAULT]"
            btnRef.TextColor3 = CurrentTheme.Accent
        else
            btnRef.Text = "[SET DEFAULT]"
            btnRef.TextColor3 = CurrentTheme.Muted
        end
    end
end

for ThemeName, ThemeData in pairs(Themes) do
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 28)
    Frame.BackgroundColor3 = ThemeData.Surface
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 13
    Frame.Parent = ThemesPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Frame

    local NameBtn = Instance.new("TextButton")
    NameBtn.Size = UDim2.new(1, -90, 1, 0)
    NameBtn.BackgroundTransparency = 1
    NameBtn.Text = "  🎨 " .. ThemeName
    NameBtn.Font = Enum.Font.Code
    NameBtn.TextSize = 9
    NameBtn.TextColor3 = ThemeData.Text
    NameBtn.TextXAlignment = Enum.TextXAlignment.Left
    NameBtn.ZIndex = 14
    NameBtn.Parent = Frame

    NameBtn.MouseButton1Click:Connect(function()
        PlaySound(6042053626, 1)
        ApplyTheme(ThemeData)
        Notify("THEME", "Applied: " .. ThemeName, 2)
    end)

    local SetDefBtn = Instance.new("TextButton")
    SetDefBtn.Size = UDim2.fromOffset(80, 20)
    SetDefBtn.Position = UDim2.new(1, -84, 0.5, -10)
    SetDefBtn.BackgroundColor3 = ThemeData.Background
    SetDefBtn.Font = Enum.Font.Code
    SetDefBtn.TextSize = 8
    SetDefBtn.ZIndex = 15
    SetDefBtn.Parent = Frame

    local DCorner = Instance.new("UICorner")
    DCorner.CornerRadius = UDim.new(0, 4)
    DCorner.Parent = SetDefBtn

    RegisteredDefaultBtns[ThemeName] = SetDefBtn

    SetDefBtn.MouseButton1Click:Connect(function()
        PlaySound(6042053626, 1)
        SavedConfig.DefaultTheme = ThemeName
        SaveConfig()
        ApplyTheme(ThemeData)
        UpdateThemeButtonsUI()
        Notify("THEME", "Set Default: " .. ThemeName, 2)
    end)
end

UpdateThemeButtonsUI()

--==================================================
-- CONFIG PAGE
--==================================================

AddSection(SettingsPage, "SYSTEM CONTROLS")

AddToggle(SettingsPage, "Auto Show GUI on Execute", SavedConfig.AutoShowGUI, function(enabled)
    SavedConfig.AutoShowGUI = enabled
    SaveConfig()
    Notify("SETTINGS", "Auto Show GUI: " .. (enabled and "ON" or "OFF"), 2)
end)

--==================================================
-- ABOUT PAGE
--==================================================

AddSection(AboutPage, "HUB INFORMATION")

local function AddAboutInfoCard(labelTitle, labelValue)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 26)
    Frame.BackgroundColor3 = CurrentTheme.Surface
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 13
    Frame.Parent = AboutPage
    RegisterThemeElement(Frame, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Frame

    local TLbl = Instance.new("TextLabel")
    TLbl.Size = UDim2.new(0.5, 0, 1, 0)
    TLbl.Position = UDim2.fromOffset(8, 0)
    TLbl.BackgroundTransparency = 1
    TLbl.Text = labelTitle
    TLbl.Font = Enum.Font.Code
    TLbl.TextSize = 9
    TLbl.TextColor3 = CurrentTheme.Muted
    TLbl.TextXAlignment = Enum.TextXAlignment.Left
    TLbl.ZIndex = 14
    TLbl.Parent = Frame
    RegisterThemeElement(TLbl, "TextColor3", "Muted")

    local VLbl = Instance.new("TextLabel")
    VLbl.Size = UDim2.new(0.5, -8, 1, 0)
    VLbl.Position = UDim2.new(0.5, 0, 0, 0)
    VLbl.BackgroundTransparency = 1
    VLbl.Text = labelValue
    VLbl.Font = Enum.Font.GothamBold
    VLbl.TextSize = 9
    VLbl.TextColor3 = CurrentTheme.Text
    VLbl.TextXAlignment = Enum.TextXAlignment.Right
    VLbl.ZIndex = 14
    VLbl.Parent = Frame
    RegisterThemeElement(VLbl, "TextColor3", "Text")
end

AddAboutInfoCard("Hub Name", "CH3A5 HUB")
AddAboutInfoCard("Version", "1.0")
AddAboutInfoCard("Developer", "CH3A5")
AddAboutInfoCard("Status", "🟢 Online")
AddAboutInfoCard("Release", "2026")

AddSection(AboutPage, "OFFICIAL LINKS")

local function AddLinkButton(platformName, linkUrl)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 32)
    Frame.BackgroundColor3 = CurrentTheme.Surface
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 13
    Frame.Parent = AboutPage
    RegisterThemeElement(Frame, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Frame

    local NameLbl = Instance.new("TextLabel")
    NameLbl.Size = UDim2.new(1, -85, 1, 0)
    NameLbl.Position = UDim2.fromOffset(8, 0)
    NameLbl.BackgroundTransparency = 1
    NameLbl.Text = "🔗 " .. platformName
    NameLbl.Font = Enum.Font.Code
    NameLbl.TextSize = 9
    NameLbl.TextColor3 = CurrentTheme.Text
    NameLbl.TextXAlignment = Enum.TextXAlignment.Left
    NameLbl.ZIndex = 14
    NameLbl.Parent = Frame
    RegisterThemeElement(NameLbl, "TextColor3", "Text")

    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Size = UDim2.fromOffset(72, 22)
    CopyBtn.Position = UDim2.new(1, -76, 0.5, -11)
    CopyBtn.BackgroundColor3 = CurrentTheme.SurfaceAlt
    CopyBtn.Text = "📋 Copy"
    CopyBtn.Font = Enum.Font.Code
    CopyBtn.TextSize = 8
    CopyBtn.TextColor3 = CurrentTheme.Accent
    CopyBtn.ZIndex = 15
    CopyBtn.Parent = Frame
    RegisterThemeElement(CopyBtn, "BackgroundColor3", "SurfaceAlt")
    RegisterThemeElement(CopyBtn, "TextColor3", "Accent")

    local ECorner = Instance.new("UICorner")
    ECorner.CornerRadius = UDim.new(0, 4)
    ECorner.Parent = CopyBtn

    CopyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(linkUrl) end)
        Notify("COPIED", "Copied " .. platformName .. " link!", 2)
    end)
end

AddLinkButton("Telegram Channel", "https://t.me/stealanegg_ch3a5_script")
AddLinkButton("Telegram Chat", "https://t.me/ch3a5")
AddLinkButton("TikTok", "https://www.tiktok.com/@ch3a5smos_404")
AddLinkButton("Facebook", "https://www.facebook.com/share/17tbhLwQuN/?mibextid=wwXIfr")

--==================================================
-- NAVIGATION TABS
--==================================================

local TabButtons = {}

local function AddTab(titleText, page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 28)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = titleText
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 10
    Button.TextColor3 = CurrentTheme.Muted
    Button.AutoButtonColor = false
    Button.ZIndex = 13
    Button.Parent = TabHolder
    RegisterThemeElement(Button, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 3, 0.65, 0)
    Indicator.Position = UDim2.new(0, 2, 0.175, 0)
    Indicator.BackgroundColor3 = CurrentTheme.Accent
    Indicator.BorderSizePixel = 0
    Indicator.BackgroundTransparency = 1
    Indicator.ZIndex = 14
    Indicator.Parent = Button
    RegisterThemeElement(Indicator, "BackgroundColor3", "Accent")

    local ICorner = Instance.new("UICorner")
    ICorner.CornerRadius = UDim.new(1, 0)
    ICorner.Parent = Indicator

    TabButtons[titleText] = {Button = Button, Page = page, Indicator = Indicator}

    Button.MouseButton1Click:Connect(function()
        PlaySound(6042053626, 1)
        for _, tabData in pairs(TabButtons) do
            tabData.Page.Visible = false
            tabData.Button.TextColor3 = CurrentTheme.Muted
            TweenService:Create(tabData.Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Surface}):Play()
            TweenService:Create(tabData.Indicator, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        end

        page.Position = UDim2.fromOffset(16, 6)
        page.Visible = true
        TweenService:Create(page, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.fromOffset(6, 6)
        }):Play()

        Button.TextColor3 = CurrentTheme.Accent
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.SurfaceAlt}):Play()
        TweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end)

    return Button
end

local HomeTab = AddTab("🏠 Home", HomePage)
AddTab("🔥 Trending", TrendingPage)
AddTab("⚡ Keyless", KeylessPage)
AddTab("🔑 Key System", KeyPage)
AddTab("⭐ Favorites", FavoritesPage)
AddTab("🎨 Themes", ThemesPage)
AddTab("⚙️ Config", SettingsPage)
AddTab("ℹ️ About", AboutPage)

HomePage.Visible = true
HomeTab.TextColor3 = CurrentTheme.Accent
HomeTab.BackgroundColor3 = CurrentTheme.SurfaceAlt
if TabButtons["🏠 Home"] and TabButtons["🏠 Home"].Indicator then
    TabButtons["🏠 Home"].Indicator.BackgroundTransparency = 0
end

-- CLOSE BUTTON LOGIC
CloseBtn.MouseButton1Click:Connect(function()
    PlaySound(6042053626, 0.8)
    ToggleGUI(false)
end)

--==================================================
-- MOON TOGGLE BUTTON
--==================================================

local MoonToggle = Instance.new("TextButton")
MoonToggle.Name = "MoonToggle"
MoonToggle.Size = UDim2.fromOffset(42, 42)
MoonToggle.Position = UDim2.new(0, 15, 0.4, 0)
MoonToggle.BackgroundColor3 = CurrentTheme.Surface
MoonToggle.Text = "🌙"
MoonToggle.Font = Enum.Font.Code
MoonToggle.TextSize = 18
MoonToggle.ZIndex = 500
MoonToggle.Visible = true
MoonToggle.Parent = ScreenGui
RegisterThemeElement(MoonToggle, "BackgroundColor3", "Surface")

local MoonCorner = Instance.new("UICorner")
MoonCorner.CornerRadius = UDim.new(1, 0)
MoonCorner.Parent = MoonToggle

local MoonStroke = Instance.new("UIStroke")
MoonStroke.Color = CurrentTheme.Accent
MoonStroke.Thickness = 1.2
MoonStroke.Parent = MoonToggle
RegisterThemeElement(MoonStroke, "Color", "Accent")

MoonToggle.MouseEnter:Connect(function()
    TweenService:Create(MoonToggle, TweenInfo.new(0.2), {Size = UDim2.fromOffset(46, 46)}):Play()
end)

MoonToggle.MouseLeave:Connect(function()
    TweenService:Create(MoonToggle, TweenInfo.new(0.2), {Size = UDim2.fromOffset(42, 42)}):Play()
end)

local getMoonMoved = MakeDraggable(MoonToggle, nil)

MoonToggle.MouseButton1Click:Connect(function()
    if not getMoonMoved() then
        PlaySound(6042053626, 1.2)
        ToggleGUI(not isGuiOpen)
    end
end)

-- INITIAL STATE
if SavedConfig.AutoShowGUI then
    ToggleGUI(true)
else
    SetBlur(false)
end

Notify("CYBERHUB", "CH3A5 HUB V6.8 Ready!", 4)
