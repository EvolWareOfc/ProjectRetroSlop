
--// Library
local LIBRARY_URL = "https://raw.githubusercontent.com/EvolWareOfc/ProjectRetroSlop/refs/heads/main/UI/v0.0.2"

local Library
do
	local ok, result = pcall(function()
		return loadstring(game:HttpGet(LIBRARY_URL))()
	end)
	if not ok or type(result) ~= "table" then
		error("[Bloxrooms] RetroSlop didn't load (" .. tostring(result) .. "). Set LIBRARY_URL to the RAW link of RetroSlop.lua.", 0)
	end
	Library = result
end

Library.Folder = "BloxroomsHub"
local Flags = Library.Flags

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

--// Settings
local CFG = {
	PlayerESP = false,
	EntityESP = true,
	ArtifactESP = true,
	EscapeESP = true,
	ArtifactSpawnESP = false,
	MaxDistance = 600,
	ShowDistance = true,
	ShowRarity = true,

	SpeedEnabled = false,
	WalkSpeed = 18,
	FlyEnabled = false,
	FlySpeed = 40,
	Noclip = false,
	InfiniteJump = false,
	Fullbright = false,
	SilentFeet = true,
	InfiniteStamina = true,
	InstantPrompts = true,

	AutoCollect = false,
	AutoFarm = false,
	AutoCollectRange = 18,
	AutoFarmDelay = 0.55,
	UnlockTPDelay = 0.35,
}

local ESP = {}
local flyBV, flyBG
local flying = false
local lastEmptyNotify = 0
local unlockRunning = false
local savedLighting = nil
local promptConnection = nil

local COLORS = {
	Good = Color3.fromRGB(180, 255, 25),
	Warn = Color3.fromRGB(255, 208, 0),
	Bad = Color3.fromRGB(255, 90, 100),
	Muted = Color3.fromRGB(216, 222, 228),
}

--// Remotes
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Remotes = Shared:WaitForChild("Remotes")
local ArtifactsRF = Remotes:WaitForChild("Artifacts")
local CollectArtifact = ArtifactsRF:WaitForChild("CollectArtifact")
local GetInventory = ArtifactsRF:FindFirstChild("GetInventory")
local ShopRF = Remotes:WaitForChild("Shop")
local SellAllArtifacts = ShopRF:FindFirstChild("SellAllArtifacts")
local CodesRF = Remotes:WaitForChild("Codes")
local RedeemCode = CodesRF:WaitForChild("RedeemCode")
local LocationsRF = Remotes:FindFirstChild("Locations")
local FastTravel = LocationsRF and LocationsRF:FindFirstChild("FastTravel")

--// Helpers
local function notify(title, content, style)
	Library:Notify({ Title = title, Content = content, Style = style or "Info", Duration = 2.8 })
end

local function camera()
	return Workspace.CurrentCamera
end

local function hrp(plr)
	local c = (plr or LocalPlayer).Character
	return c and c:FindFirstChild("HumanoidRootPart")
end

local function hum(plr)
	local c = (plr or LocalPlayer).Character
	return c and c:FindFirstChildOfClass("Humanoid")
end

local function alive(plr)
	local h = hum(plr)
	return h and h.Health > 0
end

local function getPart(obj)
	if not obj then
		return nil
	end
	if obj:IsA("BasePart") then
		return obj
	end
	if obj:IsA("Model") then
		if obj.PrimaryPart then
			return obj.PrimaryPart
		end
		local r = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("PickupAnchor")
		if r then
			return r
		end
	end
	return obj:FindFirstChildWhichIsA("BasePart", true)
end

local function tpPos(pos)
	local r = hrp()
	if r and pos then
		r.AssemblyLinearVelocity = Vector3.zero
		r.CFrame = CFrame.new(pos + Vector3.new(0, 4, 0))
	end
end

local function tpObj(obj)
	local p = getPart(obj)
	if p then
		tpPos(p.Position)
		return true
	end
	return false
end

local RARITY_COLORS = {
	Common = Color3.fromRGB(180, 180, 180),
	Uncommon = Color3.fromRGB(80, 200, 120),
	Rare = Color3.fromRGB(70, 140, 255),
	Epic = Color3.fromRGB(180, 90, 255),
	Legendary = Color3.fromRGB(255, 180, 40),
	Mythic = Color3.fromRGB(255, 60, 100),
}
local RARITY_ORDER = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic" }

local function rarityColor(rarity)
	return RARITY_COLORS[rarity] or Color3.fromRGB(80, 255, 140)
end

--// ESP
local function clearESP(obj)
	local d = ESP[obj]
	if not d then
		return
	end
	pcall(function()
		if d.Highlight then
			d.Highlight:Destroy()
		end
		if d.Billboard then
			d.Billboard:Destroy()
		end
	end)
	ESP[obj] = nil
end

local function clearAllESP()
	for obj in pairs(ESP) do
		clearESP(obj)
	end
end

local function clearKind(kind)
	for obj, data in pairs(ESP) do
		if data.Kind == kind then
			clearESP(obj)
		end
	end
end

local function addESP(obj, color, name, kind)
	if ESP[obj] then
		return
	end
	local part = getPart(obj)
	if not part then
		return
	end
	local adornee = obj:IsA("Model") and obj or part

	local hl = Instance.new("Highlight")
	hl.Adornee = adornee
	hl.FillColor = color
	hl.OutlineColor = Color3.new(1, 1, 1)
	hl.FillTransparency = 0.62
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = adornee

	local bb = Instance.new("BillboardGui")
	bb.Adornee = part
	bb.Size = UDim2.fromOffset(200, 36)
	bb.StudsOffset = Vector3.new(0, 2.6, 0)
	bb.AlwaysOnTop = true
	bb.Parent = part

	local label = Instance.new("TextLabel")
	label.Size = UDim2.fromScale(1, 1)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBlack
	label.TextSize = 13
	label.TextColor3 = color
	label.TextStrokeTransparency = 0
	label.Text = name
	label.Parent = bb

	ESP[obj] = {
		Highlight = hl,
		Billboard = bb,
		Label = label,
		Part = part,
		Name = name,
		Kind = kind or "generic",
	}
