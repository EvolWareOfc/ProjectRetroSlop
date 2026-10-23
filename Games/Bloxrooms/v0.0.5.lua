--[[
	Bloxrooms Hub  ·  v0.3.0 (REVAMP)  ·  Made by Evol
	Built on Project RetroSlop v0.0.3
	PlaceId 127943464865693  |  [REVAMP] Bloxrooms

	TELEPORT TABLES
	LOCATIONS, STILL_LIFES and ENTITIES below are what the Teleports and Index tabs are built from.
		Name     = what the button says
		Id       = the game's id (index / CollectionId / LocationId) - don't change these
		Position = Vector3.new(x, y, z)   <- optional. When set, the button goes here instead of
		                                     finding the NPC / zone live (handy for ones that wander
		                                     or aren't streamed in yet)
	Teleports > Coord Helper > "Print Live Positions" prints every entry with its current coords,
	ready to paste straight into these tables.
]]

--// Library
local LIBRARY_URL = "https://raw.githubusercontent.com/EvolWareOfc/ProjectRetroSlop/refs/heads/main/UI/v0.0.3.lua"

local Library
do
	local ok, result = pcall(function()
		return loadstring(game:HttpGet(LIBRARY_URL))()
	end)
	if not ok or type(result) ~= "table" then
		error("[Bloxrooms] RetroSlop didn't load: " .. tostring(result), 0)
	end
	Library = result
end

Library.Folder = "BloxroomsHub"

----------------------------------------------------------------
-- LOCATIONS  (Index > Locations)
----------------------------------------------------------------
local LOCATIONS = {
	{ Name = "Starting Zone", Id = "StartingZone", Zone = "StartingZone", Position = nil },
	{ Name = "Crossroads", Id = "Crossroads", Zone = "Crossroads", Position = nil },
	{ Name = "Starter Cabin", Id = "StarterCabin", Zone = "StarterCabin", Position = nil },
	{ Name = "Cart Ride", Id = "CartRide", Zone = "CartRide", Position = nil },
	{ Name = "Cheese", Id = "Cheese", Zone = "Cheese", Position = nil },
	{ Name = "Christmas", Id = "Christmas", Zone = "Christmas", Position = nil },
	{ Name = "Classic House", Id = "ClassicHouse", Zone = "ClassicHouse", Position = nil },
	{ Name = "Doomspire", Id = "Doomspire", Zone = "Doomspire", Position = nil },
	{ Name = "Fake Robloxia", Id = "FakeRobloxia", Zone = "FakeRobloxia", Position = nil },
	{ Name = "Fake Suburban", Id = "FakeSuburban", Zone = "FakeSuburban", Position = nil },
	{ Name = "Flood Escape 2", Id = "FloodEscape2", Zone = "FloodEscape2", Position = nil },
	{ Name = "Hide and Seek Extreme", Id = "Hide and Seek Extreme", Zone = "Hide and Seek Extreme", Position = nil },
	{ Name = "Highschool", Id = "Highschool", Zone = "Highschool", Position = nil },
	{ Name = "Kohl's Admin", Id = "KohlsAdmin", Zone = "KohlsAdmin", Position = nil },
	{ Name = "Last Guest", Id = "LastGuest", Zone = "LastGuest", Position = nil },
	{ Name = "Lumber Tycoon", Id = "LumberTycoon", Zone = "LumberTycoon", Position = nil },
	{ Name = "Mini HQ", Id = "MiniHQ", Zone = "MiniHQ", Position = nil },
	{ Name = "Party.exe", Id = "PartyExe", Zone = "PartyExe", Position = nil },
	{ Name = "Pizza Place", Id = "PizzaPlace", Zone = "PizzaPlace", Position = nil },
	{ Name = "Pizza Place Town", Id = "PizzaPlaceTown", Zone = "PizzaPlaceTown", Position = nil },
	{ Name = "Police Station", Id = "PoliceStation", Zone = "PoliceStation", Position = nil },
	{ Name = "SFOTH", Id = "SFOTH", Zone = "SFOTH", Position = nil },
	{ Name = "Speaker Rooms", Id = "SpeakerRooms", Zone = "SpeakerRooms", Position = nil },
	{ Name = "Teapot Room", Id = "TeaPotRoom", Zone = "TeaPotRoom", Position = nil },
	{ Name = "Treehouse", Id = "Treehouse", Zone = "Treehouse", Position = nil },
	{ Name = "Visuals", Id = "Visuals", Zone = "Visuals", Position = nil },
	{ Name = "Zombie Attack", Id = "ZombieAttack", Zone = "ZombieAttack", Position = nil },
	{ Name = "1x1x1x1", Id = "1x1x1x1", Zone = "1x1x1x1", Position = nil },
}

----------------------------------------------------------------
-- STILL LIFES  (Index > Still Lifes)  -  live in Workspace.StillLifes
----------------------------------------------------------------
local STILL_LIFES = {
	{ Name = "Guide", Id = "Guide", Position = nil },
	{ Name = "Starter Character", Id = "StarterCharacter", Position = nil },
	{ Name = "Subject 0", Id = "Subject_0", Position = nil },
	{ Name = "2016", Id = "2016", Position = nil },
	{ Name = "Bacon General", Id = "Bacon General", Position = nil },
	{ Name = "Big Cheese", Id = "BigCheese", Position = nil },
	{ Name = "Classic House Noob", Id = "ClassicHouseNoob", Position = nil },
	{ Name = "Clockwork", Id = "Clockwork", Position = nil },
	{ Name = "Cop", Id = "Cop", Position = nil },
	{ Name = "Doge", Id = "Doge", Position = nil },
	{ Name = "Doomspire Noob", Id = "DoomspireNoob", Position = nil },
	{ Name = "Doomspire Noob 2", Id = "DoomspireNoob2", Position = nil },
	{ Name = "Emma", Id = "Emma", Position = nil },
	{ Name = "Ethan", Id = "Ethan", Position = nil },
	{ Name = "Ethan Gamer", Id = "EthanGamer", Position = nil },
	{ Name = "Fat Paps", Id = "FatPaps", Position = nil },
	{ Name = "Flamingo", Id = "Flamingo", Position = nil },
	{ Name = "Forgotten", Id = "Forgotten", Position = nil },
	{ Name = "Ggrasss", Id = "Ggrasss", Position = nil },
	{ Name = "Guest", Id = "Guest", Position = nil },
	{ Name = "Headless Horseman", Id = "HeadlessHorseman", Position = nil },
	{ Name = "Helper Bot", Id = "HelperBot", Position = nil },
	{ Name = "Highschooler", Id = "Highschooler", Position = nil },
	{ Name = "Innocent", Id = "Innocent", Position = nil },
	{ Name = "Jeff", Id = "Jeff", Position = nil },
	{ Name = "Lucaa", Id = "Lucaa", Position = nil },
	{ Name = "Michael", Id = "Michael", Position = nil },
	{ Name = "MM2 Bacon 1", Id = "MM2Bacon1", Position = nil },
	{ Name = "MM2 Bacon 2", Id = "MM2Bacon2", Position = nil },
	{ Name = "MM2 Bacon 3", Id = "MM2Bacon3", Position = nil },
	{ Name = "Piggy", Id = "Piggy", Position = nil },
	{ Name = "Pizza Bacon", Id = "PizzaBacon", Position = nil },
	{ Name = "Pizza Guy", Id = "PizzaGuy", Position = nil },
	{ Name = "Prisoner", Id = "Prisoner", Position = nil },
	{ Name = "SoniiC64M", Id = "SoniiC64M", Position = nil },
	{ Name = "The Last Guest", Id = "The Last Guest", Position = nil },
}

----------------------------------------------------------------
-- ENTITIES  (Index > Entities)  -  live in Workspace.Entities
-- Event = only spawns during world events / sanity encounters
----------------------------------------------------------------
local ENTITIES = {
	{ Name = "Builderman", Id = "Builderman", Position = nil },
	{ Name = "Roblox", Id = "Roblox", Position = nil },
	{ Name = "Shedletsky", Id = "Shedletsky", Position = nil },
	{ Name = "Coolkid", Id = "Coolkid", Position = nil },
	{ Name = "1x1x1x1", Id = "1x1x1x1", Position = nil },
	{ Name = "DenisDaily", Id = "DenisDaily", Position = nil },
	{ Name = "Murderer", Id = "Murderer", Position = nil },
	{ Name = "Sheriff", Id = "Sheriff", Position = nil },
	{ Name = "Noob", Id = "Noob", Position = nil },
	{ Name = "Spider", Id = "Spider", Position = nil },
	{ Name = "Guest 666", Id = "Guest666", Event = true, Position = nil },
	{ Name = "Imposter", Id = "Imposter", Event = true, Position = nil },
}

local CODES = { "1M", "UPDATE1", "500K" }

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Flags = Library.Flags

local COLORS = {
	Good = Color3.fromRGB(180, 255, 25),
	Warn = Color3.fromRGB(255, 208, 0),
	Bad = Color3.fromRGB(255, 90, 100),
	Muted = Color3.fromRGB(216, 222, 228),
	Info = Color3.fromRGB(0, 205, 255),
}

local function notify(title, content, style, duration)
	Library:Notify({ Title = title, Content = content, Style = style or "Info", Duration = duration or 2.8 })
end

----------------------------------------------------------------
-- Remotes (missing ones just switch their feature off)
----------------------------------------------------------------
local Remote = {}

do
	local shared = ReplicatedStorage:WaitForChild("Shared", 20)
	local remotes = shared and shared:WaitForChild("Remotes", 20)

	local function find(group, name)
		local folder = remotes and remotes:WaitForChild(group, 5)
		return folder and folder:WaitForChild(name, 3)
	end

	Remote.CollectArtifact = find("Artifacts", "CollectArtifact")
	Remote.GetInventory = find("Artifacts", "GetInventory")
	Remote.SellAllArtifacts = find("Shop", "SellAllArtifacts")
	Remote.RedeemCode = find("Codes", "RedeemCode")
	Remote.FastTravel = find("Locations", "FastTravel")
	Remote.GetLocations = find("Locations", "GetLocations")
	Remote.LocationDiscovered = find("Locations", "LocationDiscovered")
	Remote.GetIndex = find("CollectionIndex", "GetIndex")
	Remote.IndexUpdated = find("CollectionIndex", "Updated")
	Remote.DailyState = find("DailyRewards", "GetState")
	Remote.DailyClaim = find("DailyRewards", "Claim")
	Remote.GroupReward = remotes and remotes:FindFirstChild("GroupReward")
end

local function invoke(remote, ...)
	if not remote then
		return false, "missing remote"
	end
	local args = table.pack(...)
	return pcall(function()
		return remote:InvokeServer(table.unpack(args, 1, args.n))
	end)
end

----------------------------------------------------------------
-- Character + teleport helpers
----------------------------------------------------------------
local function hrp(player)
	local character = (player or LocalPlayer).Character
	return character and character:FindFirstChild("HumanoidRootPart")
end

local function hum(player)
	local character = (player or LocalPlayer).Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function alive(player)
	local humanoid = hum(player)
	return humanoid ~= nil and humanoid.Health > 0
end

local function getPart(object)
	if not object then
		return nil
	end
	if object:IsA("BasePart") then
		return object
	end
	if object:IsA("Model") then
		if object.PrimaryPart then
			return object.PrimaryPart
		end
		local root = object:FindFirstChild("HumanoidRootPart") or object:FindFirstChild("PickupAnchor")
		if root then
			return root
		end
	end
	return object:FindFirstChildWhichIsA("BasePart", true)
end

local Travel = { Last = nil }

function Travel.remember()
	local root = hrp()
	if root then
		Travel.Last = root.CFrame
	end
end

function Travel.cframe(cframe)
	local root = hrp()
	if not root then
		return false
	end
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
	root.CFrame = cframe
	return true
end

function Travel.position(position)
	return Travel.cframe(CFrame.new(position + Vector3.new(0, 4, 0)))
end

-- Stands `distance` studs in front of something, facing it
function Travel.standOff(object, distance)
	local part = getPart(object)
	if not part then
		return false
	end
	local target = part.Position
	if not distance or distance <= 0 then
		return Travel.position(target)
	end
	local look = part.CFrame.LookVector
	local flat = Vector3.new(look.X, 0, look.Z)
	flat = flat.Magnitude > 0.01 and flat.Unit or Vector3.new(0, 0, -1)
	local stand = target + flat * distance + Vector3.new(0, 3, 0)
	return Travel.cframe(CFrame.lookAt(stand, Vector3.new(target.X, stand.Y, target.Z)))
end

local function formatVector(v)
	return string.format("Vector3.new(%.2f, %.2f, %.2f)", v.X, v.Y, v.Z)
end

local function spotPosition(entry)
	local value = entry.Position
	if typeof(value) == "Vector3" then
		return value
	elseif typeof(value) == "CFrame" then
		return value.Position
	end
	return nil
end

-- A folder outside the game's models for ESP / highlights
local WorldHolder = Instance.new("Folder")
WorldHolder.Name = "BloxroomsWorld"

-- Highlights / billboards only render from somewhere real, so try CoreGui, then the executor's hidden UI, then PlayerGui
local function placeWorldHolder()
	if WorldHolder.Parent then
		return
	end
	local getters = {
		function()
			return game:GetService("CoreGui")
		end,
		function()
			return gethui and gethui()
		end,
		function()
			return LocalPlayer:FindFirstChildOfClass("PlayerGui")
		end,
	}
	for _, getter in getters do
		local ok, parent = pcall(getter)
		if ok and typeof(parent) == "Instance" then
			pcall(function()
				WorldHolder.Parent = parent
			end)
			if WorldHolder.Parent then
				return
			end
		end
	end
end
placeWorldHolder()
Library:OnUnload(function()
	WorldHolder:Destroy()
end)

----------------------------------------------------------------
-- Finding still lifes, entities and locations live
----------------------------------------------------------------
local World = {}

-- Direct child by name, else any model (2 levels deep) whose CollectionId matches
local function findCollectable(folder, id)
	if not folder then
		return nil
	end
	local direct = folder:FindFirstChild(id)
	if direct then
		return direct
	end
	for _, child in folder:GetChildren() do
		if child:GetAttribute("CollectionId") == id then
			return child
		end
		if child:IsA("Folder") then
			local nested = child:FindFirstChild(id)
			if nested then
				return nested
			end
			for _, grandchild in child:GetChildren() do
				if grandchild:GetAttribute("CollectionId") == id then
					return grandchild
				end
			end
		end
	end
	return nil
end

function World.stillLife(id)
	return findCollectable(Workspace:FindFirstChild("StillLifes"), id)
end

function World.entity(id)
	return findCollectable(Workspace:FindFirstChild("Entities"), id)
		or findCollectable(Workspace:FindFirstChild("SanityDoubles"), id)
		or Workspace:FindFirstChild(id)
end

function World.location(entry)
	local root = Workspace:FindFirstChild("LocationDiscovery")
	if not root then
		return nil
	end
	for _, folderName in { "Destinations", "Zones" } do
		local folder = root:FindFirstChild(folderName)
		if folder then
			for _, child in folder:GetChildren() do
				if child:GetAttribute("LocationId") == entry.Id then
					return child
				end
			end
			local named = folder:FindFirstChild(entry.Id) or (entry.Zone and folder:FindFirstChild(entry.Zone))
			if named then
				return named
			end
		end
	end
	return nil
end

function World.entities()
	local out = {}
	local folder = Workspace:FindFirstChild("Entities")
	if folder then
		for _, child in folder:GetChildren() do
			if child:IsA("Model") or child:IsA("BasePart") then
				table.insert(out, child)
			end
		end
	end
	table.sort(out, function(a, b)
		return a.Name < b.Name
	end)
	return out
end

function World.isEntity(model)
	if not model or not model:IsA("Model") then
		return false
	end
	if Players:GetPlayerFromCharacter(model) then
		return false
	end
	local folder = Workspace:FindFirstChild("Entities")
	if folder and model:IsDescendantOf(folder) then
		return true
	end
	return model:GetAttribute("CollectionId") ~= nil or model:HasTag("Entity")
end

function World.stillLifeAreas()
	local out = {}
	local npc = Workspace:FindFirstChild("NpcAreas")
	local areas = npc and npc:FindFirstChild("StillLifes")
	if areas then
		for _, child in areas:GetChildren() do
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

----------------------------------------------------------------
-- Index (what you've discovered)
----------------------------------------------------------------
local Index = {
	Loaded = false,
	Raw = nil,
	Categories = { StillLifes = {}, Entities = {}, Locations = {} },
	Flat = {},
	Listeners = {},
}

local function categoryOf(name)
	name = string.lower(tostring(name or ""))
	if string.find(name, "still") then
		return "StillLifes"
	elseif string.find(name, "entit") then
		return "Entities"
	elseif string.find(name, "location") then
		return "Locations"
	end
	return nil
end

local function discoveredFlag(node)
	for _, key in { "Discovered", "Owned", "Unlocked", "Found", "Collected", "Seen" } do
		if node[key] ~= nil then
			return node[key] == true
		end
	end
	return nil
end

-- The index payload shape isn't public, so walk it and pick out anything that looks like an entry
local function parseIndex(data, defaultCategory)
	local function store(category, id, discovered)
		id = tostring(id)
		Index.Flat[string.lower(id)] = Index.Flat[string.lower(id)] or discovered
		if category and Index.Categories[category] then
			Index.Categories[category][id] = Index.Categories[category][id] or discovered
		end
	end

	local function walk(node, category, depth)
		if type(node) ~= "table" or depth > 7 then
			return
		end
		local id = node.Id or node.CollectionId or node.id
		local discovered = discoveredFlag(node)
		if (type(id) == "string" or type(id) == "number") and discovered ~= nil then
			store(categoryOf(node.Category or node.CollectionCategory) or category, id, discovered)
			return
		end
		for key, value in node do
			if type(value) == "boolean" and type(key) == "string" and category then
				store(category, key, value)
			else
				walk(value, (type(key) == "string" and categoryOf(key)) or category, depth + 1)
			end
		end
	end

	walk(data, defaultCategory, 0)
end

function Index.refresh()
	for _, map in Index.Categories do
		table.clear(map)
	end
	table.clear(Index.Flat)

	local ok, data = invoke(Remote.GetIndex)
	if ok and type(data) == "table" then
		Index.Raw = data
		parseIndex(data, nil)
		Index.Loaded = true
	end

	local okLocations, locations = invoke(Remote.GetLocations)
	if okLocations and type(locations) == "table" then
		local list = locations.Locations or (locations.Payload and locations.Payload.Locations) or locations
		parseIndex(list, "Locations")
		Index.Loaded = true
	end

	for _, fn in Index.Listeners do
		task.spawn(fn)
	end
end

-- true / false / nil (unknown)
function Index.discovered(category, id)
	local map = Index.Categories[category]
	if map and map[id] ~= nil then
		return map[id]
	end
	local flat = Index.Flat[string.lower(tostring(id))]
	if flat ~= nil then
		return flat
	end
	if Index.Loaded then
		return false
	end
	return nil
end

function Index.count(category, list)
	local found = 0
	for _, entry in list do
		if Index.discovered(category, entry.Id) then
			found += 1
		end
	end
	return found
end

if Remote.IndexUpdated then
	Library:Track(Remote.IndexUpdated.OnClientEvent:Connect(function()
		task.delay(0.5, Index.refresh)
	end))
end
if Remote.LocationDiscovered then
	Library:Track(Remote.LocationDiscovered.OnClientEvent:Connect(function()
		task.delay(0.5, Index.refresh)
	end))
end

----------------------------------------------------------------
-- Going to an entry
----------------------------------------------------------------
local Go = {}

function Go.stillLife(entry)
	local coords = spotPosition(entry)
	if coords then
		return Travel.position(coords)
	end
	local model = World.stillLife(entry.Id)
	return model ~= nil and Travel.standOff(model, Flags.StillLifeDistance or 6)
end

function Go.entity(entry)
	local coords = spotPosition(entry)
	if coords then
		return Travel.position(coords)
	end
	local model = World.entity(entry.Id)
	return model ~= nil and Travel.standOff(model, Flags.EntityDistance or 35)
end

function Go.location(entry)
	local coords = spotPosition(entry)
	if coords then
		return Travel.position(coords)
	end
	if Flags.UseFastTravel and Remote.FastTravel and Index.discovered("Locations", entry.Id) then
		local ok, result = invoke(Remote.FastTravel, entry.Id)
		if ok and type(result) == "table" and result.Success then
			return true
		end
		if ok and type(result) == "table" and result.Message then
			notify("Fast Travel", tostring(result.Message), "Warning")
		end
	end
	local part = World.location(entry)
	return part ~= nil and Travel.position(getPart(part).Position)
end

----------------------------------------------------------------
-- Runs (visit a whole list one by one)
----------------------------------------------------------------
local Runner = { Active = false, Label = nil, Progress = nil }

function Runner.run(name, list, visit, category)
	if Runner.Active then
		notify(name, "A run is already going. Stop it first.", "Warning")
		return
	end
	local todo = {}
	for _, entry in list do
		if not (Flags.SkipDiscovered and category and Index.discovered(category, entry.Id) == true) then
			table.insert(todo, entry)
		end
	end
	if #todo == 0 then
		notify(name, "Nothing left to visit. You've got them all.", "Success")
		return
	end

	Runner.Active = true
	local start = hrp() and hrp().CFrame
	local visited, missing = 0, {}
	notify(name, "Visiting " .. #todo .. "...", "Info")

	for i, entry in todo do
		if not Runner.Active or Library.Unloaded then
			break
		end
		if Runner.Progress then
			Runner.Progress:SetText(string.format("%s  %d / %d  ·  %s", name, i, #todo, entry.Name))
			Runner.Progress:Set(i / #todo)
		end
		if visit(entry) then
			visited += 1
			task.wait(Flags.VisitDelay or 1.5)
		else
			table.insert(missing, entry.Name)
			task.wait(0.1)
		end
	end

	local finished = Runner.Active
	Runner.Active = false
	if start and Flags.ReturnAfterRun then
		Travel.cframe(start)
	end
	if Runner.Progress then
		Runner.Progress:SetText(finished and (name .. " done") or (name .. " stopped"))
	end
	notify(name, string.format("Visited %d.%s", visited, #missing > 0 and ("  Not spawned: " .. table.concat(missing, ", ")) or ""), finished and "Success" or "Warning", 6)
	task.delay(1.5, Index.refresh)
end

----------------------------------------------------------------
-- Artifacts
----------------------------------------------------------------
local Artifacts = {}

local RARITY_COLORS = {
	Common = Color3.fromRGB(180, 180, 180),
	Uncommon = Color3.fromRGB(80, 200, 120),
	Rare = Color3.fromRGB(70, 140, 255),
	Epic = Color3.fromRGB(180, 90, 255),
	Legendary = Color3.fromRGB(255, 180, 40),
	Mythic = Color3.fromRGB(255, 60, 100),
	Secret = Color3.fromRGB(20, 255, 220),
}
local RARITY_ORDER = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret" }
local RARITY_RANK = {}
for index, rarity in RARITY_ORDER do
	RARITY_RANK[rarity] = index
end

function Artifacts.rarityColor(rarity)
	return RARITY_COLORS[rarity] or Color3.fromRGB(80, 255, 140)
end

function Artifacts.is(object)
	return object ~= nil and (object:GetAttribute("ArtifactSpawnId") ~= nil or object:GetAttribute("ArtifactId") ~= nil)
end

function Artifacts.folders()
	local list = {}
	local spawns = Workspace:FindFirstChild("ArtifactSpawns")
	if spawns then
		for _, name in { "ActiveArtifacts", "Common" } do
			local folder = spawns:FindFirstChild(name)
			if folder then
				table.insert(list, folder)
			end
		end
	end
	for _, name in { "DroppedArtifacts", "ARTIFACTSNEWNEW" } do
		local folder = Workspace:FindFirstChild(name)
		if folder then
			table.insert(list, folder)
		end
	end
	return list
end

function Artifacts.each(fn)
	for _, folder in Artifacts.folders() do
		for _, child in folder:GetChildren() do
			if Artifacts.is(child) then
				if fn(child) == false then
					return
				end
			end
		end
	end
end

function Artifacts.count()
	local count = 0
	Artifacts.each(function()
		count += 1
	end)
	return count
end

function Artifacts.rarity(object)
	return tostring(object:GetAttribute("ArtifactRarity") or "Common")
end

-- Rarities you picked in the ESP / farm filters (empty list = all of them)
function Artifacts.allowed(object, flag)
	local list = Flags[flag]
	if type(list) ~= "table" or #list == 0 then
		return true
	end
	local rarity = Artifacts.rarity(object)
	-- A rarity the hub doesn't know yet (new update) always shows
	return RARITY_RANK[rarity] == nil or table.find(list, rarity) ~= nil
end

function Artifacts.name(object)
	return tostring(object:GetAttribute("ArtifactDisplayName") or object:GetAttribute("ArtifactId") or object.Name)
end

function Artifacts.position(object)
	local part = getPart(object)
	if part then
		return part.Position
	end
	local stored = object:GetAttribute("ArtifactPosition")
	return typeof(stored) == "Vector3" and stored or nil
end

function Artifacts.collect(object)
	if not Artifacts.is(object) then
		return false
	end
	local id = object:GetAttribute("ArtifactId") or object:GetAttribute("ArtifactDisplayName") or object.Name
	local spawnId = object:GetAttribute("ArtifactSpawnId") or object.Name
	local ok, result = invoke(Remote.CollectArtifact, id, spawnId)
	return ok and type(result) == "table" and result.Success == true
end

function Artifacts.nearest()
	local root = hrp()
	if not root then
		return nil, nil
	end
	local best, bestDistance, bestPosition = nil, math.huge, nil
	Artifacts.each(function(object)
		local position = Artifacts.position(object)
		if position and Artifacts.allowed(object, "FarmRarities") then
			local distance = (root.Position - position).Magnitude
			if distance < bestDistance then
				best, bestDistance, bestPosition = object, distance, position
			end
		end
	end)
	return best, bestPosition
end

function Artifacts.inventory()
	local ok, data = invoke(Remote.GetInventory)
	if not ok or type(data) ~= "table" then
		notify("Inventory", "Couldn't fetch your inventory.", "Error")
		return nil
	end
	local list = data.Artifacts or (data.Payload and data.Payload.Artifacts) or data
	if type(list) ~= "table" then
		notify("Inventory", "Couldn't read your artifacts.", "Error")
		return nil
	end
	local totalValue, totalCount, rows = 0, 0, {}
	for _, entry in ipairs(list) do
		local count = tonumber(entry.Count) or 0
		local value = tonumber(entry.Value) or 0
		if count > 0 then
			totalCount += count
			totalValue += count * value
			table.insert(rows, { Name = entry.Name or entry.Id or "Unknown", Count = count, Value = value, Rarity = entry.Rarity or "Common" })
		end
	end
	table.sort(rows, function(a, b)
		return a.Count * a.Value > b.Count * b.Value
	end)
	return totalValue, totalCount, rows
end

local function redeem(code)
	code = code and string.gsub(code, "^%s*(.-)%s*$", "%1") or ""
	if code == "" then
		notify("Codes", "Type a code first.", "Warning")
		return
	end
	local ok, result = invoke(Remote.RedeemCode, code)
	local message = type(result) == "table" and result.Message or nil
	local success = ok and not (type(result) == "table" and result.Success == false)
	notify(success and "Code Redeemed" or "Code Failed", message and tostring(message) or code, success and "Success" or "Error")
end

----------------------------------------------------------------
-- Window
----------------------------------------------------------------
local Window = Library:CreateWindow({
	Title = "Bloxrooms",
	Subtitle = "Made By Evol • v0.3.0 REVAMP",
	Theme = "Amber",
	Width = 660,
	Height = 500,
	ToggleKey = Enum.KeyCode.LeftControl,
	IntroText = "Loading Bloxrooms Hub...",
	MobileButtonText = "BR",
	Resizable = true,
	MinimizeToButton = true,
	MinimizeButtonText = "BR",
	MinimizeButtonSnap = true,
	RememberPosition = true,
	RememberSize = true,
	SaveKey = "BloxroomsHub",
})

local Tabs = {
	Info = Window:CreateTab({ Name = "Info" }),
	Index = Window:CreateTab({ Name = "Index" }),
	Teleport = Window:CreateTab({ Name = "Teleports" }),
	ESP = Window:CreateTab({ Name = "ESP" }),
	Player = Window:CreateTab({ Name = "Player" }),
	Artifacts = Window:CreateTab({ Name = "Artifacts" }),
	Codes = Window:CreateTab({ Name = "Codes" }),
}

local UI = {}

----------------------------------------------------------------
-- Info tab
----------------------------------------------------------------
do
	Tabs.Info:CreateSection("Game Info"):AddParagraph({
		Title = "Bloxrooms",
		Content = "v0.3.0 • Revamp update • Index • Still Life & Entity teleports • Rarity ESP\nPlaceId 127943464865693\nMade by Evol",
	})

	UI.LiveStatus = Tabs.Info:CreateSection("Live Status"):AddStats({
		Rows = { "World Event", "Blackout", "Blood Moon", "Artifacts Out", "Best Artifact", "Entities", "Index" },
	})
end

local function yesNo(value, goodWhenTrue)
	if value then
		return "Yes", goodWhenTrue and COLORS.Good or COLORS.Bad
	end
	return "No", COLORS.Muted
end

local function refreshLiveStatus()
	local status = UI.LiveStatus
	local eventActive = Workspace:GetAttribute("WorldEventActive") == true
	local eventName = Workspace:GetAttribute("WorldEventName")
	status:Set("World Event", eventActive and (eventName and eventName ~= "" and tostring(eventName) or "Yes") or "No", eventActive and COLORS.Good or COLORS.Muted)
	status:Set("Blackout", yesNo(Workspace:GetAttribute("EventBlackout"), false))
	status:Set("Blood Moon", yesNo(Workspace:GetAttribute("EventBloodMoon"), false))

	local artifacts, best = 0, nil
	Artifacts.each(function(object)
		artifacts += 1
		local rarity = Artifacts.rarity(object)
		if not best or (RARITY_RANK[rarity] or 0) > (RARITY_RANK[Artifacts.rarity(best)] or 0) then
			best = object
		end
	end)
	status:Set("Artifacts Out", tostring(artifacts), artifacts > 0 and COLORS.Good or COLORS.Muted)
	if best then
		status:Set("Best Artifact", Artifacts.name(best) .. " (" .. Artifacts.rarity(best) .. ")", Artifacts.rarityColor(Artifacts.rarity(best)))
	else
		status:Set("Best Artifact", nil)
	end

	local entities = #World.entities()
	status:Set("Entities", tostring(entities), entities > 0 and COLORS.Bad or COLORS.Muted)

	if Index.Loaded then
		local found = Index.count("StillLifes", STILL_LIFES) + Index.count("Entities", ENTITIES) + Index.count("Locations", LOCATIONS)
		local total = #STILL_LIFES + #ENTITIES + #LOCATIONS
		status:Set("Index", found .. " / " .. total, found == total and COLORS.Good or COLORS.Warn)
	else
		status:Set("Index", nil)
	end
end

----------------------------------------------------------------
-- Index tab
----------------------------------------------------------------
do
	local Progress = Tabs.Index:CreateSection("Progress")
	local progressStats = Progress:AddStats({ Rows = { "Still Lifes", "Entities", "Locations" } })

	Progress:AddButton({
		Name = "Refresh Index",
		Description = "Asks the game what you've discovered",
		ButtonText = "Refresh",
		Style = "Codes",
		Callback = function()
			task.spawn(Index.refresh)
		end,
	})

	local Complete = Tabs.Index:CreateSection("Complete The Index")

	Complete:AddToggle({
		Name = "Skip Discovered",
		Description = "Only visits what you're missing",
		Flag = "SkipDiscovered",
		Default = true,
	})

	Complete:AddToggle({
		Name = "Return When Done",
		Description = "Teleports you back to where you started",
		Flag = "ReturnAfterRun",
		Default = true,
	})

	Complete:AddSlider({
		Name = "Time At Each Stop",
		Tooltip = "Longer gives the game more time to register you",
		Flag = "VisitDelay",
		Min = 0.5,
		Max = 6,
		Increment = 0.25,
		Default = 2,
		Suffix = "s",
	})

	Complete:AddButton({
		Name = "Visit Still Lifes",
		ButtonText = "Go",
		Style = "Claim",
		Callback = function()
			task.spawn(Runner.run, "Still Lifes", STILL_LIFES, Go.stillLife, "StillLifes")
		end,
	})

	Complete:AddButton({
		Name = "Visit Entities",
		Description = "Keeps your distance (Teleports tab)",
		ButtonText = "Go",
		Style = "Locked",
		Confirm = true,
		ConfirmText = "Sure?",
		Callback = function()
			task.spawn(Runner.run, "Entities", ENTITIES, Go.entity, "Entities")
		end,
	})

	Complete:AddButton({
		Name = "Visit Locations",
		ButtonText = "Go",
		Style = "Skip",
		Callback = function()
			task.spawn(Runner.run, "Locations", LOCATIONS, Go.location, "Locations")
		end,
	})

	Runner.Progress = Complete:AddProgressBar({ Name = "Run Progress", Min = 0, Max = 1, Default = 0 })
	Runner.Progress:SetText("Idle")

	Complete:AddButton({
		Name = "Stop Run",
		ButtonText = "Stop",
		Style = "Locked",
		Callback = function()
			Runner.Active = false
		end,
	})

	local Debug = Tabs.Index:CreateSection({ Name = "Raw Data", Collapsed = true })
	Debug:AddButton({
		Name = "Print Raw Index",
		Description = "Dumps what the game sends to the F9 console",
		ButtonText = "Print",
		Style = "Claimed",
		Callback = function()
			local lines = {}
			local function dump(node, indent, depth)
				if depth > 6 then
					return
				end
				for key, value in node do
					if type(value) == "table" then
						table.insert(lines, indent .. tostring(key) .. " = {")
						dump(value, indent .. "  ", depth + 1)
						table.insert(lines, indent .. "}")
					else
						table.insert(lines, indent .. tostring(key) .. " = " .. tostring(value))
					end
				end
			end
			if type(Index.Raw) == "table" then
				dump(Index.Raw, "", 0)
			else
				table.insert(lines, "GetIndex returned nothing (remote " .. (Remote.GetIndex and "found" or "missing") .. ")")
			end
			print("===== BLOXROOMS INDEX =====\n" .. table.concat(lines, "\n"))
			notify("Index", "Printed " .. #lines .. " lines to F9.", "Info")
		end,
	})

	local function countText(category, list)
		if not Index.Loaded then
			return "? / " .. #list, COLORS.Muted
		end
		local found = Index.count(category, list)
		return found .. " / " .. #list, found == #list and COLORS.Good or COLORS.Warn
	end

	table.insert(Index.Listeners, function()
		progressStats:Set("Still Lifes", countText("StillLifes", STILL_LIFES))
		progressStats:Set("Entities", countText("Entities", ENTITIES))
		progressStats:Set("Locations", countText("Locations", LOCATIONS))
	end)
end

----------------------------------------------------------------
-- Teleports tab
----------------------------------------------------------------
do
	local Quick = Tabs.Teleport:CreateSection("Quick")

	Quick:AddButton({
		Name = "Nearest Artifact",
		ButtonText = "Go",
		Style = "Codes",
		Callback = function()
			local _, position = Artifacts.nearest()
			if position then
				Travel.remember()
				Travel.position(position)
				notify("Teleport", "Nearest artifact", "Success")
			else
				notify("Teleport", "No artifacts out.", "Warning")
			end
		end,
	})


	Quick:AddButton({
		Name = "Go Back",
		Description = "Where you were before the last teleport",
		ButtonText = "Back",
		Style = "Skip",
		Callback = function()
			if not Travel.Last then
				notify("Teleport", "Nowhere to go back to yet.", "Warning")
				return
			end
			local target = Travel.Last
			Travel.remember()
			Travel.cframe(target)
		end,
	})

	local Distances = Tabs.Teleport:CreateSection("Distances")

	Distances:AddSlider({
		Name = "Still Life Distance",
		Description = "How far in front of a Still Life you land",
		Flag = "StillLifeDistance",
		Min = 0,
		Max = 30,
		Default = 6,
		Suffix = " studs",
	})

	Distances:AddSlider({
		Name = "Entity Distance",
		Description = "Keep this big, entities kill you",
		Flag = "EntityDistance",
		Min = 10,
		Max = 120,
		Default = 35,
		Increment = 5,
		Suffix = " studs",
	})

	Distances:AddToggle({
		Name = "Use Fast Travel",
		Description = "Uses the game's fast travel for discovered locations (has a cooldown)",
		Flag = "UseFastTravel",
	})

	-- One button per entry, with its index status in the description
	UI.EntryButtons = {}

	local function describe(entry, category, extra)
		local coords = spotPosition(entry)
		local parts = {}
		local discovered = Index.discovered(category, entry.Id)
		if discovered == true then
			table.insert(parts, "Discovered")
		elseif discovered == false then
			table.insert(parts, "Not discovered")
		end
		if coords then
			table.insert(parts, string.format("%.0f, %.0f, %.0f", coords.X, coords.Y, coords.Z))
		end
		if extra then
			table.insert(parts, extra)
		end
		return #parts > 0 and table.concat(parts, " • ") or nil
	end

	local function buildSection(title, list, category, goFn, style, extraFn)
		local section = Tabs.Teleport:CreateSection({ Name = title, Collapsed = true })
		for _, entry in list do
			local button = section:AddButton({
				Name = entry.Name,
				Description = describe(entry, category, extraFn and extraFn(entry)),
				ButtonText = "Go",
				Style = style,
				Callback = function()
					Travel.remember()
					if goFn(entry) then
						notify(title, entry.Name, "Success", 2)
					else
						notify(title, entry.Name .. " isn't loaded right now." .. (entry.Event and " It only shows up during events." or ""), "Warning")
					end
				end,
			})
			table.insert(UI.EntryButtons, { Button = button, Entry = entry, Category = category, Extra = extraFn })
		end
		return section
	end

	buildSection("Locations", LOCATIONS, "Locations", Go.location, "Codes")
	buildSection("Still Lifes", STILL_LIFES, "StillLifes", Go.stillLife, "Claim")
	buildSection("Entities", ENTITIES, "Entities", Go.entity, "Locked", function(entry)
		return entry.Event and "Event only" or nil
	end)

	table.insert(Index.Listeners, function()
		for _, info in UI.EntryButtons do
			info.Button:SetDescription(describe(info.Entry, info.Category, info.Extra and info.Extra(info.Entry)))
		end
	end)

	-- Still life wander areas
	local AreaSection = Tabs.Teleport:CreateSection({ Name = "Still Life Areas", Collapsed = true })
	local areas = World.stillLifeAreas()
	if #areas == 0 then
		AreaSection:AddLabel("No areas loaded yet.")
	end
	for _, area in areas do
		AreaSection:AddButton({
			Name = (string.gsub(area.Name, "Area$", "")),
			ButtonText = "Go",
			Style = "Claimed",
			Callback = function()
				Travel.remember()
				Travel.position(area.Position)
			end,
		})
	end

	-- Coord helper
	local Helper = Tabs.Teleport:CreateSection({ Name = "Coord Helper", Collapsed = true })
	local helperStats = Helper:AddStats({ Rows = { "Your Position" } })

	Helper:AddButton({
		Name = "Copy Position",
		Description = "Paste it into an entry's Position",
		ButtonText = "Copy",
		Style = "Claim",
		Callback = function()
			local root = hrp()
			if root then
				local text = formatVector(root.Position)
				pcall(setclipboard, text)
				notify("Copied", text, "Info", 4)
			end
		end,
	})

	Helper:AddButton({
		Name = "Print Live Positions",
		Description = "Every location / still life / entity, ready to paste",
		ButtonText = "Print",
		Style = "Codes",
		Callback = function()
			local lines, found = {}, 0
			local function add(header, list, finder)
				table.insert(lines, "-- " .. header)
				for _, entry in list do
					local object = finder(entry)
					local part = getPart(object)
					if part then
						found += 1
						table.insert(lines, string.format('{ Name = "%s", Id = "%s", Position = %s },', entry.Name, entry.Id, formatVector(part.Position)))
					else
						table.insert(lines, string.format("-- %s: not loaded", entry.Name))
					end
				end
			end
			add("LOCATIONS", LOCATIONS, World.location)
			add("STILL_LIFES", STILL_LIFES, function(entry)
				return World.stillLife(entry.Id)
			end)
			add("ENTITIES", ENTITIES, function(entry)
				return World.entity(entry.Id)
			end)
			local text = table.concat(lines, "\n")
			print(text)
			pcall(setclipboard, text)
			notify("Positions", found .. " found. Printed to F9 and copied.", "Info", 4)
		end,
	})

	task.spawn(function()
		while not Library.Unloaded do
			local root = hrp()
			helperStats:Set("Your Position", root and string.format("%.0f, %.0f, %.0f", root.Position.X, root.Position.Y, root.Position.Z) or nil)
			task.wait(0.25)
		end
	end)
end

----------------------------------------------------------------
-- ESP tab
----------------------------------------------------------------
do
	local Visuals = Tabs.ESP:CreateSection("Visuals")
	Visuals:AddToggle({ Name = "Player ESP", Flag = "PlayerESP" })
	Visuals:AddToggle({ Name = "Entity ESP", Description = "Real entity names", Flag = "EntityESP", Default = true })
	Visuals:AddToggle({ Name = "Still Life ESP", Description = "Every Still Life NPC", Flag = "StillLifeESP" })
	Visuals:AddToggle({ Name = "Artifact ESP", Description = "Spawned artifacts, coloured by rarity", Flag = "ArtifactESP", Default = true })
	Visuals:AddToggle({ Name = "Spawn Markers ESP", Description = "Artifact spawn points, not actual loot", Flag = "ArtifactSpawnESP" })

	local Labels = Tabs.ESP:CreateSection("Labels")
	Labels:AddToggle({ Name = "Show Artifact Rarity", Flag = "ShowRarity", Default = true })
	Labels:AddToggle({ Name = "Show Distance", Flag = "ShowDistance", Default = true })
	Labels:AddSlider({
		Name = "Max Distance",
		Description = "Players, entities and Still Lifes",
		Flag = "MaxDistance",
		Min = 100,
		Max = 5000,
		Default = 1500,
		Increment = 50,
		Format = function(value)
			return value >= 5000 and "Unlimited" or (value .. " studs")
		end,
	})

	local ArtifactSection = Tabs.ESP:CreateSection("Artifact ESP")
	ArtifactSection:AddDropdown({
		Name = "Show Rarities",
		Description = "Only these get ESP (none picked = all)",
		Options = RARITY_ORDER,
		Default = RARITY_ORDER,
		Multi = true,
		Flag = "ArtifactRarities",
	})
	ArtifactSection:AddSlider({
		Name = "Artifact Distance",
		Description = "Unlimited shows every artifact on the map",
		Flag = "ArtifactDistance",
		Min = 100,
		Max = 10000,
		Default = 10000,
		Increment = 100,
		Format = function(value)
			return value >= 10000 and "Unlimited" or (value .. " studs")
		end,
	})
	ArtifactSection:AddToggle({
		Name = "Outline Rarest First",
		Description = "Roblox only outlines ~30 things at once, labels always show",
		Flag = "ArtifactOutlines",
		Default = true,
	})
	UI.RarityStats = ArtifactSection:AddStats({ Rows = RARITY_ORDER })

	local parts = {}
	for _, rarity in RARITY_ORDER do
		table.insert(parts, string.format('<font color="#%s">%s</font>', RARITY_COLORS[rarity]:ToHex(), string.upper(rarity)))
	end
	Labels:AddLabel({ Text = table.concat(parts, "  ·  "), RichText = true, Size = 13 })

	UI.ClearESPButton = Labels:AddButton({ Name = "Clear All ESP", Style = "Locked" })
end

----------------------------------------------------------------
-- Player tab
----------------------------------------------------------------
do
	local Movement = Tabs.Player:CreateSection("Movement")

	Movement:AddToggle({
		Name = "Speed",
		Flag = "SpeedEnabled",
		Keybind = true,
		Callback = function(enabled)
			local humanoid = hum()
			if humanoid and not enabled then
				humanoid.WalkSpeed = 16
			end
		end,
	})
	Movement:AddSlider({
		Name = "Walk Speed",
		Tooltip = "Capped at 28 to stay safe",
		Flag = "WalkSpeed",
		Min = 16,
		Max = 28,
		Default = 18,
	})
	Movement:AddToggle({ Name = "Fly", Description = "WASD to move, Space up, Shift down", Flag = "FlyEnabled", Keybind = true })
	Movement:AddSlider({ Name = "Fly Speed", Flag = "FlySpeed", Min = 20, Max = 100, Default = 40 })
	Movement:AddToggle({ Name = "Noclip", Flag = "Noclip", Keybind = true })
	Movement:AddToggle({ Name = "Infinite Jump", Flag = "InfiniteJump", Keybind = true })

	local Stealth = Tabs.Player:CreateSection("Stealth & Survival")
	Stealth:AddToggle({ Name = "Silent Footsteps", Flag = "SilentFeet", Default = true })
	Stealth:AddToggle({
		Name = "Infinite Stamina",
		Description = "Uses the game's own infinite stamina event flag",
		Flag = "InfiniteStamina",
		Default = true,
	})
	Stealth:AddToggle({
		Name = "Infinite Flashlight",
		Description = "Battery never drains",
		Flag = "InfiniteBattery",
		Default = true,
	})

	local WorldSection = Tabs.Player:CreateSection("World")
	WorldSection:AddToggle({ Name = "Fullbright", Description = "Restores your lighting when turned off", Flag = "Fullbright", Keybind = true })
	WorldSection:AddToggle({ Name = "Instant Proximity Prompts", Description = "Removes hold time from every prompt", Flag = "InstantPrompts", Default = true })
end

----------------------------------------------------------------
-- Artifacts tab
----------------------------------------------------------------
do
	local Inventory = Tabs.Artifacts:CreateSection("Inventory")
	local inventoryStats = Inventory:AddStats({ Rows = { "Owned", "Total Value", "Top Item" } })

	Inventory:AddButton({
		Name = "Check Inventory Value",
		Description = "Full breakdown is printed to the console",
		ButtonText = "Check",
		Style = "Codes",
		Callback = function()
			local total, count, rows = Artifacts.inventory()
			if not total then
				return
			end
			inventoryStats:Set("Owned", tostring(count))
			inventoryStats:Set("Total Value", "$" .. total, COLORS.Good)
			if count == 0 then
				inventoryStats:Set("Top Item", nil)
				notify("Inventory", "You own 0 artifacts.", "Warning")
				return
			end
			local top = rows[1]
			inventoryStats:Set("Top Item", string.format("%s x%d", top.Name, top.Count), Artifacts.rarityColor(top.Rarity))
			notify("Inventory", "Owned: " .. count .. "  |  Total Value: $" .. total, "Success")
			print("========== INVENTORY ==========")
			for _, row in ipairs(rows) do
				print(string.format("%s x%d | $%d each | $%d (%s)", row.Name, row.Count, row.Value, row.Count * row.Value, row.Rarity))
			end
		end,
	})

	Inventory:AddButton({
		Name = "Sell All Artifacts",
		Description = "Click twice to confirm",
		ButtonText = "Sell All",
		Style = "Locked",
		Confirm = true,
		ConfirmText = "Sure?",
		Callback = function()
			local ok = invoke(Remote.SellAllArtifacts)
			notify("Shop", ok and "Sold all artifacts." or "Sell all failed.", ok and "Success" or "Error")
		end,
	})

	local Farm = Tabs.Artifacts:CreateSection("Farm")

	local autoCollect = Farm:AddToggle({ Name = "Auto Collect", Description = "Collects artifacts within range", Flag = "AutoCollect" })
	Farm:AddToggle({
		Name = "Auto Farm",
		Description = "Teleports to each artifact and collects it",
		Flag = "AutoFarm",
		Keybind = true,
		Callback = function(enabled)
			autoCollect:SetLocked(enabled, "Auto Farm is on")
		end,
	})
	Farm:AddDropdown({
		Name = "Farm Rarities",
		Description = "Auto Collect / Auto Farm only grab these (none picked = all)",
		Options = RARITY_ORDER,
		Default = RARITY_ORDER,
		Multi = true,
		Flag = "FarmRarities",
	})
	Farm:AddSlider({ Name = "Collect Range", Flag = "AutoCollectRange", Min = 8, Max = 40, Default = 18, Suffix = " studs" })
	Farm:AddSlider({
		Name = "Farm Delay",
		Tooltip = "Lower is faster but riskier",
		Flag = "AutoFarmDelay",
		Min = 0.3,
		Max = 1.5,
		Increment = 0.05,
		Default = 0.55,
		Suffix = "s",
	})

	Farm:AddButton({
		Name = "Collect Nearest Artifact",
		ButtonText = "Collect",
		Style = "Claim",
		Callback = function()
			local artifact = Artifacts.nearest()
			if artifact and Artifacts.collect(artifact) then
				notify("Artifacts", "Collected " .. Artifacts.name(artifact), "Success")
			else
				notify("Artifacts", "No artifact nearby, or collecting failed.", "Warning")
			end
		end,
	})

	Farm:AddButton({
		Name = "Check Remaining Artifacts",
		ButtonText = "Check",
		Style = "Codes",
		Callback = function()
			local count = Artifacts.count()
			notify("Artifacts", count == 0 and "All artifacts picked up." or (count .. " remaining."), count == 0 and "Success" or "Info")
		end,
	})
end

----------------------------------------------------------------
-- Codes tab
----------------------------------------------------------------
do
	local Redeem = Tabs.Codes:CreateSection("Redeem")
	Redeem:AddInput({
		Name = "Code",
		Description = "Press Enter to redeem",
		Placeholder = "Enter code",
		Flag = "CodeInput",
		Callback = function(text, enterPressed)
			if enterPressed then
				task.spawn(redeem, text)
			end
		end,
	})
	Library.ConfigIgnore.CodeInput = true
	Redeem:AddButton({
		Name = "Redeem Code",
		Style = "Claim",
		Callback = function()
			task.spawn(redeem, Flags.CodeInput)
		end,
	})

	local Rewards = Tabs.Codes:CreateSection("Rewards")
	local function claim(remote, title)
		if not remote then
			notify(title, "This reward isn't in the game right now.", "Warning")
			return
		end
		local ok, result = invoke(remote)
		local message = type(result) == "table" and (result.Message or result.Error) or nil
		local success = ok and not (type(result) == "table" and result.Success == false) and result ~= false
		notify(title, message and tostring(message) or (success and "Claimed!" or "Nothing to claim right now."), success and "Success" or "Warning", 4)
	end
	Rewards:AddButton({
		Name = "Claim Daily Reward",
		ButtonText = "Claim",
		Style = "Claim",
		Callback = function()
			claim(Remote.DailyClaim, "Daily Reward")
		end,
	})
	Rewards:AddToggle({
		Name = "Auto Claim Daily Reward",
		Description = "Tries again every 10 minutes",
		Flag = "AutoDaily",
	})
	Rewards:AddButton({
		Name = "Claim Group Reward",
		Description = "You need to be in the Bloxrooms group",
		ButtonText = "Claim",
		Style = "Codes",
		Callback = function()
			claim(Remote.GroupReward, "Group Reward")
		end,
	})
	UI.ClaimDaily = function()
		claim(Remote.DailyClaim, "Daily Reward")
	end

	local Known = Tabs.Codes:CreateSection("Known Codes")
	for _, code in ipairs(CODES) do
		Known:AddButton({
			Name = code,
			ButtonText = "Redeem",
			Style = "Codes",
			Callback = function()
				task.spawn(redeem, code)
			end,
		})
	end
	Known:AddButton({
		Name = "Redeem All Known Codes",
		Style = "Skip",
		Callback = function()
			for _, code in ipairs(CODES) do
				redeem(code)
				task.wait(0.4)
			end
		end,
	})
end

local SettingsTab = Window:CreateSettingsTab()
SettingsTab:CreateSection("Credits"):AddParagraph({
	Title = "Credits",
	Content = "Made by Evol\nBloxrooms v0.3.0 (Revamp)\nDump PlaceId 127943464865693\nUI: Project RetroSlop v" .. tostring(Library.Version),
})

----------------------------------------------------------------
-- ESP
----------------------------------------------------------------
local ESP = {}

do
	local tracked = {}
	local MAX_OUTLINES = 30
	local KIND_PRIORITY = { entity = 1, player = 2, stilllife = 3, artifact = 4, spawn = 5 }

	local function clear(object)
		local data = tracked[object]
		if not data then
			return
		end
		pcall(function()
			data.Highlight:Destroy()
			data.Billboard:Destroy()
		end)
		tracked[object] = nil
	end

	function ESP.clearAll()
		for object in tracked do
			clear(object)
		end
	end

	function ESP.clearKind(kind)
		for object, data in tracked do
			if data.Kind == kind then
				clear(object)
			end
		end
	end

	local function add(object, color, name, kind, rank)
		if tracked[object] then
			return
		end
		local part = getPart(object)
		if not part then
			return
		end

		local highlight = Instance.new("Highlight")
		highlight.Adornee = object:IsA("Model") and object or part
		highlight.FillColor = color
		highlight.OutlineColor = Color3.new(1, 1, 1)
		highlight.FillTransparency = 0.62
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Enabled = false
		highlight.Parent = WorldHolder

		local billboard = Instance.new("BillboardGui")
		billboard.Adornee = part
		billboard.Size = UDim2.fromOffset(200, 36)
		billboard.StudsOffset = Vector3.new(0, 2.6, 0)
		billboard.AlwaysOnTop = true
		billboard.MaxDistance = math.huge
		billboard.LightInfluence = 0
		billboard.Parent = WorldHolder

		local label = Instance.new("TextLabel")
		label.Size = UDim2.fromScale(1, 1)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.GothamBlack
		label.TextSize = 13
		label.TextColor3 = color
		label.TextStrokeTransparency = 0
		label.Text = name
		label.Parent = billboard

		tracked[object] = { Highlight = highlight, Billboard = billboard, Label = label, Part = part, Name = name, Kind = kind, Rank = rank or 0 }
	end

	local STILL_LIFE_NAMES = {}
	for _, entry in STILL_LIFES do
		STILL_LIFE_NAMES[entry.Id] = entry.Name
	end

	local function limit(value, unlimitedAt)
		return value >= unlimitedAt and math.huge or value
	end

	function ESP.scan()
		placeWorldHolder()
		local camera = Workspace.CurrentCamera
		if not camera then
			return
		end

		-- Players
		if Flags.PlayerESP then
			for _, player in Players:GetPlayers() do
				if player ~= LocalPlayer and alive(player) and player.Character then
					add(player.Character, Color3.fromRGB(0, 170, 255), player.DisplayName or player.Name, "player")
				end
			end
		else
			ESP.clearKind("player")
		end

		-- Entities
		if Flags.EntityESP then
			for _, entity in World.entities() do
				add(entity, Color3.fromRGB(255, 60, 60), entity.Name, "entity")
			end
			for _, child in Workspace:GetChildren() do
				if not tracked[child] and World.isEntity(child) then
					add(child, Color3.fromRGB(255, 50, 50), child.Name, "entity")
				end
			end
		else
			ESP.clearKind("entity")
		end

		-- Still lifes
		if Flags.StillLifeESP then
			local folder = Workspace:FindFirstChild("StillLifes")
			if folder then
				local function addStillLife(model)
					if model:IsA("Model") then
						local id = model:GetAttribute("CollectionId") or model.Name
						add(model, Color3.fromRGB(120, 230, 150), STILL_LIFE_NAMES[id] or model.Name, "stilllife")
					end
				end
				for _, child in folder:GetChildren() do
					if child:IsA("Folder") then
						for _, nested in child:GetChildren() do
							addStillLife(nested)
						end
					else
						addStillLife(child)
					end
				end
			end
		else
			ESP.clearKind("stilllife")
		end

		-- Artifacts (every one on the map, filtered by rarity)
		local counts = {}
		if Flags.ArtifactESP then
			Artifacts.each(function(object)
				local rarity = Artifacts.rarity(object)
				counts[rarity] = (counts[rarity] or 0) + 1
				if not Artifacts.allowed(object, "ArtifactRarities") then
					clear(object)
					return
				end
				if not tracked[object] then
					local label = Artifacts.name(object)
					if Flags.ShowRarity then
						label ..= " [" .. rarity .. "]"
					end
					add(object, Artifacts.rarityColor(rarity), label, "artifact", RARITY_RANK[rarity] or #RARITY_ORDER + 1)
				end
			end)
		else
			ESP.clearKind("artifact")
			Artifacts.each(function(object)
				local rarity = Artifacts.rarity(object)
				counts[rarity] = (counts[rarity] or 0) + 1
			end)
		end
		if UI.RarityStats then
			for _, rarity in RARITY_ORDER do
				local count = counts[rarity] or 0
				UI.RarityStats:Set(rarity, tostring(count), count > 0 and Artifacts.rarityColor(rarity) or COLORS.Muted)
			end
		end

		-- Spawn markers
		if Flags.ArtifactSpawnESP then
			local spawns = Workspace:FindFirstChild("ArtifactSpawns")
			if spawns then
				for _, descendant in spawns:GetDescendants() do
					if (descendant:IsA("BasePart") or descendant:IsA("Model")) and not tracked[descendant] and not Artifacts.is(descendant) then
						if string.find(descendant.Name, "Spawn") or descendant:GetAttribute("GeneratedArtifactSpawn") then
							if not Artifacts.is(descendant.Parent) then
								add(descendant, Color3.fromRGB(255, 200, 50), "SPAWN", "spawn")
							end
						end
					end
				end
			end
		else
			ESP.clearKind("spawn")
		end

		-- Distances, labels and who gets the ~30 outlines Roblox allows
		local origin = camera.CFrame.Position
		local maxDistance = limit(Flags.MaxDistance or 1500, 5000)
		local artifactDistance = limit(Flags.ArtifactDistance or 10000, 10000)
		local visibleList = {}
		for object, data in tracked do
			if not object.Parent or not data.Part or not data.Part.Parent then
				clear(object)
			else
				local distance = (origin - data.Part.Position).Magnitude
				local visible = distance <= (data.Kind == "artifact" and artifactDistance or maxDistance)
				data.Billboard.Enabled = visible
				data.Highlight.Enabled = false
				if visible then
					data.Label.Text = Flags.ShowDistance and (data.Name .. "  •  " .. math.floor(distance) .. "m") or data.Name
					table.insert(visibleList, { Data = data, Distance = distance })
				end
			end
		end
		local rarestFirst = Flags.ArtifactOutlines ~= false
		table.sort(visibleList, function(a, b)
			local pa, pb = KIND_PRIORITY[a.Data.Kind] or 9, KIND_PRIORITY[b.Data.Kind] or 9
			if pa ~= pb then
				return pa < pb
			end
			if rarestFirst and a.Data.Kind == "artifact" and a.Data.Rank ~= b.Data.Rank then
				return a.Data.Rank > b.Data.Rank
			end
			return a.Distance < b.Distance
		end)
		for i = 1, math.min(#visibleList, MAX_OUTLINES) do
			visibleList[i].Data.Highlight.Enabled = true
		end
		ESP.Visible = #visibleList
	end

	-- New artifacts show up straight away instead of waiting for the next sweep
	local pending = false
	function ESP.soon()
		if pending then
			return
		end
		pending = true
		task.delay(0.15, function()
			pending = false
			if not Library.Unloaded then
				pcall(ESP.scan)
			end
		end)
	end

	for _, folder in Artifacts.folders() do
		Library:Track(folder.ChildAdded:Connect(ESP.soon))
	end

	Library:OnUnload(ESP.clearAll)
end

-- Labels re-render when these change
for _, flag in { "ShowRarity" } do
	Library.Options[flag]:OnChanged(function()
		ESP.clearKind("artifact")
		ESP.soon()
	end)
end
for _, flag in { "ArtifactRarities", "ArtifactDistance", "MaxDistance", "ArtifactOutlines" } do
	Library.Options[flag]:OnChanged(ESP.soon)
end
UI.ClearESPButton:SetCallback(ESP.clearAll)

----------------------------------------------------------------
-- Game flags (stamina / flashlight are client-side event switches)
----------------------------------------------------------------
local EventFlags = { Saved = {} }

function EventFlags.apply(attribute, enabled)
	if enabled then
		if EventFlags.Saved[attribute] == nil then
			EventFlags.Saved[attribute] = Workspace:GetAttribute(attribute) == true
		end
		if Workspace:GetAttribute(attribute) ~= true then
			Workspace:SetAttribute(attribute, true)
		end
	elseif EventFlags.Saved[attribute] ~= nil then
		Workspace:SetAttribute(attribute, EventFlags.Saved[attribute])
		EventFlags.Saved[attribute] = nil
	end
end

----------------------------------------------------------------
-- Lighting + prompts
----------------------------------------------------------------
local savedLighting = nil

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
Library.Options.Fullbright:OnChanged(setFullbright)

local promptConnection = nil
local function setInstantPrompts(enabled)
	if promptConnection then
		promptConnection:Disconnect()
		promptConnection = nil
	end
	if not enabled then
		return
	end
	for _, descendant in Workspace:GetDescendants() do
		if descendant:IsA("ProximityPrompt") then
			descendant.HoldDuration = 0
		end
	end
	promptConnection = Library:Track(Workspace.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("ProximityPrompt") then
			descendant.HoldDuration = 0
		end
	end))
end
Library.Options.InstantPrompts:OnChanged(setInstantPrompts)
setInstantPrompts(Flags.InstantPrompts)

----------------------------------------------------------------
-- Background loops
----------------------------------------------------------------
task.spawn(function()
	while not Library.Unloaded do
		task.wait(0.5)
		if Library.Unloaded then
			break
		end
		local ok, err = pcall(ESP.scan)
		if not ok then
			warn("[Bloxrooms] ESP scan error: " .. tostring(err))
		end
	end
end)

task.spawn(function()
	local indexClock = 0
	while not Library.Unloaded do
		pcall(refreshLiveStatus)
		EventFlags.apply("EventInfiniteStamina", Flags.InfiniteStamina == true)
		EventFlags.apply("EventInfiniteBattery", Flags.InfiniteBattery == true)
		indexClock += 1
		if indexClock >= 20 then -- every 30s
			indexClock = 0
			task.spawn(Index.refresh)
		end
		task.wait(1.5)
	end
end)

-- Auto collect (in range)
task.spawn(function()
	local lastEmpty = 0
	while not Library.Unloaded do
		task.wait(0.4)
		local root = hrp()
		if Flags.AutoCollect and not Flags.AutoFarm and root then
			local any = false
			local targets = {}
			Artifacts.each(function(object)
				any = true
				if not Artifacts.allowed(object, "FarmRarities") then
					return
				end
				local position = Artifacts.position(object)
				if position and (root.Position - position).Magnitude <= (Flags.AutoCollectRange or 18) then
					table.insert(targets, object)
				end
			end)
			for _, object in targets do
				if Library.Unloaded or not Flags.AutoCollect then
					break
				end
				if Artifacts.collect(object) then
					notify("Auto Collect", "Collected " .. Artifacts.name(object), "Success")
				end
				task.wait(0.2)
			end
			if not any and os.clock() - lastEmpty > 8 then
				lastEmpty = os.clock()
				notify("Auto Collect", "All artifacts picked up.")
			end
		end
	end
end)

-- Auto farm (teleport + collect)
task.spawn(function()
	local lastEmpty = 0
	while not Library.Unloaded do
		task.wait(Flags.AutoFarmDelay or 0.55)
		if Flags.AutoFarm and hrp() then
			local artifact, position = Artifacts.nearest()
			if artifact and position then
				Travel.cframe(CFrame.new(position + Vector3.new(0, 3.5, 0)))
				task.wait(0.15)
				if Artifacts.collect(artifact) then
					notify("Auto Farm", "Collected " .. Artifacts.name(artifact), "Success")
				end
			elseif os.clock() - lastEmpty > 8 then
				lastEmpty = os.clock()
				notify("Auto Farm", "All artifacts picked up.")
			end
		end
	end
end)

----------------------------------------------------------------
-- Movement
----------------------------------------------------------------
local Fly = { Velocity = nil, Gyro = nil }

function Fly.start()
	local root = hrp()
	if Fly.Velocity or not root then
		return
	end
	Fly.Velocity = Instance.new("BodyVelocity")
	Fly.Velocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	Fly.Velocity.Velocity = Vector3.zero
	Fly.Velocity.Parent = root
	Fly.Gyro = Instance.new("BodyGyro")
	Fly.Gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	Fly.Gyro.P = 18000
	Fly.Gyro.Parent = root
end

function Fly.stop()
	if Fly.Velocity then
		Fly.Velocity:Destroy()
		Fly.Velocity = nil
	end
	if Fly.Gyro then
		Fly.Gyro:Destroy()
		Fly.Gyro = nil
	end
end

local function forCharacterDescendants(callback)
	local character = LocalPlayer.Character
	if character then
		for _, descendant in character:GetDescendants() do
			callback(descendant)
		end
	end
end

local function silentFeet()
	forCharacterDescendants(function(descendant)
		if descendant:IsA("Sound") then
			local name = string.lower(descendant.Name)
			if string.find(name, "foot") or string.find(name, "step") or string.find(name, "walk") or string.find(name, "run") then
				descendant.Volume = 0
			end
		end
	end)
end

do
	local sweep = 0
	Library:Track(RunService.RenderStepped:Connect(function(dt)
		sweep += dt
		if sweep >= 0.5 then
			sweep = 0
			if Flags.SilentFeet then
				silentFeet()
			end
		end

		if Flags.SpeedEnabled then
			local humanoid = hum()
			if humanoid then
				humanoid.WalkSpeed = math.clamp(Flags.WalkSpeed or 18, 16, 28)
			end
		end

		if Flags.FlyEnabled then
			if not Fly.Velocity then
				Fly.start()
			end
			local camera = Workspace.CurrentCamera
			if Fly.Velocity and camera then
				local cframe = camera.CFrame
				local direction = Vector3.zero
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					direction += cframe.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					direction -= cframe.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					direction -= cframe.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					direction += cframe.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					direction += Vector3.yAxis
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
					direction -= Vector3.yAxis
				end
				-- Touch / gamepad: follow the move stick
				local humanoid = hum()
				if direction.Magnitude == 0 and humanoid and humanoid.MoveDirection.Magnitude > 0 then
					direction = humanoid.MoveDirection
				end
				Fly.Velocity.Velocity = direction.Magnitude > 0 and direction.Unit * (Flags.FlySpeed or 40) or Vector3.zero
				Fly.Gyro.CFrame = cframe
			end
		elseif Fly.Velocity then
			Fly.stop()
		end

		if Flags.Noclip then
			local character = LocalPlayer.Character
			if character then
				for _, part in character:GetChildren() do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end

		if Flags.Fullbright then
			Lighting.Brightness = 2
			Lighting.ClockTime = 14
			Lighting.FogEnd = 100000
			Lighting.GlobalShadows = false
			Lighting.Ambient = Color3.fromRGB(170, 170, 170)
		end
	end))
end

Library:Track(UserInputService.JumpRequest:Connect(function()
	if Flags.InfiniteJump then
		local humanoid = hum()
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end))

Library:Track(LocalPlayer.CharacterAdded:Connect(Fly.stop))

----------------------------------------------------------------
-- Cleanup + start
----------------------------------------------------------------
Library:OnUnload(function()
	Runner.Active = false
	Fly.stop()
	setFullbright(false)
	setInstantPrompts(false)
	EventFlags.apply("EventInfiniteStamina", false)
	EventFlags.apply("EventInfiniteBattery", false)
	if Flags.SpeedEnabled then
		local humanoid = hum()
		if humanoid then
			humanoid.WalkSpeed = 16
		end
	end
end)

task.spawn(function()
	while not Library.Unloaded do
		if Flags.AutoDaily and UI.ClaimDaily then
			pcall(UI.ClaimDaily)
		end
		for _ = 1, 600 do
			if Library.Unloaded then
				return
			end
			task.wait(1)
		end
	end
end)

Library:LoadAutoload()
task.spawn(Index.refresh)

Library:Notify({
	Title = "Bloxrooms",
	Content = "v0.3.0 (Revamp) loaded. Left Ctrl toggles the menu.",
	Style = "Theme",
	Duration = 5,
})
