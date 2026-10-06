--// CH3A5 HUB v2
--// GUI / UX ONLY
--// Script execution intentionally left as a placeholder.

if game:GetService("CoreGui"):FindFirstChild("CH3A5_HUB") then
    game:GetService("CoreGui"):FindFirstChild("CH3A5_HUB"):Destroy()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
    ScreenPercent = 0.75,
    Animation = true,
    Notifications = true,
    SelectedTheme = "Midnight"
}

--==================================================
-- THEMES
--==================================================

local Themes = {
    Midnight = {
        BG = Color3.fromRGB(12, 13, 18),
        Surface = Color3.fromRGB(20, 21, 29),
        Surface2 = Color3.fromRGB(27, 28, 38),
        Accent = Color3.fromRGB(125, 95, 255),
        Text = Color3.fromRGB(245, 245, 250),
        Muted = Color3.fromRGB(150, 153, 165)
    },

    Discord = {
        BG = Color3.fromRGB(20, 21, 24),
        Surface = Color3.fromRGB(32, 34, 39),
        Surface2 = Color3.fromRGB(45, 47, 52),
        Accent = Color3.fromRGB(88, 101, 242),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(185, 187, 193)
    },

    GitHub = {
        BG = Color3.fromRGB(13, 17, 23),
        Surface = Color3.fromRGB(22, 27, 34),
        Surface2 = Color3.fromRGB(33, 38, 45),
        Accent = Color3.fromRGB(46, 160, 67),
        Text = Color3.fromRGB(240, 246, 252),
        Muted = Color3.fromRGB(139, 148, 158)
    },

    Spotify = {
        BG = Color3.fromRGB(10, 10, 10),
        Surface = Color3.fromRGB(24, 24, 24),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(30, 215, 96),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(165, 165, 165)
    },

    YouTube = {
        BG = Color3.fromRGB(15, 15, 15),
        Surface = Color3.fromRGB(30, 30, 30),
        Surface2 = Color3.fromRGB(45, 45, 45),
        Accent = Color3.fromRGB(255, 0, 0),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(175, 175, 175)
    },

    Telegram = {
        BG = Color3.fromRGB(12, 20, 27),
        Surface = Color3.fromRGB(22, 34, 44),
        Surface2 = Color3.fromRGB(30, 46, 59),
        Accent = Color3.fromRGB(42, 171, 238),
        Text = Color3.fromRGB(245, 250, 255),
        Muted = Color3.fromRGB(150, 180, 198)
    },

    Twitter = {
        BG = Color3.fromRGB(10, 10, 10),
        Surface = Color3.fromRGB(24, 24, 24),
        Surface2 = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(29, 155, 240),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(165, 165, 165)
    },

    Twitch = {
        BG = Color3.fromRGB(14, 12, 20),
        Surface = Color3.fromRGB(25, 22, 35),
        Surface2 = Color3.fromRGB(38, 32, 50),
        Accent = Color3.fromRGB(145, 70, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(180, 170, 195)
    },

    Dracula = {
        BG = Color3.fromRGB(24, 24, 37),
        Surface = Color3.fromRGB(40, 42, 54),
        Surface2 = Color3.fromRGB(53, 55, 70),
        Accent = Color3.fromRGB(189, 147, 249),
        Text = Color3.fromRGB(248, 248, 242),
        Muted = Color3.fromRGB(180, 180, 190)
    },

    Ocean = {
        BG = Color3.fromRGB(7, 18, 28),
        Surface = Color3.fromRGB(12, 32, 48),
        Surface2 = Color3.fromRGB(18, 45, 65),
        Accent = Color3.fromRGB(0, 190, 255),
        Text = Color3.fromRGB(235, 250, 255),
        Muted = Color3.fromRGB(145, 180, 195)
    },

    Crimson = {
        BG = Color3.fromRGB(20, 10, 12),
        Surface = Color3.fromRGB(35, 16, 20),
        Surface2 = Color3.fromRGB(50, 22, 28),
        Accent = Color3.fromRGB(235, 55, 75),
        Text = Color3.fromRGB(255, 240, 242),
        Muted = Color3.fromRGB(185, 155, 160)
    },

    Emerald = {
        BG = Color3.fromRGB(8, 18, 14),
        Surface = Color3.fromRGB(14, 32, 25),
        Surface2 = Color3.fromRGB(20, 45, 34),
        Accent = Color3.fromRGB(40, 210, 130),
        Text = Color3.fromRGB(235, 255, 245),
        Muted = Color3.fromRGB(145, 180, 160)
    },

    Angkor = {
        BG = Color3.fromRGB(18, 14, 10),
        Surface = Color3.fromRGB(35, 27, 18),
        Surface2 = Color3.fromRGB(50, 38, 24),
        Accent = Color3.fromRGB(214, 157, 65),
        Text = Color3.fromRGB(255, 245, 220),
        Muted = Color3.fromRGB(185, 160, 125)
    }
}

local Theme = Themes[CONFIG.SelectedTheme]

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "CH3A5_HUB"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = CoreGui

--==================================================
-- FLOATING BUTTON
--==================================================

local Toggle = Instance.new("TextButton")
Toggle.Name = "FloatingToggle"
Toggle.Size = UDim2.fromOffset(52, 52)
Toggle.Position = UDim2.new(0, 18, 0.5, -26)
Toggle.BackgroundColor3 = Theme.Accent
Toggle.Text = "C"
Toggle.TextColor3 = Theme.Text
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 20
Toggle.AutoButtonColor = false
Toggle.Parent = Gui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = Toggle

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 1
ToggleStroke.Transparency = 0.25
ToggleStroke.Parent = Toggle

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromScale(CONFIG.ScreenPercent, 0.70)
Main.BackgroundColor3 = Theme.BG
Main.BorderSizePixel = 0
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Accent
MainStroke.Transparency = 0.55
MainStroke.Parent = Main

local SizeConstraint = Instance.new("UISizeConstraint")
SizeConstraint.MinSize = Vector2.new(300, 260)
SizeConstraint.MaxSize = Vector2.new(720, 520)
SizeConstraint.Parent = Main

--==================================================
-- TOPBAR
--==================================================

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 54)
Topbar.BackgroundColor3 = Theme.Surface
Topbar.BorderSizePixel = 0
Topbar.Parent = Main