end

--// Artifacts
local function isArtifact(obj)
	if not obj then
		return false
	end
	return obj:GetAttribute("ArtifactSpawnId") ~= nil or obj:GetAttribute("ArtifactId") ~= nil
end

local function artifactFolders()
	local list = {}
	local spawns = Workspace:FindFirstChild("ArtifactSpawns")
	if spawns then
		local active = spawns:FindFirstChild("ActiveArtifacts")
		if active then
			table.insert(list, active)
		end
		local common = spawns:FindFirstChild("Common")
		if common then
			table.insert(list, common)
		end
	end
	local dropped = Workspace:FindFirstChild("DroppedArtifacts")
	if dropped then
		table.insert(list, dropped)
	end
	local newnew = Workspace:FindFirstChild("ARTIFACTSNEWNEW")
	if newnew then
		table.insert(list, newnew)
	end
	return list
end

local function countArtifacts()
	local n = 0
	for _, folder in ipairs(artifactFolders()) do
		for _, child in ipairs(folder:GetChildren()) do
			if isArtifact(child) then
				n += 1
			end
		end
	end
	return n
end

local function artifactName(obj)
	return tostring(obj:GetAttribute("ArtifactDisplayName") or obj:GetAttribute("ArtifactId") or obj.Name)
end

local function collectOne(obj)
	if not isArtifact(obj) then
		return false
	end
	local id = obj:GetAttribute("ArtifactId") or obj:GetAttribute("ArtifactDisplayName") or obj.Name
	local spawnId = obj:GetAttribute("ArtifactSpawnId") or obj.Name
	local ok, res = pcall(function()
		return CollectArtifact:InvokeServer(id, spawnId)
	end)
	return ok and type(res) == "table" and res.Success
end

local function nearestArtifact()
	local root = hrp()
	if not root then
		return nil, nil
	end
	local best, bestDist, bestPart = nil, math.huge, nil
	for _, folder in ipairs(artifactFolders()) do
		for _, child in ipairs(folder:GetChildren()) do
			if isArtifact(child) then
				local p = getPart(child)
				if p then
					local d = (root.Position - p.Position).Magnitude
					if d < bestDist then
						bestDist, best, bestPart = d, child, p
					end
				end
			end
		end
	end
	return best, bestPart
end

local function inventoryValue()
	if not GetInventory then
		notify("Inventory", "GetInventory remote missing", "Error")
		return nil
	end
	local ok, data = pcall(function()
		return GetInventory:InvokeServer()
	end)
	if not ok or type(data) ~= "table" then
		notify("Inventory", "Failed to fetch inventory", "Error")
		return nil
	end

	local artifacts = data.Artifacts or (data.Payload and data.Payload.Artifacts) or data
	if type(artifacts) ~= "table" then
		notify("Inventory", "Could not read artifacts", "Error")
		return nil
	end

	local totalValue, totalCount, rows = 0, 0, {}
	for _, entry in ipairs(artifacts) do
		local count = tonumber(entry.Count) or 0
		local value = tonumber(entry.Value) or 0
		if count > 0 then
			totalCount += count
			totalValue += count * value
			table.insert(rows, {
				Name = entry.Name or entry.Id or "Unknown",
				Count = count,
				Value = value,
				Rarity = entry.Rarity or "Common",
			})
		end
	end
	table.sort(rows, function(a, b)
		return (a.Count * a.Value) > (b.Count * b.Value)
	end)
	return totalValue, totalCount, rows
end

local function sellAll()
	if not SellAllArtifacts then
		notify("Shop", "SellAllArtifacts remote missing", "Error")
		return
	end
	local ok = pcall(function()
		return SellAllArtifacts:InvokeServer()
	end)
	notify("Shop", ok and "Sold all artifacts" or "Sell all failed", ok and "Success" or "Error")
end

--// Entities
local KNOWN_ENTITIES = {
	"Builderman", "Roblox", "Shedletsky", "Coolkid", "1x1x1x1", "DenisDaily", "666",
}

local function entitiesFolder()
	return Workspace:FindFirstChild("Entities")
end

local function listEntities()
	local out = {}
	local folder = entitiesFolder()
	if not folder then
		return out
	end
	for _, child in ipairs(folder:GetChildren()) do
		if child:IsA("Model") or child:IsA("BasePart") then
			table.insert(out, child)
		end
	end
	table.sort(out, function(a, b)
		return a.Name < b.Name
	end)
	return out
end

local function isEntity(model)
	if not model or not model:IsA("Model") then
		return false
	end
	if Players:GetPlayerFromCharacter(model) then
		return false
	end
	local folder = entitiesFolder()
	if folder and model:IsDescendantOf(folder) then
		return true
	end
	return model:GetAttribute("CollectionId") ~= nil or model:HasTag("Entity")
end

--// Escape
local function getActiveEscapes()
	local out = {}
	local folder = Workspace:FindFirstChild("Escapes")
	if not folder then
		return out
	end
	for _, child in ipairs(folder:GetChildren()) do
		if child.Name == "Escape" and child:GetAttribute("EscapeActive") == true then
			table.insert(out, child)
		end
	end
	return out
end

local function escapeOpen()
	return Workspace:GetAttribute("EscapeExitOpen") == true
end

local function escapeCFrame()
	local cf = Workspace:GetAttribute("EscapeExitCFrame")
	if typeof(cf) == "CFrame" then
		return cf
	end
	return nil
end

