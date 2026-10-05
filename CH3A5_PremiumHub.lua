--[[
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    CH3A5 PREMIUM HUB - Client-Side FPS Optimization Interface
    Theme: Khmer Angkor (អង្គរ • បច្ចេកវិទ្យា • ប្រសិទ្ធភាព)
    Purpose: Legal, Safe, Client-Side Rendering Optimization
    Author: CH3A5
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildWhichIsA("Terrain")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

-- System State
local HubState = {
    AnimationsEnabled = true,
    UIScale = 1,
    CurrentPreset = "Default",
    IsMobile = false,
    MenuOpen = false
}

-- Theme Engine (30 Themes)
local Themes = {
    ["Angkor Gold"] = { Bg = Color3.fromRGB(26, 24, 20), Panel = Color3.fromRGB(36, 33, 28), Accent = Color3.fromRGB(212, 175, 55), Text = Color3.fromRGB(245, 245, 220), Sub = Color3.fromRGB(150, 140, 120) },
    ["Midnight"] = { Bg = Color3.fromRGB(10, 10, 10), Panel = Color3.fromRGB(20, 20, 20), Accent = Color3.fromRGB(100, 100, 100), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(150, 150, 150) },
    ["Ocean"] = { Bg = Color3.fromRGB(0, 31, 63), Panel = Color3.fromRGB(0, 43, 86), Accent = Color3.fromRGB(0, 116, 217), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(127, 219, 255) },
    ["Emerald"] = { Bg = Color3.fromRGB(10, 47, 31), Panel = Color3.fromRGB(15, 60, 40), Accent = Color3.fromRGB(46, 204, 64), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(160, 220, 180) },
    ["Sunset"] = { Bg = Color3.fromRGB(43, 15, 25), Panel = Color3.fromRGB(60, 20, 35), Accent = Color3.fromRGB(255, 133, 27), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(255, 200, 150) },
    ["Royal Purple"] = { Bg = Color3.fromRGB(26, 0, 51), Panel = Color3.fromRGB(40, 10, 70), Accent = Color3.fromRGB(177, 13, 201), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(220, 150, 250) },
    ["Cyber"] = { Bg = Color3.fromRGB(17, 17, 17), Panel = Color3.fromRGB(30, 30, 30), Accent = Color3.fromRGB(1, 255, 112), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(150, 255, 200) },
    ["Discord"] = { Bg = Color3.fromRGB(54, 57, 63), Panel = Color3.fromRGB(47, 49, 54), Accent = Color3.fromRGB(88, 101, 242), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(185, 187, 190) },
    ["Telegram"] = { Bg = Color3.fromRGB(23, 33, 43), Panel = Color3.fromRGB(14, 22, 33), Accent = Color3.fromRGB(56, 149, 211), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(150, 170, 190) },
    ["YouTube"] = { Bg = Color3.fromRGB(15, 15, 15), Panel = Color3.fromRGB(33, 33, 33), Accent = Color3.fromRGB(255, 0, 0), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(170, 170, 170) },
    ["Spotify"] = { Bg = Color3.fromRGB(18, 18, 18), Panel = Color3.fromRGB(24, 24, 24), Accent = Color3.fromRGB(29, 185, 84), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(179, 179, 179) },
    ["Instagram"] = { Bg = Color3.fromRGB(0, 0, 0), Panel = Color3.fromRGB(18, 18, 18), Accent = Color3.fromRGB(225, 48, 108), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(150, 150, 150) },
    ["TikTok"] = { Bg = Color3.fromRGB(0, 0, 0), Panel = Color3.fromRGB(17, 17, 17), Accent = Color3.fromRGB(0, 242, 254), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(255, 0, 80) },
    ["Microsoft"] = { Bg = Color3.fromRGB(18, 18, 18), Panel = Color3.fromRGB(31, 31, 31), Accent = Color3.fromRGB(0, 164, 239), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(150, 150, 150) },
    ["Apple"] = { Bg = Color3.fromRGB(0, 0, 0), Panel = Color3.fromRGB(28, 28, 30), Accent = Color3.fromRGB(0, 122, 255), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(235, 235, 245) },
    ["Windows"] = { Bg = Color3.fromRGB(0, 0, 0), Panel = Color3.fromRGB(32, 32, 32), Accent = Color3.fromRGB(0, 120, 215), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(200, 200, 200) },
    ["PlayStation"] = { Bg = Color3.fromRGB(0, 0, 77), Panel = Color3.fromRGB(0, 0, 102), Accent = Color3.fromRGB(0, 112, 209), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(150, 180, 255) },
    ["Xbox"] = { Bg = Color3.fromRGB(16, 16, 16), Panel = Color3.fromRGB(26, 26, 26), Accent = Color3.fromRGB(16, 124, 16), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(150, 150, 150) },
    ["Steam"] = { Bg = Color3.fromRGB(23, 26, 33), Panel = Color3.fromRGB(27, 40, 56), Accent = Color3.fromRGB(102, 192, 244), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(199, 213, 224) },
    ["Google"] = { Bg = Color3.fromRGB(32, 33, 36), Panel = Color3.fromRGB(48, 49, 52), Accent = Color3.fromRGB(66, 133, 244), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(154, 160, 166) },
    ["AMOLED"] = { Bg = Color3.fromRGB(0, 0, 0), Panel = Color3.fromRGB(8, 8, 8), Accent = Color3.fromRGB(255, 255, 255), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(120, 120, 120) },
    ["Sakura"] = { Bg = Color3.fromRGB(43, 28, 34), Panel = Color3.fromRGB(55, 35, 45), Accent = Color3.fromRGB(255, 183, 197), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(255, 220, 225) },
    ["Crimson"] = { Bg = Color3.fromRGB(26, 0, 0), Panel = Color3.fromRGB(40, 5, 5), Accent = Color3.fromRGB(220, 20, 60), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(255, 150, 150) },
    ["Khmer Royal"] = { Bg = Color3.fromRGB(74, 0, 0), Panel = Color3.fromRGB(100, 10, 10), Accent = Color3.fromRGB(255, 176, 0), Text = Color3.fromRGB(255, 240, 200), Sub = Color3.fromRGB(255, 200, 100) },
    ["Angkor Night"] = { Bg = Color3.fromRGB(13, 19, 33), Panel = Color3.fromRGB(29, 45, 68), Accent = Color3.fromRGB(230, 194, 41), Text = Color3.fromRGB(240, 235, 216), Sub = Color3.fromRGB(116, 140, 170) },
    ["Arctic"] = { Bg = Color3.fromRGB(28, 35, 49), Panel = Color3.fromRGB(40, 50, 70), Accent = Color3.fromRGB(0, 255, 255), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(150, 200, 220) },
    ["Matrix"] = { Bg = Color3.fromRGB(0, 5, 0), Panel = Color3.fromRGB(5, 15, 5), Accent = Color3.fromRGB(0, 255, 65), Text = Color3.fromRGB(200, 255, 200), Sub = Color3.fromRGB(0, 150, 50) },
    ["Neon Violet"] = { Bg = Color3.fromRGB(9, 0, 20), Panel = Color3.fromRGB(20, 5, 35), Accent = Color3.fromRGB(138, 43, 226), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(200, 150, 255) },
    ["Coffee"] = { Bg = Color3.fromRGB(59, 47, 47), Panel = Color3.fromRGB(75, 60, 60), Accent = Color3.fromRGB(193, 154, 107), Text = Color3.fromRGB(255, 245, 235), Sub = Color3.fromRGB(200, 180, 160) },
    ["Platinum"] = { Bg = Color3.fromRGB(34, 34, 34), Panel = Color3.fromRGB(45, 45, 45), Accent = Color3.fromRGB(229, 228, 226), Text = Color3.fromRGB(255, 255, 255), Sub = Color3.fromRGB(180, 180, 180) }
}
local CurrentThemeName = "Angkor Gold"
local CurrentTheme = Themes[CurrentThemeName]
local ThemedElements = {}

-- Cache for Original Settings (To restore defaults)
local Cache = {
    Lighting = {},
    Terrain = {},
    Parts = {},
    Particles = {},
    Textures = {},
    PostProcessing = {}
}

-- Safe execution wrapper
local function SafeExec(func)
    local s, e = pcall(func)
    if not s then warn("[CH3A5 HUB] Opt Error: " .. tostring(e)) end
end

-- Optimization Engine (20+ Functions)
local Opt = {}

function Opt.CacheDefaults()
    SafeExec(function()
        Cache.Lighting.GlobalShadows = Lighting.GlobalShadows
        Cache.Lighting.Brightness = Lighting.Brightness
        if Terrain then
            Cache.Terrain.WaterWaveSize = Terrain.WaterWaveSize
            Cache.Terrain.WaterWaveSpeed = Terrain.WaterWaveSpeed
            Cache.Terrain.WaterReflectance = Terrain.WaterReflectance
            Cache.Terrain.WaterTransparency = Terrain.WaterTransparency
            pcall(function() Cache.Terrain.Decoration = Terrain.Decoration end)
        end
    end)
end

function Opt.ToggleShadows(state)
    SafeExec(function()
        Lighting.GlobalShadows = not state
        task.spawn(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    if state then
                        if Cache.Parts[v] == nil then Cache.Parts[v] = {CastShadow = v.CastShadow} end
                        v.CastShadow = false
                    else
                        if Cache.Parts[v] and Cache.Parts[v].CastShadow ~= nil then
                            v.CastShadow = Cache.Parts[v].CastShadow
                        end
                    end
                end
                task.wait()
            end
        end)
    end)
end

function Opt.ToggleParticles(state)
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                if state then
                    if Cache.Particles[v] == nil then Cache.Particles[v] = v.Rate end
                    v.Rate = math.clamp(v.Rate / 5, 0, 5)
                else
                    if Cache.Particles[v] then v.Rate = Cache.Particles[v] end
                end
            end
            task.wait()
        end
    end)
end

function Opt.ToggleVFX(state)
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("Beam") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                if state then
                    if Cache.Particles[v] == nil then Cache.Particles[v] = v.Enabled end
                    v.Enabled = false
                else
                    if Cache.Particles[v] ~= nil then v.Enabled = Cache.Particles[v] end
                end
            end
            task.wait()
        end
    end)
