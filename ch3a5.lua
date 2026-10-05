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
local n=J( "RF/Trailwear/AskDoff" , "Trailwear: RequestUnequip" , "AskDoff" )H(string.format ( "[RemoteCheck] Carry: %s | Snapshot: %s | Place: %s | Hatch: %s | FinishHatch: %s | Strike: %s | Toll: %s | Doff: %s" ,tostring(i~=nil),tostring(R~=nil),tostring(K~=nil),tostring(g~=nil),tostring(Q~=nil),tostring(P~=nil),tostring(N~=nil),tostring(U~=nil)))

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

local Z= "DiceHub_FlightSpeed.txt"
local z= "DiceHub_EggSelectConfig.json"
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
local W=T()h={[ "godmode" ]= true ,[ "autoGlide" ]= true ,[ "autoHatch" ]= true ;
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
local m
local e4
local r4
local y4
local u4
local w4
local j4
local k4
local a4
local o4
local V4
local H4
local t4
local s4
local p4
local B4
local J4
local K4
local c4
local v4
local i4
local R4
local g4
local Q4
local P4
local N4
local U4
local l4
local D4
local C4
local q4
local n4
local f4
local M4
local I4
local L4
local E4
local b4
local A4
local S4
local Z4
local z4
local d4
local X4={}
local G4= 0
local F4=nil
local h4
local O4= 0
local Y4= "NONE"
local T4
local x4=nil
local W4=nil pcall(function(...)
    local e=game:GetService( "Lighting" );
    (e:GetPropertyChangedSignal( "ClockTime" )):Connect(function(...) X4={}G4= 0
    end
    )
end
)pcall(function(...)
    local function e(e,...)
        if e:IsA( "RemoteEvent" )then
            local y=string.lower (e.Name )
            if string.find (y, "reset" )or string.find (y, "night" )or string.find (y, "spawn" )or string.find (y, "countdown" )then
                pcall(function(...) e.OnClientEvent :Connect(function(...) X4={}G4= 0
                    end
                    )
                end
                )
            end
        end
    end
    for y,u in ipairs(j:GetDescendants())do
        e(u)
    end
    j.DescendantAdded :Connect(e)
end
)m=function(e,...)
    if not e or not e:IsA( "Tool" )then
        return false
    end
    local r=string.lower (e.Name )
    if string.find (r, "sword" )or string.find (r, "radar" )or string.find (r, "basket" )or string.find (r, "punch" )then
        return false
    end
    if e:GetAttribute( "EggUid" )or e:GetAttribute( "UID" )or string.find (r, "egg" )or e:GetAttribute( "Category" )or e:GetAttribute( "ItemType" )== "Egg" then
        return true
    end
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
            if m(y)then
                e=e+ 1
            end
        end
    end
    local y=o.Character
    if y then
        for r,y in ipairs(y:GetChildren())do
            if m(y)then
                e=e+ 1
            end
        end
    end
    return e
end
u4=function(e,...)
    if not e and not((h.pureTweenFarm or h.autoFarmLoop or h.teleporting ))then
        return
    end
    local r=o.Character
    local y=r and r:FindFirstChildOfClass( "Humanoid" )
    local u=o:FindFirstChild( "Backpack" )
    if y then
        pcall(function(...) y:UnequipTools()
        end
        )
    end
    if r and u then
        for e,r in ipairs(r:GetChildren())do
            if r:IsA( "Tool" )then
                pcall(function(...) r.Parent =u
                end
                )
            end
        end
    end
end
w4=function(e,...)
    if((h.pureTweenFarm or h.autoFarmLoop ))and not h.holdingEggForGuard then
        local e=e4()
        if e then
            pcall(u4)
        end
        return false
    end
    local r,y=e4()
    if r then
        if e then
            if y==e or not y then
                return true
            end
        else
            return true
        end
    end
    local u=o.Character
    local w=u and u:FindFirstChild( "HumanoidRootPart" )
    if w and w.Position.X <=(E+ 15 )then
        return false
    end
    if s and s.ReadFieldEggs then
        local r,y=pcall(s.ReadFieldEggs )
        if r and(y and y.Records )then
            for r,y in ipairs(y.Records )do
                if((y.State == "Carried" or y.State == 2 ))and((y.CarrierUserId ==o.UserId or y.Carrier ==o.UserId ))then
                    if e then
                        if y.Uid ==e then
                            return true
                        end
                    else
                        return true
                    end
                end
            end
        end
    end
    return false
end
j4=function(e,...)
    local r,y=e4()
    if r then
        if not e or y==e or not y then
            return true
        end
    end
    local u=o:FindFirstChild( "Backpack" )
    if u then
        for r,y in ipairs(u:GetChildren())do
            if m(y)then
                local r=y:GetAttribute( "UID" )or y:GetAttribute( "EggUid" )
                if not e or r==e or y.Name ==tostring(e)then
                    return true
                end
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
                        if e==o.UserId then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end
local m4= false
local function ek(...)
    if m4 then
        return
    end
    local e=R or j:FindFirstChild( "RF/EggWorld/AskFieldEggSnapshot" , true )or j:FindFirstChild( "AskFieldEggSnapshot" , true )or j:FindFirstChild( "Eggs: RequestAreaEggSnapshot" , true )
    if not e or not e:IsA( "RemoteFunction" )then
        return
    end
    m4= true task.spawn (function(...)
        local r,y=pcall(function(...)
            return e:InvokeServer()
        end
        )
        if r and type(y)== "table" then
            local e={}
            local r=y.Records or y
            if type(r)== "table" then
                for r,y in pairs(r)do
                    if type(y)== "table" then
                        if not y.Uid and type(r)== "string" then
                            y.Uid =r
                        end
                        table.insert (e,y)
                    end
                end
            end
            if#e> 0 then
                F4=e G4=os.clock ()
            end
        end
        m4= false
    end
    )
end
task.spawn (function(...)
    while true do
        task.wait ( 1.5 )pcall(ek)
    end
end
)function h4(e,...)
    local y=os.clock ()
    if e or(y-G4>= 1.5 )or not F4 then
        ek()
    end
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
                        if not y.Uid and type(r)== "string" then
                            y.Uid =r
                        end
                        table.insert (e,y)
                    end
                end
            end
            if#e> 0 then
                w=e
            end
        end
    end
    local j={}
    local k={}
    if u then
        for e,r in ipairs(u)do
            if r.Uid then
                k[r.Uid ]= true table.insert (j,r)
            end
        end
    end
    if w then
        for e,r in ipairs(w)do
            if r.Uid and not k[r.Uid ]then
                k[r.Uid ]= true table.insert (j,r)
            end
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
                        local s=r:GetAttribute( "Mutations" )or r:GetAttribute( "Mutation" )table.insert (j,{[ "Uid" ]=y,[ "AssetCategory" ]=u,[ "AreaId" ]=w;
                        [ "Rarity" ]=a,[ "Rank" ]=V,[ "Income" ]=H,[ "BoundsCFrame" ]=e;
                        [ "BottomCFrame" ]=e,[ "CFrame" ]=e;
                        [ "State" ]= "Slot" ;
                        [ "AssetScale" ]=t,[ "Mutations" ]=s,[ "PhysicalModel" ]=r})
                    else
                        for u,w in ipairs(j)do
                            if w.Uid ==y then
                                w.PhysicalModel =r
                                if not w.BoundsCFrame then
                                    w.BoundsCFrame =e
                                end
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
    if not e then
        return false , "NoUid"
    end
    local y=h4( false )
    if y and#y> 0 then
        for r,y in ipairs(y)do
            if y.Uid ==e then
                if(y.State == "Carried" or y.State == 2 )then
                    local e=y.CarrierUserId or y.Carrier
                    if e and e==o.UserId then
                        return true , "CarriedBySelf"
                    else
                        return false , "CarriedByOther"
                    end
                end
                if(y.State == "Slot" or y.State == "Dropped" or y.State == "GuardCarried" or y.State == 1 )then
                    return true , "Available"
                end
                local e=y.CarrierUserId or y.Carrier
                if e then
                    if e==o.UserId then
                        return true , "CarriedBySelf"
                    else
                        return false , "CarriedByOther"
                    end
                end
                return true , "Available"
            end
        end
    end
    local u=r:FindFirstChild( "AreaEggSlotsClient" )
    if u then
        for r,y in ipairs(u:GetChildren())do
            if y.Name ==tostring(e)or y:GetAttribute( "UID" )==e or y:GetAttribute( "Uid" )==e then
                return true , "Available"
            end
        end
    end
    return true , "Unchecked"
end
a4=function(...)
    local e,r=e4()
    if not r then
        local e,y=r4()r=y
    end
    if not r then
        return false
    end
    if s and s.ReadFieldEggs then
        local e,u=pcall(s.ReadFieldEggs )
        if e and(u and u.Records )then
            for e,u in ipairs(u.Records )do
                if u.Uid ==r then
                    local e=tostring(u.AreaId or "" )
                    if e== "Lake" or string.find (string.lower (e), "lake" )~=nil then
                        return true
                    end
                end
            end
        end
    end
    if string.find (string.lower (tostring(r)), "lake" )~=nil then
        return true
    end
    return false
end
o4=function(...)
    local e,r=e4()
    if not r then
        local e,y=r4()r=y
    end
    if not r then
        return h.glideSpeed or 350
    end
    if s and s.ReadFieldEggs then
        local e,u=pcall(s.ReadFieldEggs )
        if e and(u and u.Records )then
            for e,u in ipairs(u.Records )do
                if u.Uid ==r and u.AreaId then
                    return I[u.AreaId ]or h.glideSpeed or 350
                end
            end
        end
    end
    return h.glideSpeed or 350
end
V4=function(e,y,...) y=y or 8
    local u=Instance.new ( "Part" )u.Name = "SafetyFloorPad_AntiVoid" u.Size =Vector3.new ( 28 , 1.5 , 28 )u.Position =e-Vector3.new ( 0 , 3.2 , 0 )u.Anchored = true u.Transparency = 1 u.CanCollide = true u.Parent =r task.delay (y,function(...) pcall(function(...) u:Destroy()
        end
        )
    end
    )
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
                P:FireServer({[ "EggUid" ]=e;
                [ "GuardCFrame" ]=u})
            end
        end
        )
    end
