--[[
	╔════════════════════════════════════════════════════════════════╗
	║                      CH3A5 PREMIUM HUB                         ║
	║           Khmer Angkor Edition · Client FPS Optimizer          ║
	╚════════════════════════════════════════════════════════════════╝

	Run as a LocalScript (e.g. StarterPlayer > StarterPlayerScripts).

	SCOPE (strictly enforced by design):
	  • Only changes how THIS client renders (quality level, shadows, particles,
	    lighting, terrain/water visuals, fog distance, etc.).
	  • Never touches RemoteEvents / RemoteFunctions, the server, other players,
	    stats, currency, inventory, movement, combat or any game logic.
	  • No arbitrary code execution, no loops running in the background.
	  • Every optimization stores the original value and restores it when
	    switched OFF (only if the game has not changed that value meanwhile).
	  • Gameplay-relevant visuals (blur, color correction, smoke, large
	    volumetric particles, character appearance) are intentionally untouched
	    so the tool can never act as a visibility advantage.
]]

------------------------------------------------------------------------
-- 0. BOOTSTRAP
------------------------------------------------------------------------
local RunService = game:GetService("RunService")
if not RunService:IsClient() then
	warn("[CH3A5 PREMIUM HUB] This script must run on the client (LocalScript).")
	return
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
	task.wait()
	LocalPlayer = Players.LocalPlayer
end
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove a previous instance of the hub (re-running the script is safe).
local CLEANUP_KEY = "__CH3A5_PREMIUM_HUB_CLEANUP"
if type(shared[CLEANUP_KEY]) == "function" then
	pcall(shared[CLEANUP_KEY])
end
local oldGui = PlayerGui:FindFirstChild("CH3A5_PremiumHub")
if oldGui then
	oldGui:Destroy()
end

------------------------------------------------------------------------
-- 1. CONFIG / THEME / STATE
------------------------------------------------------------------------
local CONFIG = {
	Title = "CH3A5 PREMIUM HUB",
	Version = "1.0.0",
	GuiName = "CH3A5_PremiumHub",
	ToggleKey = Enum.KeyCode.RightShift,
	DefaultLevel = 5,
	DefaultDistance = 1200,
	MinW = 280, MinH = 250, MaxW = 600, MaxH = 470,
}

local Theme = {
	BG = Color3.fromRGB(13, 13, 18),
	BGTop = Color3.fromRGB(27, 24, 29),
	Card = Color3.fromRGB(22, 22, 29),
	CardHover = Color3.fromRGB(32, 31, 40),
	Gold = Color3.fromRGB(214, 176, 96),
	GoldDark = Color3.fromRGB(140, 108, 54),
	Text = Color3.fromRGB(238, 232, 218),
	Muted = Color3.fromRGB(150, 146, 138),
	Off = Color3.fromRGB(52, 52, 63),
	Good = Color3.fromRGB(116, 196, 140),
	Bad = Color3.fromRGB(205, 92, 80),
}

local State = {
	on = {},               -- [featureId] = bool
	activePreset = nil,    -- "balanced" | "performance" | ...
	autoOn = false,
	measuring = false,
	level = CONFIG.DefaultLevel,
	dist = CONFIG.DefaultDistance,
	-- hub settings
	anim = true,
	lightUI = false,
	lightUIByPreset = false,
	khmer = true,
	keyToggle = true,
	closeAfterPreset = false,
	uiScale = 1,
	-- runtime
	open = false,
	page = "HOME",
	scale = 1,
}

-- Late-bound UI hooks (assigned after the interface is built).
local UI = {
	notify = function() end,
	refresh = function() end,
	applyLightUI = function() end,
	close = function() end,
}

-- Global connections that must be cleaned up (UI connections die with the GUI).
local Connections = {}
local function track(conn)
	Connections[#Connections + 1] = conn
	return conn
end

------------------------------------------------------------------------
-- 2. SMALL HELPERS
------------------------------------------------------------------------
local function create(className, props, children)
	local inst = Instance.new(className)
	local parent
	if props then
		for k, v in pairs(props) do
			if k == "Parent" then
				parent = v
			else
				inst[k] = v
			end
		end
	end
	if children then
		for _, c in ipairs(children) do
			c.Parent = inst
		end
	end
	if parent then
		inst.Parent = parent
	end
	return inst
end

local function corner(parent, radius)
	return create("UICorner", { CornerRadius = UDim.new(0, radius), Parent = parent })
end

local function stroke(parent, color, thickness, transparency)
	return create("UIStroke", {
		Color = color,
		Thickness = thickness or 1,
		Transparency = transparency or 0.5,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = parent,
	})
end

local function padding(parent, t, r, b, l)
	return create("UIPadding", {
		PaddingTop = UDim.new(0, t), PaddingRight = UDim.new(0, r),
		PaddingBottom = UDim.new(0, b), PaddingLeft = UDim.new(0, l),
		Parent = parent,
	})
end

local function listLayout(parent, gap, dir)
	return create("UIListLayout", {
		Padding = UDim.new(0, gap or 0),
		FillDirection = dir or Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = parent,
	})
end

local function makeLabel(props)
	local p = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Font = Enum.Font.GothamMedium,
		TextColor3 = Theme.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextWrapped = true,
	}
	for k, v in pairs(props) do
		p[k] = v
	end
	return create("TextLabel", p)
end

-- Per-parent layout order counter (keeps creation order inside lists).
local function nextOrder(parent)
	local n = (parent:GetAttribute("n") or 0) + 1
	parent:SetAttribute("n", n)
	return n
end

local function animEnabled()
	return State.anim and not State.lightUI
end

