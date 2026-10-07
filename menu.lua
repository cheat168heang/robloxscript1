--// CH3A5 HUB GUI [ULTRA PREMIUM V4.5]
--// Custom Home Dashboard + Fix Tab Scrolling + Profile Card + Untouched Script Loaders

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
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local StartSessionTime = tick()

-- Fetch Game Info
local GameInfo = {Name = "Loading...", Creator = "Loading...", Icon = "rbxassetid://0"}
task.spawn(function()
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if success and info then
        GameInfo.Name = info.Name or "Roblox Game"
        if info.Creator then
            GameInfo.Creator = info.Creator.Name or "Unknown"
        end
        if info.IconImageAssetId and info.IconImageAssetId > 0 then
            GameInfo.Icon = "rbxassetid://" .. tostring(info.IconImageAssetId)
        end
    end
end)

--==================================================
-- SOUND EFFECTS & BLUR SYSTEM
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
    TweenService:Create(Blur, TweenInfo.new(0.35), {Size = enabled and 10 or 0}):Play()
end

--==================================================
-- CYBERPUNK THEMES
--==================================================

local Themes = {
    ["Neon Cyan"] = {
        Background = Color3.fromRGB(10, 12, 18),
        Surface = Color3.fromRGB(16, 20, 28),
        SurfaceAlt = Color3.fromRGB(24, 30, 44),
        Accent = Color3.fromRGB(0, 240, 255),
        AccentAlt = Color3.fromRGB(255, 0, 110),
        Text = Color3.fromRGB(240, 250, 255),
        Muted = Color3.fromRGB(100, 140, 160)
    },
    ["Matrix Green"] = {
        Background = Color3.fromRGB(8, 14, 10),
        Surface = Color3.fromRGB(14, 22, 16),
        SurfaceAlt = Color3.fromRGB(20, 32, 24),
        Accent = Color3.fromRGB(0, 255, 128),
        AccentAlt = Color3.fromRGB(0, 180, 255),
        Text = Color3.fromRGB(230, 255, 235),
        Muted = Color3.fromRGB(100, 160, 120)
    },
    ["Overdrive Pink"] = {
        Background = Color3.fromRGB(18, 10, 15),
        Surface = Color3.fromRGB(28, 15, 24),
        SurfaceAlt = Color3.fromRGB(38, 20, 32),
        Accent = Color3.fromRGB(255, 0, 128),
        AccentAlt = Color3.fromRGB(255, 210, 0),
        Text = Color3.fromRGB(255, 240, 250),
        Muted = Color3.fromRGB(170, 110, 140)
    },
    ["Synth Yellow"] = {
        Background = Color3.fromRGB(15, 14, 8),
        Surface = Color3.fromRGB(25, 23, 12),
        SurfaceAlt = Color3.fromRGB(35, 31, 16),
        Accent = Color3.fromRGB(255, 210, 0),
        AccentAlt = Color3.fromRGB(0, 240, 255),
        Text = Color3.fromRGB(255, 252, 230),
        Muted = Color3.fromRGB(160, 150, 100)
    },
    ["Void Purple"] = {
        Background = Color3.fromRGB(12, 8, 20),
        Surface = Color3.fromRGB(20, 14, 32),
        SurfaceAlt = Color3.fromRGB(30, 18, 46),
        Accent = Color3.fromRGB(170, 0, 255),
        AccentAlt = Color3.fromRGB(0, 240, 255),
        Text = Color3.fromRGB(245, 235, 255),
        Muted = Color3.fromRGB(140, 110, 170)
    },
    ["Red Alert"] = {
        Background = Color3.fromRGB(18, 8, 10),
        Surface = Color3.fromRGB(28, 12, 15),
        SurfaceAlt = Color3.fromRGB(38, 16, 20),
        Accent = Color3.fromRGB(255, 35, 60),
        AccentAlt = Color3.fromRGB(255, 170, 0),
        Text = Color3.fromRGB(255, 235, 238),
        Muted = Color3.fromRGB(170, 110, 115)
    }
}

local CurrentTheme = Themes["Neon Cyan"]
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
-- SCREEN GUI & NOTIFICATIONS
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_CYBER_MASTER_V4"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

local NotifContainer = Instance.new("Frame")
NotifContainer.Size = UDim2.new(0, 240, 1, -30)
NotifContainer.Position = UDim2.new(1, -250, 0, 10)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent = ScreenGui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 6)
NotifLayout.Parent = NotifContainer

