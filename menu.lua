--// CH3A5 HUB GUI [CYBERPUNK ULTIMATE EDITION]
--// GUI ONLY + User-provided script loaders (Logic untouched)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CYBERPUNK THEMES
--==================================================

local Themes = {
    ["Neon Cyan"] = {
        Background = Color3.fromRGB(10, 12, 18),
        Surface = Color3.fromRGB(16, 20, 28),
        Accent = Color3.fromRGB(0, 240, 255),
        AccentAlt = Color3.fromRGB(255, 0, 85),
        Text = Color3.fromRGB(240, 250, 255),
        Muted = Color3.fromRGB(100, 140, 160)
    },
    ["Matrix Green"] = {
        Background = Color3.fromRGB(8, 14, 10),
        Surface = Color3.fromRGB(14, 22, 16),
        Accent = Color3.fromRGB(0, 255, 128),
        AccentAlt = Color3.fromRGB(0, 180, 255),
        Text = Color3.fromRGB(230, 255, 235),
        Muted = Color3.fromRGB(100, 160, 120)
    },
    ["Overdrive Pink"] = {
        Background = Color3.fromRGB(18, 10, 15),
        Surface = Color3.fromRGB(28, 15, 24),
        Accent = Color3.fromRGB(255, 0, 128),
        AccentAlt = Color3.fromRGB(255, 230, 0),
        Text = Color3.fromRGB(255, 240, 250),
        Muted = Color3.fromRGB(170, 110, 140)
    },
    ["Synth Yellow"] = {
        Background = Color3.fromRGB(15, 14, 8),
        Surface = Color3.fromRGB(25, 23, 12),
        Accent = Color3.fromRGB(255, 210, 0),
        AccentAlt = Color3.fromRGB(0, 240, 255),
        Text = Color3.fromRGB(255, 252, 230),
        Muted = Color3.fromRGB(160, 150, 100)
    },
    ["Void Purple"] = {
        Background = Color3.fromRGB(12, 8, 20),
        Surface = Color3.fromRGB(20, 14, 32),
        Accent = Color3.fromRGB(170, 0, 255),
        AccentAlt = Color3.fromRGB(0, 240, 255),
        Text = Color3.fromRGB(245, 235, 255),
        Muted = Color3.fromRGB(140, 110, 170)
    },
    ["Red Alert"] = {
        Background = Color3.fromRGB(18, 8, 10),
        Surface = Color3.fromRGB(28, 12, 15),
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
ScreenGui.Name = "CH3A5_CYBER_HUB"
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
-- MAIN FRAME (COMPACT 520x340 CYBERPUNK)
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(520, 340)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui
RegisterThemeElement(Main, "BackgroundColor3", "Background")

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = CurrentTheme.Accent
MainStroke.Thickness = 1.5
MainStroke.Parent = Main
RegisterThemeElement(MainStroke, "Color", "Accent")

--==================================================
-- TOPBAR
--==================================================

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 38)
Topbar.BackgroundColor3 = CurrentTheme.Surface
Topbar.BorderSizePixel = 0
Topbar.Parent = Main
RegisterThemeElement(Topbar, "BackgroundColor3", "Surface")

local CyberLine = Instance.new("Frame")
CyberLine.Size = UDim2.new(1, 0, 0, 1)
CyberLine.Position = UDim2.new(0, 0, 1, -1)
CyberLine.BackgroundColor3 = CurrentTheme.Accent
CyberLine.BorderSizePixel = 0
CyberLine.Parent = Topbar
RegisterThemeElement(CyberLine, "BackgroundColor3", "Accent")

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "[ CH3A5 // HUB ] v2.5 HUD"
Title.Font = Enum.Font.Code
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = CurrentTheme.Accent
Title.Parent = Topbar
RegisterThemeElement(Title, "TextColor3", "Accent")

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
-- FOOTER HUD BAR (FPS / PING / USER)
--==================================================

local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, 0, 0, 22)
Footer.Position = UDim2.new(0, 0, 1, -22)
Footer.BackgroundColor3 = CurrentTheme.Surface
Footer.BorderSizePixel = 0
Footer.Parent = Main
RegisterThemeElement(Footer, "BackgroundColor3", "Surface")