local function tpActiveEscape()
	if escapeOpen() then
		local cf = escapeCFrame()
		if cf then
			tpPos(cf.Position)
			notify("Escape", "Teleported to the open exit", "Success")
			return
		end
	end
	local actives = getActiveEscapes()
	if #actives > 0 then
		local door = actives[1]:FindFirstChild("Door", true)
		if (door and tpObj(door)) or tpObj(actives[1]) then
			notify("Escape", "Teleported to the active escape", "Success")
			return
		end
	end
	notify("Escape", "No active exit found", "Warning")
end

--// Locations & Still Lifes
local LOCATION_NAMES = {
	"ChaosCanyon", "Cheese", "ClassicHouse", "Doomspire", "ElephantHotel",
	"FakeRobloxia", "FakeSuburban", "FloodEscape2", "Highschool", "KohlsAdmin",
	"LumberTycoon", "MiniHQ", "PartyExe", "PizzaPlace", "PizzaPlaceTown",
	"PoliceStation", "RedCity", "SFOTH", "SpeakerRooms", "StarterCabin",
	"StartingZone", "TeaPotRoom", "Visuals", "ZombieAttack", "Christmas",
}

local STILL_LIFE_NAMES = {
	"Guide", "Subject_0", "Piggy", "Flamingo", "Doge", "Cop",
	"Prisoner", "PizzaGuy", "Highschooler", "ClassicHouseNoob",
	"DoomspireNoob", "EthanGamer", "Jeff", "Michael",
}

local CODES = { "1M", "UPDATE1", "500K" }

local function findLocation(name)
	local root = Workspace:FindFirstChild("LocationDiscovery")
	if not root then
		return nil
	end
	for _, folderName in ipairs({ "Destinations", "Zones" }) do
		local folder = root:FindFirstChild(folderName)
		if folder then
			local exact = folder:FindFirstChild(name)
			if exact then
				return exact
			end
			for _, child in ipairs(folder:GetChildren()) do
				local compact = string.gsub(child.Name, "%s+", "")
				if string.lower(compact) == string.lower(name) or string.lower(child.Name) == string.lower(name) then
					return child
				end
			end
		end
	end
	return nil
end

local function allLocations()
	local out, seen = {}, {}
	local root = Workspace:FindFirstChild("LocationDiscovery")
	if not root then
		return out
	end
	for _, folderName in ipairs({ "Destinations", "Zones" }) do
		local folder = root:FindFirstChild(folderName)
		if folder then
			for _, child in ipairs(folder:GetChildren()) do
				if not seen[child.Name] then
					seen[child.Name] = true
					table.insert(out, child)
				end
			end
		end
	end
	table.sort(out, function(a, b)
		return a.Name < b.Name
	end)
	return out
end

local function stillLifeNPCs()
	local out = {}
	local folder = Workspace:FindFirstChild("StillLifes")
	if folder then
		for _, child in ipairs(folder:GetChildren()) do
			table.insert(out, child)
		end
	end
	table.sort(out, function(a, b)
		return a.Name < b.Name
	end)
	return out
end

local function stillLifeAreas()
	local out = {}
	local npc = Workspace:FindFirstChild("NpcAreas")
	local sl = npc and npc:FindFirstChild("StillLifes")
	if sl then
		for _, child in ipairs(sl:GetChildren()) do
			if child.Name ~= "Template" then
				table.insert(out, child)
			end
		end
	end
	table.sort(out, function(a, b)
		return a.Name < b.Name
	end)
	return out
end

local function tryFastTravel(name)
	if FastTravel then
		local ok = pcall(function()
			FastTravel:InvokeServer(name)
		end)
		if ok then
			notify("Fast Travel", name, "Success")
			return true
		end
	end
	local loc = findLocation(name)
	if loc and tpObj(loc) then
		notify("Location", name, "Success")
		return true
	end
	notify("Location", name .. " not found", "Warning")
	return false
end

local function redeem(code)
	code = code and string.gsub(code, "^%s*(.-)%s*$", "%1") or ""
	if code == "" then
		notify("Codes", "Enter a code first", "Warning")
		return
	end
	local ok = pcall(function()
		return RedeemCode:InvokeServer(code)
	end)
	notify(ok and "Code Redeemed" or "Code Failed", ok and code or ("Couldn't redeem " .. code), ok and "Success" or "Error")
end

--// Movement
local function forCharacterDescendants(callback)
	local char = LocalPlayer.Character
	if not char then
		return
	end
	for _, d in ipairs(char:GetDescendants()) do
		callback(d)
	end
end

local function silentFeet()
	forCharacterDescendants(function(d)
		if d:IsA("Sound") then
			local n = string.lower(d.Name)
			if string.find(n, "foot") or string.find(n, "step") or string.find(n, "walk") or string.find(n, "run") then
				d.Volume = 0
			end
		end
	end)
end

local function infiniteStamina()
	forCharacterDescendants(function(d)
		if d:IsA("NumberValue") or d:IsA("IntValue") then
			local n = string.lower(d.Name)
			if string.find(n, "stamina") or string.find(n, "energy") then
				d.Value = 999
			end
		end
	end)
end

local function startFly()
	if flying then
		return
	end
	local r = hrp()
	if not r then
		return
	end
	flying = true
	flyBV = Instance.new("BodyVelocity")
	flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	flyBV.Velocity = Vector3.zero
	flyBV.Parent = r
	flyBG = Instance.new("BodyGyro")
	flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	flyBG.P = 18000
	flyBG.Parent = r
end

local function stopFly()
	flying = false
	if flyBV then
		flyBV:Destroy()
		flyBV = nil
	end
	if flyBG then
		flyBG:Destroy()
		flyBG = nil
	end
end

local function setFullbright(enabled)
	if enabled then
		if not savedLighting then
			savedLighting = {
				Brightness = Lighting.Brightness,
				ClockTime = Lighting.ClockTime,
				FogEnd = Lighting.FogEnd,
				GlobalShadows = Lighting.GlobalShadows,
				Ambient = Lighting.Ambient,
			}
		end
	elseif savedLighting then
		for property, value in savedLighting do
			Lighting[property] = value
		end
		savedLighting = nil
	end