local function Notify(titleText, descText, duration)
    duration = duration or 3
    PlaySound(6042053626, 1.2)

    local Toast = Instance.new("Frame")
    Toast.Size = UDim2.new(1, 0, 0, 48)
    Toast.BackgroundColor3 = CurrentTheme.Surface
    Toast.BorderSizePixel = 0
    Toast.BackgroundTransparency = 1
    Toast.Parent = NotifContainer
    RegisterThemeElement(Toast, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
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
    AccentBar.Parent = Toast
    RegisterThemeElement(AccentBar, "BackgroundColor3", "Accent")

    local TTitle = Instance.new("TextLabel")
    TTitle.Size = UDim2.new(1, -15, 0, 18)
    TTitle.Position = UDim2.fromOffset(10, 4)
    TTitle.BackgroundTransparency = 1
    TTitle.Text = "// " .. titleText
    TTitle.Font = Enum.Font.Code
    TTitle.TextSize = 11
    TTitle.TextColor3 = CurrentTheme.Accent
    TTitle.TextXAlignment = Enum.TextXAlignment.Left
    TTitle.Parent = Toast
    RegisterThemeElement(TTitle, "TextColor3", "Accent")

    local TDesc = Instance.new("TextLabel")
    TDesc.Size = UDim2.new(1, -15, 0, 20)
    TDesc.Position = UDim2.fromOffset(10, 22)
    TDesc.BackgroundTransparency = 1
    TDesc.Text = descText
    TDesc.Font = Enum.Font.Gotham
    TDesc.TextSize = 10
    TDesc.TextColor3 = CurrentTheme.Text
    TDesc.TextXAlignment = Enum.TextXAlignment.Left
    TDesc.Parent = Toast
    RegisterThemeElement(TDesc, "TextColor3", "Text")

    TweenService:Create(Toast, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()

    task.delay(duration, function()
        local t = TweenService:Create(Toast, TweenInfo.new(0.25), {BackgroundTransparency = 1})
        t:Play()
        t.Completed:Connect(function() Toast:Destroy() end)
    end)
end

--==================================================
-- STANDARD DRAGGING SYSTEM
--==================================================

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

--==================================================
-- SCRIPT LOADER (UNTOUCHED LOGIC)
--==================================================

local function ExecuteScript(scriptName, url)
    Notify("EXECUTE", "Downloading " .. scriptName .. "...", 2)
    task.spawn(function()
        local success, source = pcall(function()
            return game:HttpGet(url)
        end)

        if not success or not source then
            warn("[CH3A5 HUB] Failed to download script")
            Notify("ERROR", "Failed to download " .. scriptName, 3)
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
            Notify("ERROR", "Script Error in " .. scriptName, 3)
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
Main.Size = UDim2.fromOffset(580, 390)
Main.Position = UDim2.new(0.5, -290, 0.5, -195)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui
RegisterThemeElement(Main, "BackgroundColor3", "Background")

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = CurrentTheme.Accent
MainStroke.Thickness = 1.5
MainStroke.Parent = Main
RegisterThemeElement(MainStroke, "Color", "Accent")

-- TOPBAR & STATUS BADGE
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 38)
Topbar.BackgroundColor3 = CurrentTheme.Surface
Topbar.BorderSizePixel = 0
Topbar.Parent = Main
RegisterThemeElement(Topbar, "BackgroundColor3", "Surface")

MakeDraggable(Main, Topbar)

local CyberLine = Instance.new("Frame")
CyberLine.Size = UDim2.new(1, 0, 0, 1)
CyberLine.Position = UDim2.new(0, 0, 1, -1)
CyberLine.BackgroundColor3 = CurrentTheme.Accent
CyberLine.BorderSizePixel = 0
CyberLine.Parent = Topbar
RegisterThemeElement(CyberLine, "BackgroundColor3", "Accent")

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -180, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "[ CH3A5 // HUB ] PRO HUD"
Title.Font = Enum.Font.Code
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = CurrentTheme.Accent
Title.Parent = Topbar
RegisterThemeElement(Title, "TextColor3", "Accent")

local StatusBadge = Instance.new("Frame")
StatusBadge.Size = UDim2.fromOffset(72, 20)
StatusBadge.Position = UDim2.new(1, -150, 0.5, -10)
StatusBadge.BackgroundColor3 = CurrentTheme.Background
StatusBadge.BorderSizePixel = 0
StatusBadge.Parent = Topbar
RegisterThemeElement(StatusBadge, "BackgroundColor3", "Background")

local SCorner = Instance.new("UICorner")
SCorner.CornerRadius = UDim.new(0, 4)
SCorner.Parent = StatusBadge

local SDot = Instance.new("Frame")
SDot.Size = UDim2.fromOffset(6, 6)
SDot.Position = UDim2.fromOffset(8, 7)
SDot.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
SDot.BorderSizePixel = 0
SDot.Parent = StatusBadge

local SDotCorner = Instance.new("UICorner")
SDotCorner.CornerRadius = UDim.new(1, 0)
SDotCorner.Parent = SDot

local SText = Instance.new("TextLabel")
SText.Size = UDim2.new(1, -20, 1, 0)
SText.Position = UDim2.fromOffset(18, 0)
SText.BackgroundTransparency = 1
SText.Text = "ONLINE"
SText.Font = Enum.Font.Code
SText.TextSize = 9
SText.TextColor3 = CurrentTheme.Text
SText.TextXAlignment = Enum.TextXAlignment.Left
SText.Parent = StatusBadge
RegisterThemeElement(SText, "TextColor3", "Text")

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(30, 30)
Minimize.Position = UDim2.new(1, -66, 0, 4)
Minimize.BackgroundTransparency = 1
Minimize.Text = "—"
Minimize.TextSize = 13
Minimize.TextColor3 = CurrentTheme.Text
Minimize.Font = Enum.Font.Code
Minimize.Parent = Topbar
RegisterThemeElement(Minimize, "TextColor3", "Text")

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30, 30)
Close.Position = UDim2.new(1, -34, 0, 4)
Close.BackgroundTransparency = 1
Close.Text = "✕"
Close.TextSize = 13
Close.TextColor3 = CurrentTheme.AccentAlt
Close.Font = Enum.Font.Code
Close.Parent = Topbar
RegisterThemeElement(Close, "TextColor3", "AccentAlt")

--==================================================
-- SIDEBAR & FIXED SCROLLABLE TAB SYSTEM
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 145, 1, -38)
Sidebar.Position = UDim2.fromOffset(0, 38)
Sidebar.BackgroundColor3 = CurrentTheme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
RegisterThemeElement(Sidebar, "BackgroundColor3", "Surface")

-- Scrollable Tab Holder (Fixes Overflow)
local TabHolder = Instance.new("ScrollingFrame")
TabHolder.Size = UDim2.new(1, 0, 1, -55)
TabHolder.Position = UDim2.fromOffset(0, 0)
TabHolder.BackgroundTransparency = 1
TabHolder.BorderSizePixel = 0
TabHolder.ScrollBarThickness = 2
TabHolder.ScrollBarImageColor3 = CurrentTheme.Accent
TabHolder.CanvasSize = UDim2.new()
TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
TabHolder.Parent = Sidebar
RegisterThemeElement(TabHolder, "ScrollBarImageColor3", "Accent")

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 8)
SidePadding.PaddingLeft = UDim.new(0, 6)
SidePadding.PaddingRight = UDim.new(0, 6)
SidePadding.Parent = TabHolder

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 6)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = TabHolder

--==================================================
-- BOTTOM-LEFT SIDEBAR PROFILE CARD
--==================================================

local ProfileCard = Instance.new("Frame")
ProfileCard.Size = UDim2.new(1, -12, 0, 46)
ProfileCard.Position = UDim2.new(0, 6, 1, -50)
ProfileCard.BackgroundColor3 = CurrentTheme.Background
ProfileCard.BorderSizePixel = 0
ProfileCard.Parent = Sidebar
RegisterThemeElement(ProfileCard, "BackgroundColor3", "Background")

local PCorner = Instance.new("UICorner")
PCorner.CornerRadius = UDim.new(0, 6)
PCorner.Parent = ProfileCard

local PStroke = Instance.new("UIStroke")
PStroke.Color = CurrentTheme.Accent
PStroke.Transparency = 0.7
PStroke.Thickness = 1
PStroke.Parent = ProfileCard
RegisterThemeElement(PStroke, "Color", "Accent")

local PAvatar = Instance.new("ImageLabel")
PAvatar.Size = UDim2.fromOffset(32, 32)
PAvatar.Position = UDim2.fromOffset(7, 7)
PAvatar.BackgroundTransparency = 1
PAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150"
PAvatar.Parent = ProfileCard