local FooterLine = Instance.new("Frame")
FooterLine.Size = UDim2.new(1, 0, 0, 1)
FooterLine.BackgroundColor3 = CurrentTheme.Accent
FooterLine.BorderSizePixel = 0
FooterLine.Parent = Footer
RegisterThemeElement(FooterLine, "BackgroundColor3", "Accent")

local FooterLabel = Instance.new("TextLabel")
FooterLabel.Size = UDim2.new(1, -20, 1, 0)
FooterLabel.Position = UDim2.fromOffset(10, 0)
FooterLabel.BackgroundTransparency = 1
FooterLabel.Text = "[ USER: " .. Player.Name .. " | FPS: -- | PING: --ms ]"
FooterLabel.Font = Enum.Font.Code
FooterLabel.TextSize = 10
FooterLabel.TextColor3 = CurrentTheme.Muted
FooterLabel.TextXAlignment = Enum.TextXAlignment.Left
FooterLabel.Parent = Footer
RegisterThemeElement(FooterLabel, "TextColor3", "Muted")

-- Live FPS & Ping Calculator
local FrameCount = 0
local LastFPSUpdate = os.clock()

RunService.RenderStepped:Connect(function()
    FrameCount = FrameCount + 1
    local now = os.clock()
    if now - LastFPSUpdate >= 0.5 then
        local fps = math.floor(FrameCount / (now - LastFPSUpdate))
        FrameCount = 0
        LastFPSUpdate = now

        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)

        FooterLabel.Text = string.format("[ USER: %s | FPS: %d | PING: %dms ]", Player.Name, fps, ping)
    end
end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -60)
Sidebar.Position = UDim2.fromOffset(0, 38)
Sidebar.BackgroundColor3 = CurrentTheme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
RegisterThemeElement(Sidebar, "BackgroundColor3", "Surface")

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 10)
SidePadding.PaddingLeft = UDim.new(0, 8)
SidePadding.PaddingRight = UDim.new(0, 8)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 6)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

--==================================================
-- CONTENT & PAGES
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -130, 1, -60)
Content.Position = UDim2.fromOffset(130, 38)
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
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")

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

local function AddInfo(Page, text)
    local Label = Instance.new("TextLabel")
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
    Button.Size = UDim2.new(1, 0, 0, 50)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Page
    RegisterThemeElement(Button, "BackgroundColor3", "Surface")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = CurrentTheme.Accent
    BtnStroke.Transparency = 0.8
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Button
    RegisterThemeElement(BtnStroke, "Color", "Accent")

    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 3, 1, 0)
    AccentBar.BackgroundColor3 = CurrentTheme.Accent
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Button
    RegisterThemeElement(AccentBar, "BackgroundColor3", "Accent")

    local Name = Instance.new("TextLabel")
    Name.Name = "ScriptName"
    Name.Size = UDim2.new(1, -20, 0, 20)
    Name.Position = UDim2.fromOffset(12, 5)
    Name.BackgroundTransparency = 1
    Name.Text = name
    Name.Font = Enum.Font.GothamBold
    Name.TextSize = 12
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextColor3 = CurrentTheme.Text
    Name.Parent = Button
    RegisterThemeElement(Name, "TextColor3", "Text")

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -20, 0, 18)
    Desc.Position = UDim2.fromOffset(12, 25)
    Desc.BackgroundTransparency = 1
    Desc.Text = "[ " .. description .. " ]"
    Desc.Font = Enum.Font.Code
    Desc.TextSize = 10
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = CurrentTheme.Muted
    Desc.Parent = Button
    RegisterThemeElement(Desc, "TextColor3", "Muted")

    Button.MouseEnter:Connect(function()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        ExecuteScript(name, url)
    end)

    return Button
end