end

function Opt.ToggleTextures(state)
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                if state then
                    if Cache.Textures[v] == nil then Cache.Textures[v] = v.Transparency end
                    v.Transparency = 1
                else
                    if Cache.Textures[v] ~= nil then v.Transparency = Cache.Textures[v] end
                end
            end
            task.wait()
        end
    end)
end

function Opt.ToggleMaterials(state)
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                if state then
                    if Cache.Parts[v] == nil then Cache.Parts[v] = {} end
                    if Cache.Parts[v].Material == nil then Cache.Parts[v].Material = v.Material end
                    v.Material = Enum.Material.SmoothPlastic
                else
                    if Cache.Parts[v] and Cache.Parts[v].Material then
                        v.Material = Cache.Parts[v].Material
                    end
                end
            end
            task.wait()
        end
    end)
end

function Opt.TogglePostProcessing(state)
    task.spawn(function()
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("BlurEffect") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") then
                if state then
                    if Cache.PostProcessing[v] == nil then Cache.PostProcessing[v] = v.Enabled end
                    v.Enabled = false
                else
                    if Cache.PostProcessing[v] ~= nil then v.Enabled = Cache.PostProcessing[v] end
                end
            end
        end
    end)
end

function Opt.ReduceLightingQuality(state)
    SafeExec(function()
        if state then
            Lighting.Brightness = 1
            pcall(function() Lighting.EnvironmentDiffuseScale = 0 end)
            pcall(function() Lighting.EnvironmentSpecularScale = 0 end)
        else
            Lighting.Brightness = Cache.Lighting.Brightness or 2
            pcall(function() Lighting.EnvironmentDiffuseScale = 1 end)
            pcall(function() Lighting.EnvironmentSpecularScale = 1 end)
        end
    end)