local PACorner = Instance.new("UICorner")
PACorner.CornerRadius = UDim.new(1, 0)
PACorner.Parent = PAvatar

local POnlineDot = Instance.new("Frame")
POnlineDot.Size = UDim2.fromOffset(8, 8)
POnlineDot.Position = UDim2.fromOffset(29, 29)
POnlineDot.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
POnlineDot.BorderSizePixel = 0
POnlineDot.ZIndex = 2
POnlineDot.Parent = ProfileCard

local PODCorner = Instance.new("UICorner")
PODCorner.CornerRadius = UDim.new(1, 0)
PODCorner.Parent = POnlineDot

local PName = Instance.new("TextLabel")
PName.Size = UDim2.new(1, -70, 0, 16)
PName.Position = UDim2.fromOffset(44, 7)
PName.BackgroundTransparency = 1
PName.Text = Player.DisplayName
PName.Font = Enum.Font.GothamBold
PName.TextSize = 11
PName.TextColor3 = CurrentTheme.Text
PName.TextXAlignment = Enum.TextXAlignment.Left
PName.Parent = ProfileCard
RegisterThemeElement(PName, "TextColor3", "Text")

local PUser = Instance.new("TextLabel")
PUser.Size = UDim2.new(1, -70, 0, 14)
PUser.Position = UDim2.fromOffset(44, 23)
PUser.BackgroundTransparency = 1
PUser.Text = "@" .. Player.Name
PUser.Font = Enum.Font.Code
PUser.TextSize = 9
PUser.TextColor3 = CurrentTheme.Muted
PUser.TextXAlignment = Enum.TextXAlignment.Left
PUser.Parent = ProfileCard
RegisterThemeElement(PUser, "TextColor3", "Muted")

local GearBtn = Instance.new("TextButton")
GearBtn.Size = UDim2.fromOffset(20, 20)
GearBtn.Position = UDim2.new(1, -24, 0.5, -10)
GearBtn.BackgroundTransparency = 1
GearBtn.Text = "⚙"
GearBtn.Font = Enum.Font.GothamBold
GearBtn.TextSize = 12
GearBtn.TextColor3 = CurrentTheme.Muted
GearBtn.Parent = ProfileCard
RegisterThemeElement(GearBtn, "TextColor3", "Muted")

--==================================================
-- CONTENT & PAGES
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -145, 1, -38)
Content.Position = UDim2.fromOffset(145, 38)
Content.BackgroundColor3 = CurrentTheme.Background
Content.BorderSizePixel = 0
Content.Parent = Main
RegisterThemeElement(Content, "BackgroundColor3", "Background")

local Pages = {}

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Size = UDim2.new(1, -16, 1, -16)
    Page.Position = UDim2.fromOffset(8, 8)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = CurrentTheme.Accent
    Page.CanvasSize = UDim2.new()
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.Parent = Content
    RegisterThemeElement(Page, "ScrollBarImageColor3", "Accent")

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    Pages[name] = Page
    return Page
end

local HomePage = CreatePage("Home")
local KeylessPage = CreatePage("Keyless")
local KeyPage = CreatePage("Key")
local FavoritesPage = CreatePage("Favorites")
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")

GearBtn.MouseButton1Click:Connect(function()
    for _, page in pairs(Pages) do page.Visible = false end
    SettingsPage.Visible = true
end)

--==================================================
-- DEDICATED FAVORITES SYSTEM
--==================================================

local FavoritedData = {}
local RegisteredStarBtns = {}

local function RefreshFavoritesUI()
    for _, child in ipairs(FavoritesPage:GetChildren()) do
        if child:IsA("Frame") and child.Name == "ScriptFrame" then
            child:Destroy()
        end
    end

    local count = 0
    for _, scriptData in pairs(FavoritedData) do
        count = count + 1
        local Frame = Instance.new("Frame")
        Frame.Name = "ScriptFrame"
        Frame.Size = UDim2.new(1, 0, 0, 50)
        Frame.BackgroundColor3 = CurrentTheme.Surface
        Frame.BorderSizePixel = 0
        Frame.Parent = FavoritesPage
        RegisterThemeElement(Frame, "BackgroundColor3", "Surface")

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 4)
        Corner.Parent = Frame

        local BtnStroke = Instance.new("UIStroke")
        BtnStroke.Color = CurrentTheme.Accent
        BtnStroke.Transparency = 0.8
        BtnStroke.Thickness = 1
        BtnStroke.Parent = Frame
        RegisterThemeElement(BtnStroke, "Color", "Accent")

        local AccentBar = Instance.new("Frame")
        AccentBar.Size = UDim2.new(0, 3, 1, 0)
        AccentBar.BackgroundColor3 = CurrentTheme.Accent
        AccentBar.BorderSizePixel = 0
        AccentBar.Parent = Frame
        RegisterThemeElement(AccentBar, "BackgroundColor3", "Accent")

        local Name = Instance.new("TextLabel")
        Name.Name = "ScriptName"
        Name.Size = UDim2.new(1, -45, 0, 20)
        Name.Position = UDim2.fromOffset(12, 5)
        Name.BackgroundTransparency = 1
        Name.Text = scriptData.Name
        Name.Font = Enum.Font.GothamBold
        Name.TextSize = 12
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.TextColor3 = CurrentTheme.Text
        Name.Parent = Frame
        RegisterThemeElement(Name, "TextColor3", "Text")

        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(1, -45, 0, 18)
        Desc.Position = UDim2.fromOffset(12, 25)
        Desc.BackgroundTransparency = 1
        Desc.Text = "[ " .. scriptData.Desc .. " ]"
        Desc.Font = Enum.Font.Code
        Desc.TextSize = 10
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.TextColor3 = CurrentTheme.Muted
        Desc.Parent = Frame
        RegisterThemeElement(Desc, "TextColor3", "Muted")

        local ExecBtn = Instance.new("TextButton")
        ExecBtn.Size = UDim2.new(1, -35, 1, 0)
        ExecBtn.BackgroundTransparency = 1
        ExecBtn.Text = ""
        ExecBtn.Parent = Frame

        ExecBtn.MouseButton1Click:Connect(function()
            ExecuteScript(scriptData.Name, scriptData.Url)
        end)

        local UnfavBtn = Instance.new("TextButton")
        UnfavBtn.Size = UDim2.fromOffset(26, 26)
        UnfavBtn.Position = UDim2.new(1, -28, 0.5, -13)
        UnfavBtn.BackgroundColor3 = CurrentTheme.Background
        UnfavBtn.Text = "⭐"
        UnfavBtn.TextSize = 12
        UnfavBtn.TextColor3 = CurrentTheme.Accent
        UnfavBtn.Parent = Frame
        RegisterThemeElement(UnfavBtn, "BackgroundColor3", "Background")

        local FCorner = Instance.new("UICorner")
        FCorner.CornerRadius = UDim.new(0, 4)
        FCorner.Parent = UnfavBtn

        UnfavBtn.MouseButton1Click:Connect(function()
            FavoritedData[scriptData.Name] = nil
            if RegisteredStarBtns[scriptData.Name] then
                RegisteredStarBtns[scriptData.Name].TextColor3 = CurrentTheme.Muted
            end
            RefreshFavoritesUI()
            Notify("FAVORITE", "Removed " .. scriptData.Name, 2)
        end)
    end

    local NoFavLabel = FavoritesPage:FindFirstChild("NoFavLabel")
    if NoFavLabel then
        NoFavLabel.Visible = (count == 0)
    end