end
if typeof(hookmetamethod)== "function" and not _G._DesyncAntiRagdollHooked then
    _G._DesyncAntiRagdollHooked = true
    local e e=hookmetamethod(game, "__newindex" ,safeNewCClosure(function(r,y,u,...)
        if not executorCheckCaller()and typeof(r)== "Instance" then
            if r:IsA( "Motor6D" )and(y== "Enabled" and u== false )then
                return nil
            end
            if r:IsA( "Humanoid" )then
                if y== "PlatformStand" and u== true then
                    return nil
                end
                if y== "Sit" and(u== true and((h.pureTweenFarm or h.autoFarmLoop or h.isReturning or h.glidingToTarget )))then
                    return nil
                end
            end
        end
        return e(r,y,u)
    end
    ))
end
S4=function(e,...) e=e or o.Character
    if not e then
        return
    end
    local r=e:FindFirstChild( "HumanoidRootPart" )
    local y=e:FindFirstChild( "Torso" )or e:FindFirstChild( "UpperTorso" )or r
    if not y then
        return
    end
    for e,r in ipairs(e:GetDescendants())do
        if r:IsA( "BallSocketConstraint" )or r:IsA( "HingeConstraint" )or r:IsA( "NoCollisionConstraint" )then
            pcall(function(...) r:Destroy()
            end
            )
        end
    end
    for e,r in ipairs(e:GetDescendants())do
        if r:IsA( "Motor6D" )and(r.Part0 and r.Part1 )then
            r.Enabled = true
            local e= "RigidJointWeld_" ..r.Name
            local y=r.Part1 :FindFirstChild(e)
            if not y then
                local y=Instance.new ( "WeldConstraint" )y.Name =e y.Part0 =r.Part0 y.Part1 =r.Part1 y.Parent =r.Part1
            end
        end
    end
