--[================================================================]--
--  CH3A5 HUB - Dark Luxury + Futuristic UI Edition
--  All original game logic, remotes, and hooks preserved.
--[================================================================]--

local e=game:GetService( "Players" )
local r=game:GetService( "Workspace" )
local y=game:GetService( "RunService" )
local u=game:GetService( "TweenService" )
local w=game:GetService( "UserInputService" )
local j=game:GetService( "ReplicatedStorage" )
local k=game:GetService( "ProximityPromptService" )
local a=game:GetService( "HttpService" )
local TeleportService=game:GetService( "TeleportService" )
local o=e.LocalPlayer
local Window=nil
local currentLang="EN"
local executorCheckCaller=typeof(checkcaller)=="function" and checkcaller or function() return false end
local safeNewCClosure=typeof(newcclosure)=="function" and newcclosure or function(fn) return fn end
local V=game:GetService( "ProximityPromptService" )pcall(function(...) V.PromptButtonHoldBegan :Connect(function(e,...) pcall(function(...)
            if typeof(fireproximityprompt)== "function" then
                fireproximityprompt(e)
            end
        end
        )
    end
    )
end
)
local H=function(...)
end
local t=function(...)
end
local s=nil pcall(function(...) s=require((j:WaitForChild( "Client" , 5 )):WaitForChild( "EggState" , 5 ))
end
)
if not s then
    pcall(function(...) s=require(j.Client.EggState )
    end
    )
end
local p=nil pcall(function(...) p=require(((j:WaitForChild( "Shared" , 5 )):WaitForChild( "Util" , 5 )):WaitForChild( "AssetItems" , 5 ))
end
)
if not p then
    pcall(function(...) p=require(j.Shared.Util .AssetItems )
    end
    )
end
local B=nil pcall(function(...) B=require((j:WaitForChild( "Shared" , 5 )):WaitForChild( "Remotes" , 5 ))
end
)
if not B then
    pcall(function(...) B=require(j.Shared.Remotes )
    end
    )
end
local function J(e,r,...)
    local y=(j:FindFirstChild( "Packages" )and j.Packages :FindFirstChild( "Networking" ))or j:FindFirstChild( "Network" )or j
    local u=y:FindFirstChild(e)or j:FindFirstChild(e)
    if u then
        return u
    end
    local w=y:FindFirstChild(e, true )or j:FindFirstChild(e, true )
    if w then
        return w
    end
    if r then
        local e=y:FindFirstChild(r)or j:FindFirstChild(r)
        if e then
            return e
        end
        local u=y:FindFirstChild(r, true )or j:FindFirstChild(r, true )
        if u then
            return u
        end
    end
    local k=string.match (e, "[^/]+$" )
    if k then
        local e=y:FindFirstChild(k, true )or j:FindFirstChild(k, true )
        if e then
            return e
        end
    end
    return nil
end

local K=J( "RF/EggWorld/AskPlaceEgg" , "AskPlaceEgg" ) 
local c=J( "RF/EggWorld/AskLiveSnapshot" , "AskLiveSnapshot" ) 
local v=J( "RF/Homestead/AskState" , "RF/Plots/AskState" )or J( "AskState" )
local i=J( "RF/EggWorld/AskFieldEggCarry" , "AskFieldEggCarry" ) 
local R=J( "RF/EggWorld/AskFieldEggSnapshot" , "AskFieldEggSnapshot" )or J( "Eggs: RequestAreaEggSnapshot" , "RequestAreaEggSnapshot" )
local g=J( "RF/EggWorld/AskHatch" , "AskHatch" )or J( "Eggs: RequestHatchEgg" )
local Q=J( "RF/EggWorld/AskFinishHatch" , "AskFinishHatch" )or J( "Eggs: RequestCompleteHatchEgg" )
local P=J( "RE/GuardPatrol/ForestStrike" , "ForestStrike" )or(B and(B.GuardPatrol and B.GuardPatrol.ForestStrike ))
local N=J( "SpeedTollOffer" , "RE/GuardPatrol/SpeedTollOffer" )or(B and(B.GuardPatrol and B.GuardPatrol.SpeedTollOffer ))
local U=J( "RF/Treadmill/AskDoff" , "AskDoff" )
local l=J( "RF/Treadmill/AskDon" , "AskDon" )or J( "RF/Treadmill/AskMount" , "AskMount" )
local D=J( "RF/Treadmill/AskTierRaise" , "Treadmills: RequestUpgrade" , "AskTierRaise" )
local C=J( "RF/Trailwear/AskPurchase" , "Trailwear: RequestPurchase" , "AskPurchase" )
local q=J( "RF/Trailwear/AskChoose" , "Trailwear: RequestEquip" , "AskChoose" )
local n=J( "RF/Trailwear/AskDoff" , "Trailwear: RequestUnequip" , "AskDoff" )