end

--==================================================
-- CYBERPUNK UI HELPERS
--==================================================

local function AddSection(Page, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 22)
    Label.BackgroundTransparency = 1
    Label.Text = "// " .. text
    Label.Font = Enum.Font.Code
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Accent
    Label.Parent = Page
    RegisterThemeElement(Label, "TextColor3", "Accent")
    return Label
end

local function AddInfo(Page, text, nameKey)
    local Label = Instance.new("TextLabel")
    if nameKey then Label.Name = nameKey end
    Label.Size = UDim2.new(1, 0, 0, 18)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Muted
    Label.Parent = Page
    RegisterThemeElement(Label, "TextColor3", "Muted")
    return Label
end

local function AddSearchBar(Page)
    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(1, 0, 0, 28)
    SearchBox.BackgroundColor3 = CurrentTheme.Surface
    SearchBox.BorderSizePixel = 0
    SearchBox.PlaceholderText = "> Search modules..."
    SearchBox.Text = ""
    SearchBox.Font = Enum.Font.Code
    SearchBox.TextSize = 11
    SearchBox.TextColor3 = CurrentTheme.Text
    SearchBox.PlaceholderColor3 = CurrentTheme.Muted
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.Parent = Page
    RegisterThemeElement(SearchBox, "BackgroundColor3", "Surface")
    RegisterThemeElement(SearchBox, "TextColor3", "Text")
    RegisterThemeElement(SearchBox, "PlaceholderColor3", "Muted")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = SearchBox

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = CurrentTheme.Accent
    Stroke.Transparency = 0.7
    Stroke.Thickness = 1
    Stroke.Parent = SearchBox
    RegisterThemeElement(Stroke, "Color", "Accent")

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 10)
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

-- NO COPY BUTTON AS REQUESTED
local function AddScriptButton(Page, name, description, url)
    local Frame = Instance.new("Frame")
    Frame.Name = "ScriptFrame"
    Frame.Size = UDim2.new(1, 0, 0, 50)
    Frame.BackgroundColor3 = CurrentTheme.Surface
    Frame.BorderSizePixel = 0
    Frame.Parent = Page
    RegisterThemeElement(Frame, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Frame

    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = CurrentTheme.Accent
    BtnStroke.Transparency = 0.8
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Frame
    RegisterThemeElement(BtnStroke, "Color", "Accent")

    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 3, 1, 0)
    AccentBar.BackgroundColor3 = CurrentTheme.Accent
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Frame
    RegisterThemeElement(AccentBar, "BackgroundColor3", "Accent")

    local Name = Instance.new("TextLabel")
    Name.Name = "ScriptName"
    Name.Size = UDim2.new(1, -45, 0, 20)
    Name.Position = UDim2.fromOffset(12, 5)
    Name.BackgroundTransparency = 1
    Name.Text = name
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 12
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = CurrentTheme.Text
    Name.Parent = Frame
    RegisterThemeElement(Name, "TextColor3", "Text")

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -45, 0, 18)
    Desc.Position = UDim2.fromOffset(12, 25)
    Desc.BackgroundTransparency = 1
    Desc.Text = "[ " .. description .. " ]"
    Desc.Font = Enum.Font.Code
    Desc.TextSize = 10
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = CurrentTheme.Muted
    Desc.Parent = Frame
    RegisterThemeElement(Desc, "TextColor3", "Muted")

    local ExecBtn = Instance.new("TextButton")
    ExecBtn.Size = UDim2.new(1, -35, 1, 0)
    ExecBtn.BackgroundTransparency = 1
    ExecBtn.Text = ""
    ExecBtn.Parent = Frame

    ExecBtn.MouseEnter:Connect(function()
        PlaySound(6895079853, 1.2)
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)

    ExecBtn.MouseLeave:Connect(function()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
    end)

    ExecBtn.MouseButton1Click:Connect(function()
        ExecuteScript(name, url)
    end)

    local FavBtn = Instance.new("TextButton")
    FavBtn.Size = UDim2.fromOffset(26, 26)
    FavBtn.Position = UDim2.new(1, -28, 0.5, -13)
    FavBtn.BackgroundColor3 = CurrentTheme.Background
    FavBtn.Text = "⭐"
    FavBtn.TextSize = 12
    FavBtn.TextColor3 = FavoritedData[name] and CurrentTheme.Accent or CurrentTheme.Muted
    FavBtn.Parent = Frame
    RegisterThemeElement(FavBtn, "BackgroundColor3", "Background")

    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 4)
    FCorner.Parent = FavBtn

    RegisteredStarBtns[name] = FavBtn

    FavBtn.MouseButton1Click:Connect(function()
        if FavoritedData[name] then
            FavoritedData[name] = nil
            FavBtn.TextColor3 = CurrentTheme.Muted
            Notify("FAVORITE", "Removed " .. name .. " from favorites", 2)
        else
            FavoritedData[name] = {Name = name, Desc = description, Url = url}
            FavBtn.TextColor3 = CurrentTheme.Accent
            Notify("FAVORITE", "Added " .. name .. " to favorites", 2)
        end
        RefreshFavoritesUI()
    end)

    return Frame
end

