--// CH3A5 HUB GUI (Enhanced Edition)
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
-- CONFIG & THEMES
--==================================================

local Themes = {
    ["Midnight"] = {
        Background = Color3.fromRGB(12, 12, 18),
        Surface = Color3.fromRGB(20, 20, 30),
        Accent = Color3.fromRGB(120, 90, 255),
        Text = Color3.fromRGB(245, 245, 255),
        Muted = Color3.fromRGB(150, 150, 170)
    },
    ["Discord"] = {
        Background = Color3.fromRGB(25, 27, 31),
        Surface = Color3.fromRGB(32, 34, 39),
        Accent = Color3.fromRGB(88, 101, 242),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 180, 190)
    },
    ["GitHub"] = {
        Background = Color3.fromRGB(13, 17, 23),
        Surface = Color3.fromRGB(22, 27, 34),
        Accent = Color3.fromRGB(46, 160, 67),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158)
    },
    ["Spotify"] = {
        Background = Color3.fromRGB(12, 12, 12),
        Surface = Color3.fromRGB(24, 24, 24),
        Accent = Color3.fromRGB(30, 215, 96),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(170, 170, 170)
    },
    ["YouTube"] = {
        Background = Color3.fromRGB(15, 15, 15),
        Surface = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(255, 0, 0),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 180, 180)
    },
    ["Telegram"] = {
        Background = Color3.fromRGB(15, 23, 30),
        Surface = Color3.fromRGB(25, 38, 50),
        Accent = Color3.fromRGB(42, 171, 238),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(160, 180, 195)
    },
    ["Twitter"] = {
        Background = Color3.fromRGB(10, 10, 10),
        Surface = Color3.fromRGB(24, 24, 24),
        Accent = Color3.fromRGB(29, 155, 240),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(160, 170, 180)
    },
    ["Twitch"] = {
        Background = Color3.fromRGB(14, 12, 20),
        Surface = Color3.fromRGB(25, 22, 35),
        Accent = Color3.fromRGB(145, 70, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 170, 195)
    },
    ["Dracula"] = {
        Background = Color3.fromRGB(24, 24, 37),
        Surface = Color3.fromRGB(40, 42, 54),
        Accent = Color3.fromRGB(189, 147, 249),
        Text = Color3.fromRGB(248, 248, 242),
        Muted = Color3.fromRGB(180, 180, 190)
    },
    ["Ocean"] = {
        Background = Color3.fromRGB(7, 18, 28),
        Surface = Color3.fromRGB(12, 32, 48),
        Accent = Color3.fromRGB(0, 190, 255),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(145, 180, 195)
    },
    ["Crimson"] = {
        Background = Color3.fromRGB(20, 10, 12),
        Surface = Color3.fromRGB(35, 16, 20),
        Accent = Color3.fromRGB(235, 55, 75),
        Text = Color3.fromRGB(255, 240, 242),
        Muted = Color3.fromRGB(185, 155, 160)
    },
    ["Emerald"] = {
        Background = Color3.fromRGB(8, 18, 14),
        Surface = Color3.fromRGB(14, 32, 25),
        Accent = Color3.fromRGB(40, 210, 130),
        Text = Color3.fromRGB(235, 255, 245),
        Muted = Color3.fromRGB(145, 180, 160)
    },
    ["Angkor"] = {
        Background = Color3.fromRGB(18, 14, 10),
        Surface = Color3.fromRGB(35, 27, 18),
        Accent = Color3.fromRGB(214, 157, 65),
        Text = Color3.fromRGB(255, 245, 220),
        Muted = Color3.fromRGB(185, 160, 125)
    }
}

local CurrentTheme = Themes["Midnight"]
local RegisteredThemeElements = {}

local function RegisterThemeElement(instance, property, themeKey)
    table.insert(RegisteredThemeElements, {
        Instance = instance,
        Property = property,
        Key = themeKey
    })
    instance[property] = CurrentTheme[themeKey]
end