end
Z4=function(e,...)
    if h and h.onTreadmill then
        return
    end
    e=e or o.Character
    if not e then
        return
    end
    local r=e:FindFirstChildOfClass( "Humanoid" )
    if r then
        r:SetStateEnabled(Enum.HumanoidStateType.Ragdoll , false )r:SetStateEnabled(Enum.HumanoidStateType.FallingDown , false )r:SetStateEnabled(Enum.HumanoidStateType.Physics , false )r:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding , false )r:SetStateEnabled(Enum.HumanoidStateType.Seated , false )
        if r.PlatformStand then
            r.PlatformStand = false
        end
        if r.Sit then
            r.Sit = false
        end
    end
    for e,r in ipairs(e:GetDescendants())do
        if r:IsA( "LocalScript" )and((string.find (string.lower (r.Name ), "ragdoll" )or string.find (string.lower (r.Name ), "fall" )))then
            r.Disabled = true
        end
    end
    S4(e)
end
z4=function(e,...)
    if not e then
        return
    end
    Z4(e)
    for e,y in ipairs(e:GetDescendants())do
        if y:IsA( "Motor6D" )then
            (y:GetPropertyChangedSignal( "Enabled" )):Connect(function(...)
                if not y.Enabled then
                    y.Enabled = true
                end
            end
            )
        end
    end
    e.DescendantAdded :Connect(function(y,...)
        if y:IsA( "BallSocketConstraint" )or y:IsA( "HingeConstraint" )or y:IsA( "NoCollisionConstraint" )then
            task.defer (function(...) pcall(function(...) y:Destroy()
                end
                )Z4(e)
            end
            )
        elseif y:IsA( "LocalScript" )and((string.find (string.lower (y.Name ), "ragdoll" )or string.find (string.lower (y.Name ), "fall" )))then
            y.Disabled = true
        end
    end
    )e.ChildAdded :Connect(function(e,...)
        if e:IsA( "Tool" )and(((h.pureTweenFarm or h.autoFarmLoop ))and not h.holdingEggForGuard )then
            task.defer (function(...) u4()
            end
            )
        end
    end
    )