local function AddToggle(Page, text, defaultState, callback)
    local state = defaultState or false

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 34)
    ToggleFrame.BackgroundColor3 = CurrentTheme.Surface
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = Page
    RegisterThemeElement(ToggleFrame, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.fromOffset(10, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Code
    Label.TextSize = 11
    Label.TextColor3 = CurrentTheme.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    RegisterThemeElement(Label, "TextColor3", "Text")

    local SwitchBtn = Instance.new("TextButton")
    SwitchBtn.Size = UDim2.fromOffset(42, 20)
    SwitchBtn.Position = UDim2.new(1, -50, 0.5, -10)
    SwitchBtn.BackgroundColor3 = state and CurrentTheme.Accent or CurrentTheme.Background
    SwitchBtn.Text = state and "ON" or "OFF"
    SwitchBtn.Font = Enum.Font.Code
    SwitchBtn.TextSize = 10
    SwitchBtn.TextColor3 = state and CurrentTheme.Background or CurrentTheme.Muted
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

        if callback then
            callback(state)
        end
    end)
end

local function AddSlider(Page, text, minVal, maxVal, defaultVal, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 42)
    SliderFrame.BackgroundColor3 = CurrentTheme.Surface
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = Page
    RegisterThemeElement(SliderFrame, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = SliderFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 0, 18)
    Label.Position = UDim2.fromOffset(10, 4)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Code
    Label.TextSize = 11
    Label.TextColor3 = CurrentTheme.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    RegisterThemeElement(Label, "TextColor3", "Text")

    local ValLabel = Instance.new("TextLabel")
    ValLabel.Size = UDim2.fromOffset(50, 18)
    ValLabel.Position = UDim2.new(1, -55, 0, 4)
    ValLabel.BackgroundTransparency = 1
    ValLabel.Text = tostring(defaultVal)
    ValLabel.Font = Enum.Font.Code
    ValLabel.TextSize = 11
    ValLabel.TextColor3 = CurrentTheme.Accent
    ValLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValLabel.Parent = SliderFrame
    RegisterThemeElement(ValLabel, "TextColor3", "Accent")

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -20, 0, 6)
    Track.Position = UDim2.fromOffset(10, 26)
    Track.BackgroundColor3 = CurrentTheme.Background
    Track.BorderSizePixel = 0
    Track.Parent = SliderFrame
    RegisterThemeElement(Track, "BackgroundColor3", "Background")

    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = Track

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
    Fill.BackgroundColor3 = CurrentTheme.Accent
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    RegisterThemeElement(Fill, "BackgroundColor3", "Accent")

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill

    local isDragging = false
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        local val = math.floor(minVal + (maxVal - minVal) * pos)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        ValLabel.Text = tostring(val)
        if callback then callback(val) end
    end

    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            UpdateSlider(input)
        end
    end)

    Track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)
end

--==================================================
-- PREMIUM HOME PAGE REDESIGN
--==================================================

-- 1. TOP HEADER
local HomeHeader = Instance.new("Frame")
HomeHeader.Size = UDim2.new(1, 0, 0, 40)
HomeHeader.BackgroundTransparency = 1
HomeHeader.Parent = HomePage

local HomeIcon = Instance.new("TextLabel")
HomeIcon.Size = UDim2.fromOffset(24, 24)
HomeIcon.Position = UDim2.fromOffset(0, 0)
HomeIcon.BackgroundTransparency = 1
HomeIcon.Text = "🏠"
HomeIcon.TextSize = 16
HomeIcon.Parent = HomeHeader

local HomeTitle = Instance.new("TextLabel")
HomeTitle.Size = UDim2.new(1, -180, 0, 20)
HomeTitle.Position = UDim2.fromOffset(28, 0)
HomeTitle.BackgroundTransparency = 1
HomeTitle.Text = "Welcome to CH3A5 HUB"
HomeTitle.Font = Enum.Font.GothamBold
HomeTitle.TextSize = 15
HomeTitle.TextColor3 = CurrentTheme.Text
HomeTitle.TextXAlignment = Enum.TextXAlignment.Left
HomeTitle.Parent = HomeHeader
RegisterThemeElement(HomeTitle, "TextColor3", "Text")

local HomeSub = Instance.new("TextLabel")
HomeSub.Size = UDim2.new(1, -180, 0, 14)
HomeSub.Position = UDim2.fromOffset(28, 20)
HomeSub.BackgroundTransparency = 1
HomeSub.Text = "Premium Cyberpunk Execution Environment"
HomeSub.Font = Enum.Font.Code
HomeSub.TextSize = 9
HomeSub.TextColor3 = CurrentTheme.Muted
HomeSub.TextXAlignment = Enum.TextXAlignment.Left
HomeSub.Parent = HomeHeader
RegisterThemeElement(HomeSub, "TextColor3", "Muted")

local HeaderDivider = Instance.new("Frame")
HeaderDivider.Size = UDim2.new(1, 0, 0, 1)
HeaderDivider.Position = UDim2.fromOffset(0, 38)
HeaderDivider.BackgroundColor3 = CurrentTheme.Accent
HeaderDivider.BorderSizePixel = 0
HeaderDivider.Parent = HomeHeader
RegisterThemeElement(HeaderDivider, "BackgroundColor3", "Accent")

-- 2. WELCOME CARD
local WelcomeCard = Instance.new("Frame")
WelcomeCard.Size = UDim2.new(1, 0, 0, 80)
WelcomeCard.BackgroundColor3 = CurrentTheme.Surface
WelcomeCard.BorderSizePixel = 0
WelcomeCard.Parent = HomePage
RegisterThemeElement(WelcomeCard, "BackgroundColor3", "Surface")

local WCorner = Instance.new("UICorner")
WCorner.CornerRadius = UDim.new(0, 6)
WCorner.Parent = WelcomeCard

local WStroke = Instance.new("UIStroke")
WStroke.Color = CurrentTheme.Accent
WStroke.Transparency = 0.8
WStroke.Thickness = 1
WStroke.Parent = WelcomeCard
RegisterThemeElement(WStroke, "Color", "Accent")

local WAvatar = Instance.new("ImageLabel")
WAvatar.Size = UDim2.fromOffset(56, 56)
WAvatar.Position = UDim2.fromOffset(12, 12)
WAvatar.BackgroundTransparency = 1
WAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150"
WAvatar.Parent = WelcomeCard

local WACorner = Instance.new("UICorner")
WACorner.CornerRadius = UDim.new(1, 0)
WACorner.Parent = WAvatar

local WTag = Instance.new("TextLabel")
WTag.Size = UDim2.new(1, -180, 0, 14)
WTag.Position = UDim2.fromOffset(78, 12)
WTag.BackgroundTransparency = 1
WTag.Text = "WELCOME BACK"
WTag.Font = Enum.Font.Code
WTag.TextSize = 10
WTag.TextColor3 = CurrentTheme.Accent
WTag.TextXAlignment = Enum.TextXAlignment.Left
WTag.Parent = WelcomeCard
RegisterThemeElement(WTag, "TextColor3", "Accent")