-- Lightweight tween helper; falls back to direct assignment when animations are off.
local function tween(obj, duration, props, style, dir)
	if not obj then
		return nil
	end
	if animEnabled() and duration > 0 and obj:IsDescendantOf(game) then
		local t = TweenService:Create(obj, TweenInfo.new(duration, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
		t:Play()
		return t
	end
	for k, v in pairs(props) do
		obj[k] = v
	end
	return nil
end

local function isCharacterDescendant(inst)
	local p = inst.Parent
	while p and p ~= Workspace do
		if p:IsA("Model") and Players:GetPlayerFromCharacter(p) then
			return true
		end
		p = p.Parent
	end
	return false
end

local function maxSequenceValue(seq)
	local m = 0
	for _, kp in ipairs(seq.Keypoints) do
		if kp.Value > m then
			m = kp.Value
		end
	end
	return m
end

------------------------------------------------------------------------
-- 3. INSTANCE OPTIMIZER (batched, event-driven, leak-free)
--    One shared scan + one DescendantAdded hook for ALL active rules.
------------------------------------------------------------------------
local Opt = { rules = {}, activeList = {}, conns = {}, scanning = false, dirty = false }

-- rule: { classes = {ClassName=true} | parts = true, prop, value | valueFn, test, skipChars }
local function newRule(def)
	def.active = false
	def.pending = false
	def.orig = setmetatable({}, { __mode = "k" }) -- weak keys: destroyed instances are collected
	def.apply = function(inst)
		local old = inst[def.prop]
		local new
		if def.valueFn then
			new = def.valueFn(old)
		else
			new = def.value
		end
		if old == new then
			return nil
		end
		inst[def.prop] = new
		return { old, new }
	end
	Opt.rules[#Opt.rules + 1] = def
	return def
end

local function ruleMatches(rule, inst, cls, isPart)
	if rule.classes then
		if not rule.classes[cls] then
			return false
		end
	elseif rule.parts then
		if not isPart or cls == "Terrain" then
			return false
		end
	else
		return false
	end
	if rule.skipChars and isCharacterDescendant(inst) then
		return false
	end
	if rule.test and not rule.test(inst) then
		return false
	end
	return true
end

local function processInstance(inst, rules)
	local cls = inst.ClassName
	local isPart = inst:IsA("BasePart")
	for i = 1, #rules do
		local rule = rules[i]
		if rule.active and rule.orig[inst] == nil and ruleMatches(rule, inst, cls, isPart) then
			local ok, packed = pcall(rule.apply, inst)
			if ok and packed then
				rule.orig[inst] = packed
			end
		end
	end
end

local function restoreRule(rule)
	for inst, packed in pairs(rule.orig) do
		pcall(function()
			-- Only restore if the game has not changed the value since we set it.
			if inst[rule.prop] == packed[2] then
				inst[rule.prop] = packed[1]
			end
		end)
		rule.orig[inst] = nil
	end
end

function Opt.connect()
	if #Opt.conns > 0 then
		return
	end
	for _, root in ipairs({ Workspace, Lighting }) do
		Opt.conns[#Opt.conns + 1] = root.DescendantAdded:Connect(function(inst)
			processInstance(inst, Opt.activeList)
		end)
	end
end

function Opt.disconnect()
	for _, c in ipairs(Opt.conns) do
		c:Disconnect()
	end
	Opt.conns = {}
end

function Opt.refreshActive()
	local list = {}
	for _, r in ipairs(Opt.rules) do
		if r.active then
			list[#list + 1] = r
		end
	end
	Opt.activeList = list
	if #list > 0 then
		Opt.connect()
	else
		Opt.disconnect()
	end
end

-- Time-sliced scan of existing instances (max ~4ms per frame).
function Opt.requestScan()
	if Opt.scanning then
		Opt.dirty = true
		return
	end
	Opt.scanning = true
	task.defer(function() -- defer so presets can enable several rules first
		repeat
			Opt.dirty = false
			local pend = {}
			for _, r in ipairs(Opt.rules) do
				if r.active and r.pending then
					r.pending = false
					pend[#pend + 1] = r
				end
			end
			if #pend > 0 then
				local t0, n = os.clock(), 0
				for _, root in ipairs({ Workspace, Lighting }) do
					for _, inst in ipairs(root:GetDescendants()) do
						processInstance(inst, pend)
						n += 1
						if n % 128 == 0 and os.clock() - t0 > 0.004 then
							task.wait()
							t0 = os.clock()
							local anyActive = false
							for _, r in ipairs(pend) do
								if r.active then
									anyActive = true
									break
								end
							end
							if not anyActive then
								break
							end
						end
					end
				end
			end
		until not Opt.dirty
		Opt.scanning = false
	end)
end

function Opt.enableRule(rule)
	if rule.active then
		return
	end
	rule.active = true
	rule.pending = true
	Opt.refreshActive()
	Opt.requestScan()
end

function Opt.disableRule(rule)
	if not rule.active and next(rule.orig) == nil then
		return
	end
	rule.active = false
	rule.pending = false
	restoreRule(rule)
	Opt.refreshActive()
end

------------------------------------------------------------------------
-- 4. GLOBAL PROPERTY GROUPS (Lighting / Terrain / Rendering settings)
------------------------------------------------------------------------
local function safeGet(fn)
	local ok, res = pcall(fn)
	if ok then
		return res
	end
	return nil
end

local function getRendering() return safeGet(function() return settings().Rendering end) end
local function getUserGameSettings() return safeGet(function() return UserSettings():GetService("UserGameSettings") end) end
local function getTerrain() return Workspace:FindFirstChildOfClass("Terrain") end
local function getMaterialService() return safeGet(function() return game:GetService("MaterialService") end) end
local function getLighting() return Lighting end

-- Saves the original values on first enable, restores them on disable.
local function newGlobal(getObj, getValues)
	local g = { saved = nil }
	function g.enable()
		local obj = getObj()
		if not obj then
			return false
		end
		local values = getValues(g.saved)
		g.saved = g.saved or {}
		local wroteAny, hadValues = false, false
		for prop, val in pairs(values) do
			hadValues = true
			if g.saved[prop] == nil then
				local ok, cur = pcall(function() return obj[prop] end)
				if ok then
					g.saved[prop] = { cur }
				end
			end
			if pcall(function() obj[prop] = val end) then
				wroteAny = true
			end
		end
		return wroteAny or not hadValues
	end
	function g.disable()
		local obj = getObj()
		if obj and g.saved then
			for prop, packed in pairs(g.saved) do
				pcall(function() obj[prop] = packed[1] end)
			end
		end
		g.saved = nil
	end
	return g
end

local function qualityEnum(n)
	n = math.clamp(math.floor(n), 1, 10)
	return Enum.QualityLevel[string.format("Level%02d", n)]
end

------------------------------------------------------------------------
-- 5. FEATURES (each independently toggleable)
------------------------------------------------------------------------
local Features, FeatureById = {}, {}

local function defineFeature(def)
	def.apply = function(on)
		for _, r in ipairs(def.rules or {}) do
			if on then Opt.enableRule(r) else Opt.disableRule(r) end
		end
		local supported = true
		local globals = def.globals or {}
		if on then
			local anyOk = (#globals == 0)
			for _, g in ipairs(globals) do
				if g.enable() then
					anyOk = true
				end
			end
			supported = anyOk or (def.rules ~= nil and #def.rules > 0)
		else
			for _, g in ipairs(globals) do
				g.disable()
			end
		end
		return supported
	end
	Features[#Features + 1] = def
	FeatureById[def.id] = def
end

-- Rules ---------------------------------------------------------------
local ruleShadowParts = newRule({ parts = true, skipChars = true, prop = "CastShadow", value = false })
local ruleShadowLights = newRule({ classes = { PointLight = true, SpotLight = true, SurfaceLight = true }, prop = "Shadows", value = false })
local ruleParticles = newRule({
	classes = { ParticleEmitter = true }, prop = "Rate",
	-- Large/volumetric emitters (e.g. smoke screens) are left untouched on purpose.
	test = function(i) return maxSequenceValue(i.Size) < 6 end,
	valueFn = function(old) return old * 0.25 end,
})
local ruleVisual = newRule({ classes = { Beam = true, Trail = true, Highlight = true }, prop = "Enabled", value = false })
local ruleLocalFx = newRule({
	classes = { Fire = true, Sparkles = true }, prop = "Enabled", value = false,
	test = function(i) return i.ClassName ~= "Fire" or i.Size < 12 end,
})
local ruleDecals = newRule({ classes = { Decal = true, Texture = true }, skipChars = true, prop = "Transparency", value = 1 })
local ruleReflect = newRule({ parts = true, skipChars = true, prop = "Reflectance", value = 0 })
local rulePostFx = newRule({ classes = { BloomEffect = true, SunRaysEffect = true, DepthOfFieldEffect = true }, prop = "Enabled", value = false })
local ruleMesh = newRule({
	classes = { MeshPart = true, UnionOperation = true }, skipChars = true,
	prop = "RenderFidelity", value = Enum.RenderFidelity.Performance,
})
local ruleTransparency = newRule({
	parts = true, skipChars = true, prop = "Transparency", value = 1,
	test = function(i) return i.Transparency >= 0.85 and i.Transparency < 1 end,
})

-- Features -------------------------------------------------------------
defineFeature({
	id = "lowGraphics", tab = "GRAPHICS", param = true,
	name = "Low Graphics Mode",
	desc = "Lowers the client graphics quality level (choose the level in Performance).",
	globals = { newGlobal(getRendering, function() return { QualityLevel = qualityEnum(State.level) } end) },
})
defineFeature({
	id = "shadows", tab = "GRAPHICS",
	name = "Disable Shadows",
	desc = "Turns off global, part and light shadows locally.",
	rules = { ruleShadowParts, ruleShadowLights },
	globals = { newGlobal(getLighting, function() return { GlobalShadows = false } end) },
})
defineFeature({
	id = "particles", tab = "GRAPHICS",
	name = "Reduce Particle Effects",
	desc = "Cuts small particle emission to 25%. Large volumetric effects stay as they are.",
	rules = { ruleParticles },
})
defineFeature({
	id = "visualFx", tab = "GRAPHICS",
	name = "Reduce Visual Effects",
	desc = "Disables local beams, trails and highlights.",
	rules = { ruleVisual },
})
defineFeature({
	id = "textures", tab = "GRAPHICS",
	name = "Reduce Texture Quality",
	desc = "Hides world decals and tiled textures to reduce texture load.",
	rules = { ruleDecals },
})
defineFeature({
	id = "materials", tab = "GRAPHICS",
	name = "Reduce Material Quality",
	desc = "Removes reflections and legacy 2022 material detail. Visual only, physics unchanged.",
	rules = { ruleReflect },
	globals = { newGlobal(getMaterialService, function() return { Use2022Materials = false } end) },
})
defineFeature({
	id = "postfx", tab = "GRAPHICS",
	name = "Disable Post-Processing",
	desc = "Turns off bloom, sun rays and depth of field. Blur and color tint are kept.",
	rules = { rulePostFx },
})
defineFeature({
	id = "lighting", tab = "GRAPHICS",
	name = "Reduce Lighting Quality",
	desc = "Removes environment specular reflections and soft shadow edges.",
	globals = { newGlobal(getLighting, function() return { EnvironmentSpecularScale = 0, ShadowSoftness = 0 } end) },
})
defineFeature({
	id = "terrain", tab = "GRAPHICS",
	name = "Optimize Terrain Rendering",
	desc = "Turns off terrain decoration such as grass.",
	globals = { newGlobal(getTerrain, function() return { Decoration = false } end) },
})
defineFeature({
	id = "water", tab = "GRAPHICS",
	name = "Optimize Water Visuals",
	desc = "Flattens water waves and removes water reflections.",
	globals = { newGlobal(getTerrain, function() return { WaterWaveSize = 0, WaterWaveSpeed = 0, WaterReflectance = 0 } end) },
})
defineFeature({
	id = "renderDist", tab = "PERFORMANCE", param = true,
	name = "Reduce Rendering Distance",
	desc = "Adds distance haze so far-away visuals cost less (set the distance above).",
	globals = { newGlobal(getLighting, function(saved)
		local origEnd = (saved and saved.FogEnd and saved.FogEnd[1]) or Lighting.FogEnd
		local origStart = (saved and saved.FogStart and saved.FogStart[1]) or Lighting.FogStart
		local d = math.max(State.dist, 300)
		if origEnd <= d then
			return {} -- the game already uses a closer fog; leave it alone
		end
		return { FogEnd = d, FogStart = math.max(origStart, d * 0.55) }
	end) },
})
defineFeature({
	id = "meshDetail", tab = "PERFORMANCE",
	name = "Reduce Mesh Detail",
	desc = "Uses performance render fidelity for meshes. Collision is unchanged.",
	rules = { ruleMesh },
})
defineFeature({
	id = "transparency", tab = "PERFORMANCE",
	name = "Reduce Transparency Cost",
	desc = "Hides parts that are almost fully transparent to cut overdraw.",
	rules = { ruleTransparency },
})
defineFeature({
	id = "localFx", tab = "PERFORMANCE",
	name = "Disable Unnecessary Local Effects",
	desc = "Turns off decorative fire and sparkles (visual only).",
	rules = { ruleLocalFx },
})
defineFeature({
	id = "fpsCap", tab = "PERFORMANCE",
	name = "Frame Rate Limiter (30 FPS)",
	desc = "Caps FPS to save battery and heat. Turn OFF before leaving to restore your cap.",
	globals = { newGlobal(getUserGameSettings, function() return { FramerateCap = 30 } end) },
})

------------------------------------------------------------------------
-- 6. PRESETS & CONTROL LOGIC
------------------------------------------------------------------------
local function setOf(list)
	local t = {}
	for _, v in ipairs(list) do
		t[v] = true
	end
	return t
end

local Presets = {
	balanced = {
		title = "Balanced (FPS Boost)", short = "Balanced", level = 6,
		desc = "Light boost: moderate quality, fewer particles, no post effects, calmer water.",
		features = setOf({ "lowGraphics", "postfx", "particles", "water", "lighting" }),
	},
	performance = {
		title = "Performance Mode", short = "Performance", level = 4,
		desc = "Strong boost: shadows off, reduced effects, simplified terrain and lighting.",
		features = setOf({ "lowGraphics", "shadows", "postfx", "particles", "visualFx", "lighting", "water", "terrain", "transparency" }),
	},
	ultra = {
		title = "Ultra Performance", short = "Ultra", level = 2, dist = 1500,
		desc = "Maximum practical boost while keeping the world readable.",
		features = setOf({ "lowGraphics", "shadows", "postfx", "particles", "visualFx", "lighting", "water", "terrain",
			"transparency", "textures", "materials", "meshDetail", "localFx", "renderDist" }),
	},
	potato = {
		title = "Potato Mode", short = "Potato", level = 1, dist = 700, lightUI = true,
		desc = "Everything off or lowest for very weak devices. Looks plain, runs smooth.",
		features = setOf({ "lowGraphics", "shadows", "postfx", "particles", "visualFx", "lighting", "water", "terrain",
			"transparency", "textures", "materials", "meshDetail", "localFx", "renderDist" }),
	},
	battery = {
		title = "Battery Saver Mode", short = "Battery", level = 3,
		desc = "Lower quality plus a 30 FPS cap to reduce power use and heat.",
		features = setOf({ "lowGraphics", "shadows", "postfx", "particles", "visualFx", "lighting", "water", "terrain",
			"localFx", "fpsCap" }),
	},
}

local function setFeature(id, on, force)
	local f = FeatureById[id]
	if not f then
		return false
	end
	on = on and true or false
	if (State.on[id] or false) == on and not force then
		return true
	end
	local ok, supported = pcall(f.apply, on)
	if not ok then
		warn("[CH3A5 PREMIUM HUB] " .. f.name .. ": " .. tostring(supported))
		pcall(f.apply, false)
		State.on[id] = false
		UI.notify(f.name .. " failed safely")
		return false
	end
	if on and supported == false then
		pcall(f.apply, false)
		State.on[id] = false
		UI.notify(f.name .. " is not supported on this client")
		return false
	end
	State.on[id] = on
	return true
end

local function activeCount()
	local n = 0
	for _, f in ipairs(Features) do
		if State.on[f.id] then
			n += 1
		end
	end
	return n
end

local function restoreDefaults(silent)
	for _, f in ipairs(Features) do
		if State.on[f.id] then
			setFeature(f.id, false)
		end
	end
	State.level = CONFIG.DefaultLevel
	State.dist = CONFIG.DefaultDistance
	State.activePreset = nil
	State.autoOn = false
	if State.lightUIByPreset then
		State.lightUI = false
		State.lightUIByPreset = false
		UI.applyLightUI()
	end
	if not silent then
		UI.refresh()
		UI.notify("Default graphics restored")
	end
end

local function applyPreset(key, silent)
	local p = Presets[key]
	if not p then
		return
	end
	State.level = p.level
	State.dist = p.dist or CONFIG.DefaultDistance
	for _, f in ipairs(Features) do
		local want = p.features[f.id] == true
		if want or State.on[f.id] then
			setFeature(f.id, want, want and f.param)
		end
	end
	if p.lightUI and not State.lightUI then
		State.lightUI = true
		State.lightUIByPreset = true
		UI.applyLightUI()
	elseif not p.lightUI and State.lightUIByPreset then
		State.lightUI = false
		State.lightUIByPreset = false
		UI.applyLightUI()
	end
	State.activePreset = key
	State.autoOn = false
	UI.refresh()
	if not silent then
		UI.notify(p.title .. " applied")
	end
	if State.closeAfterPreset then
		task.delay(0.6, function() UI.close() end)
	end
end

-- User-driven single toggle: marks the configuration as "custom".
local function userToggle(id, on)
	setFeature(id, on)
	State.activePreset = nil
	State.autoOn = false
	UI.refresh()
end

-- Auto Optimize: one short FPS measurement, then applies the best-fitting preset.
local Auto = { conn = nil }
local function cancelAuto()
	if Auto.conn then
		Auto.conn:Disconnect()
		Auto.conn = nil
	end
	State.measuring = false
end

local function autoOptimize()
	if State.measuring then
		return
	end
	restoreDefaults(true) -- measure on the stock configuration
	State.measuring = true
	UI.refresh()
	UI.notify("Auto Optimize: measuring performance...")
	local elapsed, frames, warmup = 0, 0, 0.75
	Auto.conn = RunService.Heartbeat:Connect(function(dt)
		elapsed += dt
		if elapsed < warmup then
			return
		end
		frames += 1
		if elapsed - warmup >= 3 then
			local avg = frames / (elapsed - warmup)
			cancelAuto()
			local key = "potato"
			if avg >= 58 then key = "balanced"
			elseif avg >= 45 then key = "performance"
			elseif avg >= 30 then key = "ultra" end
			applyPreset(key, true)
			State.autoOn = true
			UI.refresh()
			UI.notify(string.format("Auto Optimize: %d FPS measured, %s applied", math.floor(avg + 0.5), Presets[key].short))
		end
	end)
end

------------------------------------------------------------------------
-- 7. USER INTERFACE
------------------------------------------------------------------------
local gui = create("ScreenGui", {
	Name = CONFIG.GuiName,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 1000,
	IgnoreGuiInset = false,
})
pcall(function() gui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets end) -- safe-area friendly

local Decor, Gradients, KhmerLabels, Refreshers = {}, {}, {}, {}
local function addRefresher(fn) Refreshers[#Refreshers + 1] = fn end

local function khmerLabel(lbl, khmer, plain)
	KhmerLabels[#KhmerLabels + 1] = { lbl = lbl, khmer = khmer, plain = plain }
	lbl.Text = State.khmer and khmer or plain
end

local function addGradient(frame, c1, c2, rotation, flat)
	frame.BackgroundColor3 = Color3.new(1, 1, 1)
	local g = create("UIGradient", { Color = ColorSequence.new(c1, c2), Rotation = rotation, Parent = frame })
	Gradients[#Gradients + 1] = { grad = g, frame = frame, flat = flat }
	return g
end

-- Angkor Wat inspired stepped-tower silhouette built from a few frames.
local function buildTemple(parent, color)
	local function block(x, y, w, h, tr)
		create("Frame", {
			BackgroundColor3 = color, BackgroundTransparency = tr or 0, BorderSizePixel = 0,
			Position = UDim2.fromScale(x, y), Size = UDim2.fromScale(w, h), Parent = parent,
		})
	end
	local function tower(cx, baseY, w, h, tiers)
		local th = h / tiers
		for i = 1, tiers do
			local tw = w * (1 - (i - 1) * 0.2)
			block(cx - tw / 2, baseY - i * th, tw, th * 0.88)
		end
		block(cx - 0.006, baseY - h - 0.12, 0.012, 0.12)
	end
	block(0.02, 0.88, 0.96, 0.12)
	block(0.10, 0.78, 0.80, 0.09)
	block(0.20, 0.62, 0.60, 0.15, 0.3)
	tower(0.5, 0.78, 0.15, 0.50, 5)
	tower(0.31, 0.78, 0.11, 0.34, 4)
	tower(0.69, 0.78, 0.11, 0.34, 4)
	tower(0.17, 0.78, 0.08, 0.22, 3)
	tower(0.83, 0.78, 0.08, 0.22, 3)
end

-- Row of small gold diamonds (Khmer border motif).
local function buildDiamondBand(parent, count)
	create("Frame", {
		BackgroundColor3 = Theme.Gold, BackgroundTransparency = 0.7, BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 1), Parent = parent,
	})
	local row = create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ClipsDescendants = true, Parent = parent })
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 7),
		VerticalAlignment = Enum.VerticalAlignment.Center, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = row,
	})
	for i = 1, count do
		create("Frame", {
			BackgroundColor3 = Theme.Gold, BorderSizePixel = 0, Rotation = 45, LayoutOrder = i,
			BackgroundTransparency = (i % 2 == 0) and 0.45 or 0.05,
			Size = UDim2.fromOffset(5, 5), Parent = row,
		})
	end
end

----------------------------------------------------------------------
-- Window shell
----------------------------------------------------------------------
local HEADER_H, TAB_Y, PAGE_Y, FOOT_H = 52, 66, 110, 26

local window = create("Frame", {
	Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(560, 420), BorderSizePixel = 0, Visible = false, Parent = gui,
})
corner(window, 14)
stroke(window, Theme.Gold, 1.5, 0.35)
addGradient(window, Theme.BGTop, Theme.BG, 90, Theme.BG)
local winScale = create("UIScale", { Scale = 1, Parent = window })

-- Corner ornaments
do
	local function ornament(ax, ay, px, py)
		local h = create("Frame", {
			BackgroundColor3 = Theme.Gold, BackgroundTransparency = 0.35, BorderSizePixel = 0,
			AnchorPoint = Vector2.new(ax, ay), Position = UDim2.new(px, ax == 0 and 5 or -5, py, ay == 0 and 5 or -5),
			Size = UDim2.fromOffset(16, 2), Parent = window,
		})
		local v = create("Frame", {
			BackgroundColor3 = Theme.Gold, BackgroundTransparency = 0.35, BorderSizePixel = 0,
			AnchorPoint = Vector2.new(ax, ay), Position = UDim2.new(px, ax == 0 and 5 or -5, py, ay == 0 and 5 or -5),
			Size = UDim2.fromOffset(2, 16), Parent = window,
		})
		Decor[#Decor + 1] = h
		Decor[#Decor + 1] = v
	end
	ornament(0, 0, 0, 0)
	ornament(1, 0, 1, 0)
	ornament(0, 1, 0, 1)
	ornament(1, 1, 1, 1)
end

-- Header
local header = create("Frame", { Name = "Header", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, HEADER_H), Parent = window })
local headerIcon = create("Frame", {
	BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 16, 0.5, 0),
	Size = UDim2.fromOffset(44, 34), Parent = header,
})
buildTemple(headerIcon, Theme.Gold)

local titleBox = create("Frame", {
	BackgroundTransparency = 1, Position = UDim2.new(0, 68, 0, 0), Size = UDim2.new(1, -68 - 54, 1, 0), Parent = header,
})
create("UIListLayout", { VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 1), SortOrder = Enum.SortOrder.LayoutOrder, Parent = titleBox })
local titleLabel = makeLabel({
	Text = CONFIG.Title, Font = Enum.Font.GothamBold, TextColor3 = Theme.Gold, TextScaled = true, TextWrapped = false,
	Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 1, Parent = titleBox,
})
create("UITextSizeConstraint", { MaxTextSize = 17, MinTextSize = 10, Parent = titleLabel })
local subtitle = makeLabel({
	Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = Theme.Muted, TextWrapped = false,
	Size = UDim2.new(1, 0, 0, 14), LayoutOrder = 2, Parent = titleBox,
})
khmerLabel(subtitle, "អង្គរ · PREMIUM CLIENT OPTIMIZER", "ANGKOR EDITION · PREMIUM CLIENT OPTIMIZER")

local closeBtn = create("TextButton", {
	Name = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(36, 36),
	BackgroundColor3 = Theme.Card, AutoButtonColor = false, Text = "×", Font = Enum.Font.GothamBold,
	TextSize = 24, TextColor3 = Theme.Text, BorderSizePixel = 0, Parent = header,
})
corner(closeBtn, 10)
stroke(closeBtn, Theme.Gold, 1, 0.6)
closeBtn.MouseEnter:Connect(function() tween(closeBtn, 0.12, { BackgroundColor3 = Theme.Bad }) end)
closeBtn.MouseLeave:Connect(function() tween(closeBtn, 0.12, { BackgroundColor3 = Theme.Card }) end)

-- Diamond band under the header
local band = create("Frame", {
	BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, HEADER_H + 1), Size = UDim2.new(1, -28, 0, 10), Parent = window,
})
buildDiamondBand(band, 50)
Decor[#Decor + 1] = band

-- Tab bar
local tabBar = create("ScrollingFrame", {
	Name = "Tabs", BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0, 10, 0, TAB_Y), Size = UDim2.new(1, -20, 0, 38),
	ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.X, AutomaticCanvasSize = Enum.AutomaticSize.X,
	CanvasSize = UDim2.new(0, 0, 0, 0), Parent = window,
})
create("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4),
	VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Parent = tabBar,
})

-- Page area + footer
local pageArea = create("Frame", {
	Name = "Pages", BackgroundTransparency = 1, ClipsDescendants = true,
	Position = UDim2.new(0, 10, 0, PAGE_Y), Size = UDim2.new(1, -20, 1, -(PAGE_Y + FOOT_H)), Parent = window,
})
local footer = create("Frame", {
	BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -4), Size = UDim2.new(1, -28, 0, FOOT_H - 6), Parent = window,
})
local toast = makeLabel({
	Text = "Ready · client-side only", Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Theme.Muted,
	TextWrapped = false, TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.new(1, -70, 1, 0), Parent = footer,
})
makeLabel({
	Text = "v" .. CONFIG.Version, Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Theme.GoldDark,
	TextXAlignment = Enum.TextXAlignment.Right, Position = UDim2.new(1, -60, 0, 0), Size = UDim2.new(0, 60, 1, 0), Parent = footer,
})

local toastToken = 0
UI.notify = function(text)
	toastToken += 1
	local mine = toastToken
	toast.Text = text
	toast.TextColor3 = Theme.Gold
	task.delay(4, function()
		if toastToken == mine and toast.Parent then
			toast.Text = "Ready · client-side only"
			toast.TextColor3 = Theme.Muted
		end
	end)
end

----------------------------------------------------------------------
-- Reusable components
----------------------------------------------------------------------
local function newPage()
	local page = create("ScrollingFrame", {
		BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false,
		ScrollBarThickness = UserInputService.TouchEnabled and 2 or 4, ScrollBarImageColor3 = Theme.Gold,
		ScrollingDirection = Enum.ScrollingDirection.Y, AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0), ElasticBehavior = Enum.ElasticBehavior.WhenScrollable, Parent = pageArea,
	})
	listLayout(page, 8)
	padding(page, 2, 8, 12, 0)
	return page
