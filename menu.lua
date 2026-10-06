--==================================================
-- CH3A5 HUB V4
-- PREMIUM RESPONSIVE GUI
-- PHONE / PC
--==================================================

if not game:IsLoaded() then
    game.Loaded:Wait()
end

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
    DesktopWidth = 820,
    DesktopHeight = 520,

    PhoneWidthScale = 0.70,
    PhoneHeightScale = 0.72,

    AnimationSpeed = 0.25
}

--==================================================
-- THEMES
--==================================================

local Themes = {

    Midnight = {
        Background = Color3.fromRGB(8, 9, 14),
        Surface = Color3.fromRGB(15, 17, 25),
        Surface2 = Color3.fromRGB(20, 22, 32),
        Accent = Color3.fromRGB(125, 95, 255),
        Accent2 = Color3.fromRGB(85, 65, 190),
        Text = Color3.fromRGB(245, 245, 255),
        Muted = Color3.fromRGB(145, 148, 165),
        Stroke = Color3.fromRGB(55, 58, 78)
    },

    Discord = {
        Background = Color3.fromRGB(18, 19, 23),
        Surface = Color3.fromRGB(30, 32, 38),
        Surface2 = Color3.fromRGB(38, 40, 48),
        Accent = Color3.fromRGB(88, 101, 242),
        Accent2 = Color3.fromRGB(71, 82, 196),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(170, 173, 185),
        Stroke = Color3.fromRGB(60, 62, 72)
    },

    Ocean = {
        Background = Color3.fromRGB(5, 12, 20),
        Surface = Color3.fromRGB(10, 24, 37),
        Surface2 = Color3.fromRGB(14, 32, 48),
        Accent = Color3.fromRGB(0, 190, 255),
        Accent2 = Color3.fromRGB(0, 130, 190),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(135, 170, 190),
        Stroke = Color3.fromRGB(30, 75, 100)
    },

    Emerald = {
        Background = Color3.fromRGB(5, 13, 10),
        Surface = Color3.fromRGB(10, 25, 19),
        Surface2 = Color3.fromRGB(14, 34, 26),
        Accent = Color3.fromRGB(35, 215, 130),
        Accent2 = Color3.fromRGB(20, 155, 90),
        Text = Color3.fromRGB(235, 255, 245),
        Muted = Color3.fromRGB(135, 175, 155),
        Stroke = Color3.fromRGB(35, 80, 60)
    },

    Crimson = {
        Background = Color3.fromRGB(16, 6, 9),
        Surface = Color3.fromRGB(29, 11, 16),
        Surface2 = Color3.fromRGB(40, 15, 21),
        Accent = Color3.fromRGB(245, 55, 80),
        Accent2 = Color3.fromRGB(175, 30, 55),
        Text = Color3.fromRGB(255, 240, 243),
        Muted = Color3.fromRGB(180, 140, 150),
        Stroke = Color3.fromRGB(90, 35, 45)
    },

    Angkor = {
        Background = Color3.fromRGB(13, 10, 7),
        Surface = Color3.fromRGB(27, 20, 13),
        Surface2 = Color3.fromRGB(38, 28, 17),
        Accent = Color3.fromRGB(220, 165, 65),
        Accent2 = Color3.fromRGB(165, 115, 35),
        Text = Color3.fromRGB(255, 245, 220),
        Muted = Color3.fromRGB(185, 155, 110),
        Stroke = Color3.fromRGB(85, 62, 30)
    }
}

local CurrentTheme = Themes.Midnight

--==================================================
-- GUI ROOT
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5_HUB_V4"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--==================================================
-- OPEN BUTTON
--==================================================

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.fromOffset(54, 54)
OpenButton.AnchorPoint = Vector2.new(1, 1)
OpenButton.Position = UDim2.new(1, -18, 1, -18)
OpenButton.BackgroundColor3 = CurrentTheme.Accent
OpenButton.Text = "C"
OpenButton.TextColor3 = Color3.fromRGB(255,255,255)
OpenButton.TextSize = 21
OpenButton.Font = Enum.Font.GothamBold
OpenButton.AutoButtonColor = false
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = CurrentTheme.Text
OpenStroke.Transparency = 0.75
OpenStroke.Thickness = 1
OpenStroke.Parent = OpenButton

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(
    CONFIG.DesktopWidth,
    CONFIG.DesktopHeight
)
Main.BackgroundColor3 = CurrentTheme.Background
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = CurrentTheme.Stroke
MainStroke.Transparency = 0.25
MainStroke.Thickness = 1
MainStroke.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 68)
Topbar.BackgroundColor3 = CurrentTheme.Surface
Topbar.BorderSizePixel = 0
Topbar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 18)
TopCorner.Parent = Topbar