end

function Opt.OptimizeTerrain(state)
    if not Terrain then return end
    SafeExec(function()
        if state then
            pcall(function() Terrain.Decoration = false end)
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
        else
            if Cache.Terrain.Decoration ~= nil then pcall(function() Terrain.Decoration = Cache.Terrain.Decoration end) end
            Terrain.WaterWaveSize = Cache.Terrain.WaterWaveSize or 0.15
            Terrain.WaterWaveSpeed = Cache.Terrain.WaterWaveSpeed or 10
            Terrain.WaterReflectance = Cache.Terrain.WaterReflectance or 1
        end
    end)
end

function Opt.OptimizeWater(state)
    if not Terrain then return end
    SafeExec(function()
        if state then
            Terrain.WaterTransparency = 1
        else
            Terrain.WaterTransparency = Cache.Terrain.WaterTransparency or 0.3
        end
    end)
end

function Opt.ReduceRenderDistance(state)
    SafeExec(function()
        if state then
            Lighting.FogEnd = 500
        else
            Lighting.FogEnd = 100000
        end
    end)
end

function Opt.DisableLocalEffects(state)
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("Explosion") or v:IsA("ForceField") then
                if state then v.Visible = false else v.Visible = true end
            end
        end
    end)
end

function Opt.ReduceTransparencyCost(state)
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency > 0 and v.Transparency < 1 then
                if state then
                    if Cache.Parts[v] == nil then Cache.Parts[v] = {} end
                    if Cache.Parts[v].Transparency == nil then Cache.Parts[v].Transparency = v.Transparency end
                    v.Transparency = (v.Transparency > 0.5) and 1 or 0
                else
                    if Cache.Parts[v] and Cache.Parts[v].Transparency then
                        v.Transparency = Cache.Parts[v].Transparency
                    end
                end
            end
            task.wait()
        end
    end)
