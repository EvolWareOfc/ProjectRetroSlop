--[[
	Project RetroSlop v0.0.3 · Example Usage
	A full showcase of every element and feature. Execute it and click around.
]]

--// Load the library
local LIBRARY_URL = "https://raw.githubusercontent.com/EvolWareOfc/ProjectRetroSlop/refs/heads/main/UI/v0.0.3.lua"

local Library
do
	local ok, result = pcall(function()
		return loadstring(game:HttpGet(LIBRARY_URL))()
	end)
	if not ok or type(result) ~= "table" then
		error("[Example] RetroSlop didn't load: " .. tostring(result), 0)
	end
	Library = result
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Flags = Library.Flags

--// Custom theme (only an Accent is required, everything else is derived)
Library:AddTheme("Lemon", { Accent = Color3.fromRGB(255, 225, 0) })

--// Window
local Window = Library:CreateWindow({
	Title = "RetroSlop Example",
	Subtitle = "Project RetroSlop · v" .. Library.Version,
	Theme = "Rebirth",
	ToggleKey = Enum.KeyCode.RightShift,
	IntroText = "Loading example...",

	Resizable = true,
	MinWidth = 480,
	MaxWidth = 1000,
	MinHeight = 340,
	MaxHeight = 720,

	MinimizeToButton = true,
	MinimizeButtonText = "RS",
	MinimizeButtonSnap = true,

	MobileTabMode = "BottomBar",

	RememberPosition = true,
	RememberSize = true,
})

----------------------------------------------------------------
-- HOME
----------------------------------------------------------------
local Home = Window:CreateTab({ Name = "Home" })

local Welcome = Home:CreateSection("Welcome")

Welcome:AddParagraph({
	Title = "Hey, " .. LocalPlayer.DisplayName,
	Content = "This is a tour of everything Project RetroSlop can do. Press RightShift to hide the menu, "
		.. "or use the blue V button in the header to shrink it into a floating button.",
})

Welcome:AddImageButton({
	Name = "Discord",
	Description = "Copies the invite link",
	Image = "rbxassetid://6031075938",
	Callback = function()
		if setclipboard then
			setclipboard("https://discord.gg/your-invite")
		end
		Library:Notify({ Title = "Discord", Content = "Invite copied to your clipboard.", Style = "Success", Duration = 3 })
	end,
})

local Session = Home:AddCard({ Title = "Session", Description = "Updates every second" })

local ServerStatus = Session:AddStatus({ Name = "Script Status", Status = "Online" })

local SessionStats = Session:AddStats({ Rows = { "Player", "Players In Server", "Uptime", "Device" } })

local Xp = Session:AddProgressBar({
	Name = "Session XP",
	Description = "Fills up while you stay",
	Min = 0,
	Max = 60,
	Default = 0,
	Format = function(value)
		return string.format("%d / 60 XP", value)
	end,
})

----------------------------------------------------------------
-- ELEMENTS
----------------------------------------------------------------
local Elements = Window:CreateTab({ Name = "Elements" })

-- Toggles & checkboxes
local Switches = Elements:CreateSection("Switches")

local AutoFarm = Switches:AddToggle({
	Name = "Auto Farm",
	Description = "Has its own hotkey (click the key box)",
	Tooltip = "Desktop: press G. Mobile: just tap the row.",
	Flag = "AutoFarm",
	Keybind = Enum.KeyCode.G,
	Callback = function(state)
		ServerStatus:SetStatus(state and "Farming" or "Online", state and Color3.fromRGB(255, 196, 40) or nil)
	end,
})

Switches:AddCheckbox({
	Name = "Show Damage Numbers",
	Description = "Checkboxes work just like toggles",
	Flag = "DamageNumbers",
	Default = true,
})

local SafeMode = Switches:AddCheckbox({
	Name = "Safe Mode",
	Description = "Locks the danger slider when on",
	Flag = "SafeMode",
})

-- Sliders
local Sliders = Elements:CreateSection("Sliders")

Sliders:AddSlider({
	Name = "Walk Speed",
	Description = "Type a number, drag, or hover + arrow keys",
	Flag = "WalkSpeed",
	Min = 16,
	Max = 100,
	Default = 16,
	Suffix = "studs/s",
	Callback = function(value)
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = value
		end
	end,
})