end

local function addSection(page, text)
	local row = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22), LayoutOrder = nextOrder(page), Parent = page })
	create("Frame", {
		BackgroundColor3 = Theme.Gold, BorderSizePixel = 0, Rotation = 45, AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(6, 6), Parent = row,
	})
	makeLabel({
		Text = text, Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.Gold, TextWrapped = false,
		Position = UDim2.new(0, 18, 0, 0), Size = UDim2.new(1, -18, 1, 0), Parent = row,
	})
end

-- Base card: title + description on the left, optional fixed-width area on the right.
local function newCard(page, title, desc, rightWidth, clickable)
	local props = {
		BackgroundColor3 = Theme.Card, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, 0, 0, 0), LayoutOrder = nextOrder(page), Parent = page,
	}
	if clickable then
		props.AutoButtonColor = false
		props.Text = ""
	end
	local card = create(clickable and "TextButton" or "Frame", props)
	corner(card, 10)
	local st = stroke(card, Theme.Gold, 1, 0.7)
	padding(card, 10, 12, 10, 12)
	create("UISizeConstraint", { MinSize = Vector2.new(0, 56), Parent = card })

	local reserve = (rightWidth and rightWidth > 0) and (rightWidth + 12) or 0
	local holder = create("Frame", {
		BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, -reserve, 0, 0), Parent = card,
	})
	listLayout(holder, 2)
	makeLabel({
		Text = title, Font = Enum.Font.GothamBold, TextSize = 14, AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 1, Parent = holder,
	})
	if desc and desc ~= "" then
		makeLabel({
			Text = desc, Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Theme.Muted, AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 2, Parent = holder,
		})
	end
	if clickable then
		card.MouseEnter:Connect(function() tween(card, 0.12, { BackgroundColor3 = Theme.CardHover }) end)
		card.MouseLeave:Connect(function() tween(card, 0.12, { BackgroundColor3 = Theme.Card }) end)
	end
	return card, st