end

function Opt.LightweightUI(state)
    for _, el in pairs(ThemedElements) do
        if el.Obj:IsA("UIStroke") or el.Obj:IsA("UICorner") then
            el.Obj.Enabled = not state
        end
    end
end

-- Macros / Presets
function Opt.PerformanceMode()
    HubState.CurrentPreset = "Performance"
    Opt.ToggleShadows(true)
    Opt.TogglePostProcessing(true)
    Opt.OptimizeTerrain(true)
    Opt.ReduceLightingQuality(true)
end

function Opt.BatterySaver()
    HubState.CurrentPreset = "Battery Saver"
    Opt.ToggleShadows(true)
    Opt.ToggleParticles(true)
    Opt.ToggleVFX(true)
    Opt.ReduceRenderDistance(true)
    pcall(function() if setfpscap then setfpscap(30) end end)
end

function Opt.PotatoMode()
    HubState.CurrentPreset = "Potato"
    Opt.ToggleShadows(true)
    Opt.ToggleParticles(true)
    Opt.ToggleVFX(true)
    Opt.ToggleTextures(true)
    Opt.ToggleMaterials(true)
    Opt.TogglePostProcessing(true)
    Opt.ReduceLightingQuality(true)
    Opt.OptimizeTerrain(true)
    Opt.OptimizeWater(true)
    Opt.ReduceRenderDistance(true)
    Opt.ReduceTransparencyCost(true)
    Opt.DisableLocalEffects(true)
end

function Opt.UltraPerformance()
    HubState.CurrentPreset = "Ultra Performance"
    Opt.PotatoMode()
    Lighting.FogEnd = 200
end

function Opt.BalancedMode()
    HubState.CurrentPreset = "Balanced"
    Opt.ToggleShadows(false)
    Opt.TogglePostProcessing(true)
    Opt.OptimizeTerrain(true)
    Opt.ToggleMaterials(false)
    Opt.ToggleTextures(false)
    Lighting.FogEnd = 2000
    pcall(function() if setfpscap then setfpscap(60) end end)
end

function Opt.AutoOptimize()
    HubState.CurrentPreset = "Auto Optimized"
    local fps = workspace:GetRealPhysicsFPS()
    if fps < 30 then
        Opt.PotatoMode()
    elseif fps < 50 then
        Opt.PerformanceMode()
    else
        Opt.BalancedMode()
    end
end

function Opt.RestoreDefaults()
    HubState.CurrentPreset = "Default"
    Opt.ToggleShadows(false)
    Opt.ToggleParticles(false)
    Opt.ToggleVFX(false)
    Opt.ToggleTextures(false)
    Opt.ToggleMaterials(false)
    Opt.TogglePostProcessing(false)
    Opt.ReduceLightingQuality(false)
    Opt.OptimizeTerrain(false)
    Opt.OptimizeWater(false)
    Opt.ReduceRenderDistance(false)
    Opt.ReduceTransparencyCost(false)
    Opt.DisableLocalEffects(false)
    Opt.LightweightUI(false)
    pcall(function() if setfpscap then setfpscap(0) end end)
end

function Opt.FPSBoost()
    Opt.PotatoMode()
    HubState.CurrentPreset = "Max Boosted"
end

Opt.CacheDefaults()

-- UI Framework Engine
local function Tween(obj, props, time)
    if not HubState.AnimationsEnabled then
        for k, v in pairs(props) do obj[k] = v end
        return
    end
    TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

local function RegisterTheme(obj, prop, themeKey)
    table.insert(ThemedElements, {Obj = obj, Prop = prop, Key = themeKey})
    obj[prop] = CurrentTheme[themeKey]
end

local function UpdateTheme()
    for _, el in pairs(ThemedElements) do
        if el.Obj.Parent then
            Tween(el.Obj, {[el.Prop] = CurrentTheme[el.Key]}, 0.4)
        end
    end
end

local function Create(className, props, children)
    local inst = Instance.new(className)
    for k, v in pairs(props) do inst[k] = v end
    if children then
        for _, child in pairs(children) do child.Parent = inst end
    end
    return inst
end

-- GUI Initialization
local CH3A5_GUI = Create("ScreenGui", {
    Name = "CH3A5_PREMIUM_HUB",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true
})

-- Protected attachment
local s, _ = pcall(function() CH3A5_GUI.Parent = CoreGui end)
if not s then CH3A5_GUI.Parent = Player:WaitForChild("PlayerGui") end