-- Cover bottom rounded corners
local TopFix = Instance.new("Frame")
TopFix.Size = UDim2.new(1, 0, 0, 18)
TopFix.Position = UDim2.new(0, 0, 1, -18)
TopFix.BackgroundColor3 = CurrentTheme.Surface
TopFix.BorderSizePixel = 0
TopFix.Parent = Topbar

--==================================================
-- LOGO
--==================================================

local Logo = Instance.new("Frame")
Logo.Size = UDim2.fromOffset(42, 42)
Logo.Position = UDim2.fromOffset(14, 13)
Logo.BackgroundColor3 = CurrentTheme.Accent
Logo.BorderSizePixel = 0
Logo.Parent = Topbar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 12)
LogoCorner.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.fromScale(1,1)
LogoText.BackgroundTransparency = 1
LogoText.Text = "C"
LogoText.TextColor3 = Color3.fromRGB(255,255,255)
LogoText.TextSize = 22
LogoText.Font = Enum.Font.GothamBlack
LogoText.Parent = Logo

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -190, 0, 25)
Title.Position = UDim2.fromOffset(68, 12)
Title.BackgroundTransparency = 1
Title.Text = "CH3A5 HUB"
Title.TextColor3 = CurrentTheme.Text
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Topbar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -190, 0, 18)
Subtitle.Position = UDim2.fromOffset(68, 36)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "PREMIUM • V4"
Subtitle.TextColor3 = CurrentTheme.Muted
Subtitle.TextSize = 9
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Topbar

--==================================================
-- TOP BUTTONS
--==================================================

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(38, 38)
Minimize.Position = UDim2.new(1, -92, 0, 15)
Minimize.BackgroundColor3 = CurrentTheme.Surface2
Minimize.Text = "−"
Minimize.TextColor3 = CurrentTheme.Text
Minimize.TextSize = 21
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.Parent = Topbar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 10)
MinCorner.Parent = Minimize

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -48, 0, 15)
Close.BackgroundColor3 = CurrentTheme.Surface2
Close.Text = "×"
Close.TextColor3 = CurrentTheme.Text
Close.TextSize = 22
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.Parent = Topbar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = Close

--==================================================
-- BODY
--==================================================

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, 0, 1, -68)
Body.Position = UDim2.fromOffset(0, 68)
Body.BackgroundTransparency = 1
Body.Parent = Main

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 190, 1, 0)
Sidebar.BackgroundColor3 = CurrentTheme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Body

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 15)
SidePadding.PaddingLeft = UDim.new(0, 12)
SidePadding.PaddingRight = UDim.new(0, 12)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 7)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -190, 1, 0)
Content.Position = UDim2.fromOffset(190, 0)
Content.BackgroundColor3 = CurrentTheme.Background
Content.BorderSizePixel = 0
Content.Parent = Body

--==================================================
-- PAGES
--==================================================

local Pages = {}

local function CreatePage(Name)

    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name
    Page.Size = UDim2.new(1, -28, 1, -28)
    Page.Position = UDim2.fromOffset(14, 14)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = CurrentTheme.Accent
    Page.CanvasSize = UDim2.new()
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Page

    Pages[Name] = Page

    return Page
end

local HomePage = CreatePage("Home")
local ScriptsPage = CreatePage("Scripts")
local ThemesPage = CreatePage("Themes")
local SettingsPage = CreatePage("Settings")

--==================================================
-- SCRIPT LOADER
--==================================================

local function ExecuteScript(url)
    task.spawn(function()
        local success, source = pcall(function()
            return game:HttpGet(url)
        end)

        if not success or not source then
            warn("[CH3A5 HUB] Failed to download script")
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
        end
    end)
end

--==================================================
-- KEYLESS
--==================================================

AddSection(KeylessPage, "Keyless Scripts")
AddInfo(KeylessPage, "No key required.")

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
-- KEY
--==================================================

AddSection(KeyPage, "Key System Scripts")
AddInfo(KeyPage, "These scripts may require a key.")

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
-- HELPERS
--==================================================

local function AddHeader(Page, TitleText, Description)

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 65)
    Container.BackgroundTransparency = 1
    Container.Parent = Page

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = TitleText
    TitleLabel.TextColor3 = CurrentTheme.Text
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Container

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, 0, 0, 25)
    DescLabel.Position = UDim2.fromOffset(0, 31)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = Description
    DescLabel.TextColor3 = CurrentTheme.Muted
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = Container

    return Container