local TopTitle = Instance.new("TextLabel")
TopTitle.Size = UDim2.new(1, -110, 0, 25)
TopTitle.Position = UDim2.fromOffset(16, 8)
TopTitle.BackgroundTransparency = 1
TopTitle.Text = "CH3A5 HUB"
TopTitle.Font = Enum.Font.GothamBold
TopTitle.TextSize = 17
TopTitle.TextXAlignment = Enum.TextXAlignment.Left
TopTitle.TextColor3 = Theme.Text
TopTitle.Parent = Topbar

local TopSub = Instance.new("TextLabel")
TopSub.Size = UDim2.new(1, -110, 0, 18)
TopSub.Position = UDim2.fromOffset(16, 31)
TopSub.BackgroundTransparency = 1
TopSub.Text = "Premium Interface"
TopSub.Font = Enum.Font.Gotham
TopSub.TextSize = 9
TopSub.TextXAlignment = Enum.TextXAlignment.Left
TopSub.TextColor3 = Theme.Muted
TopSub.Parent = Topbar

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(35, 35)
Minimize.Position = UDim2.new(1, -78, 0, 9)
Minimize.BackgroundTransparency = 1
Minimize.Text = "—"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 20
Minimize.TextColor3 = Theme.Text
Minimize.Parent = Topbar

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(35, 35)
Close.Position = UDim2.new(1, -42, 0, 9)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 22
Close.TextColor3 = Theme.Text
Close.Parent = Topbar

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 145, 1, -54)
Sidebar.Position = UDim2.fromOffset(0, 54)
Sidebar.BackgroundColor3 = Theme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 12)
SidePadding.PaddingLeft = UDim.new(0, 8)
SidePadding.PaddingRight = UDim.new(0, 8)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 7)
SideLayout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -145, 1, -54)
Content.Position = UDim2.fromOffset(145, 54)
Content.BackgroundColor3 = Theme.BG
Content.BorderSizePixel = 0
Content.Parent = Main

local Pages = {}
local ThemeObjects = {}

local function Register(instance, property, category)
    ThemeObjects[#ThemeObjects + 1] = {
        Object = instance,
        Property = property,
        Category = category
    }
end

--==================================================
-- PAGE CREATOR
--==================================================

local function CreatePage(Name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name
    Page.Size = UDim2.new(1, -18, 1, -18)
    Page.Position = UDim2.fromOffset(9, 9)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Theme.Accent
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new()
    Page.Visible = false
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 9)
    Layout.Parent = Page

    Register(Page, "ScrollBarImageColor3", "Accent")

    Pages[Name] = Page
    return Page
end

local Home = CreatePage("Home")
local Keyless = CreatePage("Keyless")
local KeyScripts = CreatePage("KeyScripts")
local ThemesPage = CreatePage("Themes")
local Settings = CreatePage("Settings")