Sliders:AddSlider({
	Name = "Render Distance",
	Description = "Logarithmic: fine control at the low end",
	Flag = "RenderDistance",
	Min = 10,
	Max = 10000,
	Default = 500,
	Logarithmic = true,
	Format = function(value)
		return value >= 1000 and string.format("%.1fk studs", value / 1000) or (value .. " studs")
	end,
})

local DangerSlider = Sliders:AddSlider({
	Name = "Danger Level",
	Flag = "Danger",
	Min = 0,
	Max = 1,
	Increment = 0.05,
	Default = 0.5,
	Prefix = "x",
})

SafeMode:OnChanged(function(state)
	DangerSlider:SetLocked(state, "Safe Mode is on")
end)

-- Dropdowns
local Pickers = Elements:CreateSection("Dropdowns")

Pickers:AddDropdown({
	Name = "Weapon",
	Description = "Arrow keys + Enter work while open",
	Options = { "Sword", "Bow", "Staff", "Hammer" },
	Default = "Sword",
	Flag = "Weapon",
})

local Pets = Pickers:AddDropdown({
	Name = "Pets",
	Description = "Multi-select with ALL / NONE",
	Options = { "Cat", "Dog", "Dragon", "Phoenix", "Slime", "Bunny", "Owl", "Fox" },
	Default = { "Cat", "Dog" },
	Multi = true,
	Flag = "Pets",
})

Pickers:AddButton({
	Name = "Add A Random Pet",
	Description = "Options can change at runtime",
	ButtonText = "Add",
	Style = "Codes",
	Callback = function()
		local name = "Pet #" .. math.random(100, 999)
		Pets:Add(name)
		Library:Notify({ Title = "Pets", Content = name .. " joined the list.", Style = "Info", Duration = 2 })
	end,
})

Pickers:AddPlayerDropdown({
	Name = "Target Player",
	Description = "Updates when players join or leave",
	Flag = "TargetPlayer",
	AutoRefresh = true,
})

-- Text
local Text = Elements:CreateSection("Text")

Text:AddInput({
	Name = "Nickname",
	Placeholder = "Type and press Enter",
	MaxLength = 20,
	Flag = "Nickname",
	Callback = function(text, enterPressed)
		if enterPressed and text ~= "" then
			Library:Notify({ Title = "Nickname", Content = "Hello, " .. text .. "!", Style = "Success", Duration = 2 })
		end
	end,
})

Text:AddInput({
	Name = "Amount",
	Placeholder = "Numbers only",
	Numeric = true,
	Flag = "Amount",
})

Text:AddTextArea({
	Name = "Notes",
	Description = "Multi-line, scrolls, has a character limit",
	Placeholder = "Write anything here...",
	MaxLength = 300,
	Height = 110,
	Flag = "Notes",
})

-- Colors & keys
local Extras = Elements:CreateSection("Colors & Keys")

Extras:AddColorPicker({
	Name = "Highlight Color",
	Description = "Copy / paste between pickers",
	Default = Color3.fromRGB(160, 0, 255),
	Flag = "HighlightColor",
})

Extras:AddKeybind({
	Name = "Dash",
	Description = "Press mode: fires once per press",
	Default = Enum.KeyCode.Q,
	Mode = "Press",
	Flag = "DashKey",
	MobileText = "DSH",
	Callback = function()
		Library:Notify({ Title = "Dash!", Content = "Whoosh.", Style = "Theme", Duration = 1.5, Sound = false })
	end,
})

Extras:AddKeybind({
	Name = "Sprint",
	Description = "Hold mode: true on press, false on release",
	Default = Enum.KeyCode.LeftShift,
	Mode = "Hold",
	Flag = "SprintKey",
	MobileText = "RUN",
	Callback = function(holding)
		ServerStatus:SetStatus(holding and "Sprinting" or "Online")
	end,
})

-- Buttons
local Buttons = Elements:CreateSection("Buttons")

Buttons:AddButton({
	Name = "Big Claim Button",
	Style = "Claim",
	Callback = function()
		Library:Notify({ Title = "Claimed", Content = "You clicked the big button.", Style = "Success", Duration = 2 })
	end,
})

