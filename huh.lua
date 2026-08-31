--[[
    CH3A5 Premium Interface v11.0
    Description: Premium Dark UI Framework (Educational/UI Design Purposes Only)
    Features: Draggable window, smooth resizing, tab system, language toggle, live stats.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Configuration
local CONFIG = {
    MinSize = Vector2.new(650, 420),
    MaxSize = Vector2.new(1100, 700),
    Colors = {
        Background = Color3.fromRGB(20, 20, 25),
        Sidebar = Color3.fromRGB(25, 25, 32),
        Topbar = Color3.fromRGB(30, 30, 40),
        Accent = Color3.fromRGB(123, 97, 255), -- Premium Purple
        TextLight = Color3.fromRGB(240, 240, 240),
        TextDim = Color3.fromRGB(150, 150, 160)
    },
    TweenSpeed = 0.3
}

-- Language Dictionary
local Languages = {
    EN = {
        Title = "CH3A5 PREMIUM v11.0",
        Home = "Home",
        Player = "Player Info",
        Server = "Server Info",
        Statistics = "Statistics",
        Settings = "Settings",
        About = "About / Credits",
        Welcome = "Welcome back, " .. LocalPlayer.Name,
        ToggleLang = "Switch to Khmer (ខ្មែរ)",
        Session = "Session Time: "
    },
    KM = {
        Title = "CH3A5 ពិសេស v11.0",
        Home = "ទំព័រដើម",
        Player = "ព័ត៌មានអ្នកលេង",
        Server = "ព័ត៌មានម៉ាស៊ីនមេ",
        Statistics = "ស្ថិតិ",
        Settings = "ការកំណត់",
        About = "អំពី / ឥណទាន",
        Welcome = "ស្វាគមន៍ការត្រលប់មកវិញ, " .. LocalPlayer.Name,
        ToggleLang = "ប្តូរទៅអង់គ្លេស (English)",
        Session = "រយៈពេល: "
    }
}
local currentLang = "EN"
local textObjects = {} -- Stores objects that need translation updates

-- Helper: Create UI Elements dynamically
local function create(className, properties, children)
    local inst = Instance.new(className)
    for k, v in pairs(properties or {}) do
        if k ~= "Parent" then inst[k] = v end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = inst
    end
    return inst
end

-- Helper: Register text for translation
local function registerText(guiObject, langKey)
    table.insert(textObjects, {obj = guiObject, key = langKey})
    guiObject.Text = Languages[currentLang][langKey] or langKey
end

local function updateLanguage()
    for _, item in ipairs(textObjects) do
        item.obj.Text = Languages[currentLang][item.key] or item.key
    end
end

-- ==============================
-- GUI CONSTRUCTION
-- ==============================

local ScreenGui = create("ScreenGui", {
    Name = "CH3A5_Premium_UI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    Parent = PlayerGui
})

local MainFrame = create("Frame", {
    Size = UDim2.new(0, 800, 0, 500),
    Position = UDim2.new(0.5, -400, 0.5, -250),
    BackgroundColor3 = CONFIG.Colors.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, {
    create("UICorner", {CornerRadius = UDim.new(0, 10)})
})
MainFrame.Parent = ScreenGui

-- Topbar (Draggable)
local Topbar = create("Frame", {
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = CONFIG.Colors.Topbar,
    BorderSizePixel = 0
}, {
    create("UICorner", {CornerRadius = UDim.new(0, 10)}),
    create("Frame", { -- Square off bottom corners
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        BackgroundColor3 = CONFIG.Colors.Topbar,
        BorderSizePixel = 0
    })
})
Topbar.Parent = MainFrame

local Title = create("TextLabel", {
    Size = UDim2.new(0, 200, 1, 0),
    Position = UDim2.new(0, 15, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextColor3 = CONFIG.Colors.Accent,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left
})
registerText(Title, "Title")
Title.Parent = Topbar

local TopStats = create("TextLabel", {
    Size = UDim2.new(0, 300, 1, 0),
    Position = UDim2.new(1, -315, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamSemibold,
    TextColor3 = CONFIG.Colors.TextDim,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Right,
    Text = "FPS: 60  |  Ping: 50ms"
})
TopStats.Parent = Topbar

-- Sidebar
local Sidebar = create("Frame", {
    Size = UDim2.new(0, 180, 1, -40),
    Position = UDim2.new(0, 0, 0, 40),
    BackgroundColor3 = CONFIG.Colors.Sidebar,
    BorderSizePixel = 0
}, {
    create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    }),
    create("UIPadding", {
        PaddingTop = UDim.new(0, 15),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    })
})
Sidebar.Parent = MainFrame

-- Content Area
local ContentArea = create("Frame", {
    Size = UDim2.new(1, -180, 1, -40),
    Position = UDim2.new(0, 180, 0, 40),
    BackgroundTransparency = 1
})
ContentArea.Parent = MainFrame

-- Resize Handle (Bottom Right)
local ResizeHandle = create("TextButton", {
    Size = UDim2.new(0, 20, 0, 20),
    Position = UDim2.new(1, -20, 1, -20),
    BackgroundTransparency = 1,
    Text = "◢",
    TextColor3 = CONFIG.Colors.TextDim,
    TextSize = 18,
    ZIndex = 10
})
ResizeHandle.Parent = MainFrame

-- ==============================
-- TABS & NAVIGATION LOGIC
-- ==============================

local tabs = {}
local buttons = {}
local activeTab = nil

local function createTab(name, langKey, layoutOrder)
    -- Tab Button
    local btn = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = CONFIG.Colors.Topbar,
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamSemibold,
        TextColor3 = CONFIG.Colors.TextDim,
        TextSize = 14,
        LayoutOrder = layoutOrder,
        AutoButtonColor = false
    }, {
        create("UICorner", {CornerRadius = UDim.new(0, 6)})
    })
    registerText(btn, langKey)
    btn.Parent = Sidebar
    
    -- Tab Content Frame
    local frame = create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false
    }, {
        create("UIPadding", {
            PaddingTop = UDim.new(0, 20),
            PaddingLeft = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20),
            PaddingBottom = UDim.new(0, 20)
        })
    })
    frame.Parent = ContentArea
    
    tabs[name] = frame
    buttons[name] = btn
    
    -- Button Animation & Click Logic
    btn.MouseEnter:Connect(function()
        if activeTab ~= name then
            TweenService:Create(btn, TweenInfo.new(CONFIG.TweenSpeed), {TextColor3 = CONFIG.Colors.TextLight}):Play()
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if activeTab ~= name then
            TweenService:Create(btn, TweenInfo.new(CONFIG.TweenSpeed), {TextColor3 = CONFIG.Colors.TextDim}):Play()
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        if activeTab == name then return end
        
        -- Hide old tab
        if activeTab then
            tabs[activeTab].Visible = false
            TweenService:Create(buttons[activeTab], TweenInfo.new(CONFIG.TweenSpeed), {
                BackgroundTransparency = 1,
                TextColor3 = CONFIG.Colors.TextDim
            }):Play()
        end
        
        -- Show new tab
        activeTab = name
        tabs[name].Visible = true
        TweenService:Create(btn, TweenInfo.new(CONFIG.TweenSpeed), {
            BackgroundTransparency = 0,
            TextColor3 = CONFIG.Colors.Accent
        }):Play()
    end)
    
    return frame