end

local function AddCard(Page, TitleText, Description)

    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 82)
    Card.BackgroundColor3 = CurrentTheme.Surface
    Card.BorderSizePixel = 0
    Card.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 13)
    Corner.Parent = Card

    local Accent = Instance.new("Frame")
    Accent.Size = UDim2.fromOffset(3, 42)
    Accent.Position = UDim2.fromOffset(12, 20)
    Accent.BackgroundColor3 = CurrentTheme.Accent
    Accent.BorderSizePixel = 0
    Accent.Parent = Card

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(1,0)
    AccentCorner.Parent = Accent

    local T = Instance.new("TextLabel")
    T.Size = UDim2.new(1, -35, 0, 25)
    T.Position = UDim2.fromOffset(28, 14)
    T.BackgroundTransparency = 1
    T.Text = TitleText
    T.TextColor3 = CurrentTheme.Text
    T.TextSize = 14
    T.Font = Enum.Font.GothamBold
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.Parent = Card

    local D = Instance.new("TextLabel")
    D.Size = UDim2.new(1, -35, 0, 25)
    D.Position = UDim2.fromOffset(28, 40)
    D.BackgroundTransparency = 1
    D.Text = Description
    D.TextColor3 = CurrentTheme.Muted
    D.TextSize = 10
    D.Font = Enum.Font.Gotham
    D.TextXAlignment = Enum.TextXAlignment.Left
    D.Parent = Card

    return Card
end

--==================================================
-- HOME
--==================================================

AddHeader(
    HomePage,
    "Welcome back.",
    "CH3A5 HUB • Premium interface"
)

AddCard(
    HomePage,
    "CH3A5 HUB V4",
    "Modern responsive interface for mobile and desktop."
)

AddCard(
    HomePage,
    "System Status",
    "Interface is ready."
)

--==================================================
-- SCRIPTS PAGE
--==================================================

AddHeader(
    ScriptsPage,
    "Scripts",
    "Your script categories."
)

AddCard(
    ScriptsPage,
    "Keyless",
    "Keyless script section."
)

AddCard(
    ScriptsPage,
    "Key System",
    "Key-based script section."
)

--==================================================
-- THEMES
--==================================================

AddHeader(
    ThemesPage,
    "Appearance",
    "Choose your preferred CH3A5 theme."
)

local function CreateThemeButton(Name, Theme)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 54)
    Button.BackgroundColor3 = Theme.Surface
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = ThemesPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Button

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.fromOffset(26, 26)
    Dot.Position = UDim2.fromOffset(14, 14)
    Dot.BackgroundColor3 = Theme.Accent
    Dot.BorderSizePixel = 0
    Dot.Parent = Button

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.fromOffset(52, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button

    Button.MouseButton1Click:Connect(function()

        CurrentTheme = Theme

        Main.BackgroundColor3 = Theme.Background
        Body.BackgroundColor3 = Theme.Background
        Content.BackgroundColor3 = Theme.Background

        Topbar.BackgroundColor3 = Theme.Surface
        TopFix.BackgroundColor3 = Theme.Surface

        Sidebar.BackgroundColor3 = Theme.Surface

        Logo.BackgroundColor3 = Theme.Accent
        MainStroke.Color = Theme.Stroke

        OpenButton.BackgroundColor3 = Theme.Accent

        Title.TextColor3 = Theme.Text
        Subtitle.TextColor3 = Theme.Muted
        LogoText.TextColor3 = Theme.Text

    end)

    return Button
end

for Name, Theme in pairs(Themes) do
    CreateThemeButton(Name, Theme)
end

--==================================================
-- SETTINGS
--==================================================

AddHeader(
    SettingsPage,
    "Settings",
    "Customize your CH3A5 HUB experience."
)

AddCard(
    SettingsPage,
    "Responsive UI",
    "Automatically adapts to phone and desktop."
)

AddCard(
    SettingsPage,
    "Touch Support",
    "Designed for touch and mouse input."
)

--==================================================
-- TAB SYSTEM
--==================================================

local Tabs = {}

local function AddTab(Name, Icon, Page)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 44)
    Button.BackgroundColor3 = CurrentTheme.Surface
    Button.BorderSizePixel = 0
    Button.Text = Icon .. "   " .. Name
    Button.TextColor3 = CurrentTheme.Muted
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamMedium
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.Parent = Button

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()

        for _, P in pairs(Pages) do
            P.Visible = false
        end

        for _, B in pairs(Tabs) do
            B.BackgroundColor3 = CurrentTheme.Surface
            B.TextColor3 = CurrentTheme.Muted
        end

        Page.Visible = true

        Button.BackgroundColor3 = CurrentTheme.Accent
        Button.TextColor3 = Color3.fromRGB(255,255,255)

    end)

    Tabs[Name] = Button

    return Button