end

local function setInstantPrompts(enabled)
	if promptConnection then
		promptConnection:Disconnect()
		promptConnection = nil
	end
	if not enabled then
		return
	end
	for _, d in ipairs(Workspace:GetDescendants()) do
		if d:IsA("ProximityPrompt") then
			d.HoldDuration = 0
		end
	end
	promptConnection = Library:Track(Workspace.DescendantAdded:Connect(function(d)
		if d:IsA("ProximityPrompt") then
			d.HoldDuration = 0
		end
	end))
end

--// Window
local Window = Library:CreateWindow({
	Title = "Bloxrooms",
	Subtitle = "Made By Evol • v0.1.4",
	Theme = "Amber",
	Width = 640,
	Height = 480,
	ToggleKey = Enum.KeyCode.LeftControl,
	IntroText = "Loading Bloxrooms Hub...",
	MobileButtonText = "BR",
})

local Tabs = {
	Info = Window:CreateTab({ Name = "Info" }),
	ESP = Window:CreateTab({ Name = "ESP" }),
	Player = Window:CreateTab({ Name = "Player" }),
	Artifacts = Window:CreateTab({ Name = "Artifacts" }),
	Escape = Window:CreateTab({ Name = "Escape" }),
	Codes = Window:CreateTab({ Name = "Codes" }),
	Utility = Window:CreateTab({ Name = "Utility" }),
	Teleport = Window:CreateTab({ Name = "Teleport" }),
}

--// Info tab
local InfoSection = Tabs.Info:CreateSection("Game Info")
InfoSection:AddParagraph({
	Title = "Bloxrooms",
	Content = "v0.1.4 • Escapes • Rarity ESP • Sell All • Fast Travel\nPlaceId 90477253860739\nMade by Evol",
})

local LiveStatus = Tabs.Info:CreateSection("Live Status"):AddStats({
	Rows = { "Escape Open", "World Event", "Blackout", "Artifacts Out", "Entities" },
})

local function yesNo(value, goodWhenTrue)
	if value then
		return "Yes", goodWhenTrue and COLORS.Good or COLORS.Bad
	end
	return "No", COLORS.Muted
end

local function refreshLiveStatus()
	LiveStatus:Set("Escape Open", yesNo(escapeOpen(), true))
	LiveStatus:Set("World Event", yesNo(Workspace:GetAttribute("WorldEventActive"), true))
	LiveStatus:Set("Blackout", yesNo(Workspace:GetAttribute("EventBlackout"), false))

	local arts = countArtifacts()
	LiveStatus:Set("Artifacts Out", arts, arts > 0 and COLORS.Good or COLORS.Muted)

	local ents = #listEntities()
	LiveStatus:Set("Entities", ents, ents > 0 and COLORS.Bad or COLORS.Muted)
end

--// ESP tab
local VisualsSection = Tabs.ESP:CreateSection("Visuals")

VisualsSection:AddToggle({
	Name = "Player ESP",
	Flag = "PlayerESP",
	Default = CFG.PlayerESP,
	Callback = function(v)
		CFG.PlayerESP = v
	end,
})

VisualsSection:AddToggle({
	Name = "Entity ESP",
	Description = "Real entity names",
	Flag = "EntityESP",
	Default = CFG.EntityESP,
	Callback = function(v)
		CFG.EntityESP = v
	end,
})

VisualsSection:AddToggle({
	Name = "Artifact ESP",
	Description = "Spawned artifacts only, coloured by rarity",
	Flag = "ArtifactESP",
	Default = CFG.ArtifactESP,
	Callback = function(v)
		CFG.ArtifactESP = v
	end,
})

VisualsSection:AddToggle({
	Name = "Active Escape ESP",
	Flag = "EscapeESP",
	Default = CFG.EscapeESP,
	Callback = function(v)
		CFG.EscapeESP = v
	end,
})

VisualsSection:AddToggle({
	Name = "Spawn Markers ESP",
	Description = "Artifact spawn points, not actual loot",
	Flag = "ArtifactSpawnESP",
	Default = CFG.ArtifactSpawnESP,
	Callback = function(v)
		CFG.ArtifactSpawnESP = v
	end,
})

local LabelSection = Tabs.ESP:CreateSection("Labels")

LabelSection:AddToggle({
	Name = "Show Artifact Rarity",
	Flag = "ShowRarity",
	Default = CFG.ShowRarity,
	Callback = function(v)
		CFG.ShowRarity = v
		clearKind("artifact")
	end,
})

LabelSection:AddToggle({
	Name = "Show Distance",
	Flag = "ShowDistance",
	Default = CFG.ShowDistance,
	Callback = function(v)
		CFG.ShowDistance = v
	end,
})

LabelSection:AddSlider({
	Name = "Max Distance",
	Flag = "MaxDistance",
	Min = 100,
	Max = 2000,
	Default = CFG.MaxDistance,
	Increment = 10,
	Suffix = "studs",
	Callback = function(v)
		CFG.MaxDistance = v
	end,
})

do
	local parts = {}
	for _, rarity in RARITY_ORDER do
		table.insert(parts, string.format('<font color="#%s">%s</font>', RARITY_COLORS[rarity]:ToHex(), string.upper(rarity)))
	end
	LabelSection:AddLabel({ Text = table.concat(parts, "  ·  "), RichText = true, Size = 13 })
end

LabelSection:AddButton({
	Name = "Clear All ESP",
	Style = "Locked",
	Callback = clearAllESP,
})

--// Player tab
local MovementSection = Tabs.Player:CreateSection("Movement")

MovementSection:AddToggle({
	Name = "Speed",
	Flag = "SpeedEnabled",
	Keybind = true,
	Default = CFG.SpeedEnabled,
	Callback = function(v)
		CFG.SpeedEnabled = v
		if not v then
			local h = hum()
			if h then
				h.WalkSpeed = 16
			end
		end
	end,
})