Buttons:AddButton({
	Name = "Reset Character",
	Description = "Asks you to click twice",
	ButtonText = "Reset",
	Style = "Locked",
	Confirm = true,
	ConfirmText = "Sure?",
	Callback = function()
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.Health = 0
		end
	end,
})

Buttons:AddButton({
	Name = "Ask Me Something",
	Description = "Opens a dialog",
	ButtonText = "Ask",
	Style = "Rebirth",
	Callback = function()
		Window:Dialog({
			Title = "Pick One",
			Content = "Dialogs can have up to three buttons.",
			Buttons = {
				{ Text = "Cats", Style = "Claim", Callback = function()
					Library:Notify({ Title = "Answer", Content = "Cats it is.", Duration = 2 })
				end },
				{ Text = "Dogs", Style = "Codes", Callback = function()
					Library:Notify({ Title = "Answer", Content = "Dogs it is.", Duration = 2 })
				end },
				{ Text = "Cancel", Style = "Claimed" },
			},
		})
	end,
})

Buttons:AddButton({
	Name = "Coming Soon",
	ButtonText = "Soon",
	Style = "Claimed",
	Locked = true,
	LockedReason = "Coming in v0.0.4",
})

----------------------------------------------------------------
-- DATA
----------------------------------------------------------------
local Data = Window:CreateTab({ Name = "Data" })

local Loot = Data:CreateSection("Loot Log")

local RARITIES = { "Common", "Rare", "Epic", "Legendary", "Mythic" }
local ITEMS = { "Sword", "Shield", "Gem", "Potion", "Crown", "Ring", "Boots" }

local LootTable = Loot:AddTable({
	Name = "Drops",
	Description = "Scrolls sideways on small screens",
	Columns = { "Item", "Rarity", { Name = "Value", Width = 90 }, { Name = "Time", Width = 90 } },
	Height = 170,
})