end

local function newToggleCard(page, title, desc, getFn, setFn)
	local card, st = newCard(page, title, desc, 46, true)
	local track = create("Frame", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(46, 26),
		BackgroundColor3 = Theme.Off, BorderSizePixel = 0, Parent = card,
	})
	corner(track, 13)
	local knob = create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 0), Size = UDim2.fromOffset(20, 20),
		BackgroundColor3 = Theme.Muted, BorderSizePixel = 0, Parent = track,
	})
	corner(knob, 10)

	local last
	local function refresh()
		local on = getFn() and true or false
		if on == last then
			return
		end
		local first = (last == nil)
		last = on
		local d = first and 0 or 0.15
		tween(track, d, { BackgroundColor3 = on and Theme.Gold or Theme.Off })
		tween(knob, d, {
			Position = on and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
			BackgroundColor3 = on and Theme.BG or Theme.Muted,
		})
		tween(st, d, { Transparency = on and 0.3 or 0.7 })
	end
	card.Activated:Connect(function()
		setFn(not getFn())
		refresh()
	end)
	addRefresher(refresh)
	refresh()
	return card
end

local function newActionCard(page, title, desc, pillText, callback)
	local card = newCard(page, title, desc, 84, true)
	local pill = makeLabel({
		Text = pillText, Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Theme.Gold, TextWrapped = false,
		TextXAlignment = Enum.TextXAlignment.Center, BackgroundTransparency = 0, BackgroundColor3 = Theme.BG,
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(78, 30), Parent = card,
	})
	corner(pill, 8)
	stroke(pill, Theme.Gold, 1, 0.45)
	card.Activated:Connect(callback)
	return card