local WName = Instance.new("TextLabel")
WName.Size = UDim2.new(1, -180, 0, 20)
WName.Position = UDim2.fromOffset(78, 26)
WName.BackgroundTransparency = 1
WName.Text = Player.DisplayName
WName.Font = Enum.Font.GothamBold
WName.TextSize = 16
WName.TextColor3 = CurrentTheme.Text
WName.TextXAlignment = Enum.TextXAlignment.Left
WName.Parent = WelcomeCard
RegisterThemeElement(WName, "TextColor3", "Text")

local WUser = Instance.new("TextLabel")
WUser.Size = UDim2.new(1, -180, 0, 16)
WUser.Position = UDim2.fromOffset(78, 48)
WUser.BackgroundTransparency = 1
WUser.Text = "@" .. Player.Name
WUser.Font = Enum.Font.Code
WUser.TextSize = 10
WUser.TextColor3 = CurrentTheme.Muted
WUser.TextXAlignment = Enum.TextXAlignment.Left
WUser.Parent = WelcomeCard
RegisterThemeElement(WUser, "TextColor3", "Muted")

local VerBadge = Instance.new("TextLabel")
VerBadge.Size = UDim2.fromOffset(75, 22)
VerBadge.Position = UDim2.new(1, -85, 0.5, -11)
VerBadge.BackgroundColor3 = CurrentTheme.Background
VerBadge.Text = "v4.5 PRO"
VerBadge.Font = Enum.Font.Code
VerBadge.TextSize = 10
VerBadge.TextColor3 = CurrentTheme.Accent
VerBadge.Parent = WelcomeCard
RegisterThemeElement(VerBadge, "BackgroundColor3", "Background")
RegisterThemeElement(VerBadge, "TextColor3", "Accent")

local VBCorner = Instance.new("UICorner")
VBCorner.CornerRadius = UDim.new(0, 4)
VBCorner.Parent = VerBadge

-- 3. PERFORMANCE DASHBOARD CARD
local PerfCard = Instance.new("Frame")
PerfCard.Size = UDim2.new(1, 0, 0, 85)
PerfCard.BackgroundColor3 = CurrentTheme.Surface
PerfCard.BorderSizePixel = 0
PerfCard.Parent = HomePage
RegisterThemeElement(PerfCard, "BackgroundColor3", "Surface")

local PCorner2 = Instance.new("UICorner")
PCorner2.CornerRadius = UDim.new(0, 6)
PCorner2.Parent = PerfCard

local PGrid = Instance.new("UIGridLayout")
PGrid.CellSize = UDim2.new(0.25, -6, 1, -12)
PGrid.CellPadding = UDim2.fromOffset(8, 0)
PGrid.SortOrder = Enum.SortOrder.LayoutOrder
PGrid.Parent = PerfCard

local PPad = Instance.new("UIPadding")
PPad.PaddingTop = UDim.new(0, 6)
PPad.PaddingLeft = UDim.new(0, 8)
PPad.PaddingRight = UDim.new(0, 8)
PPad.Parent = PerfCard

local function CreatePerfItem(title, initialValue, hasBar)
    local Item = Instance.new("Frame")
    Item.BackgroundColor3 = CurrentTheme.Background
    Item.BorderSizePixel = 0
    Item.Parent = PerfCard
    RegisterThemeElement(Item, "BackgroundColor3", "Background")

    local ICorner = Instance.new("UICorner")
    ICorner.CornerRadius = UDim.new(0, 4)
    ICorner.Parent = Item

    local ITitle = Instance.new("TextLabel")
    ITitle.Size = UDim2.new(1, -10, 0, 16)
    ITitle.Position = UDim2.fromOffset(8, 6)
    ITitle.BackgroundTransparency = 1
    ITitle.Text = title
    ITitle.Font = Enum.Font.Code
    ITitle.TextSize = 9
    ITitle.TextColor3 = CurrentTheme.Muted
    ITitle.TextXAlignment = Enum.TextXAlignment.Left
    ITitle.Parent = Item
    RegisterThemeElement(ITitle, "TextColor3", "Muted")

    local IVal = Instance.new("TextLabel")
    IVal.Size = UDim2.new(1, -10, 0, 22)
    IVal.Position = UDim2.fromOffset(8, 22)
    IVal.BackgroundTransparency = 1
    IVal.Text = initialValue
    IVal.Font = Enum.Font.Code
    IVal.TextSize = 14
    IVal.TextColor3 = CurrentTheme.Text
    IVal.TextXAlignment = Enum.TextXAlignment.Left
    IVal.Parent = Item
    RegisterThemeElement(IVal, "TextColor3", "Text")

    local FillBar
    if hasBar then
        local BarTrack = Instance.new("Frame")
        BarTrack.Size = UDim2.new(1, -16, 0, 4)
        BarTrack.Position = UDim2.fromOffset(8, 52)
        BarTrack.BackgroundColor3 = CurrentTheme.Surface
        BarTrack.BorderSizePixel = 0
        BarTrack.Parent = Item
        RegisterThemeElement(BarTrack, "BackgroundColor3", "Surface")

        local BTCorner = Instance.new("UICorner")
        BTCorner.CornerRadius = UDim.new(1, 0)
        BTCorner.Parent = BarTrack

        FillBar = Instance.new("Frame")
        FillBar.Size = UDim2.new(0.5, 0, 1, 0)
        FillBar.BackgroundColor3 = CurrentTheme.Accent
        FillBar.BorderSizePixel = 0
        FillBar.Parent = BarTrack
        RegisterThemeElement(FillBar, "BackgroundColor3", "Accent")

        local FBCorner = Instance.new("UICorner")
        FBCorner.CornerRadius = UDim.new(1, 0)
        FBCorner.Parent = FillBar
    end

    return IVal, FillBar
end

local FPSVal, FPSBar = CreatePerfItem("FPS", "60", true)
local PingVal, PingBar = CreatePerfItem("PING", "0ms", true)
local PlayersVal = CreatePerfItem("PLAYERS", "1/1", false)
local SessionVal = CreatePerfItem("SESSION", "00m 00s", false)

-- Live Dashboard Updater
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
            pcall(function()
                ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)

            FPSVal.Text = tostring(fps)
            PingVal.Text = tostring(ping) .. "ms"

            if FPSBar then FPSBar.Size = UDim2.new(math.clamp(fps / 60, 0, 1), 0, 1, 0) end
            if PingBar then PingBar.Size = UDim2.new(math.clamp(1 - (ping / 250), 0.1, 1), 0, 1, 0) end

            PlayersVal.Text = tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers)

            local elapsed = math.floor(tick() - StartSessionTime)
            local mins = math.floor(elapsed / 60)
            local secs = elapsed % 60
            SessionVal.Text = string.format("%02dm %02ds", mins, secs)
        end
    end)