local function AddToggle(Page, text, defaultState, callback)
    local state = defaultState or false

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
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
    SwitchBtn.Size = UDim2.fromOffset(42, 22)
    SwitchBtn.Position = UDim2.new(1, -50, 0.5, -11)
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

local function AddComingSoon(Page, name)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 38)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = name .. " // COMING SOON"
    Button.Font = Enum.Font.Code
    Button.TextSize = 10
    Button.TextColor3 = CurrentTheme.Muted
    Button.AutoButtonColor = false
    Button.Parent = Page
    RegisterThemeElement(Button, "BackgroundColor3", "Surface")
    RegisterThemeElement(Button, "TextColor3", "Muted")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button
end

--==================================================
-- HOME
--==================================================

AddSection(HomePage, "SYSTEM OVERVIEW")
AddInfo(HomePage, "Select module category from sidebar.")
AddComingSoon(HomePage, "More Scripts")

--==================================================
-- KEYLESS (UNTOUCHED DATA / LOADERS)
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
-- KEY (UNTOUCHED DATA / LOADERS)
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
-- THEMES
--==================================================

AddSection(ThemesPage, "COLOR SCHEMES")
AddInfo(ThemesPage, "Select visual palette.")

for ThemeName, ThemeData in pairs(Themes) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 36)
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
        ApplyTheme(ThemeData)
        Notify("THEME", "Palette updated to " .. ThemeName, 2)
    end)
end

--==================================================
-- SETTINGS
--==================================================

AddSection(SettingsPage, "SYSTEM CONTROLS")
AddInfo(SettingsPage, "Manage GUI environment.")

AddToggle(SettingsPage, "Toggle Notification System", true, function(enabled)
    NotifContainer.Visible = enabled
end)

local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(1, 0, 0, 36)
RejoinBtn.BackgroundColor3 = CurrentTheme.Surface
RejoinBtn.BorderSizePixel = 0
RejoinBtn.Text = "⚡ REJOIN SERVER"
RejoinBtn.Font = Enum.Font.Code
RejoinBtn.TextSize = 11
RejoinBtn.TextColor3 = CurrentTheme.Text
RejoinBtn.Parent = SettingsPage
RegisterThemeElement(RejoinBtn, "BackgroundColor3", "Surface")
RegisterThemeElement(RejoinBtn, "TextColor3", "Text")

local RJCorner = Instance.new("UICorner")
RJCorner.CornerRadius = UDim.new(0, 4)
RJCorner.Parent = RejoinBtn

RejoinBtn.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
end)

--==================================================
-- SIDEBAR NAVIGATION & ANIMATION
--==================================================

local TabButtons = {}

local function AddTab(name, page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 34)
    Button.BackgroundColor3 = CurrentTheme.Background
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.Font = Enum.Font.Code
    Button.TextSize = 11
    Button.TextColor3 = CurrentTheme.Muted
    Button.AutoButtonColor = false
    Button.Parent = Sidebar
    RegisterThemeElement(Button, "BackgroundColor3", "Background")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    TabButtons[name] = {Button = Button, Page = page}

    Button.MouseButton1Click:Connect(function()
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
AddTab("> Themes", ThemesPage)
AddTab("> Config", SettingsPage)

HomePage.Visible = true
HomeTab.TextColor3 = CurrentTheme.Accent
HomeTab.BackgroundColor3 = CurrentTheme.Surface

--==================================================
-- FIXED BOUNDED DRAGGING MECHANIC (NO MORE DISAPPEARING)
--==================================================

local Dragging = false
local DragStart = Vector2.zero
local StartCenterPos = Vector2.zero

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Vector2.new(input.Position.X, input.Position.Y)
        StartCenterPos = Vector2.new(Main.AbsolutePosition.X + Main.AbsoluteSize.X/2, Main.AbsolutePosition.Y + Main.AbsoluteSize.Y/2)
    end
end)