end

local function newStepper(page, title, desc, minV, maxV, stepV, getFn, setFn, fmt)
	local card = newCard(page, title, desc, 124, false)
	local box = create("Frame", {
		BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.fromOffset(124, 36), Parent = card,
	})
	local function stepButton(text, xScale, xOff)
		local b = create("TextButton", {
			AnchorPoint = Vector2.new(xScale, 0.5), Position = UDim2.new(xScale, xOff, 0.5, 0), Size = UDim2.fromOffset(36, 36),
			BackgroundColor3 = Theme.BG, AutoButtonColor = false, Text = text, Font = Enum.Font.GothamBold, TextSize = 20,
			TextColor3 = Theme.Gold, BorderSizePixel = 0, Parent = box,
		})
		corner(b, 9)
		stroke(b, Theme.Gold, 1, 0.5)
		b.MouseEnter:Connect(function() tween(b, 0.1, { BackgroundColor3 = Theme.CardHover }) end)
		b.MouseLeave:Connect(function() tween(b, 0.1, { BackgroundColor3 = Theme.BG }) end)
		return b
	end
	local minus = stepButton("-", 0, 0)
	local plus = stepButton("+", 1, 0)
	local valueLabel = makeLabel({
		Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Theme.Text, TextWrapped = false, TextXAlignment = Enum.TextXAlignment.Center,
		Position = UDim2.new(0, 36, 0, 0), Size = UDim2.new(1, -72, 1, 0), Parent = box,
	})
	local function refresh()
		valueLabel.Text = fmt(getFn())
	end
	local function change(delta)
		local v = math.clamp(getFn() + delta * stepV, minV, maxV)
		v = math.floor(v / stepV + 0.5) * stepV
		v = math.floor(v * 1000 + 0.5) / 1000
		setFn(v)
		refresh()
	end
	minus.Activated:Connect(function() change(-1) end)
	plus.Activated:Connect(function() change(1) end)
	addRefresher(refresh)
	refresh()