end)

-- 4. CURRENT GAME / SERVER CARD
local GameCard = Instance.new("Frame")
GameCard.Size = UDim2.new(1, 0, 0, 130)
GameCard.BackgroundColor3 = CurrentTheme.Surface
GameCard.BorderSizePixel = 0
GameCard.Parent = HomePage
RegisterThemeElement(GameCard, "BackgroundColor3", "Surface")

local GCorner = Instance.new("UICorner")
GCorner.CornerRadius = UDim.new(0, 6)
GCorner.Parent = GameCard

local GIcon = Instance.new("ImageLabel")
GIcon.Size = UDim2.fromOffset(48, 48)
GIcon.Position = UDim2.fromOffset(12, 12)
GIcon.BackgroundTransparency = 1
GIcon.Image = "rbxassetid://0"
GIcon.Parent = GameCard

local GICorner = Instance.new("UICorner")
GICorner.CornerRadius = UDim.new(0, 6)
GICorner.Parent = GIcon

local GName = Instance.new("TextLabel")
GName.Size = UDim2.new(1, -75, 0, 20)
GName.Position = UDim2.fromOffset(68, 12)
GName.BackgroundTransparency = 1
GName.Text = "Loading Game..."
GName.Font = Enum.Font.GothamBold
GName.TextSize = 14
GName.TextColor3 = CurrentTheme.Text
GName.TextXAlignment = Enum.TextXAlignment.Left
GName.Parent = GameCard
RegisterThemeElement(GName, "TextColor3", "Text")

local GDev = Instance.new("TextLabel")
GDev.Size = UDim2.new(1, -75, 0, 16)
GDev.Position = UDim2.fromOffset(68, 32)
GDev.BackgroundTransparency = 1
GDev.Text = "By Developer"
GDev.Font = Enum.Font.Code
GDev.TextSize = 10
GDev.TextColor3 = CurrentTheme.Muted
GDev.TextXAlignment = Enum.TextXAlignment.Left
GDev.Parent = GameCard
RegisterThemeElement(GDev, "TextColor3", "Muted")

task.spawn(function()
    while task.wait(1) do
        if GameInfo.Name ~= "Loading..." then
            GName.Text = GameInfo.Name
            GDev.Text = "By " .. GameInfo.Creator
            GIcon.Image = GameInfo.Icon
            break
        end
    end
end)

-- Action Buttons Grid
local ActGrid = Instance.new("Frame")
ActGrid.Size = UDim2.new(1, -24, 0, 36)
ActGrid.Position = UDim2.fromOffset(12, 80)
ActGrid.BackgroundTransparency = 1
ActGrid.Parent = GameCard

local ALayout = Instance.new("UIGridLayout")
ALayout.CellSize = UDim2.new(0.25, -6, 1, 0)
ALayout.CellPadding = UDim2.fromOffset(8, 0)
ALayout.Parent = ActGrid