--==================================================
-- HELPERS
--==================================================

local function Section(Page, Text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 28)
    Label.BackgroundTransparency = 1
    Label.Text = Text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = Theme.Text
    Label.Parent = Page

    Register(Label, "TextColor3", "Text")

    return Label
end

local function Info(Page, Text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = Text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextColor3 = Theme.Muted
    Label.Parent = Page

    Register(Label, "TextColor3", "Muted")

    return Label
end

local function Card(Page, Name, Description, Badge)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 66)
    Button.BackgroundColor3 = Theme.Surface
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.BorderSizePixel = 0
    Button.Parent = Page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Button

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -100, 0, 24)
    NameLabel.Position = UDim2.fromOffset(13, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = Name
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 13
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextColor3 = Theme.Text
    NameLabel.Parent = Button

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -100, 0, 20)
    Desc.Position = UDim2.fromOffset(13, 34)
    Desc.BackgroundTransparency = 1
    Desc.Text = Description
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 10
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextColor3 = Theme.Muted
    Desc.Parent = Button

    local Tag = Instance.new("TextLabel")
    Tag.Size = UDim2.fromOffset(70, 24)
    Tag.Position = UDim2.new(1, -82, 0.5, -12)
    Tag.BackgroundColor3 = Theme.Accent
    Tag.Text = Badge
    Tag.Font = Enum.Font.GothamBold
    Tag.TextSize = 9
    Tag.TextColor3 = Theme.Text
    Tag.Parent = Button

    local TagCorner = Instance.new("UICorner")
    TagCorner.CornerRadius = UDim.new(0, 6)
    TagCorner.Parent = Tag

    Register(Button, "BackgroundColor3", "Surface")
    Register(NameLabel, "TextColor3", "Text")
    Register(Desc, "TextColor3", "Muted")
    Register(Tag, "BackgroundColor3", "Accent")
    Register(Tag, "TextColor3", "Text")

    Button.MouseEnter:Connect(function()
        if CONFIG.Animation then
            TweenService:Create(
                Button,
                TweenInfo.new(0.18),
                {BackgroundColor3 = Theme.Surface2}
            ):Play()
        end
    end)

    return Button
end

local function ComingSoon(Page, Name)
    local Button = Card(Page, Name, "Feature coming soon", "SOON")
    return Button
end

--==================================================
-- PAGES
--==================================================

Section(Home, "Welcome")
Info(Home, "Choose a category from the sidebar.")

ComingSoon(Home, "More scripts")
ComingSoon(Home, "Updates")
ComingSoon(Home, "Community")

Section(Keyless, "Keyless Scripts")
Info(Keyless, "Scripts that do not require a key.")

Card(Keyless, "Sources Hub", "Keyless", "KEYLESS")
Card(Keyless, "Limbo Hub", "Keyless", "KEYLESS")
Card(Keyless, "Virexx", "Keyless", "KEYLESS")

Section(KeyScripts, "Key System")
Info(KeyScripts, "Scripts that may require a key.")

Card(KeyScripts, "Wzeus Hub", "Key System", "KEY")
Card(KeyScripts, "Pulse Hub", "Key System", "KEY")

Section(ThemesPage, "Themes")
Info(ThemesPage, "Select a visual theme.")

for Name, Data in pairs(Themes) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 43)
    Button.BackgroundColor3 = Data.Surface
    Button.Text = Name
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.TextColor3 = Data.Text
    Button.BorderSizePixel = 0
    Button.Parent = ThemesPage

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        CONFIG.SelectedTheme = Name
        Theme = Data

        for _, Item in ipairs(ThemeObjects) do
            local Object = Item.Object
            if Object and Object.Parent then
                local Target

                if Item.Category == "BG" then
                    Target = Data.BG
                elseif Item.Category == "Surface" then
                    Target = Data.Surface
                elseif Item.Category == "Surface2" then
                    Target = Data.Surface2
                elseif Item.Category == "Accent" then
                    Target = Data.Accent
                elseif Item.Category == "Text" then
                    Target = Data.Text
                elseif Item.Category == "Muted" then
                    Target = Data.Muted
                end

                if Target then
                    if CONFIG.Animation then
                        TweenService:Create(
                            Object,
                            TweenInfo.new(0.3),
                            {[Item.Property] = Target}
                        ):Play()
                    else
                        Object[Item.Property] = Target
                    end
                end
            end
        end

        -- Core objects not registered through cards
        Main.BackgroundColor3 = Data.BG
        Content.BackgroundColor3 = Data.BG
        Topbar.BackgroundColor3 = Data.Surface
        Sidebar.BackgroundColor3 = Data.Surface
        MainStroke.Color = Data.Accent
        Toggle.BackgroundColor3 = Data.Accent
        ToggleStroke.Color = Data.Text
        Toggle.TextColor3 = Data.Text
    end)