end

AddTab("Home", "⌂", HomePage)
AddTab("Scripts", "⚡", ScriptsPage)
AddTab("Themes", "✦", ThemesPage)
AddTab("Settings", "⚙", SettingsPage)

HomePage.Visible = true
Tabs["Home"].BackgroundColor3 = CurrentTheme.Accent
Tabs["Home"].TextColor3 = Color3.fromRGB(255,255,255)

--==================================================
-- RESPONSIVE
--==================================================

local function UpdateResponsive()

    local Camera = workspace.CurrentCamera
    if not Camera then
        return
    end

    local Viewport = Camera.ViewportSize

    if Viewport.X <= 700 then

        Main.Size = UDim2.new(
            CONFIG.PhoneWidthScale,
            0,
            CONFIG.PhoneHeightScale,
            0
        )

        Sidebar.Size = UDim2.new(0, 62, 1, 0)
        Content.Size = UDim2.new(1, -62, 1, 0)
        Content.Position = UDim2.fromOffset(62, 0)

        SidePadding.PaddingLeft = UDim.new(0, 7)
        SidePadding.PaddingRight = UDim.new(0, 7)

        for _, Button in pairs(Tabs) do
            Button.Text = string.sub(Button.Text, 1, 1)
            Button.TextXAlignment = Enum.TextXAlignment.Center
        end

    else

        Main.Size = UDim2.fromOffset(
            CONFIG.DesktopWidth,
            CONFIG.DesktopHeight
        )

        Sidebar.Size = UDim2.new(0, 190, 1, 0)
        Content.Size = UDim2.new(1, -190, 1, 0)
        Content.Position = UDim2.fromOffset(190, 0)

        SidePadding.PaddingLeft = UDim.new(0, 12)
        SidePadding.PaddingRight = UDim.new(0, 12)

        Tabs["Home"].Text = "⌂   Home"
        Tabs["Scripts"].Text = "⚡   Scripts"
        Tabs["Themes"].Text = "✦   Themes"
        Tabs["Settings"].Text = "⚙   Settings"

        for _, Button in pairs(Tabs) do
            Button.TextXAlignment = Enum.TextXAlignment.Left
        end

    end
end

workspace.CurrentCamera:GetPropertyChangedSignal(
    "ViewportSize"
):Connect(UpdateResponsive)

UpdateResponsive()

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

Topbar.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position

    end

end)

Topbar.InputEnded:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false

    end

end)

UserInputService.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )

    end

end)

--==================================================
-- MINIMIZE
--==================================================

local Minimized = false

Minimize.MouseButton1Click:Connect(function()

    Minimized = not Minimized

    if Minimized then

        Body.Visible = false

        TweenService:Create(
            Main,
            TweenInfo.new(0.25, Enum.EasingStyle.Quart),
            {Size = UDim2.new(Main.Size.X.Scale, Main.Size.X.Offset, 0, 68)}
        ):Play()

    else

        TweenService:Create(
            Main,
            TweenInfo.new(0.25, Enum.EasingStyle.Quart),
            {Size = UDim2.fromOffset(
                CONFIG.DesktopWidth,
                CONFIG.DesktopHeight
            )}
        ):Play()

        task.wait(0.18)

        Body.Visible = true

        UpdateResponsive()

    end

end)

--==================================================
-- CLOSE / OPEN
--==================================================

local function CloseGUI()

    TweenService:Create(
        Main,
        TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {
            Size = UDim2.fromOffset(0, 0)
        }
    ):Play()

    task.wait(0.22)

    Main.Visible = false
    OpenButton.Visible = true

end

local function OpenGUI()

    OpenButton.Visible = false

    Main.Visible = true

    UpdateResponsive()

end

Close.MouseButton1Click:Connect(CloseGUI)

OpenButton.MouseButton1Click:Connect(OpenGUI)

--==================================================
-- HOVER EFFECTS
--==================================================

local function Hover(Button)

    local Original = Button.BackgroundColor3

    Button.MouseEnter:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = CurrentTheme.Accent
            }
        ):Play()

    end)

    Button.MouseLeave:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Original
            }
        ):Play()

    end)

end

Hover(Minimize)
Hover(Close)

--==================================================
-- DONE
--==================================================

print("[CH3A5 HUB V4] GUI Loaded")