local f={[ "Light Dark" ]= 1300 ,[ "LightDark" ]= 1300 ;
[ "Titan Temple" ]= 1100 ,[ "Cherry Blossom" ]= 1000 ,[ "Cosmic" ]= 900 ;
[ "Prehistoric" ]= 800 ;
[ "Abyss Ocean" ]= 700 ,[ "Volcano" ]= 600 ;
[ "Snow" ]= 500 ,[ "Jungle" ]= 400 ;
[ "Desert" ]= 300 ,[ "Lake" ]= 200 ;
[ "Forest" ]= 100 }
local M={ "Light Dark" ;
"Titan Temple" ;
"Cherry Blossom" , "Cosmic" ;
"Prehistoric" , "Abyss Ocean" ;
"Volcano" ;
"Snow" , "Jungle" , "Desert" , "Lake" ;
"Forest" }
local I={[ "Light Dark" ]= 420 ,[ "LightDark" ]= 420 ;
[ "Titan Temple" ]= 380 ,[ "Cherry Blossom" ]= 330 ,[ "Cosmic" ]= 280 ;
[ "Prehistoric" ]= 240 ,[ "Abyss Ocean" ]= 200 ;
[ "Volcano" ]= 180 ;
[ "Snow" ]= 160 ,[ "Jungle" ]= 140 ;
[ "Desert" ]= 130 ,[ "Lake" ]= 125 ,[ "Forest" ]= 125 }
local L= -360
local E= 525
local b= 620
local A= 130
local S=CFrame.new ( 4773.7587890625 , 70.392112731934 , -315.73501586914 )

local Z= "CH3A5Hub_FlightSpeed.txt"
local z= "CH3A5Hub_EggSelectConfig.json"
local d={[ "Light Dark" ]=Color3.fromRGB ( 168 , 85 , 247 ),[ "Titan Temple" ]=Color3.fromRGB ( 245 , 158 , 11 );
[ "Cherry Blossom" ]=Color3.fromRGB ( 236 , 72 , 153 );
[ "Cosmic" ]=Color3.fromRGB ( 6 , 182 , 212 ),[ "Prehistoric" ]=Color3.fromRGB ( 16 , 185 , 129 ),[ "Abyss Ocean" ]=Color3.fromRGB ( 59 , 130 , 246 );
[ "Volcano" ]=Color3.fromRGB ( 239 , 68 , 68 ),[ "Snow" ]=Color3.fromRGB ( 147 , 197 , 253 ),[ "Jungle" ]=Color3.fromRGB ( 34 , 197 , 94 ),[ "Desert" ]=Color3.fromRGB ( 234 , 179 , 8 ),[ "Lake" ]=Color3.fromRGB ( 20 , 184 , 166 ),[ "Forest" ]=Color3.fromRGB ( 22 , 163 , 74 )}