Topbar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local Camera = workspace.CurrentCamera
        if not Camera then return end

        local Delta = Vector2.new(input.Position.X, input.Position.Y) - DragStart
        local TargetPos = StartCenterPos + Delta

        local Viewport = Camera.ViewportSize
        local HalfW = Main.AbsoluteSize.X / 2
        local HalfH = Main.AbsoluteSize.Y / 2

        -- Clamp position within screen bounds so it never disappears!
        local ClampedX = math.clamp(TargetPos.X, HalfW, Viewport.X - HalfW)
        local ClampedY = math.clamp(TargetPos.Y, HalfH, Viewport.Y - HalfH)

        Main.Position = UDim2.fromOffset(ClampedX, ClampedY)
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
        TweenService:Create(Main, TweenInfo.new(0.25), {Size = UDim2.fromOffset(520, 38)}):Play()
        Sidebar.Visible = false
        Content.Visible = false
        Footer.Visible = false
    else
        TweenService:Create(Main, TweenInfo.new(0.25), {Size = OriginalSize}):Play()
        task.wait(0.15)
        Sidebar.Visible = true
        Content.Visible = true
        Footer.Visible = true
    end
end)

Close.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.2), {Size = UDim2.fromOffset(0, 0)}):Play()
    task.wait(0.2)
    ScreenGui:Destroy()
end)

-- Keybind to Hide/Show (Right Control)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

--==================================================
-- DRAGGABLE MOBILE TOGGLE BUTTON
--==================================================

local MobileToggle = Instance.new("TextButton")
MobileToggle.Name = "MobileToggle"
MobileToggle.Size = UDim2.fromOffset(38, 38)
MobileToggle.Position = UDim2.new(0, 15, 0.5, -19)
MobileToggle.BackgroundColor3 = CurrentTheme.Surface
MobileToggle.Text = "[C]"
MobileToggle.Font = Enum.Font.Code
MobileToggle.TextSize = 12
MobileToggle.TextColor3 = CurrentTheme.Accent
MobileToggle.Parent = ScreenGui
RegisterThemeElement(MobileToggle, "BackgroundColor3", "Surface")
RegisterThemeElement(MobileToggle, "TextColor3", "Accent")

local MCorner = Instance.new("UICorner")
MCorner.CornerRadius = UDim.new(0, 6)
MCorner.Parent = MobileToggle

local MStroke = Instance.new("UIStroke")
MStroke.Color = CurrentTheme.Accent
MStroke.Thickness = 1.5
MStroke.Parent = MobileToggle
RegisterThemeElement(MStroke, "Color", "Accent")

-- Mobile Button Drag & Clamp System
local MDragging = false
local MDragStart = Vector2.zero
local MStartPos = Vector2.zero
local MHasMoved = false

MobileToggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        MDragging = true
        MHasMoved = false
        MDragStart = Vector2.new(input.Position.X, input.Position.Y)
        MStartPos = Vector2.new(MobileToggle.AbsolutePosition.X + MobileToggle.AbsoluteSize.X/2, MobileToggle.AbsolutePosition.Y + MobileToggle.AbsoluteSize.Y/2)
    end
end)

MobileToggle.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        MDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if MDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local Delta = Vector2.new(input.Position.X, input.Position.Y) - MDragStart
        if Delta.Magnitude > 5 then
            MHasMoved = true
        end

        local TargetPos = MStartPos + Delta
        local Camera = workspace.CurrentCamera
        if Camera then
            local Viewport = Camera.ViewportSize
            local HalfW = MobileToggle.AbsoluteSize.X / 2
            local HalfH = MobileToggle.AbsoluteSize.Y / 2

            local ClampedX = math.clamp(TargetPos.X, HalfW, Viewport.X - HalfW)
            local ClampedY = math.clamp(TargetPos.Y, HalfH, Viewport.Y - HalfH)

            MobileToggle.Position = UDim2.fromOffset(ClampedX, ClampedY)
        end
    end
end)

MobileToggle.MouseButton1Click:Connect(function()
    if not MHasMoved then
        Main.Visible = not Main.Visible
    end
end)

Notify("CYBERHUB", "Initialized. Drag supported without losing bounds.", 4)