end

local function newInfoCard(page, rowNames)
	local card = create("Frame", {
		BackgroundColor3 = Theme.Card, BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, 0, 0, 0), LayoutOrder = nextOrder(page), Parent = page,
	})
	corner(card, 10)
	stroke(card, Theme.Gold, 1, 0.7)
	padding(card, 8, 12, 8, 12)
	listLayout(card, 2)
	local values = {}
	for i, name in ipairs(rowNames) do
		local row = create("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = i, Parent = card })
		makeLabel({
			Text = name, Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Theme.Muted, TextWrapped = false,
			Size = UDim2.new(0.42, 0, 1, 0), Parent = row,
		})
		values[name] = makeLabel({
			Text = "-", Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.Text, TextWrapped = false,
			TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Right,
			Position = UDim2.new(0.42, 0, 0, 0), Size = UDim2.new(0.58, 0, 1, 0), Parent = row,
		})
	end
	return values
end

local function newTextCard(page, title, body)
	local card = newCard(page, title, body, 0, false)
	return card
end

----------------------------------------------------------------------
-- Pages
----------------------------------------------------------------------
local TabNames = { "HOME", "FPS BOOST", "GRAPHICS", "PERFORMANCE", "SETTINGS", "ABOUT" }
local Pages, Tabs = {}, {}
for _, n in ipairs(TabNames) do
	Pages[n] = newPage()
end

local function detectDevice()
	local touch, kb = UserInputService.TouchEnabled, UserInputService.KeyboardEnabled
	if UserInputService.GamepadEnabled and not touch and not kb then
		return "Console"
	end
	if touch and not kb then
		local v = gui.AbsoluteSize
		return (math.min(v.X, v.Y) >= 600) and "Tablet" or "Phone"
	end
	return "Desktop"
end

local function qualityText()
	local q = safeGet(function() return settings().Rendering.QualityLevel end)
	if not q then
		return "Unavailable"
	end
	if q.Name == "Automatic" then
		return "Automatic"
	end
	local txt = q.Name:gsub("Level0*", "Level ")
	return txt
end

-- HOME ---------------------------------------------------------------
local homeInfo
do
	local home = Pages["HOME"]
	local hero = create("Frame", {
		BorderSizePixel = 0, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = nextOrder(home), Parent = home,
	})
	corner(hero, 12)
	stroke(hero, Theme.Gold, 1, 0.5)
	addGradient(hero, Color3.fromRGB(34, 29, 26), Theme.Card, 90, Theme.Card)
	padding(hero, 14, 12, 14, 12)
	create("UIListLayout", {
		Padding = UDim.new(0, 5), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Parent = hero,
	})
	local temple = create("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(150, 50), LayoutOrder = 1, Parent = hero })
	buildTemple(temple, Theme.Gold)
	Decor[#Decor + 1] = temple
	local t = makeLabel({
		Text = CONFIG.Title, Font = Enum.Font.GothamBold, TextColor3 = Theme.Gold, TextScaled = true, TextWrapped = false,
		TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = 2, Parent = hero,
	})
	create("UITextSizeConstraint", { MaxTextSize = 21, MinTextSize = 12, Parent = t })
	local kh = makeLabel({
		Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Theme.GoldDark, TextXAlignment = Enum.TextXAlignment.Center,
		AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 3, Parent = hero,
	})
	khmerLabel(kh, "សូមស្វាគមន៍ · ប្រាសាទអង្គរវត្ត", "WELCOME · ANGKOR WAT")
	makeLabel({
		Text = "Client-side FPS & performance optimizer. Only changes how your game renders locally.",
		Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = Theme.Muted, TextXAlignment = Enum.TextXAlignment.Center,
		AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 4, Parent = hero,
	})

	addSection(home, "OPTIMIZATION STATUS")
	homeInfo = newInfoCard(home, { "Status", "Active optimizations", "FPS", "Memory", "Graphics quality", "Device" })

	-- Main FPS Boost button
	local main = create("TextButton", {
		BackgroundColor3 = Theme.Card, AutoButtonColor = false, Text = "", BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 56), LayoutOrder = nextOrder(home), Parent = home,
	})
	corner(main, 12)
	local mainStroke = stroke(main, Theme.Gold, 1.5, 0.2)
	local mainTitle = makeLabel({
		Text = "FPS BOOST", Font = Enum.Font.GothamBold, TextSize = 17, TextColor3 = Theme.Gold, TextWrapped = false,
		TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, 0, 0, 8), Size = UDim2.new(1, 0, 0, 22), Parent = main,
	})
	local mainSub = makeLabel({
		Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = Theme.Muted, TextWrapped = false,
		TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, 0, 0, 31), Size = UDim2.new(1, 0, 0, 16), Parent = main,
	})
	main.MouseEnter:Connect(function() tween(mainStroke, 0.12, { Transparency = 0 }) end)
	main.MouseLeave:Connect(function() tween(mainStroke, 0.12, { Transparency = 0.2 }) end)
	main.Activated:Connect(function()
		if State.activePreset == "balanced" then
			restoreDefaults()
		else
			applyPreset("balanced")
		end
	end)
	local lastMain
	addRefresher(function()
		local on = State.activePreset == "balanced"
		if lastMain == on then return end
		local first = (lastMain == nil)
		lastMain = on
		tween(main, first and 0 or 0.15, { BackgroundColor3 = on and Theme.Gold or Theme.Card })
		mainTitle.TextColor3 = on and Theme.BG or Theme.Gold
		mainSub.TextColor3 = on and Color3.fromRGB(60, 46, 20) or Theme.Muted
		mainSub.Text = on and "ON · tap to restore default graphics" or "Tap to enable the balanced FPS boost"
	end)

	newActionCard(home, "Restore Default Graphics", "Undo every optimization and return to your original settings.", "RESTORE", function()
		restoreDefaults()
	end)
end

-- FPS BOOST ----------------------------------------------------------
do
	local pg = Pages["FPS BOOST"]
	local function presetToggle(key)
		local p = Presets[key]
		newToggleCard(pg, p.title, p.desc, function() return State.activePreset == key end, function(on)
			if on then applyPreset(key) else restoreDefaults() end
		end)
	end
	addSection(pg, "PRESETS")
	presetToggle("balanced")
	presetToggle("performance")
	presetToggle("ultra")
	presetToggle("potato")
	addSection(pg, "POWER")
	presetToggle("battery")
	addSection(pg, "AUTOMATIC")
	newToggleCard(pg, "Auto Optimize", "Measures your FPS for a few seconds once, then applies the best-fitting preset. No background loop.",
		function() return State.autoOn or State.measuring end,
		function(on)
			if on then
				autoOptimize()
			else
				cancelAuto()
				restoreDefaults()
			end
		end)
	addSection(pg, "RESET")
	newActionCard(pg, "Restore Default Graphics", "Switches every optimization off and restores original values.", "RESTORE", function()
		cancelAuto()
		restoreDefaults()
	end)
end

-- GRAPHICS -----------------------------------------------------------
do
	local pg = Pages["GRAPHICS"]
	addSection(pg, "GRAPHICS OPTIMIZATIONS")
	for _, f in ipairs(Features) do
		if f.tab == "GRAPHICS" then
			newToggleCard(pg, f.name, f.desc, function() return State.on[f.id] end, function(on) userToggle(f.id, on) end)
		end
	end
end