-- Open Button
local OpenBtn = Create("TextButton", {
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0.5, -25, 0, -60),
    AnchorPoint = Vector2.new(0.5, 0),
    Text = "C",
    TextSize = 24,
    Font = Enum.Font.GothamBold,
    ClipsDescendants = true,
    AutoButtonColor = false
}, {
    Create("UICorner", {CornerRadius = UDim.new(1, 0)}),
    Create("UIStroke", {Thickness = 2, Color = CurrentTheme.Accent})
})
RegisterTheme(OpenBtn, "BackgroundColor3", "Panel")
RegisterTheme(OpenBtn, "TextColor3", "Accent")
OpenBtn.Parent = CH3A5_GUI

-- Drag logic for Open Button
local dragInput, dragStart, startPos
OpenBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = OpenBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragStart = nil end
        end)
    end
end)
OpenBtn.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragStart then
        local delta = input.Position - dragStart
        OpenBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Main Container
local MainContainer = Create("Frame", {
    Size = UDim2.new(0.85, 0, 0.85, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    ClipsDescendants = true,
    GroupTransparency = 1,
    Visible = false
}, {
    Create("UICorner", {CornerRadius = UDim.new(0, 12)}),
    Create("UISizeConstraint", {MaxSize = Vector2.new(900, 600), MinSize = Vector2.new(300, 400)})
})
RegisterTheme(MainContainer, "BackgroundColor3", "Bg")
MainContainer.Parent = CH3A5_GUI

local MainUIScale = Create("UIScale", {Scale = 1})
MainUIScale.Parent = MainContainer

-- Sidebar
local Sidebar = Create("Frame", {
    Size = UDim2.new(0, 160, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0
})
RegisterTheme(Sidebar, "BackgroundColor3", "Panel")
Sidebar.Parent = MainContainer

local LogoText = Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 60),
    BackgroundTransparency = 1,
    Text = "CH3A5\nHUB",
    Font = Enum.Font.GothamBlack,
    TextSize = 18,
    RichText = true
})
RegisterTheme(LogoText, "TextColor3", "Accent")
LogoText.Parent = Sidebar

local SidebarScroll = Create("ScrollingFrame", {
    Size = UDim2.new(1, 0, 1, -70),
    Position = UDim2.new(0, 0, 0, 70),
    BackgroundTransparency = 1,
    ScrollBarThickness = 0,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y
}, {
    Create("UIListLayout", {Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center}),
    Create("UIPadding", {PaddingTop = UDim.new(0, 5)})
})
SidebarScroll.Parent = Sidebar

-- Content Area
local ContentArea = Create("Frame", {
    Size = UDim2.new(1, -160, 1, 0),
    Position = UDim2.new(0, 160, 0, 0),
    BackgroundTransparency = 1
})
ContentArea.Parent = MainContainer

local Pages = {}
local NavButtons = {}
local CurrentPage = nil

local function SwitchPage(name)
    if CurrentPage == name then return end
    if CurrentPage and Pages[CurrentPage] then
        Tween(Pages[CurrentPage], {GroupTransparency = 1}, 0.2)
        task.delay(0.2, function() if Pages[CurrentPage] then Pages[CurrentPage].Visible = false end end)
    end
    CurrentPage = name
    if Pages[name] then
        Pages[name].Visible = true
        Tween(Pages[name], {GroupTransparency = 0}, 0.3)
    end
    for btnName, btn in pairs(NavButtons) do
        if btnName == name then
            Tween(btn, {BackgroundTransparency = 0.8}, 0.2)
        else
            Tween(btn, {BackgroundTransparency = 1}, 0.2)
        end
    end
end

local function CreatePage(name, icon)
    -- Nav Button
    local btn = Create("TextButton", {
        Size = UDim2.new(0.9, 0, 0, 40),
        BackgroundTransparency = 1,
        Text = "  " .. icon .. "  " .. name,
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 8)})
    })
    RegisterTheme(btn, "TextColor3", "Text")
    RegisterTheme(btn, "BackgroundColor3", "Accent")
    btn.Parent = SidebarScroll
    
    btn.MouseButton1Click:Connect(function() SwitchPage(name) end)
    NavButtons[name] = btn

    -- Page Container
    local page = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        Visible = false,
        GroupTransparency = 1,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    }, {
        Create("UIListLayout", {Padding = UDim.new(0, 10), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}),
        Create("UIPadding", {PaddingTop = UDim.new(0, 20), PaddingBottom = UDim.new(0, 20), PaddingLeft = UDim.new(0, 15), PaddingRight = UDim.new(0, 15)})
    })
    RegisterTheme(page, "ScrollBarImageColor3", "Accent")
    page.Parent = ContentArea
    Pages[name] = page
    return page