end

Section(Settings, "Settings")
Info(Settings, "Customize your interface.")

ComingSoon(Settings, "Notifications")
ComingSoon(Settings, "Animations")
ComingSoon(Settings, "UI Scale")
ComingSoon(Settings, "Reset Position")

--==================================================
-- TABS
--==================================================

local TabButtons = {}

local function Tab(Name, Page)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 38)
    Button.BackgroundColor3 = Theme.BG
    Button.Text = Name
    Button.Font = Enum.Font.GothamMedium
    Button.TextSize = 11
    Button.TextColor3 = Theme.Text
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 7)
    Corner.Parent = Button

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.fromOffset(3, 20)
    Indicator.Position = UDim2.new(0, 0, 0.5, -10)
    Indicator.BackgroundColor3 = Theme.Accent
    Indicator.Visible = false
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Button

    Register(Button, "BackgroundColor3", "BG")
    Register(Button, "TextColor3", "Text")
    Register(Indicator, "BackgroundColor3", "Accent")

    TabButtons[#TabButtons + 1] = {
        Button = Button,
        Indicator = Indicator,
        Page = Page
    }

    Button.MouseButton1Click:Connect(function()
        for _, TabData in ipairs(TabButtons) do
            TabData.Page.Visible = false
            TabData.Indicator.Visible = false
        end

        Page.Visible = true
        Indicator.Visible = true
    end)

    return Button
end

Tab("Home", Home)
Tab("Keyless", Keyless)
Tab("Key Scripts", KeyScripts)
Tab("Themes", ThemesPage)
Tab("Settings", Settings)

Home.Visible = true
TabButtons[1].Indicator.Visible = true

--==================================================
-- DRAG MAIN
--==================================================

local Dragging = false
local DragStart
local StartPos

Topbar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPos = Main.Position
    end
end)

Topbar.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )
    end
end)

--==================================================
-- OPEN / CLOSE
--==================================================

local Opened = true
local Minimized = false
local NormalSize = Main.Size

local function SetVisible(State)
    Opened = State

    if State then
        Main.Visible = true

        if CONFIG.Animation then
            Main.Size = UDim2.fromScale(0.01, 0.01)

            TweenService:Create(
                Main,
                TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Size = NormalSize}
            ):Play()
        else
            Main.Size = NormalSize
        end
    else
        if CONFIG.Animation then
            local Animation = TweenService:Create(
                Main,
                TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                {Size = UDim2.fromScale(0.01, 0.01)}
            )

            Animation:Play()

            Animation.Completed:Connect(function()
                if not Opened then
                    Main.Visible = false
                    Main.Size = NormalSize
                end
            end)
        else
            Main.Visible = false
        end
    end
end

Toggle.MouseButton1Click:Connect(function()
    SetVisible(not Opened)
end)

Close.MouseButton1Click:Connect(function()
    SetVisible(false)
end)

Minimize.MouseButton1Click:Connect(function()
    SetVisible(false)
end)

--==================================================
-- FLOATING BUTTON DRAG
--==================================================

local ToggleDragging = false
local ToggleStart
local TogglePosition

Toggle.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        ToggleDragging = true
        ToggleStart = Input.Position
        TogglePosition = Toggle.Position
    end
end)

Toggle.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        ToggleDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if ToggleDragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then

        local Delta = Input.Position - ToggleStart

        Toggle.Position = UDim2.new(
            TogglePosition.X.Scale,
            TogglePosition.X.Offset + Delta.X,
            TogglePosition.Y.Scale,
            TogglePosition.Y.Offset + Delta.Y
        )
    end
end)

--==================================================
-- RESPONSIVE
--==================================================

local Camera = workspace.CurrentCamera

local function Responsive()
    if not Camera then return end

    local View = Camera.ViewportSize

    if View.X < 500 then
        Main.Size = UDim2.fromScale(0.75, 0.72)
    elseif View.X < 900 then
        Main.Size = UDim2.fromScale(0.75, 0.70)
    else
        Main.Size = UDim2.fromScale(0.68, 0.70)
    end

    NormalSize = Main.Size
end

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(Responsive)

Responsive()

--==================================================
-- FINAL
--==================================================

print("CH3A5 HUB v2 GUI Loaded")