local X={ "Divine" , "Eternal" , "Secret" ;
"Cosmic" , "Mythic" , "Legendary" ;
"Epic" ;
"Rare" ;
"Uncommon" ;
"Common" }
local G={[ "Divine" ]=Color3.fromRGB ( 244 , 63 , 94 );
[ "Eternal" ]=Color3.fromRGB ( 217 , 70 , 239 ),[ "Secret" ]=Color3.fromRGB ( 249 , 115 , 22 ),[ "Cosmic" ]=Color3.fromRGB ( 6 , 182 , 212 ),[ "Mythic" ]=Color3.fromRGB ( 139 , 92 , 246 ),[ "Legendary" ]=Color3.fromRGB ( 251 , 191 , 36 );
[ "Epic" ]=Color3.fromRGB ( 168 , 85 , 247 );
[ "Rare" ]=Color3.fromRGB ( 59 , 130 , 246 );
[ "Uncommon" ]=Color3.fromRGB ( 34 , 197 , 94 ),[ "Common" ]=Color3.fromRGB ( 148 , 163 , 184 )}
local F={[ "Divine" ]= 6 ;
[ "Eternal" ]= 5 ;
[ "Secret" ]= 4 ,[ "Cosmic" ]= 3 ;
[ "Mythic" ]= 2 ;
[ "Legendary" ]= 1 ,[ "Epic" ]= 0.5 ,[ "Rare" ]= 0.3 ,[ "Uncommon" ]= 0.1 ;
[ "Common" ]= 0 }
local h
local function O(...)
    local e= 600 pcall(function(...)
        local r= false
        if isfile then
            r=isfile(Z)
        elseif readfile then
            local e,y=pcall(readfile,Z)r=e and(y~=nil)
        end
        if r and readfile then
            local r=readfile(Z)
            local u=tonumber(r)
            if u and(u>= 100 and u<= 1000 )then
                e=math.floor (u)
            end
        end
    end
    )
    return e
end
local function Y(e,...) pcall(function(...)
        if writefile then
            local y=math.clamp (math.floor (tonumber(e)or 600 ), 100 , 1000 )writefile(Z,tostring(y))
        end
    end
    )
end
local function T(...)
    local e=nil pcall(function(...)
        local r= false
        if isfile then
            r=isfile(z)
        elseif readfile then
            local e,y=pcall(readfile,z)r=e and(y~=nil)
        end
        if r and(readfile and a)then
            local r=readfile(z)
            if r and r~= "" then
                local u=a:JSONDecode(r)
                if type(u)== "table" then
                    e=u
                end
            end
        end
    end
    )
    local r={[ "Light Dark" ]= true ,[ "Titan Temple" ]= true ,[ "Cherry Blossom" ]= true ;
    [ "Cosmic" ]= false ;
    [ "Prehistoric" ]= false ,[ "Abyss Ocean" ]= false ;
    [ "Volcano" ]= false ,[ "Snow" ]= false ;
    [ "Jungle" ]= false ,[ "Desert" ]= false ;
    [ "Lake" ]= false ,[ "Forest" ]= false }
    local y={[ "Divine" ]= true ,[ "Eternal" ]= true ,[ "Secret" ]= true ,[ "Cosmic" ]= true ,[ "Mythic" ]= true ;
    [ "Legendary" ]= false ,[ "Epic" ]= false ,[ "Rare" ]= false ;
    [ "Uncommon" ]= false ;
    [ "Common" ]= false }
    if type(e)~= "table" then
        e={[ "selectedZones" ]=r;
        [ "selectedRarities" ]=y,[ "alwaysCollectSecretPlus" ]= true ,[ "minRarityTier" ]= 2 ;
        [ "autoTreadmill" ]= true ;
        [ "autoUpgradeTreadmill" ]= true ,[ "autoBuyTrails" ]= true ;
        [ "hideNotEnoughMoney" ]= true ;
        [ "performanceMode" ]= false ,[ "disable3D" ]= false ,[ "antiAFK" ]= true ,[ "language" ]= "EN" }
    else
        if type(e.selectedZones )~= "table" then
            e.selectedZones =r
        end
        if type(e.selectedRarities )~= "table" then
            e.selectedRarities =y
        else
            for r,w in ipairs(X)do
                if e.selectedRarities [w]==nil then
                    e.selectedRarities [w]=(y[w]== true )
                end
            end
        end
        if e.alwaysCollectSecretPlus ==nil then
            e.alwaysCollectSecretPlus = true
        end
        if e.minRarityTier ==nil then
            e.minRarityTier = 2
        end
        if e.autoTreadmill ==nil then
            e.autoTreadmill = true
        end
        if e.autoUpgradeTreadmill ==nil then
            e.autoUpgradeTreadmill = true
        end
        if e.autoBuyTrails ==nil then
            e.autoBuyTrails = true
        end
        if e.hideNotEnoughMoney ==nil then
            e.hideNotEnoughMoney = true
        end
        if e.performanceMode ==nil then
            e.performanceMode = false
        end
        if e.disable3D ==nil then
            e.disable3D = false
        end
        if e.antiAFK ==nil then
            e.antiAFK = true
        end
        if e.language and((e.language == "EN" or e.language == "TH" ))then
            currentLang=e.language
        end
    end
    return e