end

-- UI Components
local function CreateTitle(parent, text, sub)
    local frame = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1
    })
    local t1 = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamBold,
        TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    RegisterTheme(t1, "TextColor3", "Accent")
    t1.Parent = frame
    
    if sub then
        local t2 = Create("TextLabel", {
            Size = UDim2.new(1, 0, 0, 20),
            Position = UDim2.new(0, 0, 0, 30),
            BackgroundTransparency = 1,
            Text = sub,
            Font = Enum.Font.Gotham,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        RegisterTheme(t2, "TextColor3", "Sub")
        t2.Parent = frame
    end
    frame.Parent = parent
end

local function CreateButton(parent, text, callback)
    local btn = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 45),
        Text = text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 15,
        AutoButtonColor = false
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 8)})
    })
    RegisterTheme(btn, "BackgroundColor3", "Panel")
    RegisterTheme(btn, "TextColor3", "Text")
    
    btn.MouseEnter:Connect(function() Tween(btn, {BackgroundTransparency = 0.2}, 0.2) end)
    btn.MouseLeave:Connect(function() Tween(btn, {BackgroundTransparency = 0}, 0.2) end)
    btn.MouseButton1Click:Connect(function()
        Tween(btn, {Size = UDim2.new(0.98, 0, 0, 43)}, 0.1)
        task.wait(0.1)
        Tween(btn, {Size = UDim2.new(1, 0, 0, 45)}, 0.1)
        callback()
    end)
    btn.Parent = parent
    return btn
end

local function CreateToggle(parent, text, callback)
    local state = false
    local frame = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1
    })
    local label = Create("TextLabel", {
        Size = UDim2.new(0.7, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    RegisterTheme(label, "TextColor3", "Text")
    label.Parent = frame
    
    local toggleBg = Create("TextButton", {
        Size = UDim2.new(0, 50, 0, 26),
        Position = UDim2.new(1, -50, 0.5, -13),
        Text = "",
        BackgroundColor3 = Color3.fromRGB(100, 100, 100),
        AutoButtonColor = false
    }, { Create("UICorner", {CornerRadius = UDim.new(1, 0)}) })
    
    local circle = Create("Frame", {
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 3, 0.5, -10),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    }, { Create("UICorner", {CornerRadius = UDim.new(1, 0)}) })
    circle.Parent = toggleBg
    toggleBg.Parent = frame
    
    toggleBg.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        if state then
            Tween(circle, {Position = UDim2.new(1, -23, 0.5, -10)}, 0.3)
            Tween(toggleBg, {BackgroundColor3 = CurrentTheme.Accent}, 0.3)
            RegisterTheme(toggleBg, "BackgroundColor3", "Accent")
        else
            Tween(circle, {Position = UDim2.new(0, 3, 0.5, -10)}, 0.3)
            for i, el in ipairs(ThemedElements) do
                if el.Obj == toggleBg then table.remove(ThemedElements, i) break end
            end
            Tween(toggleBg, {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}, 0.3)
        end
    end)
    frame.Parent = parent
end

-- Building Pages
local pHome = CreatePage("HOME", "🏠")
CreateTitle(pHome, "CH3A5 PREMIUM HUB", "អង្គរ • បច្ចេកវិទ្យា • ប្រសិទ្ធភាព")

local StatusFrame = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 80),
    BackgroundTransparency = 1
}, { Create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10)}) })

local function CreateStatus(title, val)
    local f = Create("Frame", { Size = UDim2.new(0.48, 0, 1, 0) }, { Create("UICorner", {CornerRadius = UDim.new(0, 8)}) })
    RegisterTheme(f, "BackgroundColor3", "Panel")
    local t = Create("TextLabel", {Size = UDim2.new(1, 0, 0.4, 0), Text = title, Font = Enum.Font.Gotham, TextSize = 12, BackgroundTransparency = 1})
    local v = Create("TextLabel", {Size = UDim2.new(1, 0, 0.6, 0), Position = UDim2.new(0,0,0.4,0), Text = val, Font = Enum.Font.GothamBold, TextSize = 18, BackgroundTransparency = 1})
    RegisterTheme(t, "TextColor3", "Sub")
    RegisterTheme(v, "TextColor3", "Accent")
    t.Parent = f; v.Parent = f; f.Parent = StatusFrame
    return v
end

local FPSLabel = CreateStatus("CURRENT FPS", "60")
local PresetLabel = CreateStatus("CURRENT PRESET", "Default")
StatusFrame.Parent = pHome