local function ApplyTheme(newTheme)
    CurrentTheme = newTheme
    for _, item in ipairs(RegisteredThemeElements) do
        if item.Instance and item.Instance.Parent then
            TweenService:Create(item.Instance, TweenInfo.new(0.35), {
                [item.Property] = CurrentTheme[item.Key]
            }):Play()
        end
    end
end

--==================================================
-- NOTIFICATION SYSTEM
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

local NotifContainer = Instance.new("Frame")
NotifContainer.Name = "NotifContainer"
NotifContainer.Size = UDim2.new(0, 280, 1, -20)
NotifContainer.Position = UDim2.new(1, -290, 0, 10)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent = ScreenGui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 8)
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.Parent = NotifContainer

local function Notify(titleText, descText, duration)
    duration = duration or 3.5

    local Toast = Instance.new("Frame")
    Toast.Size = UDim2.new(1, 0, 0, 55)
    Toast.BackgroundColor3 = CurrentTheme.Surface
    Toast.BorderSizePixel = 0
    Toast.BackgroundTransparency = 1
    Toast.Parent = NotifContainer
    RegisterThemeElement(Toast, "BackgroundColor3", "Surface")

    local ToastCorner = Instance.new("UICorner")
    ToastCorner.CornerRadius = UDim.new(0, 8)
    ToastCorner.Parent = Toast

    local ToastStroke = Instance.new("UIStroke")
    ToastStroke.Color = CurrentTheme.Accent
    ToastStroke.Transparency = 0.5
    ToastStroke.Thickness = 1
    ToastStroke.Parent = Toast
    RegisterThemeElement(ToastStroke, "Color", "Accent")

    local TTitle = Instance.new("TextLabel")
    TTitle.Size = UDim2.new(1, -20, 0, 20)
    TTitle.Position = UDim2.fromOffset(10, 6)
    TTitle.BackgroundTransparency = 1
    TTitle.Text = titleText
    TTitle.Font = Enum.Font.GothamBold
    TTitle.TextSize = 13
    TTitle.TextColor3 = CurrentTheme.Text
    TTitle.TextXAlignment = Enum.TextXAlignment.Left
    TTitle.TextTransparency = 1
    TTitle.Parent = Toast
    RegisterThemeElement(TTitle, "TextColor3", "Text")

    local TDesc = Instance.new("TextLabel")
    TDesc.Size = UDim2.new(1, -20, 0, 22)
    TDesc.Position = UDim2.fromOffset(10, 26)
    TDesc.BackgroundTransparency = 1
    TDesc.Text = descText
    TDesc.Font = Enum.Font.Gotham
    TDesc.TextSize = 11
    TDesc.TextColor3 = CurrentTheme.Muted
    TDesc.TextXAlignment = Enum.TextXAlignment.Left
    TDesc.TextTransparency = 1
    TDesc.Parent = Toast
    RegisterThemeElement(TDesc, "TextColor3", "Muted")

    TweenService:Create(Toast, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    TweenService:Create(TTitle, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(TDesc, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

    task.delay(duration, function()
        local t1 = TweenService:Create(Toast, TweenInfo.new(0.3), {BackgroundTransparency = 1})
        TweenService:Create(TTitle, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(TDesc, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        t1:Play()
        t1.Completed:Connect(function()
            Toast:Destroy()
        end)
    end)
end

--==================================================
-- SCRIPT LOADER (UNTOUCHED LOGIC)
--==================================================

local function ExecuteScript(scriptName, url)
    Notify("CH3A5 HUB", "Executing " .. scriptName .. "...", 2.5)
    task.spawn(function()
        local success, source = pcall(function()
            return game:HttpGet(url)
        end)

        if not success or not source then
            warn("[CH3A5 HUB] Failed to download script")
            Notify("CH3A5 HUB", "Failed to download " .. scriptName, 3)
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
            Notify("CH3A5 HUB", "Error running " .. scriptName, 3)
        else
            Notify("CH3A5 HUB", scriptName .. " loaded successfully!", 3)
        end
    end)
end

--==================================================
-- MAIN GUI FRAME
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(720, 460)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui
RegisterThemeElement(Main, "BackgroundColor3", "Background")

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = CurrentTheme.Accent
Stroke.Transparency = 0.55
Stroke.Thickness = 1
Stroke.Parent = Main
RegisterThemeElement(Stroke, "Color", "Accent")

--==================================================
-- TOPBAR
--==================================================

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 55)
Topbar.BackgroundColor3 = CurrentTheme.Surface
Topbar.BorderSizePixel = 0
Topbar.Parent = Main
RegisterThemeElement(Topbar, "BackgroundColor3", "Surface")

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 0, 25)
Title.Position = UDim2.fromOffset(18, 8)
Title.BackgroundTransparency = 1
Title.Text = "CH3A5 HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = CurrentTheme.Text
Title.Parent = Topbar
RegisterThemeElement(Title, "TextColor3", "Text")

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.fromOffset(180, 18)
Subtitle.Position = UDim2.fromOffset(18, 31)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Premium Script Hub"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.TextColor3 = CurrentTheme.Muted
Subtitle.Parent = Topbar
RegisterThemeElement(Subtitle, "TextColor3", "Muted")

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(40, 40)
Minimize.Position = UDim2.new(1, -88, 0, 8)
Minimize.BackgroundTransparency = 1
Minimize.Text = "—"
Minimize.TextSize = 18
Minimize.TextColor3 = CurrentTheme.Text
Minimize.Font = Enum.Font.GothamBold
Minimize.Parent = Topbar
RegisterThemeElement(Minimize, "TextColor3", "Text")

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(40, 40)
Close.Position = UDim2.new(1, -45, 0, 8)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextSize = 22
Close.TextColor3 = CurrentTheme.Text
Close.Font = Enum.Font.GothamBold
Close.Parent = Topbar
RegisterThemeElement(Close, "TextColor3", "Text")

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 170, 1, -55)
Sidebar.Position = UDim2.fromOffset(0, 55)
Sidebar.BackgroundColor3 = CurrentTheme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
RegisterThemeElement(Sidebar, "BackgroundColor3", "Surface")

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 15)
SidePadding.PaddingLeft = UDim.new(0, 10)
SidePadding.PaddingRight = UDim.new(0, 10)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 8)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