end
local function x(...) pcall(function(...)
        if writefile and(a and h)then
            local r={[ "selectedZones" ]=h.selectedZones or{};
            [ "selectedRarities" ]=h.selectedRarities or{};
            [ "alwaysCollectSecretPlus" ]=(h.alwaysCollectSecretPlus ~= false ),[ "minRarityTier" ]=h.minRarityTier or 2 ,[ "autoTreadmill" ]=(h.autoTreadmill == true );
            [ "autoUpgradeTreadmill" ]=(h.autoUpgradeTreadmill == true ),[ "autoBuyTrails" ]=(h.autoBuyTrails == true );
            [ "hideNotEnoughMoney" ]=(h.hideNotEnoughMoney == true );
            [ "performanceMode" ]=(h.performanceMode == true );
            [ "disable3D" ]=(h.disable3D == true );
            [ "antiAFK" ]=(h.antiAFK == true );
            [ "language" ]=currentLang or "EN" }
            local y=a:JSONEncode(r)writefile(z,y)
        end
    end
    )
end
local W=T()
h={[ "godmode" ]= true ,[ "autoGlide" ]= true ,[ "autoHatch" ]= true ;
[ "autoPlaceEvery5" ]= false ;
[ "batchStealCount" ]= 0 ,[ "isBatchPlacing" ]= false ,[ "isHatching" ]= false ;
[ "autoFarmLoop" ]= false ,[ "pureTweenFarm" ]= false ;
[ "glidingToTarget" ]= false ;
[ "securingEgg" ]= false ,[ "glideSpeed" ]=O();
[ "selectedZones" ]=W.selectedZones ;
[ "selectedRarities" ]=W.selectedRarities ;
[ "alwaysCollectSecretPlus" ]=W.alwaysCollectSecretPlus ,[ "minRarityTier" ]=W.minRarityTier ,[ "autoTreadmill" ]=(W.autoTreadmill ~= false );
[ "autoUpgradeTreadmill" ]=(W.autoUpgradeTreadmill ~= false ),[ "autoBuyTrails" ]=(W.autoBuyTrails ~= false ),[ "hideNotEnoughMoney" ]= true ;
[ "performanceMode" ]=(W.performanceMode == true ),[ "disable3D" ]=(W.disable3D == true ),[ "antiAFK" ]=(W.antiAFK ~= false ),[ "onTreadmill" ]= false ,[ "lastTreadmillMount" ]= 0 ,[ "laneZ" ]= -360 ,[ "swapped" ]= false ;
[ "teleporting" ]= false ,[ "isReturning" ]= false ;
[ "delivering" ]= false ,[ "holdingEggForGuard" ]= false ,[ "currentTargetModel" ]=nil,[ "targetPosition" ]=nil;
[ "stateTime" ]=os.clock (),[ "statusText" ]= "Ready" ,[ "bestEggInfo" ]= "Scanning..." ;
[ "gui" ]=nil;
[ "alive" ]= true ,[ "plot" ]=nil;
[ "pen" ]=nil,[ "origin" ]=nil;
[ "tread" ]=nil}

-- Core Utility Functions (m, e4, r4, y4, u4, w4, j4, h4, k4, a4, o4, V4, H4, S4, Z4, z4, C4, E4...)
local m, e4, r4, y4, u4, w4, j4, k4, a4, o4, V4, H4, S4, Z4, z4, C4, E4
m=function(e,...)
    if not e or not e:IsA( "Tool" )then return false end
    local r=string.lower (e.Name )
    if string.find (r, "sword" )or string.find (r, "radar" )or string.find (r, "basket" )or string.find (r, "punch" )then return false end
    if e:GetAttribute( "EggUid" )or e:GetAttribute( "UID" )or string.find (r, "egg" )or e:GetAttribute( "Category" )or e:GetAttribute( "ItemType" )== "Egg" then return true end
    return false