-- PERFORMANCE --------------------------------------------------------
do
	local pg = Pages["PERFORMANCE"]
	addSection(pg, "TUNING")
	newStepper(pg, "Graphics Quality Level", "Used by Low Graphics Mode (1 = lowest, 10 = highest).", 1, 10, 1,
		function() return State.level end,
		function(v)
			State.level = v
			if State.on.lowGraphics then setFeature("lowGraphics", true, true) end
		end,
		function(v) return "Level " .. v end)
	newStepper(pg, "Render Distance", "Fog distance used by Reduce Rendering Distance (studs).", 300, 3000, 100,
		function() return State.dist end,
		function(v)
			State.dist = v
			if State.on.renderDist then setFeature("renderDist", true, true) end
		end,
		function(v) return v .. " studs" end)
	addSection(pg, "ADVANCED OPTIMIZATIONS")
	for _, f in ipairs(Features) do
		if f.tab == "PERFORMANCE" then
			newToggleCard(pg, f.name, f.desc, function() return State.on[f.id] end, function(on) userToggle(f.id, on) end)
		end
	end
	addSection(pg, "INTERFACE")
	newToggleCard(pg, "Lightweight UI Mode", "Hides ornaments and gradients on this hub and disables its animations.",
		function() return State.lightUI end,
		function(on)
			State.lightUI = on
			State.lightUIByPreset = false
			UI.applyLightUI()
		end)
end

-- SETTINGS -----------------------------------------------------------
local updateLayout -- forward declaration
local function resetHubSettings()
	State.uiScale = 1
	State.anim = true
	State.khmer = true
	State.keyToggle = true
	State.closeAfterPreset = false
	State.lightUI = false
	State.lightUIByPreset = false
	for _, k in ipairs(KhmerLabels) do k.lbl.Text = k.khmer end
	UI.applyLightUI()
	updateLayout()
	UI.refresh()
	UI.notify("Hub settings reset")
end

do
	local pg = Pages["SETTINGS"]
	addSection(pg, "INTERFACE")
	newStepper(pg, "UI Scale", "Resize the hub (it always stays inside your screen).", 0.7, 1.3, 0.1,
		function() return State.uiScale end,
		function(v) State.uiScale = v; updateLayout() end,
		function(v) return math.floor(v * 100 + 0.5) .. "%" end)
	newToggleCard(pg, "Animations", "Smooth open, close, hover, toggle and tab animations.",
		function() return State.anim end, function(on) State.anim = on end)
	newToggleCard(pg, "Khmer Decorative Text", "Shows small Khmer script accents. Turn off if your device shows boxes instead of letters.",
		function() return State.khmer end,
		function(on)
			State.khmer = on
			for _, k in ipairs(KhmerLabels) do k.lbl.Text = on and k.khmer or k.plain end
		end)
	addSection(pg, "OPEN / CLOSE BEHAVIOR")
	newToggleCard(pg, "Keyboard Shortcut (Right Shift)", "Open or close the hub with Right Shift. Left/Right arrows switch tabs.",
		function() return State.keyToggle end, function(on) State.keyToggle = on end)
	newToggleCard(pg, "Close After Applying a Preset", "Minimizes the hub to the floating button after a preset is applied.",
		function() return State.closeAfterPreset end, function(on) State.closeAfterPreset = on end)
	addSection(pg, "RESET")
	newActionCard(pg, "Reset Hub Settings", "Restores UI scale, animations and behavior options to default.", "RESET", resetHubSettings)
	newActionCard(pg, "Restore Default Graphics", "Undo every optimization and restore original graphics values.", "RESTORE", function()
		cancelAuto()
		restoreDefaults()
	end)
end

-- ABOUT --------------------------------------------------------------
do
	local pg = Pages["ABOUT"]
	addSection(pg, "CH3A5 PREMIUM HUB · v" .. CONFIG.Version)
	newTextCard(pg, "What it does", "Adjusts only your own client's rendering and performance: quality level, shadows, particles, effects, lighting, terrain and water visuals, and fog distance.")
	newTextCard(pg, "What it never does", "No RemoteEvents or RemoteFunctions, no server contact, no gameplay, stats, currency, inventory, movement or combat changes, no effect on other players, no arbitrary code, no security bypass.")
	newTextCard(pg, "Fair play by design", "Blur, color correction, smoke and large volumetric effects are intentionally left untouched, so these options can never become a visibility advantage.")
	newTextCard(pg, "Good to know", "Every toggle restores the original value when turned off. If a game re-applies its own settings, toggle again. Rejoining the game resets everything. If you use the Frame Rate Limiter, switch it off before leaving.")
	newTextCard(pg, "Controls", "Floating button: tap to open or close, drag to move. Keyboard: Right Shift toggles the hub, Left/Right arrows switch tabs.")
	local credit = newCard(pg, "", "", 0, false)
	local kh = makeLabel({
		Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Theme.Gold, TextXAlignment = Enum.TextXAlignment.Center,
		AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = credit,
	})
	khmerLabel(kh, "ខ្មែរ · អង្គរវត្ត · CH3A5", "KHMER · ANGKOR WAT · CH3A5")
end

----------------------------------------------------------------------
-- Tabs
----------------------------------------------------------------------
local Live = { conn = nil, acc = 0, frames = 0 }

local function stopLive()
	if Live.conn then
		Live.conn:Disconnect()
		Live.conn = nil
	end
end

local function refreshStatus()
	local count = activeCount()
	local status
	if State.measuring then
		status = "Measuring..."
	elseif State.autoOn and State.activePreset then
		status = "Auto · " .. Presets[State.activePreset].short
	elseif State.activePreset then
		status = Presets[State.activePreset].short .. " preset"
	elseif count > 0 then
		status = "Custom"
	else
		status = "Stock graphics"
	end
	homeInfo["Status"].Text = status
	homeInfo["Status"].TextColor3 = (count > 0) and Theme.Gold or Theme.Text
	homeInfo["Active optimizations"].Text = tostring(count)
	homeInfo["Graphics quality"].Text = qualityText()
	homeInfo["Device"].Text = detectDevice()
end

local function startLive()
	if Live.conn or not State.open or State.page ~= "HOME" then
		return
	end
	Live.acc, Live.frames = 0, 0
	Live.conn = RunService.Heartbeat:Connect(function(dt)
		Live.acc += dt
		Live.frames += 1
		if Live.acc >= (State.lightUI and 1 or 0.5) then
			local fps = Live.frames / Live.acc
			Live.acc, Live.frames = 0, 0
			local lbl = homeInfo["FPS"]
			lbl.Text = string.format("%d  (%.1f ms)", math.floor(fps + 0.5), 1000 / math.max(fps, 1))
			lbl.TextColor3 = fps >= 50 and Theme.Good or (fps >= 30 and Theme.Gold or Theme.Bad)
			local mem = safeGet(function() return game:GetService("Stats"):GetTotalMemoryUsageMb() end)
			homeInfo["Memory"].Text = mem and string.format("%d MB", math.floor(mem + 0.5)) or "Unavailable"
		end
	end)
end

local function selectPage(name)
	State.page = name
	for n, p in pairs(Pages) do
		p.Visible = (n == name)
	end
	for n, t in pairs(Tabs) do
		local active = (n == name)
		tween(t.btn, 0.15, { TextColor3 = active and Theme.Gold or Theme.Muted })
		tween(t.line, 0.15, { BackgroundTransparency = active and 0 or 1 })
	end
	local page = Pages[name]
	page.CanvasPosition = Vector2.zero
	page.Position = UDim2.fromOffset(0, 10)
	tween(page, 0.2, { Position = UDim2.fromOffset(0, 0) })
	-- keep the active tab visible on narrow screens
	local t = Tabs[name]
	if t and t.btn.AbsoluteSize.X > 0 then
		local x = t.btn.AbsolutePosition.X - tabBar.AbsolutePosition.X + tabBar.CanvasPosition.X - 16
		tabBar.CanvasPosition = Vector2.new(math.max(0, x), 0)
	end
	if name == "HOME" then startLive() else stopLive() end