local function randomDrop()
	return {
		Item = ITEMS[math.random(#ITEMS)],
		Rarity = RARITIES[math.random(#RARITIES)],
		Value = "$" .. math.random(10, 5000),
		Time = os.date("%H:%M:%S"),
	}
end

Loot:AddButton({
	Name = "Simulate A Drop",
	ButtonText = "Drop",
	Style = "Claim",
	Callback = function()
		LootTable:AddRow(randomDrop())
	end,
})

Loot:AddButton({
	Name = "Clear Log",
	ButtonText = "Clear",
	Style = "Locked",
	Callback = function()
		LootTable:Clear()
	end,
})

local Filter = Data:CreateSection("Search Box")

Filter:AddSearch({
	Placeholder = "Filter this section...",
	FilterScope = "Section",
})

for _, fruit in { "Apple", "Banana", "Cherry", "Dragonfruit", "Elderberry", "Fig", "Grape" } do
	Filter:AddLabel({ Text = string.upper(fruit), Color = Color3.fromRGB(255, 255, 255) })
end

----------------------------------------------------------------
-- NOTIFICATIONS
----------------------------------------------------------------
local Notifs = Window:CreateTab({ Name = "Notifications" })

local Styles = Notifs:CreateSection("Styles")

for _, style in { "Info", "Success", "Warning", "Error", "Theme" } do
	Styles:AddButton({
		Name = style,
		ButtonText = "Show",
		Style = style == "Error" and "Locked" or (style == "Warning" and "Skip" or (style == "Success" and "Claim" or "Codes")),
		Callback = function()
			Library:Notify({ Title = style, Content = "This is a " .. string.lower(style) .. " notification.", Style = style, Duration = 4 })
		end,
	})
end

local Advanced = Notifs:CreateSection("Advanced")

Advanced:AddButton({
	Name = "With Action Buttons",
	Description = "Stays until you pick",
	ButtonText = "Show",
	Style = "Rebirth",
	Callback = function()
		Library:Notify({
			Title = "Teleport?",
			Content = "Go back to spawn?",
			Persistent = true,
			Buttons = {
				{ Text = "Go", Style = "Claim", Callback = function()
					local character = LocalPlayer.Character
					if character then
						character:PivotTo(CFrame.new(0, 10, 0))
					end
				end },
				{ Text = "Nah", Style = "Claimed" },
			},
		})
	end,
})

Advanced:AddButton({
	Name = "Download Simulation",
	Description = "A notification with a live progress bar",
	ButtonText = "Start",
	Style = "Codes",
	Callback = function()
		local note = Library:Notify({ Title = "Downloading", Content = "0%", Progress = 0, Persistent = true })
		for step = 1, 10 do
			task.wait(0.3)
			note:SetProgress(step / 10)
			note:SetContent(string.format("%d%%", step * 10))
		end
		note:SetTitle("Done")
		task.wait(1)
		note:Close()
	end,
})

Advanced:AddButton({
	Name = "Spam 8 (Queue Test)",
	Description = "Extras wait their turn",
	ButtonText = "Spam",
	Style = "Skip",
	Callback = function()
		for index = 1, 8 do
			Library:Notify({ Title = "Queued #" .. index, Content = "Shown when there's room.", Duration = 2, Sound = index == 1 })
		end
	end,
})

Advanced:AddDropdown({
	Name = "Position",
	Options = { "TopLeft", "Top", "TopRight", "BottomLeft", "Bottom", "BottomRight" },
	Default = "BottomRight",
	Callback = function(position)
		if position then
			Library:SetNotificationPosition(position)
			Library:Notify({ Title = "Moved", Content = "Notifications now appear " .. position .. ".", Duration = 2 })
		end
	end,
})

----------------------------------------------------------------
-- WINDOW
----------------------------------------------------------------
local WindowTab = Window:CreateTab({ Name = "Window" })

local Controls = WindowTab:CreateSection("Controls")

Controls:AddButton({
	Name = "Minimize To Button",
	Description = "Tap the floating button to come back",
	ButtonText = "Shrink",
	Style = "Codes",
	Callback = function()
		Window:SetMinimizedToButton(true)
	end,
})

Controls:AddButton({
	Name = "Collapse To Header",
	ButtonText = "Collapse",
	Style = "Skip",
	Callback = function()
		Window:SetMinimized(true)
	end,
})

Controls:AddButton({
	Name = "Center Window",
	ButtonText = "Center",
	Style = "Claim",
	Callback = function()
		Window:Center()
	end,
})

Controls:AddButton({
	Name = "Snap To Top Left",
	ButtonText = "Move",
	Style = "Rebirth",
	Callback = function()
		Window:SetPosition(20, 20)
	end,
})

local Look = WindowTab:CreateSection("Quick Look")

Look:AddDropdown({
	Name = "Theme",
	Description = "Includes the custom Lemon theme",
	Options = Library:GetThemes(),
	Default = Library.ThemeName,
	Searchable = true,
	Callback = function(theme)
		if theme then
			Library:SetTheme(theme)
		end
	end,
})

Look:AddDropdown({
	Name = "Mobile Tab Layout",
	Description = "Visible on phones / small windows",
	Options = { "Sidebar", "BottomBar", "Dropdown" },
	Default = Window.MobileTabMode,
	Callback = function(mode)
		if mode then
			Window:SetMobileTabMode(mode)
		end
	end,
})

Look:AddStatus({
	Name = "Device",
	Status = (select(1, Library:GetDevice())),
	Color = Color3.fromRGB(0, 205, 255),
})

----------------------------------------------------------------
-- SETTINGS (themes, theme editor, accessibility, configs, unload...)
----------------------------------------------------------------
Window:CreateSettingsTab()

----------------------------------------------------------------
-- LIVE UPDATES
----------------------------------------------------------------
local startTime = os.clock()

task.spawn(function()
	while not Library.Unloaded do
		local elapsed = os.clock() - startTime
		SessionStats:Set("Player", LocalPlayer.Name)
		SessionStats:Set("Players In Server", #Players:GetPlayers())
		SessionStats:Set("Uptime", string.format("%02d:%02d", elapsed // 60, elapsed % 60))
		SessionStats:Set("Device", (select(1, Library:GetDevice())), Color3.fromRGB(0, 205, 255))
		Xp:Set(math.min(60, elapsed // 1))

		if Flags.AutoFarm and math.random() < 0.3 then
			LootTable:AddRow(randomDrop())
		end

		task.wait(1)
	end
end)

Library:OnUnload(function()
	print("[Example] Unloaded, bye!")
end)

--// Start
Library:LoadAutoload()

Library:Notify({
	Title = "Welcome",
	Content = "RightShift toggles the menu. Check out every tab!",
	Style = "Theme",
	Duration = 5,
})