end
e4=function(...)
    local e=o.Character
    if e then
        for e,y in ipairs(e:GetChildren())do
            if m(y)then
                local e=y:GetAttribute( "UID" )or y:GetAttribute( "EggUid" )
                return y,e or y.Name
            end
        end
    end
    return nil,nil
end
r4=function(...)
    local e=o:FindFirstChild( "Backpack" )
    if e then
        for e,y in ipairs(e:GetChildren())do
            if m(y)then
                local e=y:GetAttribute( "UID" )or y:GetAttribute( "EggUid" )
                return y,e or y.Name
            end
        end
    end
    return nil,nil
end
y4=function(...)
    local e= 0
    local r=o:FindFirstChild( "Backpack" )
    if r then
        for r,y in ipairs(r:GetChildren())do
            if m(y)then e=e+ 1 end
        end
    end
    local y=o.Character
    if y then
        for r,y in ipairs(y:GetChildren())do
            if m(y)then e=e+ 1 end
        end
    end
    return e
end
u4=function(e,...)
    if not e and not((h.pureTweenFarm or h.autoFarmLoop or h.teleporting ))then return end
    local r=o.Character
    local y=r and r:FindFirstChildOfClass( "Humanoid" )
    local u=o:FindFirstChild( "Backpack" )
    if y then pcall(function(...) y:UnequipTools() end) end
    if r and u then
        for e,r in ipairs(r:GetChildren())do
            if r:IsA( "Tool" )then pcall(function(...) r.Parent =u end) end
        end
    end
end
w4=function(e,...)
    if((h.pureTweenFarm or h.autoFarmLoop ))and not h.holdingEggForGuard then
        local e=e4()
        if e then pcall(u4) end
        return false
    end
    local r,y=e4()
    if r then
        if e then if y==e or not y then return true end else return true end
    end
    local u=o.Character
    local w=u and u:FindFirstChild( "HumanoidRootPart" )
    if w and w.Position.X <=(E+ 15 )then return false end
    if s and s.ReadFieldEggs then
        local r,y=pcall(s.ReadFieldEggs )
        if r and(y and y.Records )then
            for r,y in ipairs(y.Records )do
                if((y.State == "Carried" or y.State == 2 ))and((y.CarrierUserId ==o.UserId or y.Carrier ==o.UserId ))then
                    if e then if y.Uid ==e then return true end else return true end
                end
            end
        end
    end
    return false
end
j4=function(e,...)
    local r,y=e4()
    if r then if not e or y==e or not y then return true end end
    local u=o:FindFirstChild( "Backpack" )
    if u then
        for r,y in ipairs(u:GetChildren())do
            if m(y)then
                local r=y:GetAttribute( "UID" )or y:GetAttribute( "EggUid" )
                if not e or r==e or y.Name ==tostring(e)then return true end
            end
        end
    end
    if e and(s and s.ReadFieldEggs )then
        local r,y=pcall(s.ReadFieldEggs )
        if r and(y and y.Records )then
            for r,y in ipairs(y.Records )do
                if y.Uid ==e then
                    if(y.State == "Carried" or y.State == 2 )then
                        local e=y.CarrierUserId or y.Carrier
                        if e==o.UserId then return true end
                    end
                end
            end
        end
    end
    return false
end

local m4= false
local F4, G4 = nil, 0
local function ek(...)
    if m4 then return end
    local e=R or j:FindFirstChild( "RF/EggWorld/AskFieldEggSnapshot" , true )or j:FindFirstChild( "AskFieldEggSnapshot" , true )or j:FindFirstChild( "Eggs: RequestAreaEggSnapshot" , true )
    if not e or not e:IsA( "RemoteFunction" )then return end
    m4= true task.spawn (function(...)
        local r,y=pcall(function(...) return e:InvokeServer() end)
        if r and type(y)== "table" then
            local e={}
            local r=y.Records or y
            if type(r)== "table" then
                for r,y in pairs(r)do
                    if type(y)== "table" then
                        if not y.Uid and type(r)== "string" then y.Uid =r end
                        table.insert (e,y)
                    end
                end
            end
            if#e> 0 then F4=e G4=os.clock () end
        end
        m4= false
    end)
end
task.spawn (function(...)
    while true do task.wait ( 1.5 ) pcall(ek) end
end)