end

-- Initialize Tabs
local tabHome = createTab("Home", "Home", 1)
local tabPlayer = createTab("Player", "Player", 2)
local tabServer = createTab("Server", "Server", 3)
local tabStats = createTab("Stats", "Statistics", 4)
local tabSettings = createTab("Settings", "Settings", 5)
local tabAbout = createTab("About", "About", 6)

-- Populate Home Tab
local WelcomeMsg = create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextColor3 = CONFIG.Colors.TextLight,
    TextSize = 24,
    TextXAlignment = Enum.TextXAlignment.Left
})
registerText(WelcomeMsg, "Welcome")
WelcomeMsg.Parent = tabHome

-- Populate Settings Tab (Language Toggle)
local LangBtn = create("TextButton", {
    Size = UDim2.new(0, 200, 0, 40),
    Position = UDim2.new(0, 0, 0, 50),
    BackgroundColor3 = CONFIG.Colors.Accent,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14
}, { create("UICorner", {CornerRadius = UDim.new(0, 6)}) })
registerText(LangBtn, "ToggleLang")
LangBtn.Parent = tabSettings

LangBtn.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "EN") and "KM" or "EN"
    updateLanguage()
end)

-- Open Default Tab
buttons["Home"].BackgroundTransparency = 0
buttons["Home"].TextColor3 = CONFIG.Colors.Accent
tabs["Home"].Visible = true
activeTab = "Home"

-- ==============================
-- DRAG & RESIZE LOGIC
-- ==============================

local function enableDragging(handle, target)
    local dragging, dragInput, dragStart, startPos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
            
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
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end
enableDragging(Topbar, MainFrame)

local function enableResizing(handle, target)
    local resizing, dragInput, dragStart, startSize
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            dragStart = input.Position
            startSize = target.AbsoluteSize
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
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
        if input == dragInput and resizing then
            local delta = input.Position - dragStart
            local newWidth = math.clamp(startSize.X + delta.X, CONFIG.MinSize.X, CONFIG.MaxSize.X)
            local newHeight = math.clamp(startSize.Y + delta.Y, CONFIG.MinSize.Y, CONFIG.MaxSize.Y)
            target.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
end
enableResizing(ResizeHandle, MainFrame)

-- ==============================
-- LIVE STATS (FPS, PING, TIMER)
-- ==============================

local startTime = os.time()
local frames = 0

RunService.RenderStepped:Connect(function()
    frames = frames + 1
end)

task.spawn(function()
    while task.wait(1) do
        -- Calculate FPS
        local fps = frames
        frames = 0
        
        -- Get Ping (Using Roblox NetworkStats)
        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        
        -- Format Timer
        local diff = os.time() - startTime
        local mins = math.floor(diff / 60)
        local secs = diff % 60
        local timeStr = string.format("%02d:%02d", mins, secs)
        
        local sessionText = Languages[currentLang]["Session"] or "Session: "
        TopStats.Text = string.format("FPS: %d  |  Ping: %dms  |  %s%s", fps, ping, sessionText, timeStr)
    end
end)