MovementSection:AddSlider({
	Name = "Walk Speed",
	Tooltip = "Capped at 28 to stay safe",
	Flag = "WalkSpeed",
	Min = 16,
	Max = 28,
	Default = CFG.WalkSpeed,
	Callback = function(v)
		CFG.WalkSpeed = v
	end,
})

MovementSection:AddToggle({
	Name = "Fly",
	Description = "WASD to move, Space up, Shift down",
	Flag = "FlyEnabled",
	Keybind = true,
	Default = CFG.FlyEnabled,
	Callback = function(v)
		CFG.FlyEnabled = v
	end,
})

MovementSection:AddSlider({
	Name = "Fly Speed",
	Flag = "FlySpeed",
	Min = 20,
	Max = 100,
	Default = CFG.FlySpeed,
	Callback = function(v)
		CFG.FlySpeed = v
	end,
})

MovementSection:AddToggle({
	Name = "Noclip",
	Flag = "Noclip",
	Keybind = true,
	Default = CFG.Noclip,
	Callback = function(v)
		CFG.Noclip = v
	end,
})

MovementSection:AddToggle({
	Name = "Infinite Jump",
	Flag = "InfiniteJump",
	Keybind = true,
	Default = CFG.InfiniteJump,
	Callback = function(v)
		CFG.InfiniteJump = v
	end,
})

local StealthSection = Tabs.Player:CreateSection("Stealth")

StealthSection:AddToggle({
	Name = "Silent Footsteps",
	Flag = "SilentFeet",
	Default = CFG.SilentFeet,
	Callback = function(v)
		CFG.SilentFeet = v
	end,
})

StealthSection:AddToggle({
	Name = "Infinite Stamina",
	Flag = "InfiniteStamina",
	Default = CFG.InfiniteStamina,
	Callback = function(v)
		CFG.InfiniteStamina = v
	end,
})

local WorldSection = Tabs.Player:CreateSection("World")

WorldSection:AddToggle({
	Name = "Fullbright",
	Description = "Restores your lighting when turned off",
	Flag = "Fullbright",
	Keybind = true,
	Default = CFG.Fullbright,
	Callback = function(v)
		CFG.Fullbright = v
		setFullbright(v)
	end,
})

--// Artifacts tab
local InventorySection = Tabs.Artifacts:CreateSection("Inventory")

local InventoryStats = InventorySection:AddStats({
	Rows = { "Owned", "Total Value", "Top Item" },
})

InventorySection:AddButton({
	Name = "Check Inventory Value",
	Description = "Full breakdown is printed to the console",
	ButtonText = "Check",
	Style = "Codes",
	Callback = function()
		local total, count, rows = inventoryValue()
		if not total then
			return
		end

		InventoryStats:Set("Owned", count)
		InventoryStats:Set("Total Value", "$" .. total, COLORS.Good)

		if count == 0 then
			InventoryStats:Set("Top Item", nil)
			notify("Inventory", "You own 0 artifacts", "Warning")
			return
		end

		local top = rows[1]
		InventoryStats:Set("Top Item", string.format("%s x%d", top.Name, top.Count), rarityColor(top.Rarity))
		notify("Inventory", "Owned: " .. count .. "  |  Total Value: $" .. total, "Success")

		print("========== INVENTORY ==========")
		for _, row in ipairs(rows) do
			print(string.format(
				"%s x%d | $%d each | $%d (%s)",
				row.Name, row.Count, row.Value, row.Count * row.Value, row.Rarity
			))
		end
	end,
})

InventorySection:AddButton({
	Name = "Sell All Artifacts",
	Description = "Click twice to confirm",
	ButtonText = "Sell All",
	Style = "Locked",
	Confirm = true,
	ConfirmText = "Sure?",
	Callback = sellAll,
})

local FarmSection = Tabs.Artifacts:CreateSection("Farm")

local AutoCollectToggle = FarmSection:AddToggle({
	Name = "Auto Collect",
	Description = "Collects artifacts within range",
	Flag = "AutoCollect",
	Default = CFG.AutoCollect,
	Callback = function(v)
		CFG.AutoCollect = v
	end,
})

FarmSection:AddToggle({
	Name = "Auto Farm",
	Description = "Teleports to each artifact and collects it",
	Flag = "AutoFarm",
	Keybind = true,
	Default = CFG.AutoFarm,
	Callback = function(v)
		CFG.AutoFarm = v
		AutoCollectToggle:SetLocked(v, "Auto Farm is on")
	end,
})

FarmSection:AddSlider({
	Name = "Collect Range",
	Flag = "AutoCollectRange",
	Min = 8,
	Max = 40,
	Default = CFG.AutoCollectRange,
	Suffix = "studs",
	Callback = function(v)
		CFG.AutoCollectRange = v
	end,
})

FarmSection:AddSlider({
	Name = "Farm Delay",
	Tooltip = "Lower is faster but riskier",
	Flag = "AutoFarmDelay",
	Min = 0.3,
	Max = 1.5,
	Increment = 0.05,
	Default = CFG.AutoFarmDelay,
	Suffix = "s",
	Callback = function(v)
		CFG.AutoFarmDelay = v
	end,
})

FarmSection:AddButton({
	Name = "Collect Nearest Artifact",
	ButtonText = "Collect",
	Style = "Claim",
	Callback = function()
		local art = nearestArtifact()
		if art and collectOne(art) then
			notify("Artifacts", "Collected " .. artifactName(art), "Success")
		else
			notify("Artifacts", "No artifact nearby, or collecting failed", "Warning")
		end
	end,
})

FarmSection:AddButton({
	Name = "Check Remaining Artifacts",
	ButtonText = "Check",
	Style = "Codes",
	Callback = function()
		local n = countArtifacts()
		notify("Artifacts", n == 0 and "All artifacts picked up" or (n .. " remaining"), n == 0 and "Success" or "Info")
	end,
})