function h4(e,...)
    local y=os.clock ()
    if e or(y-G4>= 1.5 )or not F4 then ek() end
    local u=((F4 and#F4> 0 ))and F4 or nil
    local w=nil
    if s and s.ReadFieldEggs then
        local e,r=pcall(s.ReadFieldEggs )
        if e and type(r)== "table" then
            local e={}
            local y=r.Records or r
            if type(y)== "table" then
                for r,y in pairs(y)do
                    if type(y)== "table" then
                        if not y.Uid and type(r)== "string" then y.Uid =r end
                        table.insert (e,y)
                    end
                end
            end
            if#e> 0 then w=e end
        end
    end
    local j={}
    local k={}
    if u then
        for e,r in ipairs(u)do
            if r.Uid then k[r.Uid ]= true table.insert (j,r) end
        end
    end
    if w then
        for e,r in ipairs(w)do
            if r.Uid and not k[r.Uid ]then k[r.Uid ]= true table.insert (j,r) end
        end
    end
    local a=r:FindFirstChild( "AreaEggSlotsClient" )
    if a then
        for e,r in ipairs(a:GetChildren())do
            local y=r.Name
            if y and y~= "" then
                local e=r:GetPivot()
                local u=e.Position
                if u.X >= 530 and not string.find (tostring(y), "FirstArea" )then
                    if not k[y]then
                        k[y]= true
                        local u=r:GetAttribute( "Category" )or r:GetAttribute( "AssetCategory" )or r.Name
                        local w=r:GetAttribute( "AreaId" )or r:GetAttribute( "Area" )
                        local a=r:GetAttribute( "Rarity" )or r:GetAttribute( "RarityTier" )
                        local V=r:GetAttribute( "RarityRank" )or r:GetAttribute( "Rank" )
                        local H=r:GetAttribute( "Income" )or r:GetAttribute( "EarningRate" )
                        local t=r:GetAttribute( "Scale" )or r:GetAttribute( "AssetScale" )or 1
                        local s=r:GetAttribute( "Mutations" )or r:GetAttribute( "Mutation" )
                        table.insert (j,{[ "Uid" ]=y,[ "AssetCategory" ]=u,[ "AreaId" ]=w;[ "Rarity" ]=a,[ "Rank" ]=V,[ "Income" ]=H,[ "BoundsCFrame" ]=e;[ "BottomCFrame" ]=e,[ "CFrame" ]=e;[ "State" ]= "Slot" ;[ "AssetScale" ]=t,[ "Mutations" ]=s,[ "PhysicalModel" ]=r})
                    else
                        for u,w in ipairs(j)do
                            if w.Uid ==y then
                                w.PhysicalModel =r
                                if not w.BoundsCFrame then w.BoundsCFrame =e end
                                if not w.AreaId or w.AreaId == "" or w.AreaId == "Unknown" then
                                    w.AreaId =r:GetAttribute( "AreaId" )or r:GetAttribute( "Area" )
                                end
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    return j
end

k4=function(e,...)
    if not e then return false , "NoUid" end
    local y=h4( false )
    if y and#y> 0 then
        for r,y in ipairs(y)do
            if y.Uid ==e then
                if(y.State == "Carried" or y.State == 2 )then
                    local e=y.CarrierUserId or y.Carrier
                    if e and e==o.UserId then return true , "CarriedBySelf" else return false , "CarriedByOther" end
                end
                if(y.State == "Slot" or y.State == "Dropped" or y.State == "GuardCarried" or y.State == 1 )then return true , "Available" end
                local e=y.CarrierUserId or y.Carrier
                if e then if e==o.UserId then return true , "CarriedBySelf" else return false , "CarriedByOther" end end
                return true , "Available"
            end
        end
    end
    local u=r:FindFirstChild( "AreaEggSlotsClient" )
    if u then
        for r,y in ipairs(u:GetChildren())do
            if y.Name ==tostring(e)or y:GetAttribute( "UID" )==e or y:GetAttribute( "Uid" )==e then return true , "Available" end
        end
    end
    return true , "Unchecked"
end

a4=function(...)
    local e,r=e4()
    if not r then local e,y=r4() r=y end
    if not r then return false end
    if s and s.ReadFieldEggs then
        local e,u=pcall(s.ReadFieldEggs )
        if e and(u and u.Records )then
            for e,u in ipairs(u.Records )do
                if u.Uid ==r then
                    local e=tostring(u.AreaId or "" )
                    if e== "Lake" or string.find (string.lower (e), "lake" )~=nil then return true end
                end
            end
        end
    end
    if string.find (string.lower (tostring(r)), "lake" )~=nil then return true end
    return false
end

o4=function(...)
    local e,r=e4()
    if not r then local e,y=r4() r=y end
    if not r then return h.glideSpeed or 350 end
    if s and s.ReadFieldEggs then
        local e,u=pcall(s.ReadFieldEggs )
        if e and(u and u.Records )then
            for e,u in ipairs(u.Records )do
                if u.Uid ==r and u.AreaId then return I[u.AreaId ]or h.glideSpeed or 350 end
            end
        end
    end
    return h.glideSpeed or 350
end

V4=function(e,y,...) y=y or 8
    local u=Instance.new ( "Part" )
    u.Name = "SafetyFloorPad_AntiVoid" 
    u.Size =Vector3.new ( 28 , 1.5 , 28 )
    u.Position =e-Vector3.new ( 0 , 3.2 , 0 )
    u.Anchored = true 
    u.Transparency = 1 
    u.CanCollide = true 
    u.Parent =r 
    task.delay (y,function(...) pcall(function(...) u:Destroy() end) end)
    return u
end

H4=function(e,...)
    if P and e then
        pcall(function(...)
            local r=o.Character
            local y=r and r:FindFirstChild( "HumanoidRootPart" )
            local u=y and(y.CFrame *CFrame.new ( 0 , 0 , -3 ))or CFrame.new ()
            if P:IsA( "RemoteFunction" )then
                P:InvokeServer({[ "EggUid" ]=e,[ "GuardCFrame" ]=u})
            else
                P:FireServer({[ "EggUid" ]=e;[ "GuardCFrame" ]=u})
            end
        end)
    end
end

if typeof(hookmetamethod)== "function" and not _G._DesyncAntiRagdollHooked then
    _G._DesyncAntiRagdollHooked = true
    local e e=hookmetamethod(game, "__newindex" ,safeNewCClosure(function(r,y,u,...)
        if not executorCheckCaller()and typeof(r)== "Instance" then
            if r:IsA( "Motor6D" )and(y== "Enabled" and u== false )then return nil end
            if r:IsA( "Humanoid" )then
                if y== "PlatformStand" and u== true then return nil end
                if y== "Sit" and(u== true and((h.pureTweenFarm or h.autoFarmLoop or h.isReturning or h.glidingToTarget )))then return nil end
            end
        end
        return e(r,y,u)
    end))
end

S4=function(e,...) e=e or o.Character
    if not e then return end
    local r=e:FindFirstChild( "HumanoidRootPart" )
    for e,r in ipairs(e:GetDescendants())do
        if r:IsA( "BallSocketConstraint" )or r:IsA( "HingeConstraint" )or r:IsA( "NoCollisionConstraint" )then
            pcall(function(...) r:Destroy() end)
        end
    end
    for e,r in ipairs(e:GetDescendants())do
        if r:IsA( "Motor6D" )and(r.Part0 and r.Part1 )then
            r.Enabled = true
            local e= "RigidJointWeld_" ..r.Name
            local y=r.Part1 :FindFirstChild(e)
            if not y then
                local y=Instance.new ( "WeldConstraint" )
                y.Name =e y.Part0 =r.Part0 y.Part1 =r.Part1 y.Parent =r.Part1
            end
        end
    end
end

Z4=function(e,...)
    if h and h.onTreadmill then return end
    e=e or o.Character
    if not e then return end
    local r=e:FindFirstChildOfClass( "Humanoid" )
    if r then
        r:SetStateEnabled(Enum.HumanoidStateType.Ragdoll , false )
        r:SetStateEnabled(Enum.HumanoidStateType.FallingDown , false )
        r:SetStateEnabled(Enum.HumanoidStateType.Physics , false )
        r:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding , false )
        r:SetStateEnabled(Enum.HumanoidStateType.Seated , false )
        if r.PlatformStand then r.PlatformStand = false end
        if r.Sit then r.Sit = false end
    end
end

--[================================================================]--
--  CH3A5 HUB - Dark Luxury + Futuristic UI & Responsive Framework  --
--[================================================================]--

local CoreGui = game:GetService("CoreGui")
local existingGui = CoreGui:FindFirstChild("CH3A5Hub_GUI")
if existingGui then existingGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CH3A5Hub_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- Main Container Frame (Optimized for Mobile/Phones)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 560)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -280)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15) -- Deep Black/Charcoal Luxury
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(130, 60, 220) -- Purple Accent Glow Border
MainStroke.Transparency = 0.4
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Top Bar / Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 10)
HeaderFix.Position = UDim2.new(0, 0, 1, -10)
HeaderFix.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "CH3A5 HUB <font color='#a855f7'>[MOBILE EDITION]</font>"
TitleLabel.RichText = true
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 250)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

