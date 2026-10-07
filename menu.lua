--// CH3A5 HUB GUI [ULTRA EDITION V5.0]
--// Reduced Size 20% + Persistent Theme/Favs + Auto-Load + Khmer/English + Asset Icons

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
local ConfigFile = "CH3A5_Config_V5.json"

--==================================================
-- LOCAL DATA PERSISTENCE (WRITEFILE / READFILE)
--==================================================

local SavedConfig = {
    Theme = "Neon Cyan",
    Language = "EN", -- "EN" or "KH"
    AutoLoad = false,
    AutoLoadUrl = "",
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
-- TRANSLATION LOCALES
--==================================================

local Locales = {
    EN = {
        Title = "[ CH3A5 // HUB ] V5.0",
        Home = "Home",
        Keyless = "Keyless",
        Keyed = "Keyed",
        Favorites = "Favorites",
        Themes = "Themes",
        Config = "Config",
        Welcome = "WELCOME BACK",
        Overview = "System Overview",
        NoFav = "[ NO FAVORITE MODULES ]",
        AutoLoadLabel = "Auto Load Script on Launch",
        LangLabel = "Language: English",
        Rejoin = "Rejoin",
        Hop = "Server Hop",
        LowHop = "Low Hop",
        CopyJob = "Job ID"
    },
    KH = {
        Title = "[ CH3A5 // HUB ] V5.0",
        Home = "ទំព័រដើម",
        Keyless = "គ្មាន Key",
        Keyed = "មាន Key",
        Favorites = "ចូលចិត្ត",
        Themes = "ពណ៌ GUI",
        Config = "ការកំណត់",
        Welcome = "ស្វាគមន៍ត្រឡប់មកវិញ",
        Overview = "ព័ត៌មានប្រព័ន្ធ",
        NoFav = "[ គ្មាន Script ចូលចិត្តទេ ]",
        AutoLoadLabel = "Auto រត់ Script ពេលបើក",
        LangLabel = "ភាសា: ភាសាខ្មែរ",
        Rejoin = "ចូលឡើងវិញ",
        Hop = "ប្តូរ Server",
        LowHop = "Server ទំនេរ",
        CopyJob = "ចម្លង Job ID"
    }
}

local CurrentLang = SavedConfig.Language or "EN"

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

local CurrentTheme = Themes[SavedConfig.Theme] or Themes["Neon Cyan"]
local RegisteredElements = {}

local function RegisterThemeElement(instance, property, themeKey)
    table.insert(RegisteredElements, {Instance = instance, Property = property, Key = themeKey})
    instance[property] = CurrentTheme[themeKey]
end

local function ApplyTheme(newTheme, name)
    CurrentTheme = newTheme
    if name then
        SavedConfig.Theme = name
        SaveConfig()
    end
    for _, item in ipairs(RegisteredElements) do
        if item.Instance and item.Instance.Parent then
            TweenService:Create(item.Instance, TweenInfo.new(0.3), {
                [item.Property] = CurrentTheme[item.Key]
            }):Play()
        end
    end
end

--==================================================
-- SCREEN GUI (20% REDUCED SIZE & DISPLAY ORDER FIX)
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_CYBER_MASTER_V5"
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

    TweenService:Create(Toast, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()

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
-- MAIN FRAME (REDUCED 20%: 464 x 312)
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(464, 312)
Main.Position = UDim2.new(0.5, -232, 0.5, -156)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.ZIndex = 10
Main.Parent = ScreenGui
RegisterThemeElement(Main, "BackgroundColor3", "Background")

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = CurrentTheme.Accent
MainStroke.Thickness = 1.2
MainStroke.Parent = Main
RegisterThemeElement(MainStroke, "Color", "Accent")

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
Title.Text = Locales[CurrentLang].Title
Title.Font = Enum.Font.Code
Title.TextSize = 11
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

local CloseBtnIcon = Instance.new("ImageButton")
CloseBtnIcon.Size = UDim2.fromOffset(16, 16)
CloseBtnIcon.Position = UDim2.new(1, -24, 0.5, -8)
CloseBtnIcon.BackgroundTransparency = 1
CloseBtnIcon.Image = "rbxassetid://6031094678"
CloseBtnIcon.ImageColor3 = CurrentTheme.AccentAlt
CloseBtnIcon.ZIndex = 13
CloseBtnIcon.Parent = Topbar
RegisterThemeElement(CloseBtnIcon, "ImageColor3", "AccentAlt")

-- SIDEBAR & FIXED SCROLLING TABS
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

-- PROFILE CARD AT BOTTOM SIDEBAR
local ProfileCard = Instance.new("Frame")
ProfileCard.Size = UDim2.new(1, -10, 0, 36)
ProfileCard.Position = UDim2.new(0, 5, 1, -38)
ProfileCard.BackgroundColor3 = CurrentTheme.Background
ProfileCard.BorderSizePixel = 0
ProfileCard.ZIndex = 12
ProfileCard.Parent = Sidebar
RegisterThemeElement(ProfileCard, "BackgroundColor3", "Background")

local PCorner = Instance.new("UICorner")
PCorner.CornerRadius = UDim.new(0, 4)
PCorner.Parent = ProfileCard

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
local KeylessPage = CreatePage("Keyless")
local KeyPage = CreatePage("Key")
local FavoritesPage = CreatePage("Favorites")
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")

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
        Frame.Size = UDim2.new(1, 0, 0, 42)
        Frame.BackgroundColor3 = CurrentTheme.Surface
        Frame.BorderSizePixel = 0
        Frame.ZIndex = 13
        Frame.Parent = FavoritesPage
        RegisterThemeElement(Frame, "BackgroundColor3", "Surface")

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 4)
        Corner.Parent = Frame

        local Name = Instance.new("TextLabel")
        Name.Name = "ScriptName"
        Name.Size = UDim2.new(1, -35, 0, 18)
        Name.Position = UDim2.fromOffset(8, 4)
        Name.BackgroundTransparency = 1
        Name.Text = scriptData.Name
        Name.Font = Enum.Font.GothamBold
        Name.TextSize = 10
        Name.TextTruncate = Enum.TextTruncate.AtEnd
        Name.TextColor3 = CurrentTheme.Text
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.ZIndex = 14
        Name.Parent = Frame
        RegisterThemeElement(Name, "TextColor3", "Text")

        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(1, -35, 0, 14)
        Desc.Position = UDim2.fromOffset(8, 22)
        Desc.BackgroundTransparency = 1
        Desc.Text = "[ " .. scriptData.Desc .. " ]"
        Desc.Font = Enum.Font.Code
        Desc.TextSize = 8
        Desc.TextTruncate = Enum.TextTruncate.AtEnd
        Desc.TextColor3 = CurrentTheme.Muted
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.ZIndex = 14
        Desc.Parent = Frame
        RegisterThemeElement(Desc, "TextColor3", "Muted")

        local ExecBtn = Instance.new("TextButton")
        ExecBtn.Size = UDim2.new(1, -30, 1, 0)
        ExecBtn.BackgroundTransparency = 1
        ExecBtn.Text = ""
        ExecBtn.ZIndex = 15
        ExecBtn.Parent = Frame

        ExecBtn.MouseButton1Click:Connect(function()
            ExecuteScript(scriptData.Name, scriptData.Url)
        end)

        local UnfavIcon = Instance.new("ImageButton")
        UnfavIcon.Size = UDim2.fromOffset(18, 18)
        UnfavIcon.Position = UDim2.new(1, -22, 0.5, -9)
        UnfavIcon.BackgroundTransparency = 1
        UnfavIcon.Image = "rbxassetid://6031094678"
        UnfavIcon.ImageColor3 = CurrentTheme.Accent
        UnfavIcon.ZIndex = 15
        UnfavIcon.Parent = Frame

        UnfavIcon.MouseButton1Click:Connect(function()
            SavedConfig.Favorites[scriptName] = nil
            SaveConfig()
            if RegisteredStarBtns[scriptName] then
                RegisteredStarBtns[scriptName].ImageColor3 = CurrentTheme.Muted
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

local function AddInfo(Page, text, nameKey)
    local Label = Instance.new("TextLabel")
    if nameKey then Label.Name = nameKey end
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
    SearchBox.PlaceholderText = "Search..."
    SearchBox.Text = ""
    SearchBox.Font = Enum.Font.Code
    SearchBox.TextSize = 9
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
    Frame.Size = UDim2.new(1, 0, 0, 42)
    Frame.BackgroundColor3 = CurrentTheme.Surface
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 13
    Frame.Parent = Page
    RegisterThemeElement(Frame, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Frame

    local Name = Instance.new("TextLabel")
    Name.Name = "ScriptName"
    Name.Size = UDim2.new(1, -35, 0, 18)
    Name.Position = UDim2.fromOffset(8, 4)
    Name.BackgroundTransparency = 1
    Name.Text = name
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 10
    Name.TextTruncate = Enum.TextTruncate.AtEnd
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = CurrentTheme.Text
    Name.ZIndex = 14
    Name.Parent = Frame
    RegisterThemeElement(Name, "TextColor3", "Text")

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -35, 0, 14)
    Desc.Position = UDim2.fromOffset(8, 22)
    Desc.BackgroundTransparency = 1
    Desc.Text = "[ " .. description .. " ]"
    Desc.Font = Enum.Font.Code
    Desc.TextSize = 8
    Desc.TextTruncate = Enum.TextTruncate.AtEnd
    Desc.TextColor3 = CurrentTheme.Muted
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.ZIndex = 14
    Desc.Parent = Frame
    RegisterThemeElement(Desc, "TextColor3", "Muted")

    local ExecBtn = Instance.new("TextButton")
    ExecBtn.Size = UDim2.new(1, -30, 1, 0)
    ExecBtn.BackgroundTransparency = 1
    ExecBtn.Text = ""
    ExecBtn.ZIndex = 15
    ExecBtn.Parent = Frame

    ExecBtn.MouseButton1Click:Connect(function()
        ExecuteScript(name, url)
    end)

    local FavIcon = Instance.new("ImageButton")
    FavIcon.Size = UDim2.fromOffset(18, 18)
    FavIcon.Position = UDim2.new(1, -22, 0.5, -9)
    FavIcon.BackgroundTransparency = 1
    FavIcon.Image = "rbxassetid://6031094678"
    FavIcon.ImageColor3 = SavedConfig.Favorites[name] and CurrentTheme.Accent or CurrentTheme.Muted
    FavIcon.ZIndex = 15
    FavIcon.Parent = Frame

    RegisteredStarBtns[name] = FavIcon

    FavIcon.MouseButton1Click:Connect(function()
        if SavedConfig.Favorites[name] then
            SavedConfig.Favorites[name] = nil
            FavIcon.ImageColor3 = CurrentTheme.Muted
            Notify("FAVORITE", "Removed " .. name, 2)
        else
            SavedConfig.Favorites[name] = {Name = name, Desc = description, Url = url}
            FavIcon.ImageColor3 = CurrentTheme.Accent
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

local HomeIconImg = Instance.new("ImageLabel")
HomeIconImg.Size = UDim2.fromOffset(16, 16)
HomeIconImg.Position = UDim2.fromOffset(0, 2)
HomeIconImg.BackgroundTransparency = 1
HomeIconImg.Image = "rbxassetid://6031075931"
HomeIconImg.ImageColor3 = CurrentTheme.Accent
HomeIconImg.ZIndex = 14
HomeIconImg.Parent = HomeHeader
RegisterThemeElement(HomeIconImg, "ImageColor3", "Accent")

local HomeTitle = Instance.new("TextLabel")
HomeTitle.Size = UDim2.new(1, -24, 0, 16)
HomeTitle.Position = UDim2.fromOffset(22, 0)
HomeTitle.BackgroundTransparency = 1
HomeTitle.Text = Locales[CurrentLang].Title
HomeTitle.Font = Enum.Font.GothamBold
HomeTitle.TextSize = 12
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
WTag.Text = Locales[CurrentLang].Welcome
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

local function CreateActionButton(textKey, callback)
    local Btn = Instance.new("TextButton")
    Btn.BackgroundColor3 = CurrentTheme.Background
    Btn.Text = Locales[CurrentLang][textKey] or textKey
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

CreateActionButton("Rejoin", function()
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

CreateActionButton("Hop", function() ServerHop(false) end)
CreateActionButton("LowHop", function() ServerHop(true) end)
CreateActionButton("CopyJob", function()
    pcall(function() setclipboard(game.JobId) end)
    Notify("SERVER", "Copied Job ID", 2)
end)

--==================================================
-- KEYLESS & KEYED LOADERS
--==================================================

AddSection(KeylessPage, "KEYLESS MODULES")
AddInfo(KeylessPage, "Direct execution without key verification.")
AddSearchBar(KeylessPage)

AddScriptButton(KeylessPage, "Sources Hub", "Keyless", "https://pastefy.app/Lk0vDMmN/raw")
AddScriptButton(KeylessPage, "Limbo Hub", "Keyless", "https://limbohub.my.id/loader.lua")
AddScriptButton(KeylessPage, "Virexx", "Keyless", "https://gist.githubusercontent.com/virexx55/b4e8b16201904da5ab7b554aa71c378f/raw/b9524b701b35ec97603ff0a32227b24461479c5c/virex.lua")

AddSection(KeyPage, "PROTECTED MODULES")
AddInfo(KeyPage, "Requires key access to run.")
AddSearchBar(KeyPage)

AddScriptButton(KeyPage, "Wzeus Hub", "Key System", "https://raw.githubusercontent.com/Wzeus-NTH/Wzeusno1/main/Wzeus/nthzz")
AddScriptButton(KeyPage, "Pulse Hub", "Key System", "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua")

AddSection(FavoritesPage, "FAVORITED MODULES")
AddInfo(FavoritesPage, Locales[CurrentLang].NoFav, "NoFavLabel")
AddSearchBar(FavoritesPage)
RefreshFavoritesUI()

--==================================================
-- THEMES PAGE (PERSISTENT AUTO-SAVE)
--==================================================

AddSection(ThemesPage, "COLOR SCHEMES")
AddInfo(ThemesPage, "Select theme to save automatically.")

for ThemeName, ThemeData in pairs(Themes) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 28)
    Button.BackgroundColor3 = ThemeData.Surface
    Button.BorderSizePixel = 0
    Button.Text = "  > " .. ThemeName
    Button.Font = Enum.Font.Code
    Button.TextSize = 9
    Button.TextColor3 = ThemeData.Text
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.ZIndex = 13
    Button.Parent = ThemesPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        PlaySound(6042053626, 1)
        ApplyTheme(ThemeData, ThemeName)
        Notify("THEME", "Saved & set: " .. ThemeName, 2)
    end)
end

--==================================================
-- CONFIG & LANGUAGE SETTINGS
--==================================================

AddSection(SettingsPage, "SYSTEM CONTROLS")

AddToggle(SettingsPage, Locales[CurrentLang].AutoLoadLabel, SavedConfig.AutoLoad, function(enabled)
    SavedConfig.AutoLoad = enabled
    SaveConfig()
    Notify("SETTINGS", "Auto Load: " .. (enabled and "ON" or "OFF"), 2)
end)

local LangBtn = Instance.new("TextButton")
LangBtn.Size = UDim2.new(1, 0, 0, 28)
LangBtn.BackgroundColor3 = CurrentTheme.Surface
LangBtn.BorderSizePixel = 0
LangBtn.Text = "  " .. Locales[CurrentLang].LangLabel
LangBtn.Font = Enum.Font.Code
LangBtn.TextSize = 9
LangBtn.TextColor3 = CurrentTheme.Text
LangBtn.TextXAlignment = Enum.TextXAlignment.Left
LangBtn.ZIndex = 13
LangBtn.Parent = SettingsPage
RegisterThemeElement(LangBtn, "BackgroundColor3", "Surface")
RegisterThemeElement(LangBtn, "TextColor3", "Text")

local LCorner = Instance.new("UICorner")
LCorner.CornerRadius = UDim.new(0, 4)
LCorner.Parent = LangBtn

LangBtn.MouseButton1Click:Connect(function()
    CurrentLang = (CurrentLang == "EN") and "KH" or "EN"
    SavedConfig.Language = CurrentLang
    SaveConfig()
    LangBtn.Text = "  " .. Locales[CurrentLang].LangLabel
    Title.Text = Locales[CurrentLang].Title
    Notify("LANGUAGE", "Updated to " .. CurrentLang, 2)
end)

--==================================================
-- NAVIGATION TABS
--==================================================

local TabButtons = {}

local function AddTab(textKey, page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 26)
    Button.BackgroundColor3 = CurrentTheme.Background
    Button.BorderSizePixel = 0
    Button.Text = Locales[CurrentLang][textKey] or textKey
    Button.Font = Enum.Font.Code
    Button.TextSize = 9
    Button.TextColor3 = CurrentTheme.Muted
    Button.AutoButtonColor = false
    Button.ZIndex = 13
    Button.Parent = TabHolder
    RegisterThemeElement(Button, "BackgroundColor3", "Background")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    TabButtons[textKey] = {Button = Button, Page = page}

    Button.MouseButton1Click:Connect(function()
        PlaySound(6042053626, 1)
        for _, tabData in pairs(TabButtons) do
            tabData.Page.Visible = false
            tabData.Button.TextColor3 = CurrentTheme.Muted
            TweenService:Create(tabData.Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Background}):Play()
        end
        page.Visible = true
        Button.TextColor3 = CurrentTheme.Accent
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Surface}):Play()
    end)

    return Button