--// Escape tab
local ExitSection = Tabs.Escape:CreateSection("Exit")

local EscapeStats = ExitSection:AddStats({
	Rows = { "Exit Open", "Open Sequence", "Active Escapes" },
})

local function refreshEscapeStats()
	local open = escapeOpen()
	EscapeStats:Set("Exit Open", open and "Yes" or "No", open and COLORS.Good or COLORS.Muted)
	EscapeStats:Set("Open Sequence", tostring(Workspace:GetAttribute("EscapeOpenSequence") or "—"))
	local count = #getActiveEscapes()
	EscapeStats:Set("Active Escapes", count, count > 0 and COLORS.Good or COLORS.Muted)
end

ExitSection:AddButton({
	Name = "Teleport to Active Escape",
	Style = "Claim",
	Callback = tpActiveEscape,
})

ExitSection:AddButton({
	Name = "Print Escape Status",
	Description = "Prints the raw values to the console",
	ButtonText = "Print",
	Style = "Codes",
	Callback = function()
		local open = tostring(Workspace:GetAttribute("EscapeExitOpen"))
		local seq = tostring(Workspace:GetAttribute("EscapeOpenSequence"))
		local actives = getActiveEscapes()
		print("EscapeExitOpen:", open)
		print("EscapeOpenSequence:", seq)
		print("Active Escape models:", #actives)
		notify("Escape", "Open = " .. open .. "  |  Active models = " .. #actives)
	end,
})

--// Codes tab
local RedeemSection = Tabs.Codes:CreateSection("Redeem")

RedeemSection:AddInput({
	Name = "Code",
	Description = "Press Enter to redeem",
	Placeholder = "Enter code",
	Flag = "CodeInput",
	Callback = function(text, enterPressed)
		if enterPressed then
			redeem(text)
		end
	end,
})

RedeemSection:AddButton({
	Name = "Redeem Code",
	Style = "Claim",
	Callback = function()
		redeem(Flags.CodeInput)
	end,
})

local KnownCodesSection = Tabs.Codes:CreateSection("Known Codes")

for _, code in ipairs(CODES) do
	KnownCodesSection:AddButton({
		Name = code,
		ButtonText = "Redeem",
		Style = "Codes",
		Callback = function()
			redeem(code)
		end,
	})
end

KnownCodesSection:AddButton({
	Name = "Redeem All Known Codes",
	Style = "Skip",
	Callback = function()
		for _, code in ipairs(CODES) do
			redeem(code)
			task.wait(0.4)
		end
	end,
})

--// Utility tab
local HelpersSection = Tabs.Utility:CreateSection("Helpers")

HelpersSection:AddToggle({
	Name = "Instant Proximity Prompts",
	Description = "Removes hold time from every prompt",
	Flag = "InstantPrompts",
	Default = CFG.InstantPrompts,
	Callback = function(v)
		CFG.InstantPrompts = v
		setInstantPrompts(v)
	end,
})

--// Teleport tab
local QuickSection = Tabs.Teleport:CreateSection("Quick")

QuickSection:AddButton({
	Name = "Nearest Artifact",
	ButtonText = "Go",
	Style = "Codes",
	Callback = function()
		local _, part = nearestArtifact()
		if part then
			tpPos(part.Position)
			notify("Teleport", "Nearest artifact", "Success")
		else
			notify("Teleport", "No artifacts out", "Warning")
		end
	end,
})

QuickSection:AddButton({
	Name = "Active Escape",
	ButtonText = "Go",
	Style = "Codes",
	Callback = tpActiveEscape,
})

QuickSection:AddSlider({
	Name = "Multi-TP Delay",
	Description = "Wait between stops on cycle / unlock runs",
	Flag = "UnlockTPDelay",
	Min = 0.15,
	Max = 1.5,
	Increment = 0.05,
	Default = CFG.UnlockTPDelay,
	Suffix = "s",
	Callback = function(v)
		CFG.UnlockTPDelay = v
	end,
})

-- Entities
local EntitySection = Tabs.Teleport:CreateSection("Entities")

local EntityDropdown = EntitySection:AddDropdown({
	Name = "Entity",
	Options = KNOWN_ENTITIES,
	Default = KNOWN_ENTITIES[1],
	Searchable = true,
	Flag = "EntityTarget",
})
Library.ConfigIgnore.EntityTarget = true

EntitySection:AddButton({
	Name = "Teleport to Entity",
	Style = "Codes",
	Callback = function()
		local name = Flags.EntityTarget
		local folder = entitiesFolder()
		local e = name and folder and folder:FindFirstChild(name)
		if e and tpObj(e) then
			notify("Entity", name, "Success")
		else
			notify("Entity", tostring(name) .. " not found", "Warning")
		end
	end,
})

EntitySection:AddButton({
	Name = "Refresh From Game",
	Description = "Adds any spawned entities to the list",
	ButtonText = "Refresh",
	Style = "Skip",
	Callback = function()
		local names = table.clone(KNOWN_ENTITIES)
		for _, e in ipairs(listEntities()) do
			if not table.find(names, e.Name) then
				table.insert(names, e.Name)
			end
		end
		EntityDropdown:Refresh(names, true)
		notify("Entities", #listEntities() .. " spawned right now")
	end,
})

EntitySection:AddButton({
	Name = "Cycle All Entities",
	ButtonText = "Cycle",
	Style = "Rebirth",
	Callback = function()
		local list = listEntities()
		if #list == 0 then
			notify("Entities", "No entities found", "Warning")
			return
		end
		for i, e in ipairs(list) do
			if Library.Unloaded then
				return
			end
			tpObj(e)
			notify("Entities", string.format("%d/%d  %s", i, #list, e.Name))
			task.wait(CFG.UnlockTPDelay)
		end
		notify("Entities", "Done", "Success")
	end,
})

EntitySection:AddButton({
	Name = "List Entities",
	Description = "Prints them to the console",
	ButtonText = "Print",
	Style = "Claimed",
	Callback = function()
		local list = listEntities()
		print("===== ENTITIES =====")
		for _, e in ipairs(list) do
			print(e.Name, e:GetAttribute("CollectionId") or "")
		end
		notify("Entities", #list .. " found (see console)")
	end,
})

-- Locations
local LocationSection = Tabs.Teleport:CreateSection("Locations")

LocationSection:AddDropdown({
	Name = "Location",
	Options = LOCATION_NAMES,
	Default = LOCATION_NAMES[1],
	Searchable = true,
	Flag = "LocationTarget",
})
Library.ConfigIgnore.LocationTarget = true

LocationSection:AddButton({
	Name = "Travel to Location",
	Style = "Codes",
	Callback = function()
		if Flags.LocationTarget then
			tryFastTravel(Flags.LocationTarget)
		end
	end,
})

local UnlockProgress = LocationSection:AddProgressBar({
	Name = "Unlock Progress",
	Min = 0,
	Max = 1,
	Default = 0,
})
UnlockProgress:SetText("Idle")

LocationSection:AddButton({
	Name = "Unlock All Locations",
	Description = "Teleports through every zone",
	ButtonText = "Unlock",
	Style = "Claim",
	Callback = function()
		if unlockRunning then
			notify("Unlock", "Already running", "Warning")
			return
		end

		local locs = allLocations()
		if #locs == 0 then
			notify("Unlock", "No LocationDiscovery zones found", "Warning")
			return
		end

		unlockRunning = true
		notify("Unlock", "Teleporting through " .. #locs .. " locations...")

		for i, loc in ipairs(locs) do
			if not unlockRunning or Library.Unloaded then
				break
			end
			tpObj(loc)
			UnlockProgress:SetText(string.format("%d / %d  %s", i, #locs, loc.Name))
			UnlockProgress:Set(i / #locs)
			task.wait(CFG.UnlockTPDelay)
		end

		local finished = unlockRunning
		unlockRunning = false
		UnlockProgress:SetText(finished and "Done" or "Stopped")
		notify("Unlock", finished and "Done" or "Stopped", finished and "Success" or "Warning")
	end,
})

LocationSection:AddButton({
	Name = "Stop Unlock",
	ButtonText = "Stop",
	Style = "Locked",
	Callback = function()
		unlockRunning = false
	end,
})

-- Still Lifes / NPCs
local StillLifeSection = Tabs.Teleport:CreateSection("Still Lifes / NPCs")

StillLifeSection:AddDropdown({
	Name = "NPC",
	Options = STILL_LIFE_NAMES,
	Default = STILL_LIFE_NAMES[1],
	Searchable = true,
	Flag = "StillLifeTarget",
})
Library.ConfigIgnore.StillLifeTarget = true

StillLifeSection:AddButton({
	Name = "Teleport to NPC",
	Style = "Codes",
	Callback = function()
		local name = Flags.StillLifeTarget
		local folder = Workspace:FindFirstChild("StillLifes")
		local n = name and folder and folder:FindFirstChild(name)
		if n and tpObj(n) then
			notify("Still Life", name, "Success")
		else
			notify("Still Life", tostring(name) .. " not found", "Warning")
		end
	end,
})

StillLifeSection:AddButton({
	Name = "Visit All Still Lifes + Areas",
	ButtonText = "Visit",
	Style = "Rebirth",
	Callback = function()
		notify("Still Lifes", "Visiting NPCs and areas...")
		for _, n in ipairs(stillLifeNPCs()) do
			if Library.Unloaded then
				return
			end
			tpObj(n)
			task.wait(CFG.UnlockTPDelay)
		end
		for _, a in ipairs(stillLifeAreas()) do
			if Library.Unloaded then
				return
			end
			tpObj(a)
			task.wait(CFG.UnlockTPDelay)
		end
		notify("Still Lifes", "Done", "Success")
	end,
})

--// Settings tab
local SettingsTab = Window:CreateSettingsTab()
SettingsTab:CreateSection("Credits"):AddParagraph({
	Title = "Credits",
	Content = "Made by Evol\nBloxrooms v0.1.4\nDump PlaceId 90477253860739\nUI: Project RetroSlop v" .. Library.Version,
})

--// ESP scan
local function scanESP()
	local cam = camera()
	if not cam then
		return
	end
	local origin = cam.CFrame.Position

	for obj, data in pairs(ESP) do
		if not obj.Parent or not data.Part or not data.Part.Parent then
			clearESP(obj)
		else
			local dist = (origin - data.Part.Position).Magnitude
			local on = dist <= CFG.MaxDistance
			data.Billboard.Enabled = on
			data.Highlight.Enabled = on
			if on then
				data.Label.Text = CFG.ShowDistance and (data.Name .. "  •  " .. math.floor(dist) .. "m") or data.Name
			end
		end
	end

	-- Players
	if CFG.PlayerESP then
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and alive(plr) and plr.Character and not ESP[plr.Character] then
				addESP(plr.Character, Color3.fromRGB(0, 170, 255), plr.DisplayName or plr.Name, "player")
			end
		end
	else
		clearKind("player")
	end

	-- Entities
	if CFG.EntityESP then
		local folder = entitiesFolder()
		if folder then
			for _, child in ipairs(folder:GetChildren()) do
				if (child:IsA("Model") or child:IsA("BasePart")) and not ESP[child] then
					addESP(child, Color3.fromRGB(255, 60, 60), child.Name, "entity")
				end
			end
		end
		for _, child in ipairs(Workspace:GetChildren()) do
			if not ESP[child] and isEntity(child) then
				addESP(child, Color3.fromRGB(255, 50, 50), child.Name, "entity")
			end
		end
	else
		clearKind("entity")
	end

	-- Artifacts
	if CFG.ArtifactESP then
		for _, folder in ipairs(artifactFolders()) do
			for _, child in ipairs(folder:GetChildren()) do
				if isArtifact(child) and not ESP[child] then
					local display = artifactName(child)
					local rarity = child:GetAttribute("ArtifactRarity")
					local label = display
					if CFG.ShowRarity and rarity then
						label = display .. " [" .. tostring(rarity) .. "]"
					end
					addESP(child, rarityColor(rarity), label, "artifact")
				end
			end
		end
	else
		clearKind("artifact")
	end

	-- Escapes
	if CFG.EscapeESP then
		for _, esc in ipairs(getActiveEscapes()) do
			local door = esc:FindFirstChild("Door", true) or esc
			if not ESP[door] then
				addESP(door, Color3.fromRGB(255, 220, 50), "EXIT (ACTIVE)", "escape")
			end
		end
	else
		clearKind("escape")
	end

	-- Spawn markers
	if CFG.ArtifactSpawnESP then
		local spawns = Workspace:FindFirstChild("ArtifactSpawns")
		if spawns then
			for _, d in ipairs(spawns:GetDescendants()) do
				if (d:IsA("BasePart") or d:IsA("Model")) and not ESP[d] and not isArtifact(d) then
					if string.find(d.Name, "Spawn") or d:GetAttribute("GeneratedArtifactSpawn") then
						addESP(d, Color3.fromRGB(255, 200, 50), "SPAWN", "spawn")
					end
				end
			end
		end
	else
		clearKind("spawn")
	end
end

--// Background loops
task.spawn(function()
	while not Library.Unloaded do
		task.wait(1)
		if Library.Unloaded then
			break
		end
		local ok, err = pcall(scanESP)
		if not ok then
			warn("[Bloxrooms] ESP scan error: " .. tostring(err))
		end
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		pcall(refreshLiveStatus)
		pcall(refreshEscapeStats)
		task.wait(1.5)
	end
end)

-- Auto collect (in range)
task.spawn(function()
	while not Library.Unloaded do
		task.wait(0.4)
		if not CFG.AutoCollect or CFG.AutoFarm then
			continue
		end
		local root = hrp()
		if not root then
			continue
		end

		local any = false
		for _, folder in ipairs(artifactFolders()) do
			for _, child in ipairs(folder:GetChildren()) do
				if Library.Unloaded or not CFG.AutoCollect then
					break
				end
				if isArtifact(child) then
					any = true
					local p = getPart(child)
					if p and (root.Position - p.Position).Magnitude <= CFG.AutoCollectRange then
						if collectOne(child) then
							notify("Auto Collect", "Collected " .. artifactName(child), "Success")
						end
						task.wait(0.2)
					end
				end
			end
		end

		if not any and os.clock() - lastEmptyNotify > 8 then
			lastEmptyNotify = os.clock()
			notify("Auto Collect", "All artifacts picked up")
		end
	end
end)

-- Auto farm (teleport + collect)
task.spawn(function()
	while not Library.Unloaded do
		task.wait(CFG.AutoFarmDelay)
		if not CFG.AutoFarm then
			continue
		end
		local root = hrp()
		if not root then
			continue
		end

		local art, part = nearestArtifact()
		if art and part then
			root.AssemblyLinearVelocity = Vector3.zero
			root.CFrame = part.CFrame + Vector3.new(0, 3.5, 0)
			task.wait(0.15)
			if collectOne(art) then
				notify("Auto Farm", "Collected " .. artifactName(art), "Success")
			end
		elseif os.clock() - lastEmptyNotify > 8 then
			lastEmptyNotify = os.clock()
			notify("Auto Farm", "All artifacts picked up")
		end
	end
end)

-- Per-frame movement
local characterSweep = 0

Library:Track(RunService.RenderStepped:Connect(function(dt)
	characterSweep += dt
	if characterSweep >= 0.5 then
		characterSweep = 0
		if CFG.SilentFeet then
			silentFeet()
		end
		if CFG.InfiniteStamina then
			infiniteStamina()
		end
	end

	if CFG.SpeedEnabled then
		local h = hum()
		if h then
			h.WalkSpeed = math.clamp(CFG.WalkSpeed, 16, 28)
		end
	end

	if CFG.FlyEnabled then
		if not flying then
			startFly()
		end
		local cam = camera()
		if flyBV and flyBG and cam then
			local cf = cam.CFrame
			local dir = Vector3.zero
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				dir += cf.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				dir -= cf.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				dir -= cf.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				dir += cf.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
				dir += Vector3.yAxis
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
				dir -= Vector3.yAxis
			end
			flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * CFG.FlySpeed or Vector3.zero
			flyBG.CFrame = cf
		end
	elseif flying then
		stopFly()
	end

	if CFG.Noclip then
		local char = LocalPlayer.Character
		if char then
			for _, p in ipairs(char:GetChildren()) do
				if p:IsA("BasePart") then
					p.CanCollide = false
				end
			end
		end
	end

	if CFG.Fullbright then
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.fromRGB(170, 170, 170)
	end
end))

Library:Track(UserInputService.JumpRequest:Connect(function()
	if CFG.InfiniteJump then
		local h = hum()
		if h then
			h:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end))

Library:Track(LocalPlayer.CharacterAdded:Connect(function()
	stopFly()
end))

--// Cleanup on unload
Library:OnUnload(function()
	unlockRunning = false
	CFG.AutoCollect = false
	CFG.AutoFarm = false
	clearAllESP()
	stopFly()
	setFullbright(false)
	setInstantPrompts(false)
	if CFG.SpeedEnabled then
		local h = hum()
		if h then
			h.WalkSpeed = 16
		end
	end
end)

--// Start
Library:LoadAutoload()

Library:Notify({
	Title = "Bloxrooms",
	Content = "v0.1.4 loaded. Left Ctrl toggles the menu.",
	Style = "Theme",
	Duration = 5,
})