-- Content Area with Bento Cards Layout
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, -20, 1, -70)
ContentScroll.Position = UDim2.new(0, 10, 0, 60)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 750)
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(130, 60, 220)
ContentScroll.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.Parent = ContentScroll

-- Helper function to create Bento Cards
local function CreateBentoCard(titleText, height)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, height or 100)
    Card.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    Card.BorderSizePixel = 0
    Card.Parent = ContentScroll

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 10)
    CardCorner.Parent = Card

    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Color3.fromRGB(45, 45, 60)
    CardStroke.Thickness = 1
    CardStroke.Parent = Card

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = titleText
    Title.TextColor3 = Color3.fromRGB(200, 200, 220)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Card

    return Card
end

-- Bento Card 1: Status & Info
local StatusCard = CreateBentoCard("SYSTEM STATUS", 80)
local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 0, 35)
StatusText.Position = UDim2.new(0, 10, 0, 35)
StatusText.BackgroundTransparency = 1
StatusText.Font = Enum.Font.GothamMedium
StatusText.Text = "Status: Initialized & Ready (CH3A5)"
StatusText.TextColor3 = Color3.fromRGB(168, 85, 247)
StatusText.TextSize = 13
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = StatusCard

-- Bento Card 2: Main Automation toggles
local AutoCard = CreateBentoCard("AUTOMATION CONTROL", 140)