end

local HomeTab = AddTab("Home", HomePage)
AddTab("Keyless", KeylessPage)
AddTab("Keyed", KeyPage)
AddTab("Favorites", FavoritesPage)
AddTab("Themes", ThemesPage)
AddTab("Config", SettingsPage)

HomePage.Visible = true
HomeTab.TextColor3 = CurrentTheme.Accent
HomeTab.BackgroundColor3 = CurrentTheme.Surface

-- CLOSE BUTTON LOGIC
CloseBtnIcon.MouseButton1Click:Connect(function()
    PlaySound(6042053626, 0.8)
    Main.Visible = false
    SetBlur(false)
end)

--==================================================
-- ALWAYS VISIBLE MOON TOGGLE ICON (🌙 REPLACED WITH ASSET)
--==================================================

local MoonToggle = Instance.new("ImageButton")
MoonToggle.Name = "MoonToggle"
MoonToggle.Size = UDim2.fromOffset(36, 36)
MoonToggle.Position = UDim2.new(0, 15, 0.4, 0)
MoonToggle.BackgroundColor3 = CurrentTheme.Surface
MoonToggle.Image = "rbxassetid://6031068421" -- Clean Night/Moon Icon
MoonToggle.ImageColor3 = CurrentTheme.Accent
MoonToggle.ZIndex = 500
MoonToggle.Parent = ScreenGui
RegisterThemeElement(MoonToggle, "BackgroundColor3", "Surface")
RegisterThemeElement(MoonToggle, "ImageColor3", "Accent")

local MoonCorner = Instance.new("UICorner")
MoonCorner.CornerRadius = UDim.new(1, 0)
MoonCorner.Parent = MoonToggle

local MoonStroke = Instance.new("UIStroke")
MoonStroke.Color = CurrentTheme.Accent
MoonStroke.Thickness = 1.2
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
Notify("CYBERHUB", "CH3A5 HUB V5.0 Loaded Successfully!", 4)