--==================================================
-- CONTENT & PAGES
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -170, 1, -55)
Content.Position = UDim2.fromOffset(170, 55)
Content.BackgroundColor3 = CurrentTheme.Background
Content.BorderSizePixel = 0
Content.Parent = Main
RegisterThemeElement(Content, "BackgroundColor3", "Background")

local Pages = {}

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Size = UDim2.new(1, -20, 1, -20)
    Page.Position = UDim2.fromOffset(10, 10)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = CurrentTheme.Accent
    Page.CanvasSize = UDim2.new()
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.Parent = Content
    RegisterThemeElement(Page, "ScrollBarImageColor3", "Accent")

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
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
-- UI HELPERS & SEARCH BAR
--==================================================

local function AddSection(Page, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Text
    Label.Parent = Page
    RegisterThemeElement(Label, "TextColor3", "Text")
    return Label
end

local function AddInfo(Page, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 22)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = CurrentTheme.Muted
    Label.Parent = Page
    RegisterThemeElement(Label, "TextColor3", "Muted")
    return Label
end

local function AddSearchBar(Page)
    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(1, 0, 0, 36)
    SearchBox.BackgroundColor3 = CurrentTheme.Surface
    SearchBox.BorderSizePixel = 0
    SearchBox.PlaceholderText = "🔍  Search scripts..."
    SearchBox.Text = ""
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.TextSize = 12
    SearchBox.TextColor3 = CurrentTheme.Text
    SearchBox.PlaceholderColor3 = CurrentTheme.Muted
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.Parent = Page
    RegisterThemeElement(SearchBox, "BackgroundColor3", "Surface")
    RegisterThemeElement(SearchBox, "TextColor3", "Text")
    RegisterThemeElement(SearchBox, "PlaceholderColor3", "Muted")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = SearchBox

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.Parent = SearchBox

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = string.lower(SearchBox.Text)
        for _, child in ipairs(Page:GetChildren()) do
            if child:IsA("TextButton") and child:FindFirstChild("ScriptName") then
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
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 68)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Page
    RegisterThemeElement(Button, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button

    local Name = Instance.new("TextLabel")
    Name.Name = "ScriptName"
    Name.Size = UDim2.new(1, -25, 0, 25)
    Name.Position = UDim2.fromOffset(15, 8)
    Name.BackgroundTransparency = 1
    Name.Text = name
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 14
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = CurrentTheme.Text
    Name.Parent = Button
    RegisterThemeElement(Name, "TextColor3", "Text")

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -25, 0, 20)
    Desc.Position = UDim2.fromOffset(15, 34)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = CurrentTheme.Muted
    Desc.Parent = Button
    RegisterThemeElement(Desc, "TextColor3", "Muted")

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Accent}):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Surface}):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        ExecuteScript(name, url)
    end)

    return Button