end
C4=function(...)
    if h then
        h.onTreadmill = false
    end
    local e=o.Character
    local r=e and e:FindFirstChildOfClass( "Humanoid" )
    local y=e and e:FindFirstChild( "HumanoidRootPart" )
    if U then
        task.spawn (function(...) pcall(function(...) U:InvokeServer()
            end
            )
        end
        )
    end
    if r then
        pcall(function(...)
            for r,y in ipairs(r:GetPlayingAnimationTracks())do
                local u=y.Animation
                local w=u and u.AnimationId or ""
                if string.find (w, "10921259953" )or string.find (string.lower (y.Name ), "treadmill" )or string.find (string.lower (y.Name ), "run" )then
                    y:Stop( 0 )
                end
            end
            r.PlatformStand = false r.Sit = false r:SetStateEnabled(Enum.HumanoidStateType.Running , true )r:SetStateEnabled(Enum.HumanoidStateType.Jumping , true )r:ChangeState(Enum.HumanoidStateType.Running )
        end
        )
    end
    local u=o:FindFirstChild( "PlayerGui" )
    if u then
        local e=u:FindFirstChild( "SpeedGainAnimation" )
        if e then
            pcall(function(...) e:Destroy()
            end
            )
        end
    end
    if y then
        y.AssemblyLinearVelocity =Vector3.zero y.AssemblyAngularVelocity =Vector3.zero
    end
    Z4(e)
end
local rk= 0
local yk= false E4=function(...)
    local e=o:FindFirstChild( "PlayerGui" )
    if not e then
        return false
    end
    local r= false pcall(function(...)
        for e,u in ipairs(e:GetChildren())do
            if u:IsA( "ScreenGui" )and u.Enabled then
                for e,u in ipairs(u:GetDescendants())do
                    if((u:IsA( "TextButton" )or u:IsA( "ImageButton" )))and u.Visible then
                        local e=(u:IsA( "TextButton" )and u.Text )or u.Name
                        local w=string.lower (e or "" )
                        if string.find (w, "get out" )or string.find (w, "treadmill" )or string.find (w, "doff" )or string.find (w, "leave" )or string.find (w, "exit" )then
                            if typeof(firesignal)== "function" and u.Activated then
                                pcall(firesignal,u.Activated )
                            elseif typeof(firesignal)== "function" and u.MouseButton1Click then
                                pcall(firesignal,u.MouseButton1Click )
                            elseif typeof(getconnections)== "function" then
                                local e=getconnections(u.MouseButton1Click )or getconnections(u.Activated )or{}
                                for e,r in ipairs(e)do
                                    pcall(function(...) r:Fire()
                                    end
                                    )
                                    break
                                end
                            end
                            r= true
                            break
                        end
                    end
                end
            end
        end
    end
    )
    return r
end

--------------------------------------------------------------------------------
-- CH3A5 HUB - ANGKOR KHMER AESTHETIC GUI ENGINE REBUILD
--------------------------------------------------------------------------------

