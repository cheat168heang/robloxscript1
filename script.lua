-- Modern Hacker Vibe UI
-- Roblox Studio / LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "ModernHackerUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Window
local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(620, 380)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(10, 12, 15)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

-- Stroke
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(35, 255, 130)
stroke.Transparency = 0.65
stroke.Thickness = 1
stroke.Parent = main

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 50)
title.Position = UDim2.fromOffset(20, 10)
title.BackgroundTransparency = 1
title.Text = ">_ TOATOA HUB"
title.TextColor3 = Color3.fromRGB(35, 255, 130)
title.Font = Enum.Font.Code
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.fromOffset(130, 30)
status.Position = UDim2.new(1, -150, 0, 20)
status.BackgroundTransparency = 1
status.Text = "● ONLINE"
status.TextColor3 = Color3.fromRGB(35, 255, 130)
status.Font = Enum.Font.Code
status.TextSize = 14
status.Parent = main

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.fromOffset(150, 300)
sidebar.Position = UDim2.fromOffset(15, 70)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 18, 22)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sidebar

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.Parent = sidebar

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 15)
padding.Parent = sidebar

local function createButton(text)
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(125, 42)
    button.BackgroundColor3 = Color3.fromRGB(20, 24, 29)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(180, 190, 195)
    button.Font = Enum.Font.Code
    button.TextSize = 15
    button.AutoButtonColor = false
    button.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Color3.fromRGB(25, 45, 35),
                TextColor3 = Color3.fromRGB(35, 255, 130)
            }
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Color3.fromRGB(20, 24, 29),
                TextColor3 = Color3.fromRGB(180, 190, 195)
            }
        ):Play()
    end)

    return button
end

createButton("▣  Dashboard")
createButton("◈  Games")
createButton("⌘  Scripts")
createButton("⚙  Settings")

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -190, 1, -85)
content.Position = UDim2.fromOffset(180, 70)
content.BackgroundTransparency = 1
content.Parent = main

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundTransparency = 1
header.Text = "SYSTEM STATUS"
header.TextColor3 = Color3.fromRGB(230, 235, 235)
header.Font = Enum.Font.Code
header.TextSize = 18
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = content

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, 0, 0, 100)
info.Position = UDim2.fromOffset(0, 45)
info.BackgroundColor3 = Color3.fromRGB(15, 18, 22)
info.BorderSizePixel = 0
info.Text = "\n  ROBLOX CONNECTION     ONLINE\n\n  CLIENT STATUS          READY"
info.TextColor3 = Color3.fromRGB(35, 255, 130)
info.Font = Enum.Font.Code
info.TextSize = 14
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextYAlignment = Enum.TextYAlignment.Top
info.Parent = content

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 10)
infoCorner.Parent = info

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.Text = "v1.0  //  secure interface"
footer.TextColor3 = Color3.fromRGB(90, 100, 105)
footer.Font = Enum.Font.Code
footer.TextSize = 12
footer.TextXAlignment = Enum.TextXAlignment.Left
footer.Parent = content