local function CreateActionButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.BackgroundColor3 = CurrentTheme.Background
    Btn.Text = text
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 10
    Btn.TextColor3 = CurrentTheme.Text
    Btn.Parent = ActGrid
    RegisterThemeElement(Btn, "BackgroundColor3", "Background")
    RegisterThemeElement(Btn, "TextColor3", "Text")

    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 4)
    BCorner.Parent = Btn

    local BStroke = Instance.new("UIStroke")
    BStroke.Color = CurrentTheme.Accent
    BStroke.Transparency = 0.8
    BStroke.Thickness = 1
    BStroke.Parent = Btn
    RegisterThemeElement(BStroke, "Color", "Accent")

    Btn.MouseEnter:Connect(function()
        TweenService:Create(BStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(BStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
    end)

    Btn.MouseButton1Click:Connect(callback)
end

-- Server Action Logic
CreateActionButton("⚡ Rejoin", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
end)

local function ServerHop(lowest)
    Notify("SERVER", "Searching for server...", 3)
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
        Notify("SERVER", "No alternate server found!", 3)
    end)
end

CreateActionButton("🚀 Hop", function() ServerHop(false) end)
CreateActionButton("📉 Low Hop", function() ServerHop(true) end)
CreateActionButton("📋 Job ID", function()
    pcall(function() setclipboard(game.JobId) end)
    Notify("SERVER", "Copied Job ID to clipboard", 2)
end)

--==================================================
-- KEYLESS PAGE (UNTOUCHED LOADERS)
--==================================================

AddSection(KeylessPage, "KEYLESS MODULES")
AddInfo(KeylessPage, "Direct execution without key verification.")
AddSearchBar(KeylessPage)

AddScriptButton(
    KeylessPage,
    "Sources Hub",
    "Keyless",
    "https://pastefy.app/Lk0vDMmN/raw"
)
AddScriptButton(
    KeylessPage,
    "CH3A5 Hub",
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
-- KEY PAGE (UNTOUCHED LOADERS)
--==================================================

AddSection(KeyPage, "PROTECTED MODULES")
AddInfo(KeyPage, "Requires key access to run.")
AddSearchBar(KeyPage)

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
-- FAVORITES PAGE
--==================================================

AddSection(FavoritesPage, "FAVORITED MODULES")
AddInfo(FavoritesPage, "[ NO FAVORITE MODULES ]", "NoFavLabel")
AddSearchBar(FavoritesPage)

--==================================================
-- THEMES PAGE
--==================================================

AddSection(ThemesPage, "COLOR SCHEMES")
AddInfo(ThemesPage, "Select visual palette.")

for ThemeName, ThemeData in pairs(Themes) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 34)
    Button.BackgroundColor3 = ThemeData.Surface
    Button.BorderSizePixel = 0
    Button.Text = "  > " .. ThemeName
    Button.Font = Enum.Font.Code
    Button.TextSize = 11
    Button.TextColor3 = ThemeData.Text
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.Parent = ThemesPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.fromOffset(12, 12)
    Dot.Position = UDim2.new(1, -20, 0.5, -6)
    Dot.BackgroundColor3 = ThemeData.Accent
    Dot.BorderSizePixel = 0
    Dot.Parent = Button

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot

    Button.MouseButton1Click:Connect(function()
        PlaySound(6042053626, 1)
        ApplyTheme(ThemeData)
        Notify("THEME", "Palette updated to " .. ThemeName, 2)
    end)
end

--==================================================
-- SETTINGS PAGE
--==================================================

AddSection(SettingsPage, "SYSTEM CONTROLS")
AddInfo(SettingsPage, "Manage GUI environment.")

AddToggle(SettingsPage, "Notifications System", true, function(enabled)
    NotifContainer.Visible = enabled
end)

AddToggle(SettingsPage, "Background Blur Effect", true, function(enabled)
    SetBlur(enabled and Main.Visible)
end)

AddSlider(SettingsPage, "UI Transparency", 0, 50, 0, function(val)
    Main.BackgroundTransparency = val / 100
end)

local CurrentKeybind = Enum.KeyCode.RightControl

local KeybindBtn = Instance.new("TextButton")
KeybindBtn.Size = UDim2.new(1, 0, 0, 34)
KeybindBtn.BackgroundColor3 = CurrentTheme.Surface
KeybindBtn.BorderSizePixel = 0
KeybindBtn.Text = "  Keybind: [ " .. CurrentKeybind.Name .. " ]"
KeybindBtn.Font = Enum.Font.Code
KeybindBtn.TextSize = 11
KeybindBtn.TextColor3 = CurrentTheme.Text
KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
KeybindBtn.Parent = SettingsPage
RegisterThemeElement(KeybindBtn, "BackgroundColor3", "Surface")
RegisterThemeElement(KeybindBtn, "TextColor3", "Text")

local KBCorner = Instance.new("UICorner")
KBCorner.CornerRadius = UDim.new(0, 4)
KBCorner.Parent = KeybindBtn

local listeningForKey = false
KeybindBtn.MouseButton1Click:Connect(function()
    listeningForKey = true
    KeybindBtn.Text = "  > Press Any Key..."
    KeybindBtn.TextColor3 = CurrentTheme.Accent
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if listeningForKey and input.UserInputType == Enum.UserInputType.Keyboard then
        listeningForKey = false
        CurrentKeybind = input.KeyCode
        KeybindBtn.Text = "  Keybind: [ " .. CurrentKeybind.Name .. " ]"
        KeybindBtn.TextColor3 = CurrentTheme.Text
        Notify("KEYBIND", "Set toggle key to " .. CurrentKeybind.Name, 2)
    elseif not gpe and input.KeyCode == CurrentKeybind then
        Main.Visible = not Main.Visible
        SetBlur(Main.Visible)
    end
end)

--==================================================
-- SIDEBAR NAVIGATION & ANIMATION
--==================================================

local TabButtons = {}

local function AddTab(name, page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 32)
    Button.BackgroundColor3 = CurrentTheme.Background
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.Font = Enum.Font.Code
    Button.TextSize = 11
    Button.TextColor3 = CurrentTheme.Muted
    Button.AutoButtonColor = false
    Button.Parent = TabHolder
    RegisterThemeElement(Button, "BackgroundColor3", "Background")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    TabButtons[name] = {Button = Button, Page = page}

    Button.MouseEnter:Connect(function()
        PlaySound(6895079853, 1.4)
    end)

    Button.MouseButton1Click:Connect(function()
        PlaySound(6042053626, 1)
        for _, tabData in pairs(TabButtons) do
            tabData.Page.Visible = false
            tabData.Button.TextColor3 = CurrentTheme.Muted
            TweenService:Create(tabData.Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Background}):Play()
        end

        page.Position = UDim2.fromOffset(8, 18)
        page.Visible = true
        TweenService:Create(page, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.fromOffset(8, 8)
        }):Play()

        Button.TextColor3 = CurrentTheme.Accent
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Surface}):Play()
    end)

    return Button
end

local HomeTab = AddTab("> Home", HomePage)
AddTab("> Keyless", KeylessPage)
AddTab("> Keyed", KeyPage)
AddTab("> Favorites", FavoritesPage)
AddTab("> Themes", ThemesPage)
AddTab("> Config", SettingsPage)

HomePage.Visible = true
HomeTab.TextColor3 = CurrentTheme.Accent
HomeTab.BackgroundColor3 = CurrentTheme.Surface

--==================================================
-- MINIMIZE / CLOSE
--==================================================

local Minimized = false
local OriginalSize = Main.Size

Minimize.MouseButton1Click:Connect(function()
    PlaySound(6042053626, 0.9)
    Minimized = not Minimized
    if Minimized then
        TweenService:Create(Main, TweenInfo.new(0.25), {Size = UDim2.fromOffset(580, 38)}):Play()
        Sidebar.Visible = false
        Content.Visible = false
        SetBlur(false)
    else
        TweenService:Create(Main, TweenInfo.new(0.25), {Size = OriginalSize}):Play()
        task.wait(0.15)
        Sidebar.Visible = true
        Content.Visible = true
        SetBlur(true)
    end
end)

Close.MouseButton1Click:Connect(function()
    PlaySound(6042053626, 0.8)
    TweenService:Create(Main, TweenInfo.new(0.2), {Size = UDim2.fromOffset(0, 0)}):Play()
    SetBlur(false)
    task.wait(0.2)
    Main.Visible = false
    Main.Size = OriginalSize
end)

--==================================================
-- ALWAYS VISIBLE MOON TOGGLE (🌙)
--==================================================

local MoonToggle = Instance.new("TextButton")
MoonToggle.Name = "MoonToggle"
MoonToggle.Size = UDim2.fromOffset(42, 42)
MoonToggle.Position = UDim2.new(0, 15, 0.4, 0)
MoonToggle.BackgroundColor3 = CurrentTheme.Surface
MoonToggle.Text = "🌙"
MoonToggle.TextSize = 18
MoonToggle.ZIndex = 1000
MoonToggle.Parent = ScreenGui
RegisterThemeElement(MoonToggle, "BackgroundColor3", "Surface")

local MoonCorner = Instance.new("UICorner")
MoonCorner.CornerRadius = UDim.new(1, 0)
MoonCorner.Parent = MoonToggle

local MoonStroke = Instance.new("UIStroke")
MoonStroke.Color = CurrentTheme.Accent
MoonStroke.Thickness = 1.5
MoonStroke.Parent = MoonToggle
RegisterThemeElement(MoonStroke, "Color", "Accent")

local getMoonMoved = MakeDraggable(MoonToggle, nil)

MoonToggle.MouseButton1Click:Connect(function()
    if not getMoonMoved() then
        PlaySound(6042053626, 1.2)
        Main.Visible = not Main.Visible
        SetBlur(Main.Visible)
    end
end)

SetBlur(true)
Notify("CYBERHUB", "Initialized V4.5 PRO Dashboard!", 4)