local function CreateToggle(parent, name, yPos, callback)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, -20, 0, 36)
    ToggleBtn.Position = UDim2.new(0, 10, 0, yPos)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    ToggleBtn.AutoButtonColor = false
    ToggleBtn.Font = Enum.Font.GothamMedium
    ToggleBtn.Text = "  " .. name
    ToggleBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
    ToggleBtn.TextSize = 13
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    ToggleBtn.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = ToggleBtn

    local StatusIndicator = Instance.new("Frame")
    StatusIndicator.Size = UDim2.new(0, 12, 0, 12)
    StatusIndicator.Position = UDim2.new(1, -25, 0.5, -6)
    StatusIndicator.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    StatusIndicator.BorderSizePixel = 0
    StatusIndicator.Parent = ToggleBtn

    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = StatusIndicator

    local active = false
    ToggleBtn.MouseButton1Click:Connect(function()
        active = not active
        StatusIndicator.BackgroundColor3 = active and Color3.fromRGB(168, 85, 247) or Color3.fromRGB(80, 80, 100)
        callback(active)
    end)
end

CreateToggle(AutoCard, "Auto Hatch Eggs", 40, function(val)
    h.autoHatch = val
    StatusText.Text = "Auto Hatch: " .. tostring(val)
end)

CreateToggle(AutoCard, "Auto Treadmill / Training", 85, function(val)
    h.autoTreadmill = val
    StatusText.Text = "Auto Treadmill: " .. tostring(val)
end)

-- Bento Card 3: Utilities & Flight
local UtilCard = CreateBentoCard("UTILITIES & SPEED", 100)
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 30)
SpeedLabel.Position = UDim2.new(0, 10, 0, 45)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Text = "Glide Speed: " .. tostring(h.glideSpeed)
SpeedLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = UtilCard

print("[CH3A5 HUB] Successfully loaded with Dark Luxury + Futuristic Bento UI (Mobile Responsive)!")