local function createKhmerGUI()
    local oldGUI = o.PlayerGui:FindFirstChild("CH3A5_HUB") or o.PlayerGui:FindFirstChild("DiceHubGUI")
    if oldGUI then oldGUI:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "CH3A5_HUB"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = o:WaitForChild("PlayerGui")
    h.gui = gui

    -- Theme Palette
    local COLOR_BG = Color3.fromRGB(15, 16, 19)
    local COLOR_CONTAINER = Color3.fromRGB(24, 26, 31)
    local COLOR_CARD = Color3.fromRGB(32, 35, 42)
    local COLOR_GOLD = Color3.fromRGB(212, 175, 55)
    local COLOR_GOLD_DARK = Color3.fromRGB(140, 110, 30)
    local COLOR_TEXT_MAIN = Color3.fromRGB(240, 235, 220)
    local COLOR_TEXT_MUTED = Color3.fromRGB(150, 153, 160)
    local COLOR_TOGGLE_ON = Color3.fromRGB(212, 175, 55)
    local COLOR_TOGGLE_OFF = Color3.fromRGB(45, 48, 56)

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 560, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -280, 0.5, -200)
    mainFrame.BackgroundColor3 = COLOR_BG
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim me and UDim.new(0, 12) or UDim.new(0, 12)
    corner.Parent = mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = COLOR_GOLD
    stroke.Thickness = 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = mainFrame

    -- Khmer Geometric Watermark Backdrop
    local patternBg = Instance.new("ImageLabel")
    patternBg.Name = "PatternBg"
    patternBg.Size = UDim2.new(1, 0, 1, 0)
    patternBg.BackgroundTransparency = 1
    patternBg.Image = "rbxassetid://8524312261" -- Ornamental Motif / Pattern
    patternBg.ImageColor3 = COLOR_GOLD
    patternBg.ImageTransparency = 0.95
    patternBg.ScaleType = Enum.ScaleType.Tile
    patternBg.TileSize = UDim2.new(0, 120, 0, 120)
    patternBg.Parent = mainFrame

    -- Header Bar
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 48)
    header.BackgroundColor3 = COLOR_CONTAINER
    header.BorderSizePixel = 0
    header.Parent = mainFrame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header

    -- Khmer Ornamental Top Banner Motif
    local topMotif = Instance.new("Frame")
    topMotif.Size = UDim2.new(1, -20, 0, 2)
    topMotif.Position = UDim2.new(0, 10, 1, -2)
    topMotif.BackgroundColor3 = COLOR_GOLD
    topMotif.BorderSizePixel = 0
    topMotif.Parent = header

    local topMotifGrad = Instance.new("UIGradient")
    topMotifGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15,16,19)),
        ColorSequenceKeypoint.new(0.5, COLOR_GOLD),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15,16,19))
    })
    topMotifGrad.Parent = topMotif

    -- Title Branding
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = "CH3A5 HUB"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = COLOR_GOLD
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Position = UDim2.new(0, 16, 0, 0)
    title.Size = UDim2.new(0, 200, 1, 0)
    title.BackgroundTransparency = 1
    title.Parent = header

    local subTitle = Instance.new("TextLabel")
    subTitle.Text = "🇰🇭 ANGKOR EDITION"
    subTitle.Font = Enum.Font.GothamMedium
    subTitle.TextSize = 10
    subTitle.TextColor3 = COLOR_TEXT_MUTED
    subTitle.TextXAlignment = Enum.TextXAlignment.Left
    subTitle.Position = UDim2.new(0, 125, 0, 2)
    subTitle.Size = UDim2.new(0, 150, 1, 0)
    subTitle.BackgroundTransparency = 1
    subTitle.Parent = header

    -- Minimize Button
    local minBtn = Instance.new("TextButton")
    minBtn.Name = "MinBtn"
    minBtn.Text = "—"
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 16
    minBtn.TextColor3 = COLOR_TEXT_MUTED
    minBtn.Size = UDim2.new(0, 32, 0, 32)
    minBtn.Position = UDim2.new(1, -40, 0, 8)
    minBtn.BackgroundColor3 = COLOR_CARD
    minBtn.AutoButtonColor = false
    minBtn.Parent = header

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minBtn

    -- Sidebar Nav
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 130, 1, -56)
    sidebar.Position = UDim2.new(0, 8, 0, 52)
    sidebar.BackgroundColor3 = COLOR_CONTAINER
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame

    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 8)
    sideCorner.Parent = sidebar

    local sideList = Instance.new("UIListLayout")
    sideList.SortOrder = Enum.SortOrder.LayoutOrder
    sideList.Padding = UDim.new(0, 4)
    sideList.Parent = sidebar

    local sidePadding = Instance.new("UIPadding")
    sidePadding.PaddingTop = UDim.new(0, 8)
    sidePadding.PaddingLeft = UDim.new(0, 6)
    sidePadding.PaddingRight = UDim.new(0, 6)
    sidePadding.Parent = sidebar

    -- Page Container
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, -154, 1, -56)
    container.Position = UDim2.new(0, 146, 0, 52)
    container.BackgroundTransparency = 1
    container.Parent = mainFrame

    local pages = {}

    local function createPage(name)
        local page = Instance.new("ScrollingFrame")
        page.Name = name .. "Page"
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 3
        page.ScrollBarImageColor3 = COLOR_GOLD
        page.Visible = false
        page.Parent = container

        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 6)
        layout.Parent = page

        local pad = Instance.new("UIPadding")
        pad.PaddingRight = UDim.new(0, 6)
        pad.Parent = page

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 12)
        end)

        pages[name] = page
        return page
    end

    local mainPage = createPage("Main")
    local zonesPage = createPage("Zones")
    local raritiesPage = createPage("Rarities")
    local settingsPage = createPage("Settings")
    mainPage.Visible = true

    -- Navigation Tabs Handler
    local activeTabBtn = nil
    local function addTab(name, labelText)
        local btn = Instance.new("TextButton")
        btn.Name = name .. "Tab"
        btn.Text = labelText
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 12
        btn.TextColor3 = COLOR_TEXT_MUTED
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.BackgroundColor3 = COLOR_CARD
        btn.BackgroundTransparency = 0.5
        btn.AutoButtonColor = false
        btn.Parent = sidebar

        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 6)
        bCorner.Parent = btn

        local stroke = Instance.new("UIStroke")
        stroke.Color = COLOR_GOLD
        stroke.Thickness = 1
        stroke.Transparency = 1
        stroke.Parent = btn

        btn.MouseButton1Click:Connect(function()
            for pageName, pageObj in pairs(pages) do
                pageObj.Visible = (pageName == name)
            end
            for _, child in ipairs(sidebar:GetChildren()) do
                if child:IsA("TextButton") then
                    u:Create(child, TweenInfo.new(0.2), {BackgroundTransparency = 0.5, TextColor3 = COLOR_TEXT_MUTED}):Play()
                    local s = child:FindFirstChildOfClass("UIStroke")
                    if s then s.Transparency = 1 end
                end
            end
            u:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, TextColor3 = COLOR_GOLD}):Play()
            stroke.Transparency = 0
        end)

        if name == "Main" then
            btn.BackgroundTransparency = 0
            btn.TextColor3 = COLOR_GOLD
            stroke.Transparency = 0
        end
    end

    addTab("Main", "🏰 Control")
    addTab("Zones", "🗺️ World Zones")
    addTab("Rarities", "🔮 Rarities")
    addTab("Settings", "⚙️ Hub Config")

    -- UI Component Constructors with Khmer Temple Styling
    local function createToggle(parent, text, state, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 36)
        frame.BackgroundColor3 = COLOR_CONTAINER
        frame.Parent = parent

        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 6)
        fCorner.Parent = frame

        local fStroke = Instance.new("UIStroke")
        fStroke.Color = COLOR_GOLD_DARK
        fStroke.Thickness = 1
        fStroke.Transparency = 0.6
        fStroke.Parent = frame

        local lbl = Instance.new("TextLabel")
        lbl.Text = text
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextSize = 12
        lbl.TextColor3 = COLOR_TEXT_MAIN
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Position = UDim2.new(0, 10, 0, 0)
        lbl.Size = UDim2.new(1, -60, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Parent = frame

        local tog = Instance.new("TextButton")
        tog.Text = ""
        tog.Size = UDim2.new(0, 40, 0, 20)
        tog.Position = UDim2.new(1, -48, 0.5, -10)
        tog.BackgroundColor3 = state and COLOR_TOGGLE_ON or COLOR_TOGGLE_OFF
        tog.AutoButtonColor = false
        tog.Parent = frame

        local tCorner = Instance.new("UICorner")
        tCorner.CornerRadius = UDim.new(1, 0)
        tCorner.Parent = tog

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 16, 0, 16)
        knob.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        knob.Parent = tog

        local kCorner = Instance.new("UICorner")
        kCorner.CornerRadius = UDim.new(1, 0)
        kCorner.Parent = knob

        local active = state
        tog.MouseButton1Click:Connect(function()
            active = not active
            u:Create(tog, TweenInfo.new(0.2), {BackgroundColor3 = active and COLOR_TOGGLE_ON or COLOR_TOGGLE_OFF}):Play()
            u:Create(knob, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
            pcall(callback, active)
        end)

        return frame
    end

    local function createButton(parent, text, callback)
        local btn = Instance.new("TextButton")
        btn.Text = text
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.TextColor3 = COLOR_TEXT_MAIN
        btn.Size = UDim2.new(1, 0, 0, 34)
        btn.BackgroundColor3 = COLOR_CONTAINER
        btn.AutoButtonColor = false
        btn.Parent = parent

        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 6)
        bCorner.Parent = btn

        local bStroke = Instance.new("UIStroke")
        bStroke.Color = COLOR_GOLD
        bStroke.Thickness = 1
        bStroke.Transparency = 0.5
        bStroke.Parent = btn

        btn.MouseButton1Click:Connect(function()
            u:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = COLOR_GOLD, TextColor3 = COLOR_BG}):Play()
            task.delay(0.15, function()
                u:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_CONTAINER, TextColor3 = COLOR_TEXT_MAIN}):Play()
            end)
            pcall(callback)
        end)

        return btn
    end

    -- POPULATE MAIN TAB
    createToggle(mainPage, "Auto Farm Loop", h.autoFarmLoop, function(v) h.autoFarmLoop = v end)
    createToggle(mainPage, "Pure Tween Farm", h.pureTweenFarm, function(v) h.pureTweenFarm = v end)
    createToggle(mainPage, "Godmode / Desync", h.godmode, function(v) h.godmode = v end)
    createToggle(mainPage, "Auto Glide", h.autoGlide, function(v) h.autoGlide = v end)
    createToggle(mainPage, "Auto Hatch", h.autoHatch, function(v) h.autoHatch = v end)
    createToggle(mainPage, "Auto Treadmill", h.autoTreadmill, function(v) h.autoTreadmill = v x() end)
    createToggle(mainPage, "Auto Upgrade Treadmill", h.autoUpgradeTreadmill, function(v) h.autoUpgradeTreadmill = v x() end)

    -- POPULATE ZONES TAB
    for _, zoneName in ipairs(M) do
        local state = h.selectedZones[zoneName] == true
        createToggle(zonesPage, zoneName, state, function(v)
            h.selectedZones[zoneName] = v
            x()
        end)
    end

    -- POPULATE RARITIES TAB
    for _, rarityName in ipairs(X) do
        local state = h.selectedRarities[rarityName] == true
        createToggle(raritiesPage, rarityName, state, function(v)
            h.selectedRarities[rarityName] = v
            x()
        end)
    end

    -- POPULATE SETTINGS TAB
    createToggle(settingsPage, "Performance Mode", h.performanceMode, function(v) h.performanceMode = v x() end)
    createToggle(settingsPage, "Disable 3D Rendering", h.disable3D, function(v)
        h.disable3D = v
        game:GetService("RunService"):Set3dRenderingEnabled(not v)
        x()
    end)
    createToggle(settingsPage, "Anti-AFK Protection", h.antiAFK, function(v) h.antiAFK = v x() end)

    -- Collapse / Minimize Window Handler
    local isMin = false
    minBtn.MouseButton1Click:Connect(function()
        isMin = not isMin
        if isMin then
            u:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 560, 0, 48)}):Play()
            sidebar.Visible = false
            container.Visible = false
        else
            sidebar.Visible = true
            container.Visible = true
            u:Create(mainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 560, 0, 400)}):Play()
        end
    end)

    Window = {
        MainFrame = mainFrame,
        Gui = gui
    }
end

-- Initialize the GUI rebuild seamlessly
pcall(createKhmerGUI)