end

local function AddComingSoon(Page, name)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 50)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = name .. "  •  COMING SOON"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.TextColor3 = CurrentTheme.Muted
    Button.AutoButtonColor = false
    Button.Parent = Page
    RegisterThemeElement(Button, "BackgroundColor3", "Surface")
    RegisterThemeElement(Button, "TextColor3", "Muted")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button
end

--==================================================
-- HOME
--==================================================

AddSection(HomePage, "Welcome to CH3A5 HUB")
AddInfo(HomePage, "Select a category from the sidebar to browse scripts.")
AddComingSoon(HomePage, "More Scripts")

--==================================================
-- KEYLESS (LOADERS - UNTOUCHED DATA)
--==================================================

AddSection(KeylessPage, "Keyless Scripts")
AddInfo(KeylessPage, "No key required to run these scripts.")
AddSearchBar(KeylessPage)

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
-- KEY (LOADERS - UNTOUCHED DATA)
--==================================================

AddSection(KeyPage, "Key System Scripts")
AddInfo(KeyPage, "These scripts may require an official key.")
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
-- THEMES
--==================================================

AddSection(ThemesPage, "Themes")
AddInfo(ThemesPage, "Choose a color theme for CH3A5 HUB.")

for ThemeName, ThemeData in pairs(Themes) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 46)
    Button.BackgroundColor3 = ThemeData.Surface
    Button.BorderSizePixel = 0
    Button.Text = "  " .. ThemeName
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.TextColor3 = ThemeData.Text
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.Parent = ThemesPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Button

    local ColorIndicator = Instance.new("Frame")
    ColorIndicator.Size = UDim2.fromOffset(18, 18)
    ColorIndicator.Position = UDim2.new(1, -28, 0.5, -9)
    ColorIndicator.BackgroundColor3 = ThemeData.Accent
    ColorIndicator.BorderSizePixel = 0
    ColorIndicator.Parent = Button

    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = ColorIndicator

    Button.MouseButton1Click:Connect(function()
        ApplyTheme(ThemeData)
        Notify("Theme Updated", "Switched to " .. ThemeName .. " theme.", 2)
    end)
end

--==================================================
-- SETTINGS
--==================================================

AddSection(SettingsPage, "Settings & Tools")
AddInfo(SettingsPage, "Configure interface options.")

local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(1, 0, 0, 48)
RejoinBtn.BackgroundColor3 = CurrentTheme.Surface
RejoinBtn.BorderSizePixel = 0
RejoinBtn.Text = "⚡  Rejoin Server"
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.TextSize = 13
RejoinBtn.TextColor3 = CurrentTheme.Text
RejoinBtn.Parent = SettingsPage
RegisterThemeElement(RejoinBtn, "BackgroundColor3", "Surface")
RegisterThemeElement(RejoinBtn, "TextColor3", "Text")

local RJCorner = Instance.new("UICorner")
RJCorner.CornerRadius = UDim.new(0, 9)
RJCorner.Parent = RejoinBtn

RejoinBtn.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
end)

AddComingSoon(SettingsPage, "Interface Customization")

--==================================================
-- SIDEBAR BUTTONS
--==================================================