local lastTime = tick()
local frames = 0
RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - lastTime >= 1 then
        if FPSLabel.Parent then FPSLabel.Text = tostring(frames) end
        if PresetLabel.Parent then PresetLabel.Text = HubState.CurrentPreset end
        frames = 0
        lastTime = tick()
    end
end)

CreateButton(pHome, "🚀 INSTANT FPS BOOST", function() Opt.FPSBoost() end)
CreateButton(pHome, "⚡ AUTO OPTIMIZE", function() Opt.AutoOptimize() end)
CreateButton(pHome, "🔄 RESTORE DEFAULTS", function() Opt.RestoreDefaults() end)

local pBoost = CreatePage("FPS BOOST", "🚀")
CreateTitle(pBoost, "OPTIMIZATION PRESETS", "Quickly apply balanced settings based on your needs.")
CreateButton(pBoost, "Max FPS Boost", function() Opt.FPSBoost() end)
CreateButton(pBoost, "Auto Optimize", function() Opt.AutoOptimize() end)
CreateButton(pBoost, "Balanced Mode", function() Opt.BalancedMode() end)
CreateButton(pBoost, "Performance Mode", function() Opt.PerformanceMode() end)
CreateButton(pBoost, "Ultra Performance", function() Opt.UltraPerformance() end)
CreateButton(pBoost, "Potato Mode (Max FPS)", function() Opt.PotatoMode() end)

local pGraph = CreatePage("GRAPHICS", "🎮")
CreateTitle(pGraph, "GRAPHICS SETTINGS", "Fine-tune individual rendering elements.")
CreateToggle(pGraph, "Disable Shadows", function(s) Opt.ToggleShadows(s) end)
CreateToggle(pGraph, "Reduce Particle Effects", function(s) Opt.ToggleParticles(s) end)
CreateToggle(pGraph, "Disable Visual Effects (Fire, Smoke)", function(s) Opt.ToggleVFX(s) end)
CreateToggle(pGraph, "Remove Textures/Decals", function(s) Opt.ToggleTextures(s) end)
CreateToggle(pGraph, "Lowest Material Quality", function(s) Opt.ToggleMaterials(s) end)
CreateToggle(pGraph, "Disable Post Processing", function(s) Opt.TogglePostProcessing(s) end)
CreateToggle(pGraph, "Reduce Lighting Quality", function(s) Opt.ReduceLightingQuality(s) end)
CreateToggle(pGraph, "Optimize Terrain Rendering", function(s) Opt.OptimizeTerrain(s) end)
CreateToggle(pGraph, "Reduce Water Quality", function(s) Opt.OptimizeWater(s) end)

local pPerf = CreatePage("PERFORMANCE", "⚡")
CreateTitle(pPerf, "ADVANCED PERFORMANCE", "System-level visual downgrades for low-end devices.")
CreateToggle(pPerf, "Reduce Render Distance (Fog Trick)", function(s) Opt.ReduceRenderDistance(s) end)
CreateToggle(pPerf, "Disable Unnecessary Local Effects", function(s) Opt.DisableLocalEffects(s) end)
CreateToggle(pPerf, "Reduce Transparency Cost", function(s) Opt.ReduceTransparencyCost(s) end)
CreateToggle(pPerf, "Lightweight UI Mode", function(s) Opt.LightweightUI(s) end)
CreateButton(pPerf, "Battery Saver Mode", function() Opt.BatterySaver() end)

local pThemes = CreatePage("THEMES", "🎨")
CreateTitle(pThemes, "THEME SELECTOR", "Customize the look of CH3A5 Premium Hub.")

local ThemeGrid = Create("Frame", {
    Size = UDim2.new(1, 0, 0, 0),
    BackgroundTransparency = 1,
    AutomaticSize = Enum.AutomaticSize.Y
}, {
    Create("UIGridLayout", {
        CellSize = UDim2.new(0, 130, 0, 80),
        CellPadding = UDim2.new(0, 10, 0, 10),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.Name
    })
})