end

for i, name in ipairs(TabNames) do
	local btn = create("TextButton", {
		Text = name, Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Theme.Muted, BackgroundTransparency = 1,
		AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 34), LayoutOrder = i, Parent = tabBar,
	})
	padding(btn, 0, 12, 0, 12)
	local line = create("Frame", {
		BackgroundColor3 = Theme.Gold, BackgroundTransparency = 1, BorderSizePixel = 0, AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 0, 0, 2), Parent = btn,
	})
	Tabs[name] = { btn = btn, line = line }
	btn.MouseEnter:Connect(function()
		if State.page ~= name then tween(btn, 0.1, { TextColor3 = Theme.Text }) end
	end)
	btn.MouseLeave:Connect(function()
		if State.page ~= name then tween(btn, 0.1, { TextColor3 = Theme.Muted }) end
	end)
	btn.Activated:Connect(function() selectPage(name) end)
end

----------------------------------------------------------------------
-- Floating open button (draggable, always available)
----------------------------------------------------------------------
local floatBtn = create("TextButton", {
	Name = "OpenButton", AnchorPoint = Vector2.new(0, 0), Position = UDim2.fromOffset(10, 70), Size = UDim2.fromOffset(48, 48),
	BackgroundColor3 = Theme.BG, AutoButtonColor = false, Text = "", BorderSizePixel = 0, ZIndex = 5, Parent = gui,
})
corner(floatBtn, 24)
local floatStroke = stroke(floatBtn, Theme.Gold, 2, 0.1)
local floatIcon = create("Frame", {
	BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromScale(0.6, 0.46), ZIndex = 6, Parent = floatBtn,
})
buildTemple(floatIcon, Theme.Gold)
for _, c in ipairs(floatIcon:GetChildren()) do c.ZIndex = 6 end
local floatDot = create("Frame", {
	BackgroundColor3 = Theme.Good, BorderSizePixel = 0, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -2, 0, 2),
	Size = UDim2.fromOffset(10, 10), Visible = false, ZIndex = 7, Parent = floatBtn,
})
corner(floatDot, 5)
floatBtn.MouseEnter:Connect(function() tween(floatStroke, 0.12, { Thickness = 3 }) end)
floatBtn.MouseLeave:Connect(function() tween(floatStroke, 0.12, { Thickness = 2 }) end)

----------------------------------------------------------------------
-- Open / close
----------------------------------------------------------------------
local closeToken = 0
local function openHub()
	if State.open then return end
	State.open = true
	closeToken += 1
	window.Visible = true
	winScale.Scale = State.scale * 0.88
	tween(winScale, 0.22, { Scale = State.scale }, Enum.EasingStyle.Back)
	startLive()
end

local function closeHub()
	if not State.open then return end
	State.open = false
	stopLive()
	closeToken += 1
	local mine = closeToken
	local t = tween(winScale, 0.16, { Scale = State.scale * 0.9 })
	if t then
		t.Completed:Once(function()
			if closeToken == mine and not State.open then
				window.Visible = false
			end
		end)
	else
		window.Visible = false
	end
end
UI.close = closeHub

local function toggleHub()
	if State.open then closeHub() else openHub() end
end

closeBtn.Activated:Connect(closeHub)

-- Drag (and click) handling for the floating button
do
	local dragging, moved, dragStart, startPos, dragConn, activeInput
	floatBtn.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		dragging, moved = true, false
		activeInput = input
		dragStart = input.Position
		startPos = floatBtn.AbsolutePosition - gui.AbsolutePosition
		if dragConn then dragConn:Disconnect() end
		dragConn = UserInputService.InputChanged:Connect(function(changed)
			if not dragging then return end
			if changed.UserInputType ~= Enum.UserInputType.MouseMovement and changed.UserInputType ~= Enum.UserInputType.Touch then return end
			local delta = changed.Position - dragStart
			if not moved and delta.Magnitude > 8 then moved = true end
			if moved then
				local area = gui.AbsoluteSize
				local sz = floatBtn.AbsoluteSize
				floatBtn.Position = UDim2.fromOffset(
					math.clamp(startPos.X + delta.X, 4, math.max(4, area.X - sz.X - 4)),
					math.clamp(startPos.Y + delta.Y, 4, math.max(4, area.Y - sz.Y - 4))
				)
			end
		end)
		local endConn
		endConn = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				endConn:Disconnect()
				if dragConn then dragConn:Disconnect(); dragConn = nil end
				dragging = false
				if not moved then toggleHub() end
			end
		end)
	end)
end

----------------------------------------------------------------------
-- Layout (responsive: 320px phones → 4K desktops)
----------------------------------------------------------------------
updateLayout = function()
	local size = gui.AbsoluteSize
	if size.X < 10 or size.Y < 10 then return end
	local device = math.clamp(size.Y / 900, 1, 1.5)
	local s = device * State.uiScale
	s = math.min(s, size.X * 0.96 / CONFIG.MinW, size.Y * 0.92 / CONFIG.MinH)
	s = math.max(s, 0.5)
	local w = math.clamp(size.X * 0.94 / s, CONFIG.MinW, CONFIG.MaxW)
	local h = math.clamp(size.Y * 0.84 / s, CONFIG.MinH, CONFIG.MaxH)
	State.scale = s
	window.Size = UDim2.fromOffset(w, h)
	if State.open then
		winScale.Scale = s
	end
	-- floating button: touch-friendly size, always kept inside the screen
	local fb = math.floor(48 * math.min(device, 1.3))
	floatBtn.Size = UDim2.fromOffset(fb, fb)
	local bp = floatBtn.AbsolutePosition - gui.AbsolutePosition
	floatBtn.Position = UDim2.fromOffset(
		math.clamp(bp.X, 4, math.max(4, size.X - fb - 4)),
		math.clamp(bp.Y, 4, math.max(4, size.Y - fb - 4))
	)
end

UI.applyLightUI = function()
	for _, d in ipairs(Decor) do d.Visible = not State.lightUI end
	for _, g in ipairs(Gradients) do
		g.grad.Enabled = not State.lightUI
		g.frame.BackgroundColor3 = State.lightUI and g.flat or Color3.new(1, 1, 1)
	end
end

UI.refresh = function()
	for _, fn in ipairs(Refreshers) do
		pcall(fn)
	end
	pcall(refreshStatus)
	floatDot.Visible = activeCount() > 0
end

----------------------------------------------------------------------
-- Input + lifecycle
----------------------------------------------------------------------
track(UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == CONFIG.ToggleKey and State.keyToggle then
		toggleHub()
	elseif State.open and (input.KeyCode == Enum.KeyCode.Right or input.KeyCode == Enum.KeyCode.Left) then
		local idx = table.find(TabNames, State.page) or 1
		idx = ((idx - 1 + (input.KeyCode == Enum.KeyCode.Right and 1 or -1)) % #TabNames) + 1
		selectPage(TabNames[idx])
	end
end))

track(gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLayout))

-- Best-effort: give the player their own FPS cap back when leaving.
track(Players.PlayerRemoving:Connect(function(p)
	if p == LocalPlayer and State.on.fpsCap then
		pcall(setFeature, "fpsCap", false)
	end
end))

local function cleanup()
	cancelAuto()
	stopLive()
	pcall(restoreDefaults, true)
	Opt.disconnect()
	for _, c in ipairs(Connections) do
		c:Disconnect()
	end
	Connections = {}
	if gui then gui:Destroy() end
	shared[CLEANUP_KEY] = nil
end
shared[CLEANUP_KEY] = cleanup

----------------------------------------------------------------------
-- Start
----------------------------------------------------------------------
gui.Parent = PlayerGui
UI.applyLightUI()
updateLayout()
UI.refresh()
selectPage("HOME")
task.defer(function()
	updateLayout()
	openHub()
	UI.notify("Welcome · tap the gold button to open or close the hub")
end)