local TabButtons = {}

local function AddTab(name, page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 42)
    Button.BackgroundColor3 = CurrentTheme.Background
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.Font = Enum.Font.GothamMedium
    Button.TextSize = 12
    Button.TextColor3 = CurrentTheme.Muted
    Button.AutoButtonColor = false
    Button.Parent = Sidebar
    RegisterThemeElement(Button, "BackgroundColor3", "Background")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    TabButtons[name] = {Button = Button, Page = page}

    Button.MouseButton1Click:Connect(function()
        for _, tabData in pairs(TabButtons) do
            tabData.Page.Visible = false
            tabData.Button.TextColor3 = CurrentTheme.Muted
            TweenService:Create(tabData.Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Background}):Play()
        end

        page.Visible = true
        Button.TextColor3 = CurrentTheme.Text
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = CurrentTheme.Surface}):Play()
    end)

    return Button
end

local HomeTab = AddTab("⌂  Home", HomePage)
AddTab("⚡  Keyless", KeylessPage)
AddTab("🔑  Key Scripts", KeyPage)
AddTab("🎨  Themes", ThemesPage)
AddTab("⚙  Settings", SettingsPage)

HomePage.Visible = true
HomeTab.TextColor3 = CurrentTheme.Text
HomeTab.BackgroundColor3 = CurrentTheme.Surface

--==================================================
-- DRAGGING MECHANIC
--==================================================

local Dragging = false
local DragStart, StartPosition

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position
    end
end)

Topbar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
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
-- MINIMIZE / CLOSE / TOGGLE
--==================================================

local Minimized = false
local OriginalSize = Main.Size

Minimize.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        TweenService:Create(Main, TweenInfo.new(0.25), {Size = UDim2.fromOffset(720, 55)}):Play()
        Sidebar.Visible = false
        Content.Visible = false
    else
        TweenService:Create(Main, TweenInfo.new(0.25), {Size = OriginalSize}):Play()
        task.wait(0.15)
        Sidebar.Visible = true
        Content.Visible = true
    end
end)

Close.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.25), {Size = UDim2.fromOffset(0, 0)}):Play()
    task.wait(0.25)
    ScreenGui:Destroy()
end)

-- Keybind to Hide/Show GUI (Right Control)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

-- Mobile Floating Toggle Button
local MobileToggle = Instance.new("TextButton")
MobileToggle.Name = "MobileToggle"
MobileToggle.Size = UDim2.fromOffset(45, 45)
MobileToggle.Position = UDim2.new(0, 15, 0.5, -22)
MobileToggle.BackgroundColor3 = CurrentTheme.Surface
MobileToggle.Text = "HUB"
MobileToggle.Font = Enum.Font.GothamBold
MobileToggle.TextSize = 12
MobileToggle.TextColor3 = CurrentTheme.Accent
MobileToggle.Parent = ScreenGui
RegisterThemeElement(MobileToggle, "BackgroundColor3", "Surface")
RegisterThemeElement(MobileToggle, "TextColor3", "Accent")

local MCorner = Instance.new("UICorner")
MCorner.CornerRadius = UDim.new(1, 0)
MCorner.Parent = MobileToggle

local MStroke = Instance.new("UIStroke")
MStroke.Color = CurrentTheme.Accent
MStroke.Thickness = 1.5
MStroke.Parent = MobileToggle
RegisterThemeElement(MStroke, "Color", "Accent")

MobileToggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

--==================================================
-- RESPONSIVE MECHANICS
--==================================================

local function UpdateResponsive()
    local Camera = workspace.CurrentCamera
    if not Camera then return end
    local Viewport = Camera.ViewportSize

    if Viewport.X < 650 then
        Main.Size = UDim2.new(0.92, 0, 0, 420)
        OriginalSize = Main.Size
    else
        Main.Size = UDim2.fromOffset(720, 460)
        OriginalSize = Main.Size
    end
end

if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateResponsive)
    UpdateResponsive()
end

Notify("CH3A5 HUB", "Loaded successfully! Press RightCtrl to hide/show.", 4)