for tName, tColors in pairs(Themes) do
    local tBtn = Create("TextButton", {
        Name = tName,
        BackgroundColor3 = tColors.Panel,
        Text = "",
        AutoButtonColor = false
    }, { Create("UICorner", {CornerRadius = UDim.new(0, 8)}) })
    
    local cPrev = Create("Frame", {
        Size = UDim2.new(0.6, 0, 0, 4),
        Position = UDim2.new(0.2, 0, 0.2, 0),
        BackgroundColor3 = tColors.Accent,
        BorderSizePixel = 0
    }, { Create("UICorner", {CornerRadius = UDim.new(1, 0)}) })
    cPrev.Parent = tBtn
    
    local tLbl = Create("TextLabel", {
        Size = UDim2.new(1, 0, 0.5, 0),
        Position = UDim2.new(0, 0, 0.4, 0),
        BackgroundTransparency = 1,
        Text = tName,
        TextColor3 = tColors.Text,
        Font = Enum.Font.GothamSemibold,
        TextSize = 12
    })
    tLbl.Parent = tBtn
    tBtn.Parent = ThemeGrid
    
    tBtn.MouseButton1Click:Connect(function()
        CurrentThemeName = tName
        CurrentTheme = Themes[tName]
        UpdateTheme()
    end)
end
ThemeGrid.Parent = pThemes

local pSettings = CreatePage("SETTINGS", "⚙️")
CreateTitle(pSettings, "HUB SETTINGS", "Configure application behavior.")
CreateToggle(pSettings, "Disable Animations", function(s) HubState.AnimationsEnabled = not s end)
CreateButton(pSettings, "Reset Hub Settings", function() HubState.AnimationsEnabled = true; MainUIScale.Scale = 1 end)
CreateButton(pSettings, "Close Menu", function()
    HubState.MenuOpen = false
    Tween(MainContainer, {Size = UDim2.new(0.8, 0, 0.8, 0), GroupTransparency = 1}, 0.3)
    task.wait(0.3)
    MainContainer.Visible = false
    Tween(OpenBtn, {Position = UDim2.new(0.5, -25, 0, 10)}, 0.4)
end)

local pAbout = CreatePage("ABOUT", "ℹ️")
CreateTitle(pAbout, "ABOUT", "Information about this utility.")
local abtTxt = Create("TextLabel", {
    Size = UDim2.new(1, 0, 0, 150),
    BackgroundTransparency = 1,
    Text = "CH3A5 PREMIUM HUB\nVersion 1.0.0\n\nA professional client-side optimization toolkit designed for maximum performance without exploiting.\n\nMade by CH3A5",
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top
})
RegisterTheme(abtTxt, "TextColor3", "Sub")
abtTxt.Parent = pAbout

-- Close/Open Logic
OpenBtn.MouseButton1Click:Connect(function()
    if dragStart then return end -- Prevent opening if it was a drag
    if HubState.MenuOpen then return end
    HubState.MenuOpen = true
    MainContainer.Visible = true
    MainContainer.Size = UDim2.new(0.7, 0, 0.7, 0)
    Tween(MainContainer, {Size = UDim2.new(0.85, 0, 0.85, 0), GroupTransparency = 0}, 0.4)
    Tween(OpenBtn, {Position = UDim2.new(0.5, -25, 0, -60)}, 0.3)
end)

-- Responsive Design Engine
local function HandleResize()
    local cam = Workspace.CurrentCamera
    if not cam then return end
    local width = cam.ViewportSize.X
    
    if width < 600 then
        -- Mobile Layout
        Sidebar.Size = UDim2.new(0, 55, 1, 0)
        ContentArea.Size = UDim2.new(1, -55, 1, 0)
        ContentArea.Position = UDim2.new(0, 55, 0, 0)
        LogoText.Text = "C"
        LogoText.TextSize = 24
        for _, btn in pairs(NavButtons) do
            local icon = btn.Text:match("(%S+)")
            btn.Text = icon
            btn.TextXAlignment = Enum.TextXAlignment.Center
        end
    else
        -- Tablet / Desktop Layout
        Sidebar.Size = UDim2.new(0, 160, 1, 0)
        ContentArea.Size = UDim2.new(1, -160, 1, 0)
        ContentArea.Position = UDim2.new(0, 160, 0, 0)
        LogoText.Text = "CH3A5\nHUB"
        LogoText.TextSize = 18
        for name, btn in pairs(NavButtons) do
            local icon = ""
            if name == "HOME" then icon = "🏠"
            elseif name == "FPS BOOST" then icon = "🚀"
            elseif name == "GRAPHICS" then icon = "🎮"
            elseif name == "PERFORMANCE" then icon = "⚡"
            elseif name == "THEMES" then icon = "🎨"
            elseif name == "SETTINGS" then icon = "⚙️"
            elseif name == "ABOUT" then icon = "ℹ️" end
            btn.Text = "  " .. icon .. "  " .. name
            btn.TextXAlignment = Enum.TextXAlignment.Left
        end
    end
end

Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(HandleResize)
HandleResize() -- Initial Call

-- Start
SwitchPage("HOME")
Tween(OpenBtn, {Position = UDim2.new(0.5, -25, 0, 10)}, 0.8) -- Initial enter animation
