--[[
	Project RetroSlop · UI Library · v0.0.3
	Cartoon / simulator-style Roblox UI library built on the Check-UI design standard.

	local Library = loadstring(game:HttpGet("<raw url>"))()

	Everything from v0.0.2 still works. New in v0.0.3 is marked [NEW].

	════════════════════════════════════════════════════════════════════════
	WINDOW
	════════════════════════════════════════════════════════════════════════
	local Window = Library:CreateWindow({
		Title, Subtitle, Theme, Width, Height, Position,
		ToggleKey,                 -- default RightShift
		Sunburst,                  -- default true
		Intro, IntroText,          -- loading splash (default true)
		MobileButton,              -- floating open/close button (default: on for touch devices)
		MobileButtonText,          -- default "RS"

		[NEW] ForceMobile,             -- true/false to force touch layout (handy for testing in Studio)
		[NEW] MobileSidebar,           -- collapsible sidebar on phones / small windows (default true)
		[NEW] MobileTabMode,           -- "Sidebar" (default) | "BottomBar" | "Dropdown"
		[NEW] MinimizeToButton,        -- adds a header button that hides the window behind a floating button
		[NEW] MinimizeButtonText,      -- default MobileButtonText or "RS"
		[NEW] MinimizeButtonSize,      -- default 54
		[NEW] MinimizeButtonPosition,  -- UDim2 or Vector2 (pixel centre), default left middle
		[NEW] MinimizeButtonSnap,      -- snap the floating button to the nearest edge (default false)
		[NEW] Resizable,               -- drag the corner grip to resize (default false)
		[NEW] MinWidth, MaxWidth, MinHeight, MaxHeight,
		[NEW] RememberPosition, RememberSize, RememberMinimizedState,
		[NEW] SaveKey,                 -- file name for remembered state (default: Title)
	})

	Window:CreateTab({ Name, Icon }) -> Tab          Tab:Select()
	Window:CreateSettingsTab({ Name, Icon }) -> Tab
	Window:SelectTab(tab | name) / :SetVisible(bool) / :Toggle() / :SetMinimized(bool)
	Window:SetTitle(title, subtitle) / :SetToggleKey(key) / :SetTheme(name) / :Destroy()
	Window:Dialog({ Title, Content, RichText, Buttons = { { Text, Style, Callback } } }) -> { Close }

	[NEW] Window:SetMinimizedToButton(bool) / :ToggleMinimizedToButton()
	[NEW] Window:SetFloatingButton(bool) / :SetButtonSnap(bool)
	[NEW] Window:Center() / :ResetPosition() / :SetPosition(x, y | Vector2 | UDim2) / :GetPosition() -> Vector2 (top-left px)
	[NEW] Window:SetSize(width, height) / :GetSize() -> Vector2 / :ResetSize()
	[NEW] Window:SetSidebarOpen(bool) / :ToggleSidebar() / :SetMobileTabMode(mode)
	[NEW] Window.Compact / Window.Profile    ("Desktop", "Small", "PhonePortrait", "PhoneLandscape", "TabletPortrait", "TabletLandscape")

	════════════════════════════════════════════════════════════════════════
	CONTAINERS
	════════════════════════════════════════════════════════════════════════
	Tab:CreateSection(name | { Name, Collapsed }) -> Section     (collapsible)
	[NEW] Container:AddCard({ Title, Description }) -> Card      (holds any elements, searchable)
	Tabs, Sections and Cards share every Add method.

	════════════════════════════════════════════════════════════════════════
	ELEMENTS   (option tables also accept Tooltip, Locked, LockedReason, [NEW] Enabled)
	════════════════════════════════════════════════════════════════════════
	:AddToggle({ Name, Description, Default, Flag, Callback, Keybind, KeybindMode, KeybindFlag })
	:AddButton({ Name, Description, ButtonText, Style, Confirm, ConfirmText, [NEW] Icon, Callback })
	:AddSlider({ Name, Description, Min, Max, Default, Increment, Prefix, Suffix, Format, Input,
	             [NEW] Logarithmic, Flag, Callback })
	             Arrow keys nudge a hovered slider (Shift = x10). Hold Shift while dragging for fine control.
	:AddDropdown({ Name, Description, Options, Default, Multi, Searchable, [NEW] MaxVisible, Flag, Callback })
	             -> :Refresh(options, keepSelection) / :SetOptions() / :Add() / :Remove()
	                [NEW] :SelectAll() / :ClearAll() / :GetOptions() / :SetOpen(bool)
	             Open dropdowns support Up / Down / Enter / Escape.
	:AddPlayerDropdown({ ...dropdown options, IncludeLocal, [NEW] AutoRefresh })  -> :GetPlayer() / [NEW] :RefreshPlayers()
	:AddInput({ Name, Description, Placeholder, Default, Numeric, Live, ClearOnFocus, [NEW] MaxLength, Flag, Callback })
	:AddKeybind({ Name, Description, Default, Mode, Flag, Callback, OnChanged, ShowInList, [NEW] MobileText })
	             Right-click the key box (or press Esc / Backspace while binding) to clear.
	             On touch-only devices it becomes a SHOW / HIDE switch for a draggable on-screen action button.
	:AddColorPicker({ Name, Description, Default, Flag, Callback })
	:AddProgressBar({ Name, Description, Min, Max, Default, Format, Gradient })
	:AddImage({ Image, Height })
	:AddLabel(text | { Text, Color, Size, RichText })
	:AddParagraph({ Title, Content, RichText })
	:AddStats({ Rows = { "Status", "Target" } })    -> :Set(row, value, color)
	:AddDivider()

	[NEW] :AddCheckbox({ Name, Description, Default, Flag, Callback })
	[NEW] :AddTextArea({ Name, Description, Placeholder, Default, Height, MaxLength, ReadOnly, Live, Flag, Callback })
	      -> :Clear() / :SetReadOnly(bool) / :SetPlaceholder(text) / :SetMaxLength(n)
	[NEW] :AddSearch({ Name, Placeholder, Callback, FilterScope = "Section" | "Tab" }) -> :Clear()
	[NEW] :AddImageButton({ Name, Description, Image, Callback }) -> :SetIcon(id) / :SetText(text)
	[NEW] :AddStatus({ Name, Description, Status, Color }) -> :SetStatus(text, color?) / :SetColor(color)
	[NEW] :AddTable({ Name, Columns = { "Name", { Name = "Value", Width = 80 } }, Rows, Height })
	      -> :SetRows(rows) / :AddRow(row) / :UpdateRow(i, row) / :RemoveRow(i) / :Clear() / :GetRows()
	         :SetColumns(columns) / :Refresh()      rows are arrays or { ColumnName = value } tables

	Every element: :Set() / :Get() / :OnChanged(fn) / :SetVisible(bool) / :SetLocked(bool, reason)
	               :SetTitle(text) / :SetDescription(text) / :SetTooltip(text) / :Destroy()
	[NEW] Interactive elements also: :SetEnabled(bool) / :SetCallback(fn)

	════════════════════════════════════════════════════════════════════════
	LIBRARY
	════════════════════════════════════════════════════════════════════════
	Library:Notify({ Title, Content, Duration, Style }) -> { Close }   Styles: Info, Success, Warning, Error, Theme
	  [NEW] options: Sound, Icon, Persistent, Buttons = { { Text, Style, Callback, Close } },
	                 Progress (0-1, shows a progress bar you update), Timer (false hides the countdown), Gradient
	  [NEW] handle:  :SetTitle(t) / :SetContent(t) / :SetProgress(0-1) / .Closed / .Queued
	[NEW] Library:SetNotificationPosition("TopLeft" | "Top" | "TopRight" | "BottomLeft" | "Bottom" | "BottomRight")
	[NEW] Library:SetNotificationLimit(n)       -- extra notifications wait in a queue

	Library:SetTheme(name) / :AddTheme(name, def) / :GetThemes()
	  def = { Gradient, Accent, TopHighlight, Damier, DivDark, Rotation,
	          [NEW] Background, Card, CardHighlight, Recessed, RecessedBorder, Text, Muted, Border, Notification }
	  [NEW] Only Gradient OR Accent is required, everything else is derived. Gradient accepts a ColorSequence,
	        a Color3 or a table of Color3s.
	[NEW] Library:GetTheme(name?) -> copy of a theme definition

	Library:SetWatermark(visible, text) / :SetKeybindList(visible) / :SetSounds(bool)
	[NEW] Library:SetNotificationSounds(bool) / :SetReducedAnimations(bool) / :SetUIScale(0.75 - 1.5)
	[NEW] Library:SetHighContrast(bool) / :SetTooltips(bool) / :SetSunburst(enabled, animated)
	[NEW] Library:GetDevice() -> profile, isMobile        Library.IsMobile
	[NEW] Library:GetStats() -> { Connections, FrameTasks, ThemedObjects, Windows, Notifications, Queued }

	Library:SaveConfig(name) / :LoadConfig(name) / :DeleteConfig(name) / :ListConfigs()
	Library:SetAutoload(name) / :GetAutoload() / :LoadAutoload()
	Library.Flags[flag] / Library.Options[flag] / Library.ConfigIgnore[flag] = true
	Library:Track(connection) / :OnUnload(callback) / :Destroy()

	════════════════════════════════════════════════════════════════════════
	EXAMPLES
	════════════════════════════════════════════════════════════════════════
	local Window = Library:CreateWindow({
		Title = "My Hub", Theme = "Ocean",
		Resizable = true, MinimizeToButton = true, MinimizeButtonSnap = true,
		RememberPosition = true, RememberSize = true,
		MobileTabMode = "BottomBar",
	})

	local Main = Window:CreateTab({ Name = "Main" })
	local Info = Main:AddCard({ Title = "Server", Description = "Live info" })
	local Online = Info:AddStatus({ Name = "Connection", Status = "Online" })
	Online:SetStatus("Offline")

	Main:AddCheckbox({ Name = "Auto Sell", Flag = "AutoSell" })
	Main:AddSlider({ Name = "Zoom", Min = 1, Max = 1000, Logarithmic = true, Default = 10 })
	Main:AddDropdown({ Name = "Pets", Options = { "Cat", "Dog", "Dragon" }, Multi = true })

	local Log = Main:AddTable({ Name = "Drops", Columns = { "Item", "Rarity", { Name = "Value", Width = 80 } } })
	Log:AddRow({ "Sword", "Epic", 1500 })

	Library:Notify({
		Title = "Update", Content = "Restart to apply?", Persistent = true,
		Buttons = { { Text = "Restart", Style = "Claim", Callback = restart }, { Text = "Later", Style = "Claimed" } },
	})

	Library:AddTheme("Lemon", { Accent = Color3.fromRGB(255, 230, 0) })
	Library:SetTheme("Lemon")
	Window:CreateSettingsTab()
]]

--// Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StatsService = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer

--// Re-execution: destroy the previous instance first
local env = (getgenv and getgenv()) or _G
do
	local previous = env.__RetroSlop
	if type(previous) == "table" and type(previous.Destroy) == "function" then
		local ok, err = pcall(previous.Destroy, previous)
		if not ok then
			warn("[RetroSlop] Couldn't clean up the previous instance: " .. tostring(err))
		end
	end
end

local Library = {
	Name = "Project RetroSlop",
	Version = "0.0.3",
	Flags = {},
	Options = {},
	Folder = "RetroSlop",
	ConfigIgnore = {},
	SoundsEnabled = true,
	NotificationSounds = true,
	TooltipsEnabled = true,
	ReducedAnimations = false,
	HighContrast = false,
	UIScale = 1,
	NotificationPosition = "BottomRight",
	NotificationLimit = 5,
	SunburstEnabled = true,
	SunburstAnimated = true,
	IsMobile = false,
	Unloaded = false,
	Gui = nil,
	Theme = nil,
	ThemeName = nil,
	Windows = {},
	_connections = {},
	_unloadCallbacks = {},
	_scaleTargets = {},
	_themed = {},
	_themeHooks = {},
	_themeListListeners = {},
	_binds = {},
	_activeBinder = nil,
	_lastBindInput = nil,
	_notifyPositionSet = false,
}
env.__RetroSlop = Library

local function report(message)
	warn("[RetroSlop] " .. tostring(message))
end

--// Device
Library.IsMobile = UserInputService.TouchEnabled == true and UserInputService.KeyboardEnabled ~= true

--// Design constants
local rgb = Color3.fromRGB
local nkp = NumberSequenceKeypoint.new
local ckp = ColorSequenceKeypoint.new

local HEADER_HEIGHT = 60
local SIDEBAR_WIDTH = 156
local SUNBURST_SPEED = 20
local TOUCH_SLOP = 10
local TAB_MODES = { Sidebar = true, BottomBar = true, Dropdown = true }

local Palette = {
	Ink        = rgb(12, 20, 26),
	TextStroke = rgb(17, 23, 26),
	Black      = rgb(0, 0, 0),
	White      = rgb(255, 255, 255),
	Lime       = rgb(180, 255, 25),
	Red        = rgb(255, 70, 95),
	Amber      = rgb(255, 196, 40),
	Silver     = rgb(216, 222, 228),
	LockTint   = rgb(10, 16, 20),
	LockDamier = rgb(144, 0, 24),
	GoldFill   = ColorSequence.new(rgb(255, 200, 0), rgb(255, 106, 0)),
	GoldBevel  = rgb(153, 60, 0),
}

-- Theme-overridable surface colors (the v0.0.2 look)
local BasePalette = {
	Background     = rgb(59, 88, 102),
	Border         = rgb(24, 30, 34),
	Card           = rgb(26, 44, 52),
	CardHighlight  = rgb(75, 125, 145),
	Recessed       = rgb(20, 34, 42),
	RecessedBorder = rgb(85, 140, 160),
	Text           = rgb(255, 255, 255),
	Muted          = rgb(175, 205, 218),
	Placeholder    = rgb(110, 140, 155),
}

local THEME_PALETTE_KEYS = { "Background", "Card", "CardHighlight", "Recessed", "RecessedBorder", "Text", "Muted", "Border" }

local function lighten(color, amount)
	return color:Lerp(Palette.White, amount)
end

local function darken(color, amount)
	return color:Lerp(Palette.Black, amount)
end

local function toGradient(value)
	local kind = typeof(value)
	if kind == "ColorSequence" then
		return value
	elseif kind == "Color3" then
		return ColorSequence.new(lighten(value, 0.12), darken(value, 0.18))
	elseif kind == "table" then
		local colors = {}
		for _, color in value do
			if typeof(color) == "Color3" then
				table.insert(colors, color)
			end
		end
		if #colors == 0 then
			return nil
		elseif #colors == 1 then
			return ColorSequence.new(colors[1])
		elseif #colors == 2 then
			return ColorSequence.new(colors[1], colors[2])
		end
		local points = {}
		for index, color in colors do
			table.insert(points, ckp((index - 1) / (#colors - 1), color))
		end
		return ColorSequence.new(points)
	end
	return nil
end

local function gradientStart(sequence)
	return sequence.Keypoints[1].Value
end

local function gradientEnd(sequence)
	return sequence.Keypoints[#sequence.Keypoints].Value
end

local function buildTheme(def)
	if type(def) ~= "table" then
		return nil, "theme definition must be a table"
	end
	local gradient = toGradient(def.Gradient) or toGradient(def.Accent)
	if not gradient then
		return nil, "theme needs a Gradient or an Accent color"
	end
	local accent = typeof(def.Accent) == "Color3" and def.Accent or gradientStart(gradient)

	local theme = {
		Gradient = gradient,
		Accent = accent,
		TopHighlight = typeof(def.TopHighlight) == "Color3" and def.TopHighlight or lighten(accent, 0.6),
		Damier = typeof(def.Damier) == "Color3" and def.Damier or darken(accent, 0.45),
		DivDark = typeof(def.DivDark) == "Color3" and def.DivDark or darken(accent, 0.55),
		Rotation = tonumber(def.Rotation) or 90,
		Notification = toGradient(def.Notification),
	}
	for _, key in THEME_PALETTE_KEYS do
		if typeof(def[key]) == "Color3" then
			theme[key] = def[key]
		end
	end
	return theme
end

local function builtin(def)
	return (assert(buildTheme(def)))
end

local Themes = {
	Rebirth = builtin({ Gradient = { rgb(160, 0, 255), rgb(96, 0, 200) }, Accent = rgb(160, 0, 255), TopHighlight = rgb(224, 160, 255), Damier = rgb(96, 0, 144), DivDark = rgb(80, 0, 120) }),
	Shop = builtin({ Gradient = { rgb(255, 20, 150), rgb(225, 0, 25) }, Accent = rgb(255, 20, 150), TopHighlight = rgb(255, 200, 225), Damier = rgb(150, 0, 20), DivDark = rgb(125, 0, 18) }),
	Codes = builtin({ Gradient = { rgb(0, 205, 255), rgb(0, 130, 245) }, Accent = rgb(0, 205, 255), TopHighlight = rgb(180, 240, 255), Damier = rgb(0, 75, 150), DivDark = rgb(0, 50, 110) }),
	Settings = builtin({ Gradient = { rgb(255, 255, 255), rgb(215, 222, 232) }, Accent = rgb(215, 222, 232), TopHighlight = rgb(255, 255, 255), Damier = rgb(110, 120, 135), DivDark = rgb(90, 100, 112) }),
	Daily = builtin({ Gradient = { rgb(152, 255, 0), rgb(80, 208, 0) }, Accent = rgb(152, 255, 0), TopHighlight = rgb(224, 255, 176), Damier = rgb(53, 128, 0), DivDark = rgb(37, 96, 0) }),
	Amber = builtin({ Gradient = { rgb(255, 208, 0), rgb(255, 140, 0) }, Accent = rgb(255, 170, 0), TopHighlight = rgb(255, 240, 160), Damier = rgb(176, 96, 0), DivDark = rgb(153, 76, 0) }),
	Bubblegum = builtin({ Gradient = { rgb(255, 20, 128), rgb(212, 0, 85) }, Accent = rgb(255, 20, 128), TopHighlight = rgb(255, 176, 208), Damier = rgb(160, 0, 64), DivDark = rgb(120, 10, 45) }),
	Rainbow = builtin({
		Gradient = { rgb(255, 30, 80), rgb(255, 140, 0), rgb(255, 230, 0), rgb(40, 230, 50), rgb(0, 210, 255), rgb(90, 60, 255), rgb(220, 0, 230) },
		Accent = rgb(255, 30, 80), TopHighlight = rgb(255, 235, 250), Damier = rgb(90, 0, 120), DivDark = rgb(60, 0, 90), Rotation = 0,
	}),
	Ocean = builtin({ Gradient = { rgb(0, 225, 205), rgb(0, 120, 210) }, Accent = rgb(0, 200, 210), TopHighlight = rgb(190, 255, 250), Damier = rgb(0, 80, 110), DivDark = rgb(0, 60, 90) }),
	Lava = builtin({ Gradient = { rgb(255, 130, 0), rgb(220, 20, 0) }, Accent = rgb(255, 90, 0), TopHighlight = rgb(255, 210, 160), Damier = rgb(140, 20, 0), DivDark = rgb(110, 15, 0) }),
	Mint = builtin({ Gradient = { rgb(120, 255, 200), rgb(30, 200, 140) }, Accent = rgb(60, 230, 170), TopHighlight = rgb(220, 255, 240), Damier = rgb(10, 110, 80), DivDark = rgb(5, 80, 60) }),
	Gold = builtin({ Gradient = { rgb(255, 232, 90), rgb(225, 160, 0) }, Accent = rgb(255, 200, 30), TopHighlight = rgb(255, 250, 200), Damier = rgb(150, 95, 0), DivDark = rgb(120, 75, 0) }),
	Toxic = builtin({ Gradient = { rgb(210, 255, 0), rgb(0, 190, 90) }, Accent = rgb(120, 230, 40), TopHighlight = rgb(240, 255, 190), Damier = rgb(40, 120, 0), DivDark = rgb(25, 90, 0) }),
	Arctic = builtin({ Gradient = { rgb(235, 250, 255), rgb(140, 200, 255) }, Accent = rgb(150, 210, 255), TopHighlight = rgb(255, 255, 255), Damier = rgb(60, 110, 170), DivDark = rgb(40, 80, 130) }),
	Midnight = builtin({
		Gradient = { rgb(100, 100, 255), rgb(40, 30, 170) }, Accent = rgb(110, 110, 255), TopHighlight = rgb(190, 190, 255), Damier = rgb(30, 20, 110), DivDark = rgb(20, 15, 80),
		Background = rgb(36, 40, 70), Card = rgb(20, 22, 42), CardHighlight = rgb(70, 76, 140), Recessed = rgb(16, 17, 34),
		RecessedBorder = rgb(90, 96, 170), Muted = rgb(180, 184, 230), Border = rgb(10, 10, 24),
	}),
	Monochrome = builtin({
		Gradient = { rgb(235, 235, 235), rgb(150, 150, 150) }, Accent = rgb(220, 220, 220), TopHighlight = rgb(255, 255, 255), Damier = rgb(90, 90, 90), DivDark = rgb(70, 70, 70),
		Background = rgb(70, 70, 74), Card = rgb(36, 36, 40), CardHighlight = rgb(110, 110, 118), Recessed = rgb(28, 28, 32),
		RecessedBorder = rgb(130, 130, 140), Muted = rgb(200, 200, 206),
	}),
}
Themes.Custom = table.clone(Themes.Rebirth)

local ThemeOrder = {
	"Rebirth", "Shop", "Codes", "Settings", "Daily", "Amber", "Bubblegum", "Rainbow",
	"Ocean", "Lava", "Mint", "Gold", "Toxic", "Arctic", "Midnight", "Monochrome", "Custom",
}

local function resolveTheme(raw)
	local theme = {}
	for key, value in BasePalette do
		theme[key] = value
	end
	for key, value in raw do
		theme[key] = value
	end
	theme.Notification = raw.Notification or raw.Gradient

	if Library.HighContrast then
		theme.Muted = theme.Text
		theme.Placeholder = lighten(theme.Placeholder, 0.35)
		theme.RecessedBorder = lighten(theme.RecessedBorder, 0.45)
		theme.CardHighlight = lighten(theme.CardHighlight, 0.4)
		theme.Border = Palette.Black
		theme.Card = darken(theme.Card, 0.25)
		theme.Recessed = darken(theme.Recessed, 0.3)
	end

	theme.CardHover = lighten(theme.Card, 0.06)
	theme.RecessedHover = lighten(theme.Recessed, 0.06)
	theme.Trough = darken(theme.Recessed, 0.12)
	theme.TroughBorder = darken(theme.Recessed, 0.45)
	theme.TabIdle = ColorSequence.new(theme.Background, darken(theme.Background, 0.3))
	return theme
end

Library.ThemeName = "Rebirth"
Library.Theme = resolveTheme(Themes.Rebirth)

local ButtonStyles = {
	Claim   = ColorSequence.new(rgb(180, 255, 25), rgb(105, 225, 0)),
	Claimed = ColorSequence.new(rgb(216, 222, 228), rgb(148, 160, 176)),
	Locked  = ColorSequence.new(rgb(255, 32, 80), rgb(208, 0, 32)),
	Skip    = ColorSequence.new(rgb(255, 208, 0), rgb(255, 140, 0)),
	Music   = ColorSequence.new(rgb(255, 20, 128), rgb(212, 0, 85)),
	Codes   = ColorSequence.new(rgb(0, 205, 255), rgb(0, 130, 245)),
	Rebirth = ColorSequence.new(rgb(160, 0, 255), rgb(96, 0, 200)),
}

local NotifyStyles = {
	Info    = ButtonStyles.Codes,
	Success = ButtonStyles.Claim,
	Warning = ButtonStyles.Skip,
	Error   = ButtonStyles.Locked,
}

local Assets = {
	Damier   = "rbxassetid://385956923",
	Sunburst = "rbxassetid://130563114903838",
	Sfx      = "rbxassetid://6895079853",
}

local KEY_ALIASES = {
	LeftShift = "LSHIFT", RightShift = "RSHIFT",
	LeftControl = "LCTRL", RightControl = "RCTRL",
	LeftAlt = "LALT", RightAlt = "RALT",
	LeftSuper = "LWIN", RightSuper = "RWIN",
	Return = "ENTER", Backspace = "BKSP", Space = "SPACE",
	CapsLock = "CAPS", PageUp = "PGUP", PageDown = "PGDN",
	Insert = "INS", Delete = "DEL",
	MouseButton2 = "MB2", MouseButton3 = "MB3",
	One = "1", Two = "2", Three = "3", Four = "4", Five = "5",
	Six = "6", Seven = "7", Eight = "8", Nine = "9", Zero = "0",
	KeypadOne = "NUM1", KeypadTwo = "NUM2", KeypadThree = "NUM3", KeypadFour = "NUM4", KeypadFive = "NUM5",
	KeypadSix = "NUM6", KeypadSeven = "NUM7", KeypadEight = "NUM8", KeypadNine = "NUM9", KeypadZero = "NUM0",
}

--// Utilities
local function track(connection)
	table.insert(Library._connections, connection)
	return connection
end

local function create(className, props)
	local instance = Instance.new(className)
	if props then
		for key, value in props do
			if key ~= "Parent" then
				instance[key] = value
			end
		end
		if props.Parent then
			instance.Parent = props.Parent
		end
	end
	return instance
end

local function addCorner(parent, radius)
	return create("UICorner", { CornerRadius = UDim.new(0, radius), Parent = parent })
end

local function addStroke(parent, color, thickness, transparency, mode)
	return create("UIStroke", {
		Color = color,
		Thickness = thickness,
		Transparency = transparency or 0,
		ApplyStrokeMode = mode or Enum.ApplyStrokeMode.Border,
		Parent = parent,
	})
end

local function addPadding(parent, top, bottom, left, right)
	return create("UIPadding", {
		PaddingTop = UDim.new(0, top),
		PaddingBottom = UDim.new(0, bottom),
		PaddingLeft = UDim.new(0, left),
		PaddingRight = UDim.new(0, right),
		Parent = parent,
	})
end

local function addList(parent, padding, direction)
	return create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, padding or 0),
		FillDirection = direction or Enum.FillDirection.Vertical,
		Parent = parent,
	})
end

local function upper(value)
	return string.upper(tostring(value))
end

local function lower(value)
	return string.lower(tostring(value))
end

local function trim(value)
	return (string.gsub(tostring(value), "^%s*(.-)%s*$", "%1"))
end

local function clampNumber(value, default, min, max)
	value = tonumber(value) or default
	return math.clamp(value, min, max)
end

local function textLength(text)
	return utf8.len(text) or #text
end

local function truncateText(text, maxLength)
	if not maxLength or textLength(text) <= maxLength then
		return text
	end
	local cut = utf8.offset(text, maxLength + 1)
	return cut and string.sub(text, 1, cut - 1) or string.sub(text, 1, maxLength)
end

--// Tweens (respect Reduced Animations, reuse TweenInfo objects)
local tweenInfoCache = {}

local function getTweenInfo(duration, style, direction)
	local key = tostring(duration) .. "|" .. style.Name .. "|" .. direction.Name
	local info = tweenInfoCache[key]
	if not info then
		info = TweenInfo.new(duration, style, direction)
		tweenInfoCache[key] = info
	end
	return info
end

local function instantTween()
	local function deferCall(_, callback)
		task.defer(callback, Enum.PlaybackState.Completed)
		return { Disconnect = function() end, Connected = false }
	end
	return {
		Completed = {
			Once = deferCall,
			Connect = deferCall,
			Wait = function()
				return Enum.PlaybackState.Completed
			end,
		},
		Play = function() end,
		Cancel = function() end,
		Pause = function() end,
	}
end

local function tween(object, duration, goal, style, direction, essential)
	if Library.ReducedAnimations and not essential then
		duration = 0
	end
	if duration <= 0 then
		for key, value in goal do
			object[key] = value
		end
		return instantTween()
	end
	local t = TweenService:Create(
		object,
		getTweenInfo(duration, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out),
		goal
	)
	t:Play()
	return t
end

--// Callbacks (errors are reported with a traceback, never swallowed)
local function safeCallback(callback, ...)
	if callback == nil then
		return
	end
	if type(callback) ~= "function" then
		report("Callback must be a function, got " .. typeof(callback))
		return
	end
	local args = table.pack(...)
	task.spawn(function()
		local ok, err = xpcall(function()
			return callback(table.unpack(args, 1, args.n))
		end, debug.traceback)
		if not ok then
			report("Callback error: " .. tostring(err))
		end
	end)
end

local function fire(element, callback, ...)
	safeCallback(callback, ...)
	for _, listener in element._listeners do
		safeCallback(listener, ...)
	end
end

--// Frame scheduler: one Heartbeat connection shared by every animated feature
local stepTasks = {}
local stepCount = 0
local stepConnection = nil

local function unbindStep(key)
	if stepTasks[key] ~= nil then
		stepTasks[key] = nil
		stepCount -= 1
	end
	if stepCount <= 0 then
		stepCount = 0
		if stepConnection then
			stepConnection:Disconnect()
			stepConnection = nil
		end
	end
end

local function bindStep(key, callback)
	if Library.Unloaded then
		return
	end
	if stepTasks[key] == nil then
		stepCount += 1
	end
	stepTasks[key] = callback
	if not stepConnection then
		stepConnection = RunService.Heartbeat:Connect(function(dt)
			for taskKey, taskFn in stepTasks do
				local ok, err = pcall(taskFn, dt)
				if not ok then
					report("Frame task '" .. tostring(taskKey) .. "' failed and was stopped: " .. tostring(err))
					unbindStep(taskKey)
				end
			end
		end)
	end
end

--// Input dispatcher: three UserInputService connections shared by the whole library
local inputHandlers = { Began = {}, Changed = {}, Ended = {} }

local function onInput(kind, callback)
	local record = { Fn = callback }
	table.insert(inputHandlers[kind], record)
	return function()
		local list = inputHandlers[kind]
		local index = table.find(list, record)
		if index then
			table.remove(list, index)
		end
	end
end

local function dispatchInput(kind, input, gameProcessed)
	local list = inputHandlers[kind]
	if #list == 0 then
		return
	end
	for _, record in table.clone(list) do
		local ok, err = pcall(record.Fn, input, gameProcessed)
		if not ok then
			report("Input handler error: " .. tostring(err))
		end
	end
end

track(UserInputService.InputBegan:Connect(function(input, gameProcessed)
	dispatchInput("Began", input, gameProcessed)
end))
track(UserInputService.InputChanged:Connect(function(input, gameProcessed)
	dispatchInput("Changed", input, gameProcessed)
end))
track(UserInputService.InputEnded:Connect(function(input, gameProcessed)
	dispatchInput("Ended", input, gameProcessed)
end))

local function isPress(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end

-- Tap vs drag: a touch that moves more than TOUCH_SLOP will not count as a button press
local touchState = { Start = nil, Moved = false }

onInput("Began", function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		touchState.Start = input.Position
		touchState.Moved = false
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
		touchState.Moved = false
	end
end)

onInput("Changed", function(input)
	if input.UserInputType == Enum.UserInputType.Touch and touchState.Start and not touchState.Moved then
		local delta = input.Position - touchState.Start
		if math.abs(delta.X) + math.abs(delta.Y) > TOUCH_SLOP then
			touchState.Moved = true
		end
	end
end)

-- Single active drag at a time (sliders, color pickers, window, resize grip, floating buttons)
local activeDrag = nil

local function endDrag()
	local drag = activeDrag
	activeDrag = nil
	if drag and drag.OnEnd then
		local ok, err = pcall(drag.OnEnd)
		if not ok then
			report("Drag end error: " .. tostring(err))
		end
	end
end

local function beginDrag(input, handlers)
	if activeDrag then
		endDrag()
	end
	handlers.Input = input
	activeDrag = handlers
end

onInput("Changed", function(input)
	if not activeDrag then
		return
	end
	local dragInput = activeDrag.Input
	local matches = input.UserInputType == Enum.UserInputType.MouseMovement
		and dragInput.UserInputType == Enum.UserInputType.MouseButton1
		or (input.UserInputType == Enum.UserInputType.Touch and input == dragInput)
	if matches then
		activeDrag.OnMove(input.Position, input)
	end
end)

onInput("Ended", function(input)
	if not activeDrag then
		return
	end
	local dragInput = activeDrag.Input
	if input == dragInput
		or (dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseButton1)
	then
		endDrag()
	end
end)

local function bindDrag(hitbox, onMove, onStart, onEnd, canStart)
	return hitbox.InputBegan:Connect(function(input)
		if not isPress(input) or (canStart and not canStart()) then
			return
		end
		if onStart then
			onStart(input)
		end
		beginDrag(input, { OnMove = onMove, OnEnd = onEnd })
		onMove(input.Position, input)
	end)
end

-- Click that ignores taps which turned into drags / scrolls
local function onClick(button, callback)
	local function handler()
		if touchState.Moved then
			return
		end
		callback()
	end
	button.MouseButton1Click:Connect(handler)
	local hitbox = button:FindFirstChild("TouchHitbox")
	if hitbox then
		hitbox.MouseButton1Click:Connect(handler)
	end
end

local function bindMatches(input, key)
	return key ~= nil and (input.KeyCode == key or input.UserInputType == key)
end

local function shortKeyName(key)
	if not key then
		return "NONE"
	end
	return KEY_ALIASES[key.Name] or upper(key.Name)
end

--// Screen & device profile
local function getScreenSize()
	local gui = Library.Gui
	if gui then
		local size = gui.AbsoluteSize
		if size and size.X > 0 and size.Y > 0 then
			return size
		end
	end
	local camera = workspace.CurrentCamera
	if camera and camera.ViewportSize.X > 0 then
		return camera.ViewportSize
	end
	return Vector2.new(1280, 720)
end

local function getDeviceScale()
	local screen = getScreenSize()
	return math.clamp(math.min(screen.X / 1050, screen.Y / 620), 0.52, 1.18) * Library.UIScale
end

local function getProfile(screen)
	local width, height = screen.X, screen.Y
	local portrait = height > width
	local short = math.min(width, height)

	if Library.IsMobile then
		if short < 600 then
			return portrait and "PhonePortrait" or "PhoneLandscape", true
		end
		return portrait and "TabletPortrait" or "TabletLandscape", portrait or width < 1000
	end
	if width < 760 or height < 480 then
		return "Small", true
	end
	return "Desktop", false
end

--// Theme registry
local function themed(instance, property, key)
	table.insert(Library._themed, { Instance = instance, Property = property, Key = key })
	instance[property] = Library.Theme[key]
	return instance
end

local function themeGradient(gradient)
	themed(gradient, "Color", "Gradient")
	themed(gradient, "Rotation", "Rotation")
	return gradient
end

local function addThemeHook(callback)
	table.insert(Library._themeHooks, callback)
	return function()
		local index = table.find(Library._themeHooks, callback)
		if index then
			table.remove(Library._themeHooks, index)
		end
	end
end

--[[
	newText Color:
		nil         -> themed "Text"
		"Muted" etc -> themed palette key
		Color3      -> fixed color
	Dynamic = true  -> not registered (element manages the color itself)
]]
local function newText(parent, props)
	local color = props.Color
	local label = create("TextLabel", {
		Name = props.Name or "Text",
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBlack,
		Text = props.Text or "",
		TextSize = props.Size or 16,
		TextColor3 = typeof(color) == "Color3" and color or Library.Theme[color or "Text"],
		TextXAlignment = props.AlignX or Enum.TextXAlignment.Left,
		TextYAlignment = props.AlignY or Enum.TextYAlignment.Center,
		TextTruncate = props.Truncate and Enum.TextTruncate.AtEnd or Enum.TextTruncate.None,
		TextWrapped = props.Wrapped or false,
		RichText = props.RichText or false,
		AutomaticSize = props.AutoSize or (props.AutoY and Enum.AutomaticSize.Y) or Enum.AutomaticSize.None,
		Size = props.Bounds or UDim2.fromScale(1, 1),
		Position = props.Position or UDim2.new(),
		AnchorPoint = props.Anchor or Vector2.zero,
		ZIndex = props.ZIndex or 1,
		LayoutOrder = props.LayoutOrder or 0,
		Parent = parent,
	})
	if typeof(color) ~= "Color3" and not props.Dynamic then
		themed(label, "TextColor3", color or "Text")
	end
	addStroke(label, props.StrokeColor or Palette.Black, props.Stroke or 2, 0, Enum.ApplyStrokeMode.Contextual)
	return label
end

local function newTextBox(parent, props)
	local box = create("TextBox", {
		Name = props.Name or "TextBox",
		BackgroundTransparency = 1,
		Position = props.Position or UDim2.fromOffset(10, 0),
		Size = props.Bounds or UDim2.new(1, -20, 1, 0),
		Font = Enum.Font.GothamBlack,
		TextSize = props.Size or 13,
		PlaceholderText = props.Placeholder and upper(props.Placeholder) or "",
		Text = props.Text or "",
		ClearTextOnFocus = props.ClearOnFocus == true,
		TextXAlignment = props.AlignX or Enum.TextXAlignment.Left,
		TextYAlignment = props.AlignY or Enum.TextYAlignment.Center,
		MultiLine = props.MultiLine == true,
		TextWrapped = props.MultiLine == true,
		ClipsDescendants = true,
		ZIndex = props.ZIndex or 1,
		Parent = parent,
	})
	themed(box, "TextColor3", "Text")
	themed(box, "PlaceholderColor3", "Placeholder")
	addStroke(box, Palette.Black, 2, 0, Enum.ApplyStrokeMode.Contextual)
	return box
end

--// ScreenGui & sounds
local Sounds = {}
local GUI_MARKER = "RetroSlopGui"

local function playSound(name)
	if not Library.SoundsEnabled then
		return
	end
	local sound = Sounds[name]
	if sound then
		pcall(function()
			SoundService:PlayLocalSound(sound)
		end)
	end
end

local function refreshScales()
	for _, apply in table.clone(Library._scaleTargets) do
		local ok, err = pcall(apply)
		if not ok then
			report("Layout refresh error: " .. tostring(err))
		end
	end
end

-- Removes interfaces left behind by an older run that lost its env reference
local function destroyStrayGuis(parent)
	if not parent then
		return
	end
	pcall(function()
		for _, child in parent:GetChildren() do
			if child:IsA("ScreenGui") and child:GetAttribute(GUI_MARKER) then
				child:Destroy()
			end
		end
	end)
end

local function getGui()
	if Library.Gui then
		return Library.Gui
	end

	local hiddenUi = gethui and select(2, pcall(gethui)) or nil
	local coreGui = select(2, pcall(function()
		return game:GetService("CoreGui")
	end))
	local playerGui = LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")

	for _, parent in { hiddenUi, coreGui, playerGui } do
		if typeof(parent) == "Instance" then
			destroyStrayGuis(parent)
		end
	end

	local gui = create("ScreenGui", {
		Name = "RetroSlop_" .. string.sub(HttpService:GenerateGUID(false), 1, 8),
		ResetOnSpawn = false,
		IgnoreGuiInset = false,
		DisplayOrder = 100,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	gui:SetAttribute(GUI_MARKER, true)

	if syn and syn.protect_gui then
		pcall(syn.protect_gui, gui)
	end

	local parented = false
	if typeof(hiddenUi) == "Instance" then
		parented = pcall(function()
			gui.Parent = hiddenUi
		end) and gui.Parent ~= nil
	end
	if not parented and typeof(coreGui) == "Instance" then
		parented = pcall(function()
			gui.Parent = coreGui
		end) and gui.Parent ~= nil
	end
	if not parented then
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	Sounds.Hover = create("Sound", { SoundId = Assets.Sfx, Volume = 0.25, Parent = gui })
	Sounds.Click = create("Sound", { SoundId = Assets.Sfx, Volume = 0.5, PlaybackSpeed = 1.15, Parent = gui })

	Library.Gui = gui
	track(gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(refreshScales))

	return gui
end

--// Tooltips
local tooltipFrame, tooltipLabel, tooltipOwner

local function hideTooltip()
	if tooltipFrame then
		tooltipFrame.Visible = false
	end
	tooltipOwner = nil
end

local function getTooltip()
	if tooltipFrame and tooltipFrame.Parent then
		return tooltipFrame
	end

	tooltipFrame = create("Frame", {
		Name = "Tooltip",
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.fromOffset(0, 0),
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 500,
		Parent = getGui(),
	})
	themed(tooltipFrame, "BackgroundColor3", "Recessed")
	addCorner(tooltipFrame, 4)
	themed(addStroke(tooltipFrame, Palette.Black, 2.5), "Color", "Border")
	addPadding(tooltipFrame, 6, 6, 10, 10)
	create("UISizeConstraint", { MaxSize = Vector2.new(280, math.huge), Parent = tooltipFrame })

	tooltipLabel = newText(tooltipFrame, {
		Text = "",
		Size = 12,
		Wrapped = true,
		Bounds = UDim2.fromOffset(0, 0),
		AutoSize = Enum.AutomaticSize.XY,
		ZIndex = 501,
	})

	return tooltipFrame
end

onInput("Changed", function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseMovement or not tooltipFrame or not tooltipFrame.Visible then
		return
	end
	local screen = getScreenSize()
	local size = tooltipFrame.AbsoluteSize
	local x = math.min(input.Position.X + 16, screen.X - size.X - 6)
	local y = math.min(input.Position.Y + 14, screen.Y - size.Y - 6)
	tooltipFrame.Position = UDim2.fromOffset(math.max(6, x), math.max(6, y))
end)

local function attachTooltip(instance, getText)
	if Library.IsMobile then
		return
	end
	instance.MouseEnter:Connect(function()
		if not Library.TooltipsEnabled then
			return
		end
		local text = getText()
		if not text or text == "" then
			return
		end
		local frame = getTooltip()
		tooltipLabel.Text = upper(text)
		tooltipOwner = instance
		frame.Visible = true
	end)
	instance.MouseLeave:Connect(function()
		if tooltipOwner == instance then
			hideTooltip()
		end
	end)
end

--// Micro-interactions
local function bindButtonAnimations(button, scale, hoverFactor, clickFactor)
	hoverFactor = hoverFactor or 1.05
	clickFactor = clickFactor or 0.94

	button.MouseEnter:Connect(function()
		if Library.IsMobile then
			return
		end
		playSound("Hover")
		tween(scale, 0.08, { Scale = hoverFactor })
	end)
	button.MouseLeave:Connect(function()
		tween(scale, 0.08, { Scale = 1 })
	end)
	button.MouseButton1Down:Connect(function()
		playSound("Click")
		tween(scale, 0.05, { Scale = clickFactor })
	end)
	button.MouseButton1Up:Connect(function()
		tween(scale, 0.12, { Scale = Library.IsMobile and 1 or hoverFactor }, Enum.EasingStyle.Back)
	end)
end

--// Canonical iconless button (optional Icon)
local function createStandardButton(props)
	local z = props.ZIndex or 5

	local button = create("ImageButton", {
		Name = props.Name or "StandardButton",
		Size = props.Size or UDim2.fromOffset(176, 55),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = props.Position or UDim2.fromScale(0.5, 0.5),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		ClipsDescendants = true,
		ZIndex = z,
		LayoutOrder = props.LayoutOrder or 0,
		Parent = props.Parent,
	})
	addStroke(button, Palette.Ink, 3)

	create("UIGradient", {
		Name = "ButtonGradient",
		Color = props.Gradient or ButtonStyles.Skip,
		Rotation = 90,
		Parent = button,
	})

	local checkerboard = create("ImageLabel", {
		Name = "Checkerboard",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = Assets.Damier,
		ImageColor3 = Palette.Black,
		ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(19, 19),
		ZIndex = z + 1,
		Parent = button,
	})
	create("UIGradient", {
		Rotation = 90,
		Transparency = NumberSequence.new({ nkp(0, 0.91), nkp(1, 0.62) }),
		Parent = checkerboard,
	})

	for index, transparency in { 0.25, 0.45, 0.8 } do
		local highlight = create("Frame", {
			Name = "InnerHighlight" .. index,
			Size = UDim2.new(1, -index * 2, 1, -index * 2),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
			ZIndex = z + 2,
			Parent = button,
		})
		addStroke(highlight, Palette.White, 1, transparency)
	end

	local label = newText(button, {
		Name = "Label",
		Text = props.Text or "",
		Size = props.TextSize or 36,
		Stroke = props.Stroke or 3,
		StrokeColor = Palette.TextStroke,
		Color = props.TextColor or Palette.White,
		AlignX = Enum.TextXAlignment.Center,
		Anchor = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, -1),
		Truncate = true,
		ZIndex = z + 3,
	})

	if props.Icon then
		create("ImageLabel", {
			Name = "Icon",
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 10, 0.5, 0),
			Size = UDim2.fromOffset(props.IconSize or 22, props.IconSize or 22),
			BackgroundTransparency = 1,
			Image = props.Icon,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = z + 4,
			Parent = button,
		})
		label.Size = UDim2.new(1, -44, 1, 0)
		label.Position = UDim2.new(0.5, 16, 0.5, -1)
	end

	local scale = create("UIScale", { Name = "ButtonScale", Parent = button })
	bindButtonAnimations(button, scale, props.Hover, props.Click)

	return button
end

-- Invisible, larger tap area for small controls on touch devices
local function addTouchHitbox(button, padding)
	if not Library.IsMobile then
		return nil
	end
	padding = padding or 18
	local hitbox = create("TextButton", {
		Name = "TouchHitbox",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, padding, 1, padding),
		ZIndex = button.ZIndex + 6,
		Parent = button,
	})
	return hitbox
end

--// 3D beveled square button
local function createBevelSquare(parent, props)
	local size = props.Size or 38

	local button = create("ImageButton", {
		Name = props.Name,
		Size = UDim2.fromOffset(size, size),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = props.Position or UDim2.new(),
		BackgroundColor3 = props.Base or Palette.Ink,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		ZIndex = props.ZIndex or 25,
		Parent = parent,
	})
	addStroke(button, Palette.Black, 2.8)

	local face = create("Frame", {
		Name = "Face",
		Size = UDim2.new(1, 0, 1, -4),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		ZIndex = button.ZIndex + 1,
		Parent = button,
	})
	local faceGradient = create("UIGradient", { Name = "FaceGradient", Color = props.Face, Rotation = 90, Parent = face })

	local inner = create("Frame", {
		Size = UDim2.new(1, -2, 1, -2),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = button.ZIndex + 2,
		Parent = face,
	})
	addStroke(inner, props.Highlight or Palette.White, 1.2, props.HighlightTransparency or 0)

	create("Frame", {
		Name = "SepLine",
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -4),
		BackgroundColor3 = props.Sep or Palette.Black,
		BackgroundTransparency = 0.4,
		BorderSizePixel = 0,
		ZIndex = button.ZIndex + 2,
		Parent = button,
	})

	local label = newText(face, {
		Name = "Label",
		Text = props.Text or "",
		Size = props.TextSize or 29,
		Stroke = 3,
		Color = Palette.White,
		AlignX = Enum.TextXAlignment.Center,
		ZIndex = button.ZIndex + 3,
	})

	local scale = create("UIScale", { Name = "ButtonScale", Parent = button })
	bindButtonAnimations(button, scale, 1.08, 0.92)

	if not props.NoHitbox then
		local hitbox = addTouchHitbox(button, 14)
		if hitbox then
			bindButtonAnimations(hitbox, scale, 1.08, 0.92)
		end
	end

	return button, label, faceGradient, face
end

local function recessedBox(parent, props)
	local box = create(props.Class or "Frame", {
		Name = props.Name or "Box",
		AnchorPoint = props.Anchor or Vector2.new(1, 0.5),
		Position = props.Position or UDim2.new(),
		Size = props.Size,
		BorderSizePixel = 0,
		ZIndex = props.ZIndex or 1,
		LayoutOrder = props.LayoutOrder or 0,
		Parent = parent,
	})
	themed(box, "BackgroundColor3", "Recessed")
	if props.Class == "TextButton" then
		box.Text = ""
		box.AutoButtonColor = false
	end
	addCorner(box, 4)
	local stroke = themed(addStroke(box, Palette.White, 1.2), "Color", "RecessedBorder")
	return box, stroke
end

local function bindRecessedHover(box)
	box.MouseEnter:Connect(function()
		tween(box, 0.12, { BackgroundColor3 = Library.Theme.RecessedHover })
	end)
	box.MouseLeave:Connect(function()
		tween(box, 0.12, { BackgroundColor3 = Library.Theme.Recessed })
	end)
end

local function smallRecessedButton(parent, props)
	local button = recessedBox(parent, {
		Class = "TextButton",
		Name = props.Name,
		Anchor = props.Anchor or Vector2.zero,
		Position = props.Position,
		Size = props.Size,
		ZIndex = props.ZIndex,
		LayoutOrder = props.LayoutOrder,
	})
	newText(button, {
		Name = "Label",
		Text = props.Text,
		Size = props.TextSize or 11,
		AlignX = Enum.TextXAlignment.Center,
		ZIndex = button.ZIndex + 1,
	})
	bindRecessedHover(button)
	addTouchHitbox(button, 12)
	return button
end

-- Whole-row tap target for card elements on touch devices
local function addRowHitbox(card, callback)
	if not Library.IsMobile then
		return nil
	end
	local hitbox = create("TextButton", {
		Name = "RowHitbox",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0,
		Parent = card,
	})
	onClick(hitbox, callback)
	return hitbox
end

--// Floating button (minimize-to-button, mobile toggle, mobile keybind actions)
local function createFloatingButton(props)
	local gui = getGui()
	local baseSize = clampNumber(props.Size, 54, 32, 120)
	local floating = { Visible = false, Snap = props.Snap == true, Center = nil }

	local button, label, faceGradient = createBevelSquare(gui, {
		Name = props.Name or "FloatingButton",
		Size = baseSize,
		Text = upper(props.Text or "RS"),
		TextSize = math.floor(baseSize * 0.4),
		Face = Library.Theme.Gradient,
		Highlight = Palette.White,
		HighlightTransparency = 0.4,
		ZIndex = 80,
		NoHitbox = true,
	})
	button.Visible = false
	themed(button, "BackgroundColor3", "DivDark")
	themeGradient(faceGradient)
	floating.Button = button

	local buttonScale = button:FindFirstChild("ButtonScale")

	local function pixelSize()
		return math.floor(baseSize * Library.UIScale + 0.5)
	end

	local function clampCenter(center)
		local screen = getScreenSize()
		local half = pixelSize() / 2 + 6
		return Vector2.new(
			math.clamp(center.X, half, math.max(half, screen.X - half)),
			math.clamp(center.Y, half, math.max(half, screen.Y - half))
		)
	end

	local function setCenter(center, animate)
		center = clampCenter(center)
		floating.Center = center
		local goal = UDim2.fromOffset(center.X, center.Y)
		if animate then
			tween(button, 0.25, { Position = goal }, Enum.EasingStyle.Back)
		else
			button.Position = goal
		end
	end

	local function snapToEdge()
		local screen = getScreenSize()
		local half = pixelSize() / 2 + 10
		local center = floating.Center
		local distances = {
			Left = center.X,
			Right = screen.X - center.X,
			Top = center.Y,
			Bottom = screen.Y - center.Y,
		}
		local nearest, best = "Left", math.huge
		for edge, distance in distances do
			if distance < best then
				nearest, best = edge, distance
			end
		end
		if nearest == "Left" then
			center = Vector2.new(half, center.Y)
		elseif nearest == "Right" then
			center = Vector2.new(screen.X - half, center.Y)
		elseif nearest == "Top" then
			center = Vector2.new(center.X, half)
		else
			center = Vector2.new(center.X, screen.Y - half)
		end
		setCenter(center, true)
	end

	-- Initial position
	do
		local screen = getScreenSize()
		local position = props.Position
		if typeof(position) == "Vector2" then
			setCenter(position)
		elseif typeof(position) == "UDim2" then
			setCenter(Vector2.new(
				screen.X * position.X.Scale + position.X.Offset,
				screen.Y * position.Y.Scale + position.Y.Offset
			))
		else
			setCenter(Vector2.new(56, screen.Y / 2))
		end
	end

	-- Press / drag / release
	button.InputBegan:Connect(function(input)
		if not isPress(input) or not floating.Visible then
			return
		end
		local pressStart = input.Position
		local startCenter = floating.Center
		local moved = false

		if props.OnPress then
			safeCallback(props.OnPress)
		end

		beginDrag(input, {
			OnMove = function(position)
				local dx, dy = position.X - pressStart.X, position.Y - pressStart.Y
				if not moved and math.abs(dx) + math.abs(dy) > 8 then
					moved = true
				end
				if moved then
					setCenter(Vector2.new(startCenter.X + dx, startCenter.Y + dy))
				end
			end,
			OnEnd = function()
				if props.OnRelease then
					safeCallback(props.OnRelease)
				end
				if moved then
					if floating.Snap then
						snapToEdge()
					end
					if props.OnMoved then
						safeCallback(props.OnMoved, floating.Center)
					end
				elseif props.OnClick then
					safeCallback(props.OnClick)
				end
			end,
		})
	end)

	function floating:SetVisible(visible)
		visible = visible and true or false
		if visible == self.Visible then
			return
		end
		self.Visible = visible
		if visible then
			button.Visible = true
			setCenter(self.Center)
			buttonScale.Scale = 0.01
			tween(buttonScale, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
		else
			local t = tween(buttonScale, 0.15, { Scale = 0.01 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			t.Completed:Once(function()
				if not self.Visible then
					button.Visible = false
				end
			end)
		end
	end

	function floating:SetText(text)
		label.Text = upper(text)
	end

	function floating:SetSnap(enabled)
		self.Snap = enabled and true or false
		if self.Snap and self.Visible then
			snapToEdge()
		end
	end

	function floating:SetCenter(center, animate)
		setCenter(center, animate)
	end

	function floating:Refresh()
		local size = pixelSize()
		button.Size = UDim2.fromOffset(size, size)
		label.TextSize = math.floor(size * 0.4)
		setCenter(self.Center)
	end

	function floating:Destroy()
		local index = table.find(Library._scaleTargets, self._scaleTarget)
		if index then
			table.remove(Library._scaleTargets, index)
		end
		button:Destroy()
	end

	floating._scaleTarget = function()
		floating:Refresh()
	end
	table.insert(Library._scaleTargets, floating._scaleTarget)
	floating:Refresh()

	return floating
end

--// Overlay scaling (keybind list, watermark, notifications follow Library.UIScale)
local function addOverlayScale(frame)
	local scale = create("UIScale", { Scale = Library.UIScale, Parent = frame })
	local function apply()
		scale.Scale = Library.UIScale
	end
	table.insert(Library._scaleTargets, apply)
	return scale
end

local function overlayHeader(parent, title, height)
	local header = create("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, height or 34),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		LayoutOrder = 1,
		Parent = parent,
	})
	addCorner(header, 4)
	themeGradient(create("UIGradient", { Parent = header }))
	create("Frame", {
		Position = UDim2.new(0, 0, 1, -3),
		Size = UDim2.new(1, 0, 0, 3),
		BackgroundColor3 = Palette.Black,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = header,
	})
	newText(header, {
		Name = "Title",
		Text = upper(title),
		Size = 16,
		Stroke = 2.5,
		Color = Palette.White,
		Position = UDim2.fromOffset(12, 0),
		Bounds = UDim2.new(1, -24, 1, -3),
		Truncate = true,
		ZIndex = 3,
	})
	return header
end

--// Keybind list
local bindListFrame, bindListBody, bindListEmpty

local function ensureBindRow(entry)
	if entry.Row and entry.Row.Parent then
		return entry.Row
	end
	local row = create("Frame", {
		Name = "Row",
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		Parent = bindListBody,
	})
	entry.NameLabel = newText(row, {
		Text = upper(entry.Name),
		Size = 13,
		Dynamic = true,
		Bounds = UDim2.new(1, -64, 1, 0),
		Truncate = true,
	})
	entry.KeyLabel = newText(row, {
		Size = 13,
		Dynamic = true,
		AlignX = Enum.TextXAlignment.Right,
		Anchor = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0),
		Bounds = UDim2.new(0, 60, 1, 0),
	})
	entry.Row = row
	return row
end

local function refreshBindList()
	if not bindListFrame or not bindListFrame.Parent or not bindListFrame.Visible then
		return
	end

	for index = #Library._binds, 1, -1 do
		local entry = Library._binds[index]
		if not entry.Instance.Parent then
			if entry.Row then
				entry.Row:Destroy()
			end
			table.remove(Library._binds, index)
		end
	end

	local shown = 0
	for index, entry in Library._binds do
		local key = entry.GetKey()
		local row = ensureBindRow(entry)
		row.LayoutOrder = index
		row.Visible = key ~= nil
		if key then
			shown += 1
			local state = entry.GetState and entry.GetState()
			local color = state == true and Palette.Lime or (state == false and Library.Theme.Muted or Library.Theme.Text)
			entry.KeyLabel.Text = "[" .. shortKeyName(key) .. "]"
			entry.NameLabel.TextColor3 = color
			entry.KeyLabel.TextColor3 = color
		end
	end

	bindListEmpty.Visible = shown == 0
end

local function registerBind(entry)
	table.insert(Library._binds, entry)
	refreshBindList()
	return function()
		local index = table.find(Library._binds, entry)
		if index then
			table.remove(Library._binds, index)
		end
		if entry.Row then
			entry.Row:Destroy()
		end
		refreshBindList()
	end
end

function Library:SetKeybindList(visible)
	if not bindListFrame or not bindListFrame.Parent then
		bindListFrame = create("Frame", {
			Name = "KeybindList",
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -16, 0, 16),
			Size = UDim2.fromOffset(220, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 50,
			Parent = getGui(),
		})
		themed(bindListFrame, "BackgroundColor3", "Background")
		addCorner(bindListFrame, 4)
		themed(addStroke(bindListFrame, Palette.Black, 3), "Color", "Border")
		addList(bindListFrame)
		addOverlayScale(bindListFrame)
		overlayHeader(bindListFrame, "Keybinds")

		bindListBody = create("Frame", {
			Name = "Body",
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Parent = bindListFrame,
		})
		addPadding(bindListBody, 8, 10, 12, 12)
		addList(bindListBody, 2)

		bindListEmpty = create("Frame", {
			Name = "Empty",
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundTransparency = 1,
			LayoutOrder = 100000,
			Parent = bindListBody,
		})
		newText(bindListEmpty, { Text = "NO KEYBINDS SET", Size = 12, Color = "Muted" })
	end

	bindListFrame.Visible = visible and true or false
	refreshBindList()
end

--// Watermark (only counts frames while visible)
local watermarkFrame, watermarkLabel
Library.WatermarkText = Library.Name

function Library:SetWatermark(visible, text)
	if text ~= nil then
		self.WatermarkText = tostring(text)
	end

	if not watermarkFrame or not watermarkFrame.Parent then
		watermarkFrame = create("Frame", {
			Name = "Watermark",
			Position = UDim2.fromOffset(16, 16),
			Size = UDim2.fromOffset(0, 34),
			AutomaticSize = Enum.AutomaticSize.X,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 50,
			Parent = getGui(),
		})
		themed(watermarkFrame, "BackgroundColor3", "Background")
		addCorner(watermarkFrame, 4)
		themed(addStroke(watermarkFrame, Palette.Black, 3), "Color", "Border")
		addPadding(watermarkFrame, 0, 0, 18, 14)
		addOverlayScale(watermarkFrame)

		local strip = create("Frame", {
			Name = "Accent",
			Position = UDim2.fromOffset(-18, 0),
			Size = UDim2.new(0, 7, 1, 0),
			BackgroundColor3 = Palette.White,
			BorderSizePixel = 0,
			Parent = watermarkFrame,
		})
		addCorner(strip, 3)
		themeGradient(create("UIGradient", { Parent = strip }))

		watermarkLabel = newText(watermarkFrame, {
			Text = upper(self.WatermarkText),
			Size = 14,
			Stroke = 2.5,
			Bounds = UDim2.new(0, 0, 1, 0),
			AutoSize = Enum.AutomaticSize.X,
		})
	end

	watermarkLabel.Text = upper(self.WatermarkText)
	watermarkFrame.Visible = visible and true or false

	if watermarkFrame.Visible then
		local frames, elapsed = 0, 0
		bindStep("Watermark", function(dt)
			frames += 1
			elapsed += dt
			if elapsed < 0.5 then
				return
			end
			local fps = math.floor(frames / elapsed + 0.5)
			frames, elapsed = 0, 0

			local ping = 0
			pcall(function()
				ping = math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
			end)

			watermarkLabel.Text = string.format(
				"%s  |  %d FPS  |  %d MS  |  %s",
				upper(self.WatermarkText), fps, ping, os.date("%H:%M")
			)
		end)
	else
		unbindStep("Watermark")
	end
end

--// Notifications
local NOTIFY_POSITIONS = {
	TopLeft     = { Anchor = Vector2.new(0, 0), Position = UDim2.new(0, 16, 0, 16), V = "Top", H = "Left", Slide = Vector2.new(-1, 0) },
	Top         = { Anchor = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 16), V = "Top", H = "Center", Slide = Vector2.new(0, -1) },
	TopRight    = { Anchor = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 16), V = "Top", H = "Right", Slide = Vector2.new(1, 0) },
	BottomLeft  = { Anchor = Vector2.new(0, 1), Position = UDim2.new(0, 16, 1, -16), V = "Bottom", H = "Left", Slide = Vector2.new(-1, 0) },
	Bottom      = { Anchor = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -16), V = "Bottom", H = "Center", Slide = Vector2.new(0, 1) },
	BottomRight = { Anchor = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -16), V = "Bottom", H = "Right", Slide = Vector2.new(1, 0) },
}

local notifyState = { Holder = nil, Layout = nil, Active = {}, Queue = {}, Count = 0 }

local function currentNotifyPosition()
	local name = Library.NotificationPosition
	if Library.IsMobile and not Library._notifyPositionSet then
		name = "Top"
	end
	return NOTIFY_POSITIONS[name] or NOTIFY_POSITIONS.BottomRight, name
end

local function layoutNotifyHolder()
	local holder = notifyState.Holder
	if not holder then
		return
	end
	local position = currentNotifyPosition()
	local screen = getScreenSize()
	local width = math.min(300, (screen.X - 32) / Library.UIScale)

	holder.AnchorPoint = position.Anchor
	holder.Position = position.Position
	holder.Size = UDim2.new(0, width, 1, -32)
	notifyState.Layout.VerticalAlignment = position.V == "Top" and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Bottom
	notifyState.Layout.HorizontalAlignment = position.H == "Left" and Enum.HorizontalAlignment.Left
		or (position.H == "Center" and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Right)
end

local function getNotifyHolder()
	if notifyState.Holder and notifyState.Holder.Parent then
		return notifyState.Holder
	end

	notifyState.Holder = create("Frame", {
		Name = "Notifications",
		BackgroundTransparency = 1,
		ZIndex = 60,
		Parent = getGui(),
	})
	notifyState.Layout = create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 10),
		Parent = notifyState.Holder,
	})
	create("UIScale", { Name = "NotifyScale", Scale = Library.UIScale, Parent = notifyState.Holder })

	table.insert(Library._scaleTargets, function()
		if notifyState.Holder then
			notifyState.Holder.NotifyScale.Scale = Library.UIScale
			layoutNotifyHolder()
		end
	end)
	layoutNotifyHolder()

	return notifyState.Holder
end

local showNotification

local function pumpNotifyQueue()
	while #notifyState.Queue > 0 and #notifyState.Active < Library.NotificationLimit do
		local handle = table.remove(notifyState.Queue, 1)
		if not handle.Closed then
			showNotification(handle)
		end
	end
end

function showNotification(handle)
	local options = handle.Options
	handle.Queued = false
	table.insert(notifyState.Active, handle)
	notifyState.Count += 1

	local position = currentNotifyPosition()
	local style = typeof(options.Gradient) == "ColorSequence" and options.Gradient
		or (typeof(options.Gradient) == "Color3" and toGradient(options.Gradient))
		or (options.Style == "Theme" and Library.Theme.Notification)
		or NotifyStyles[options.Style or "Info"]
		or NotifyStyles.Info

	local slot = create("Frame", {
		Name = "Notification",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = position.V == "Top" and -notifyState.Count or notifyState.Count,
		Parent = getNotifyHolder(),
	})

	local hiddenOffset = UDim2.new(position.Slide.X, position.Slide.X * 40, position.Slide.Y, position.Slide.Y * 40)

	local card = create("Frame", {
		Position = hiddenOffset,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		Parent = slot,
	})
	themed(card, "BackgroundColor3", "Background")
	addCorner(card, 4)
	themed(addStroke(card, Palette.Black, 3), "Color", "Border")
	addList(card)

	local header = create("TextButton", {
		Text = "",
		AutoButtonColor = false,
		Size = UDim2.new(1, 0, 0, 38),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		LayoutOrder = 1,
		Parent = card,
	})
	addCorner(header, 4)
	create("UIGradient", { Color = style, Rotation = 90, Parent = header })
	create("Frame", {
		Position = UDim2.new(0, 0, 1, -3),
		Size = UDim2.new(1, 0, 0, 3),
		BackgroundColor3 = Palette.Black,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = header,
	})

	local titleX = 12
	if options.Icon then
		create("ImageLabel", {
			Name = "Icon",
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 10, 0.5, -1),
			Size = UDim2.fromOffset(24, 24),
			BackgroundTransparency = 1,
			Image = tostring(options.Icon),
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 3,
			Parent = header,
		})
		titleX = 40
	end

	local titleLabel = newText(header, {
		Text = upper(options.Title or "Notification"),
		Size = 18,
		Stroke = 2.5,
		Color = Palette.White,
		Position = UDim2.fromOffset(titleX, 0),
		Bounds = UDim2.new(1, -(titleX + 32), 1, -3),
		Truncate = true,
		ZIndex = 3,
	})

	newText(header, {
		Text = "X",
		Size = 16,
		Stroke = 2.5,
		Color = Palette.White,
		AlignX = Enum.TextXAlignment.Center,
		Anchor = Vector2.new(1, 0),
		Position = UDim2.new(1, -8, 0, 0),
		Bounds = UDim2.new(0, 20, 1, -3),
		ZIndex = 3,
	})

	local body = create("Frame", {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Parent = card,
	})
	addPadding(body, 10, 12, 12, 12)
	addList(body, 10)

	local contentLabel = newText(body, {
		Text = tostring(options.Content or ""),
		Size = 14,
		Wrapped = true,
		AutoY = true,
		RichText = options.RichText,
		AlignY = Enum.TextYAlignment.Top,
		Bounds = UDim2.new(1, 0, 0, 0),
		LayoutOrder = 1,
	})

	-- Action buttons
	if type(options.Buttons) == "table" and #options.Buttons > 0 then
		local row = create("Frame", {
			Size = UDim2.new(1, 0, 0, 36),
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Parent = body,
		})
		local rowLayout = addList(row, 8, Enum.FillDirection.Horizontal)
		rowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		local count = math.min(#options.Buttons, 3)
		for index = 1, count do
			local info = options.Buttons[index]
			if type(info) == "table" then
				local holder = create("Frame", {
					Size = UDim2.new(1 / count, -(8 * (count - 1)) / count, 1, 0),
					BackgroundTransparency = 1,
					LayoutOrder = index,
					Parent = row,
				})
				local button = createStandardButton({
					Parent = holder,
					Size = UDim2.new(1, -4, 1, -4),
					Text = upper(info.Text or "OK"),
					TextSize = 16,
					Stroke = 2.5,
					Gradient = ButtonStyles[info.Style or "Claim"] or ButtonStyles.Claim,
					ZIndex = 2,
				})
				onClick(button, function()
					safeCallback(info.Callback)
					if info.Close ~= false then
						task.spawn(handle.Close, handle)
					end
				end)
			end
		end
	end

	-- Timer / progress bar
	local showBar = options.Progress ~= nil or (not options.Persistent and options.Timer ~= false)
	local fill
	if showBar then
		local bar = create("Frame", {
			Size = UDim2.new(1, 0, 0, options.Progress ~= nil and 14 or 8),
			BorderSizePixel = 0,
			LayoutOrder = 3,
			ClipsDescendants = true,
			Parent = body,
		})
		themed(bar, "BackgroundColor3", "Trough")
		themed(addStroke(bar, Palette.Black, 1.5), "Color", "TroughBorder")

		fill = create("Frame", {
			Size = UDim2.fromScale(options.Progress ~= nil and math.clamp(tonumber(options.Progress) or 0, 0, 1) or 1, 1),
			BackgroundColor3 = Palette.White,
			BorderSizePixel = 0,
			Parent = bar,
		})
		create("UIGradient", { Color = options.Progress ~= nil and Palette.GoldFill or style, Rotation = 90, Parent = fill })
	end

	handle._card = card
	handle._slot = slot
	handle._title = titleLabel
	handle._content = contentLabel
	handle._fill = fill
	handle._hidden = hiddenOffset

	onClick(header, function()
		task.spawn(handle.Close, handle)
	end)

	if options.Sound ~= false and Library.NotificationSounds then
		playSound("Click")
	end
	tween(card, 0.35, { Position = UDim2.new() }, Enum.EasingStyle.Back)

	if not options.Persistent then
		local duration = clampNumber(options.Duration, 4, 0.5, 600)
		if fill and options.Progress == nil then
			tween(fill, duration, { Size = UDim2.fromScale(0, 1) }, Enum.EasingStyle.Linear, nil, true)
		end
		task.delay(duration, function()
			handle:Close()
		end)
	end
end

function Library:Notify(options)
	if type(options) == "string" then
		options = { Content = options }
	elseif type(options) ~= "table" then
		options = {}
	end

	local handle = { Closed = false, Queued = false, Options = options }

	function handle:Close()
		if self.Closed then
			return
		end
		self.Closed = true

		local queueIndex = table.find(notifyState.Queue, self)
		if queueIndex then
			table.remove(notifyState.Queue, queueIndex)
			return
		end

		local activeIndex = table.find(notifyState.Active, self)
		if activeIndex then
			table.remove(notifyState.Active, activeIndex)
		end

		if self._card and self._card.Parent then
			local t = tween(self._card, 0.25, { Position = self._hidden }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			t.Completed:Wait()
		end
		if self._slot then
			self._slot:Destroy()
		end
		pumpNotifyQueue()
	end

	function handle:SetTitle(text)
		options.Title = text
		if self._title then
			self._title.Text = upper(text)
		end
	end

	function handle:SetContent(text)
		options.Content = text
		if self._content then
			self._content.Text = tostring(text)
		end
	end

	function handle:SetProgress(alpha)
		options.Progress = math.clamp(tonumber(alpha) or 0, 0, 1)
		if self._fill then
			tween(self._fill, 0.2, { Size = UDim2.fromScale(options.Progress, 1) }, Enum.EasingStyle.Quint)
		end
	end

	if self.Unloaded then
		handle.Closed = true
		return handle
	end

	if #notifyState.Active >= self.NotificationLimit then
		handle.Queued = true
		table.insert(notifyState.Queue, handle)
		return handle
	end

	showNotification(handle)
	return handle
end

function Library:SetNotificationPosition(name)
	if not NOTIFY_POSITIONS[name] then
		report("Unknown notification position '" .. tostring(name) .. "'")
		return false
	end
	self.NotificationPosition = name
	self._notifyPositionSet = true
	layoutNotifyHolder()
	return true
end

function Library:SetNotificationLimit(limit)
	self.NotificationLimit = math.floor(clampNumber(limit, 5, 1, 20))
	pumpNotifyQueue()
end

--// Key binder (shared by Keybind elements and Toggle keybinds)
local function createKeyBinder(parent, props)
	local button, stroke = recessedBox(parent, {
		Class = "TextButton",
		Name = props.Name or "Bind",
		Anchor = props.Anchor or Vector2.new(1, 0.5),
		Position = props.Position,
		Size = props.Size,
		ZIndex = props.ZIndex or 3,
	})
	bindRecessedHover(button)

	local label = newText(button, {
		Name = "Key",
		Text = "NONE",
		Size = props.TextSize or 14,
		AlignX = Enum.TextXAlignment.Center,
		Truncate = true,
		ZIndex = button.ZIndex + 1,
	})

	local binder = { Value = nil, Binding = false, LastInput = nil, Button = button }

	local function refresh()
		label.Text = binder.Binding and "..." or shortKeyName(binder.Value)
		stroke.Color = binder.Binding and Library.Theme.Accent or Library.Theme.RecessedBorder
	end

	function binder:Set(key, silent)
		if type(key) == "string" then
			local ok, item = pcall(function()
				return Enum.KeyCode[key]
			end)
			if not ok or item == nil then
				ok, item = pcall(function()
					return Enum.UserInputType[key]
				end)
			end
			key = ok and item or nil
		elseif key ~= nil and typeof(key) ~= "EnumItem" then
			report("Keybind value must be a KeyCode, got " .. typeof(key))
			key = nil
		end
		self.Value = key
		if props.Flag then
			Library.Flags[props.Flag] = key
		end
		refresh()
		refreshBindList()
		if not silent and props.OnChanged then
			props.OnChanged(key)
		end
	end

	function binder:Cancel()
		self.Binding = false
		if Library._activeBinder == self then
			Library._activeBinder = nil
		end
		refresh()
	end

	onClick(button, function()
		if props.IsLocked and props.IsLocked() then
			return
		end
		if Library._activeBinder and Library._activeBinder ~= binder then
			Library._activeBinder:Cancel()
		end
		binder.Binding = true
		Library._activeBinder = binder
		refresh()
	end)

	button.MouseButton2Click:Connect(function()
		if props.IsLocked and props.IsLocked() then
			return
		end
		binder:Cancel()
		binder:Set(nil)
	end)

	local removeInput = onInput("Began", function(input)
		if not binder.Binding then
			return
		end

		local key
		if input.UserInputType == Enum.UserInputType.Keyboard then
			key = input.KeyCode
		elseif input.UserInputType == Enum.UserInputType.MouseButton2
			or input.UserInputType == Enum.UserInputType.MouseButton3
		then
			key = input.UserInputType
		else
			return
		end

		binder.LastInput = input
		Library._lastBindInput = input
		binder:Cancel()

		if key == Enum.KeyCode.Escape or key == Enum.KeyCode.Backspace then
			binder:Set(nil)
		else
			binder:Set(key)
		end
	end)

	local removeHook = addThemeHook(refresh)
	function binder.Disconnect()
		removeInput()
		removeHook()
		if Library._activeBinder == binder then
			Library._activeBinder = nil
		end
	end

	binder:Set(props.Default, true)
	return binder
end

--// Containers (Tabs, Sections, Cards)
local Container = {}
Container.__index = Container

local function newContainer(window, holder, tab, section)
	return setmetatable({ Window = window, Holder = holder, Tab = tab, Section = section, _order = 0 }, Container)
end

function Container:_nextOrder()
	self._order += 1
	return self._order
end

function Container:_register(entry)
	entry.Section = self.Section
	table.insert(self.Tab._entries, entry)
end

local function newCard(container, height, recessed)
	local card = create("Frame", {
		Name = "Card",
		Size = UDim2.new(1, 0, 0, height),
		BorderSizePixel = 0,
		LayoutOrder = container:_nextOrder(),
		Parent = container.Holder,
	})
	addCorner(card, 4)

	if recessed then
		themed(card, "BackgroundColor3", "Recessed")
		themed(addStroke(card, Palette.White, 1.2), "Color", "RecessedBorder")
	else
		themed(card, "BackgroundColor3", "Card")
		addStroke(card, Palette.Ink, 2)
		local highlight = create("Frame", {
			Name = "InnerHighlight",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, -4, 1, -4),
			BackgroundTransparency = 1,
			Parent = card,
		})
		addCorner(highlight, 3)
		themed(addStroke(highlight, Palette.White, 1.2, 0.4), "Color", "CardHighlight")
	end

	return card
end

-- reserve: pixels kept free on the right, reserveScale: fraction of the width kept free
local function addTitle(card, name, description, reserve, reserveScale)
	reserve = reserve or 130
	reserveScale = reserveScale or 0

	if description then
		newText(card, {
			Name = "Title",
			Text = upper(name),
			Size = 18,
			Stroke = 2.5,
			Position = UDim2.fromOffset(14, 9),
			Bounds = UDim2.new(1 - reserveScale, -(14 + reserve), 0, 22),
			Truncate = true,
		})
		newText(card, {
			Name = "Description",
			Text = upper(description),
			Size = 11,
			Color = "Muted",
			Position = UDim2.fromOffset(14, 34),
			Bounds = UDim2.new(1 - reserveScale, -(14 + reserve), 0, 16),
			Truncate = true,
		})
		return 62
	end

	newText(card, {
		Name = "Title",
		Text = upper(name),
		Size = 18,
		Stroke = 2.5,
		Position = UDim2.fromOffset(14, 0),
		Bounds = UDim2.new(1 - reserveScale, -(14 + reserve), 0, 48),
		Truncate = true,
	})
	return 48
end

-- Responsive right-side control: shrinks on narrow windows, capped at maxWidth
local function responsiveControl(control, maxWidth, height)
	control.Size = UDim2.new(0.45, 0, 0, height)
	create("UISizeConstraint", {
		MinSize = Vector2.new(math.min(110, maxWidth), height),
		MaxSize = Vector2.new(maxWidth, height),
		Parent = control,
	})
end

local function buildLockOverlay(instance)
	local overlay = create("TextButton", {
		Name = "LockOverlay",
		Text = "",
		AutoButtonColor = false,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Palette.LockTint,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		ZIndex = 40,
		Visible = false,
		Parent = instance,
	})
	addCorner(overlay, 4)

	local damier = create("ImageLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = Assets.Damier,
		ImageColor3 = Palette.LockDamier,
		ImageTransparency = 0.8,
		ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(19, 19),
		ZIndex = 41,
		Parent = overlay,
	})
	addCorner(damier, 4)

	local label = newText(overlay, {
		Name = "Reason",
		Text = "LOCKED",
		Size = 15,
		Stroke = 2.5,
		Color = Palette.White,
		AlignX = Enum.TextXAlignment.Center,
		Truncate = true,
		ZIndex = 42,
	})

	return overlay, label
end

local function registerOption(flag, element)
	if flag == nil then
		return
	end
	if type(flag) ~= "string" then
		report("Flag must be a string, got " .. typeof(flag))
		return
	end
	if Library.Options[flag] and Library.Options[flag] ~= element then
		report("Flag '" .. flag .. "' is used by more than one element; the newest one wins")
	end
	Library.Options[flag] = element
end

--[[
	Every element keeps the v0.0.2 methods:
		SetVisible, SetLocked, SetTitle, SetDescription, SetTooltip, OnChanged, Destroy
	Interactive elements (features.Interactive) also get:
		SetEnabled, SetCallback
]]
local function baseElement(container, instance, kind, options, features)
	options = options or {}
	features = features or {}

	local element = {
		Type = kind,
		Instance = instance,
		Locked = false,
		Enabled = true,
		Hidden = false,
		_listeners = {},
		_cleanups = {},
	}

	local entry = {
		Instance = instance,
		Element = element,
		Text = lower(options.Name or options.Title or options.Text or ""),
	}
	if not features.NoSearch then
		container:_register(entry)
	end

	local tooltipText = options.Tooltip
	attachTooltip(instance, function()
		return tooltipText
	end)

	local overlay, overlayLabel

	function element:SetVisible(visible)
		self.Hidden = not visible
		instance.Visible = (visible and true or false) and entry.Match ~= false
	end

	function element:SetLocked(state, reason)
		self.Locked = state and true or false
		if not overlay then
			overlay, overlayLabel = buildLockOverlay(instance)
		end
		overlayLabel.Text = upper(reason or "Locked")
		overlay.Visible = self.Locked
	end

	function element:SetTitle(text)
		local title = instance:FindFirstChild("Title")
		if title then
			title.Text = upper(text)
		end
		entry.Text = lower(text)
	end

	function element:SetDescription(text)
		local description = instance:FindFirstChild("Description")
		if description then
			description.Text = upper(text)
		end
	end

	function element:SetTooltip(text)
		tooltipText = text
	end

	function element:OnChanged(listener)
		if type(listener) ~= "function" then
			report(kind .. ":OnChanged expects a function")
			return self
		end
		table.insert(self._listeners, listener)
		return self
	end

	function element:_cleanup(callback)
		table.insert(self._cleanups, callback)
	end

	function element:Destroy()
		for _, callback in self._cleanups do
			local ok, err = pcall(callback)
			if not ok then
				report(kind .. " cleanup error: " .. tostring(err))
			end
		end
		table.clear(self._cleanups)
		local index = table.find(container.Tab._entries, entry)
		if index then
			table.remove(container.Tab._entries, index)
		end
		if options.Flag and Library.Options[options.Flag] == self then
			Library.Options[options.Flag] = nil
		end
		instance:Destroy()
	end

	if features.Interactive then
		function element:SetEnabled(enabled)
			self.Enabled = enabled and true or false
			self:SetLocked(not self.Enabled, "Disabled")
		end

		function element:SetCallback(callback)
			if callback ~= nil and type(callback) ~= "function" then
				report(kind .. ":SetCallback expects a function")
				return
			end
			options.Callback = callback
		end
	end

	if options.Locked then
		element:SetLocked(true, options.LockedReason)
	end
	if features.Interactive and options.Enabled == false then
		element:SetEnabled(false)
	end

	return element
end

--// Search filtering (sections and cards expand when they contain a match)
local function applyFilter(tab, query)
	query = lower(trim(query or ""))
	local searching = query ~= ""
	local sectionHits = {}

	for _, entry in tab._entries do
		local match = not searching or string.find(entry.Text, query, 1, true) ~= nil
		local section = entry.Section
		while searching and not match and section do
			if string.find(section.Search, query, 1, true) then
				match = true
			end
			section = section.Parent
		end
		entry.Match = match
		entry.Instance.Visible = match and not entry.Element.Hidden
		if match then
			section = entry.Section
			while section do
				sectionHits[section] = true
				section = section.Parent
			end
		end
	end

	for _, section in tab._sections do
		local visible = not searching or sectionHits[section] or string.find(section.Search, query, 1, true) ~= nil
		section.Frame.Visible = (visible and true or false) and not section.Hidden
		section.Body.Visible = searching or not section.Collapsed
	end
end

--// Section
function Container:CreateSection(sectionOptions)
	if type(sectionOptions) ~= "table" then
		sectionOptions = { Name = sectionOptions }
	end
	local name = tostring(sectionOptions.Name or "Section")
	local headerHeight = Library.IsMobile and 34 or 24

	local frame = create("Frame", {
		Name = "Section",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = self:_nextOrder(),
		Parent = self.Holder,
	})
	addList(frame, 8)

	local header = create("TextButton", {
		Name = "Header",
		Text = "",
		AutoButtonColor = false,
		Size = UDim2.new(1, 0, 0, headerHeight),
		BackgroundTransparency = 1,
		LayoutOrder = 0,
		Parent = frame,
	})

	local badge = create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 2, 0.5, 0),
		Size = UDim2.fromOffset(8, 16),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		Parent = header,
	})
	addStroke(badge, Palette.Ink, 2)
	themeGradient(create("UIGradient", { Parent = badge }))

	newText(header, {
		Name = "Title",
		Text = upper(name),
		Size = 16,
		Stroke = 2.5,
		Position = UDim2.fromOffset(18, 0),
		Bounds = UDim2.new(1, -44, 1, 0),
		Truncate = true,
	})

	local arrow = newText(header, {
		Name = "Arrow",
		Text = ">",
		Size = 16,
		Stroke = 2.5,
		AlignX = Enum.TextXAlignment.Center,
		Anchor = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		Bounds = UDim2.fromOffset(16, 16),
	})

	local body = create("Frame", {
		Name = "Body",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Parent = frame,
	})
	addList(body, 8)

	local record = {
		Frame = frame,
		Body = body,
		Name = name,
		Search = lower(name),
		Collapsed = sectionOptions.Collapsed == true,
		Hidden = false,
		Parent = self.Section,
	}
	table.insert(self.Tab._sections, record)

	local section = newContainer(self.Window, body, self.Tab, record)
	section.Name = name
	section.Instance = frame

	function section:SetCollapsed(state)
		record.Collapsed = state and true or false
		body.Visible = not record.Collapsed
		tween(arrow, 0.2, { Rotation = record.Collapsed and 0 or 90 }, Enum.EasingStyle.Quint)
	end

	function section:SetVisible(visible)
		record.Hidden = not visible
		frame.Visible = visible and true or false
	end

	function section:SetName(text)
		header.Title.Text = upper(text)
		record.Search = lower(text)
	end

	onClick(header, function()
		playSound("Click")
		section:SetCollapsed(not record.Collapsed)
	end)

	body.Visible = not record.Collapsed
	arrow.Rotation = record.Collapsed and 0 or 90

	return section
end
Container.AddSection = Container.CreateSection

--// Card container [NEW]
function Container:AddCard(options)
	if type(options) ~= "table" then
		options = { Title = options }
	end
	local title = tostring(options.Title or options.Name or "Card")

	local frame = newCard(self, 0, true)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	addPadding(frame, 10, 12, 12, 12)
	addList(frame, 8)

	local header = create("Frame", {
		Name = "CardHeader",
		Size = UDim2.new(1, 0, 0, options.Description and 38 or 22),
		BackgroundTransparency = 1,
		LayoutOrder = 0,
		Parent = frame,
	})
	local titleLabel = newText(header, {
		Name = "Title",
		Text = upper(title),
		Size = 17,
		Stroke = 2.5,
		Bounds = UDim2.new(1, 0, 0, 22),
		Truncate = true,
	})
	local descriptionLabel
	if options.Description then
		descriptionLabel = newText(header, {
			Name = "Description",
			Text = upper(options.Description),
			Size = 11,
			Color = "Muted",
			Position = UDim2.fromOffset(0, 22),
			Bounds = UDim2.new(1, 0, 0, 16),
			Truncate = true,
		})
	end

	local body = create("Frame", {
		Name = "Body",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Parent = frame,
	})
	addList(body, 8)

	local record = {
		Frame = frame,
		Body = body,
		Name = title,
		Search = lower(title),
		Collapsed = false,
		Hidden = false,
		Parent = self.Section,
	}
	table.insert(self.Tab._sections, record)

	local card = newContainer(self.Window, body, self.Tab, record)
	card.Type = "Card"
	card.Instance = frame

	function card:SetTitle(text)
		titleLabel.Text = upper(text)
		record.Search = lower(text)
	end

	function card:SetDescription(text)
		if descriptionLabel then
			descriptionLabel.Text = upper(text)
		end
	end

	function card:SetVisible(visible)
		record.Hidden = not visible
		frame.Visible = visible and true or false
	end

	function card:Destroy()
		local index = table.find(self.Tab._sections, record)
		if index then
			table.remove(self.Tab._sections, index)
		end
		frame:Destroy()
	end

	return card
end

--// Toggle
function Container:AddToggle(options)
	options = type(options) == "table" and options or {}
	local hasBind = options.Keybind ~= nil
	local showBindBox = hasBind and not Library.IsMobile

	local card = newCard(self, options.Description and 62 or 48)
	addTitle(card, options.Name or "Toggle", options.Description, showBindBox and 190 or 120)

	local button = createStandardButton({
		Name = "Toggle",
		Parent = card,
		Size = UDim2.fromOffset(92, 36),
		Position = UDim2.new(1, -60, 0.5, 0),
		Text = "OFF",
		TextSize = 22,
		Stroke = 2.5,
		Gradient = ButtonStyles.Locked,
	})

	local Toggle = baseElement(self, card, "Toggle", options, { Interactive = true })
	Toggle.Value = false

	function Toggle:Set(value, silent)
		value = value and true or false
		self.Value = value
		button.ButtonGradient.Color = value and ButtonStyles.Claim or ButtonStyles.Locked
		button.Label.Text = value and "ON" or "OFF"
		if options.Flag then
			Library.Flags[options.Flag] = value
		end
		refreshBindList()
		if not silent then
			fire(self, options.Callback, value)
		end
	end

	function Toggle:Get()
		return self.Value
	end

	local function flip()
		if Toggle.Locked then
			return
		end
		Toggle:Set(not Toggle.Value)
	end

	onClick(button, flip)
	addRowHitbox(card, flip)

	if hasBind then
		local mode = options.KeybindMode or "Toggle"
		local keyFlag = options.KeybindFlag or (options.Flag and (options.Flag .. "_Key"))
		local defaultKey = options.Keybind ~= true and options.Keybind or nil

		local KeyOption = { Type = "ToggleKeybind", Value = nil }
		local binder

		if showBindBox then
			binder = createKeyBinder(card, {
				Name = "Bind",
				Anchor = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -116, 0.5, 0),
				Size = UDim2.fromOffset(62, 28),
				TextSize = 12,
				Flag = keyFlag,
				Default = defaultKey,
				IsLocked = function()
					return Toggle.Locked
				end,
			})
			Toggle:_cleanup(binder.Disconnect)
		end

		function KeyOption:Set(key, silent)
			if binder then
				binder:Set(key, silent)
				self.Value = binder.Value
			else
				self.Value = key
				if keyFlag then
					Library.Flags[keyFlag] = key
				end
			end
		end

		function KeyOption:Get()
			return binder and binder.Value or self.Value
		end

		if not binder then
			KeyOption:Set(defaultKey, true)
		end

		Toggle.Keybind = KeyOption
		registerOption(keyFlag, KeyOption)

		if binder then
			Toggle:_cleanup(onInput("Began", function(input, gameProcessed)
				if gameProcessed or Toggle.Locked or binder.Binding or input == binder.LastInput then
					return
				end
				if not bindMatches(input, binder.Value) then
					return
				end
				if mode == "Hold" then
					Toggle:Set(true)
				else
					Toggle:Set(not Toggle.Value)
				end
			end))

			if mode == "Hold" then
				Toggle:_cleanup(onInput("Ended", function(input)
					if Toggle.Value and bindMatches(input, binder.Value) then
						Toggle:Set(false)
					end
				end))
			end

			Toggle:_cleanup(registerBind({
				Name = options.Name or "Toggle",
				Instance = card,
				GetKey = function()
					return binder.Value
				end,
				GetState = function()
					return Toggle.Value
				end,
			}))
		end
	end

	registerOption(options.Flag, Toggle)
	Toggle:Set(options.Default == true, options.Default ~= true)

	return Toggle
end

--// Checkbox [NEW]
function Container:AddCheckbox(options)
	options = type(options) == "table" and options or {}

	local card = newCard(self, options.Description and 62 or 48)
	addTitle(card, options.Name or "Checkbox", options.Description, 64)

	local box, boxStroke = recessedBox(card, {
		Class = "TextButton",
		Name = "Checkbox",
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.fromOffset(30, 30),
		ZIndex = 3,
	})
	boxStroke.Thickness = 2
	bindRecessedHover(box)
	addTouchHitbox(box, 16)

	local check = create("Frame", {
		Name = "Check",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(18, 18),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 4,
		Parent = box,
	})
	addCorner(check, 3)
	addStroke(check, Palette.Ink, 2)
	create("UIGradient", { Color = ButtonStyles.Claim, Rotation = 90, Parent = check })
	local checkScale = create("UIScale", { Parent = check })

	local Checkbox = baseElement(self, card, "Checkbox", options, { Interactive = true })
	Checkbox.Value = false

	local function paint(animate)
		check.Visible = Checkbox.Value
		boxStroke.Color = Checkbox.Value and Palette.Lime or Library.Theme.RecessedBorder
		if Checkbox.Value and animate then
			checkScale.Scale = 0.4
			tween(checkScale, 0.18, { Scale = 1 }, Enum.EasingStyle.Back)
		else
			checkScale.Scale = 1
		end
	end

	function Checkbox:Set(value, silent)
		value = value and true or false
		local changed = value ~= self.Value
		self.Value = value
		if options.Flag then
			Library.Flags[options.Flag] = value
		end
		paint(changed and not silent)
		if not silent then
			fire(self, options.Callback, value)
		end
	end

	function Checkbox:Get()
		return self.Value
	end

	local function flip()
		if Checkbox.Locked then
			return
		end
		playSound("Click")
		Checkbox:Set(not Checkbox.Value)
	end

	onClick(box, flip)
	addRowHitbox(card, flip)
	Checkbox:_cleanup(addThemeHook(function()
		paint(false)
	end))

	registerOption(options.Flag, Checkbox)
	Checkbox:Set(options.Default == true, true)

	return Checkbox
end

--// Button
function Container:AddButton(options)
	options = type(options) == "table" and options or {}
	local currentStyle = ButtonStyles[options.Style or "Claim"] or ButtonStyles.Claim
	local currentText
	local inCard = options.ButtonText ~= nil or options.Description ~= nil

	local holder, button

	if inCard then
		holder = newCard(self, options.Description and 62 or 48)
		addTitle(holder, options.Name or "Button", options.Description, 140)
		currentText = upper(options.ButtonText or "Run")

		button = createStandardButton({
			Name = "Button",
			Parent = holder,
			Size = UDim2.fromOffset(110, 36),
			Position = UDim2.new(1, -69, 0.5, 0),
			Text = currentText,
			TextSize = 20,
			Stroke = 2.5,
			Gradient = currentStyle,
		})
	else
		holder = create("Frame", {
			Name = "ButtonSlot",
			Size = UDim2.new(1, 0, 0, 48),
			BackgroundTransparency = 1,
			LayoutOrder = self:_nextOrder(),
			Parent = self.Holder,
		})
		currentText = upper(options.Name or "Button")

		button = createStandardButton({
			Name = "Button",
			Parent = holder,
			Size = UDim2.new(1, -8, 0, 44),
			Position = UDim2.fromScale(0.5, 0.5),
			Text = currentText,
			TextSize = 24,
			Stroke = 3,
			Gradient = currentStyle,
			Icon = options.Icon,
			Hover = 1.02,
			Click = 0.97,
		})
	end

	local Button = baseElement(self, holder, "Button", options, { Interactive = true })

	local confirming = false
	local confirmToken = 0

	local function restore()
		button.Label.Text = currentText
		button.ButtonGradient.Color = currentStyle
	end

	function Button:SetText(text)
		currentText = upper(text)
		if not confirming then
			restore()
		end
	end

	function Button:SetStyle(name)
		if not ButtonStyles[name] then
			report("Unknown button style '" .. tostring(name) .. "'")
			return
		end
		currentStyle = ButtonStyles[name]
		if not confirming then
			restore()
		end
	end

	function Button:SetIcon(image)
		local icon = button:FindFirstChild("Icon")
		if icon then
			icon.Image = image or ""
		end
	end

	function Button:Fire()
		fire(self, options.Callback)
	end

	local function press()
		if Button.Locked then
			return
		end

		if options.Confirm and not confirming then
			confirming = true
			confirmToken += 1
			local token = confirmToken
			button.Label.Text = upper(options.ConfirmText or "Sure?")
			button.ButtonGradient.Color = ButtonStyles.Skip
			task.delay(2.5, function()
				if confirming and token == confirmToken then
					confirming = false
					restore()
				end
			end)
			return
		end

		confirming = false
		restore()
		fire(Button, options.Callback)
	end

	onClick(button, press)
	if inCard then
		addRowHitbox(holder, press)
	end

	return Button
end

--// Image button [NEW]
function Container:AddImageButton(options)
	options = type(options) == "table" and options or {}

	local card = newCard(self, options.Description and 62 or 52)

	local iconBox = recessedBox(card, {
		Name = "IconBox",
		Anchor = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.fromOffset(options.Description and 44 or 36, options.Description and 44 or 36),
	})
	local icon = create("ImageLabel", {
		Name = "Icon",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, -8, 1, -8),
		BackgroundTransparency = 1,
		Image = options.Image or options.Icon or "",
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 2,
		Parent = iconBox,
	})

	local textLeft = options.Description and 66 or 58
	newText(card, {
		Name = "Title",
		Text = upper(options.Name or "Button"),
		Size = 18,
		Stroke = 2.5,
		Position = UDim2.fromOffset(textLeft, options.Description and 9 or 0),
		Bounds = UDim2.new(1, -(textLeft + 40), 0, options.Description and 22 or 52),
		Truncate = true,
	})
	if options.Description then
		newText(card, {
			Name = "Description",
			Text = upper(options.Description),
			Size = 11,
			Color = "Muted",
			Position = UDim2.fromOffset(textLeft, 34),
			Bounds = UDim2.new(1, -(textLeft + 40), 0, 16),
			Truncate = true,
		})
	end

	local arrow = newText(card, {
		Name = "Arrow",
		Text = ">",
		Size = 20,
		Stroke = 2.5,
		AlignX = Enum.TextXAlignment.Center,
		Anchor = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Bounds = UDim2.fromOffset(20, 20),
	})

	local hit = create("TextButton", {
		Name = "Hit",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 5,
		Parent = card,
	})

	local ImageButton = baseElement(self, card, "ImageButton", options, { Interactive = true })

	hit.MouseEnter:Connect(function()
		if Library.IsMobile then
			return
		end
		playSound("Hover")
		tween(card, 0.12, { BackgroundColor3 = Library.Theme.CardHover })
		tween(arrow, 0.12, { Position = UDim2.new(1, -8, 0.5, 0) })
	end)
	hit.MouseLeave:Connect(function()
		tween(card, 0.12, { BackgroundColor3 = Library.Theme.Card })
		tween(arrow, 0.12, { Position = UDim2.new(1, -12, 0.5, 0) })
	end)

	onClick(hit, function()
		if ImageButton.Locked then
			return
		end
		playSound("Click")
		fire(ImageButton, options.Callback)
	end)

	function ImageButton:SetIcon(image)
		icon.Image = image or ""
	end

	function ImageButton:SetText(text)
		self:SetTitle(text)
	end

	function ImageButton:Fire()
		fire(self, options.Callback)
	end

	return ImageButton
end

--// Slider
local hoveredSlider = nil

onInput("Began", function(input, gameProcessed)
	if gameProcessed or not hoveredSlider or input.UserInputType ~= Enum.UserInputType.Keyboard then
		return
	end
	local key = input.KeyCode
	local direction = 0
	if key == Enum.KeyCode.Right or key == Enum.KeyCode.Up then
		direction = 1
	elseif key == Enum.KeyCode.Left or key == Enum.KeyCode.Down then
		direction = -1
	end
	if direction == 0 then
		return
	end
	local slider = hoveredSlider
	if not slider.Instance.Parent then
		hoveredSlider = nil
		return
	end
	if slider.Locked then
		return
	end
	local fast = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
	slider:_nudge(direction * (fast and 10 or 1))
end)

function Container:AddSlider(options)
	options = type(options) == "table" and options or {}

	local min = tonumber(options.Min) or 0
	local max = tonumber(options.Max) or 100
	if min > max then
		min, max = max, min
	end
	local increment = tonumber(options.Increment) or 1
	if increment <= 0 then
		increment = 1
	end
	local fraction = string.match(tostring(increment), "%.(%d+)")
	local decimals = fraction and #fraction or 0
	local hasInput = options.Input ~= false
	local logarithmic = options.Logarithmic == true
	if logarithmic and (min <= 0 or max <= min) then
		report("Slider '" .. tostring(options.Name) .. "': Logarithmic needs Min > 0 and Max > Min, using linear")
		logarithmic = false
	end

	local top = options.Description and 58 or 38
	local card = newCard(self, top + 42)
	local reserve = hasInput and 104 or 28

	newText(card, {
		Name = "Title",
		Text = upper(options.Name or "Slider"),
		Size = 18,
		Stroke = 2.5,
		Position = UDim2.fromOffset(14, 8),
		Bounds = UDim2.new(1, -(14 + reserve), 0, 22),
		Truncate = true,
	})

	if options.Description then
		newText(card, {
			Name = "Description",
			Text = upper(options.Description),
			Size = 11,
			Color = "Muted",
			Position = UDim2.fromOffset(14, 32),
			Bounds = UDim2.new(1, -(14 + reserve), 0, 16),
			Truncate = true,
		})
	end

	local inputBox, inputStroke
	if hasInput then
		local frame
		frame, inputStroke = recessedBox(card, {
			Name = "ValueInput",
			Anchor = Vector2.new(1, 0),
			Position = UDim2.new(1, -14, 0, 7),
			Size = UDim2.fromOffset(78, 24),
		})
		inputBox = newTextBox(frame, {
			Size = 12,
			AlignX = Enum.TextXAlignment.Center,
			Position = UDim2.fromOffset(4, 0),
			Bounds = UDim2.new(1, -8, 1, 0),
		})
	end

	local extra = Library.IsMobile and 9 or 2
	local area = create("TextButton", {
		Name = "SliderArea",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(16, top - extra),
		Size = UDim2.new(1, -32, 0, 28 + extra * 2),
		ZIndex = 2,
		Parent = card,
	})

	local trough = create("Frame", {
		Name = "Trough",
		Position = UDim2.fromOffset(0, extra),
		Size = UDim2.new(1, 0, 0, 28),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 2,
		Parent = area,
	})
	themed(trough, "BackgroundColor3", "Trough")
	themed(addStroke(trough, Palette.Black, 2), "Color", "TroughBorder")

	local fill = create("Frame", {
		Name = "Fill",
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = trough,
	})
	create("UIGradient", { Color = Palette.GoldFill, Rotation = 90, Parent = fill })
	create("Frame", {
		Name = "Bevel",
		Position = UDim2.new(0, 0, 1, -2),
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = Palette.GoldBevel,
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = fill,
	})

	local valueLabel = newText(trough, {
		Name = "Value",
		Size = 16,
		Stroke = 2.6,
		Color = Palette.White,
		AlignX = Enum.TextXAlignment.Center,
		ZIndex = 5,
	})

	local knob = create("Frame", {
		Name = "Knob",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.fromOffset(14, 36),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		ZIndex = 6,
		Parent = area,
	})
	addCorner(knob, 3)
	addStroke(knob, Palette.Ink, 2.5)
	create("UIGradient", {
		Color = ColorSequence.new(Palette.White, rgb(200, 208, 218)),
		Rotation = 90,
		Parent = knob,
	})
	local knobScale = create("UIScale", { Parent = knob })

	local Slider = baseElement(self, card, "Slider", options, { Interactive = true })
	Slider.Value = nil
	Slider.Min = min
	Slider.Max = max

	local function toAlpha(value)
		if max <= min then
			return 0
		end
		if logarithmic then
			return math.clamp(math.log(value / min) / math.log(max / min), 0, 1)
		end
		return math.clamp((value - min) / (max - min), 0, 1)
	end

	local function fromAlpha(alpha)
		if logarithmic then
			return min * (max / min) ^ alpha
		end
		return min + (max - min) * alpha
	end

	local function snap(value)
		value = math.floor((value - min) / increment + 0.5) * increment + min
		value = math.clamp(value, min, max)
		return tonumber(string.format("%." .. decimals .. "f", value))
	end

	local function format(value)
		if options.Format then
			local ok, result = pcall(options.Format, value)
			if ok and result ~= nil then
				return upper(result)
			elseif not ok then
				report("Slider Format error: " .. tostring(result))
			end
		end
		local text = string.format("%." .. decimals .. "f", value)
		if options.Prefix then
			text = tostring(options.Prefix) .. text
		end
		if options.Suffix then
			text ..= " " .. tostring(options.Suffix)
		end
		return upper(text)
	end

	function Slider:Set(value, silent)
		value = snap(tonumber(value) or min)

		local changed = value ~= self.Value
		self.Value = value

		local alpha = toAlpha(value)
		fill.Size = UDim2.fromScale(alpha, 1)
		knob.Position = UDim2.fromScale(alpha, 0.5)
		valueLabel.Text = format(value)
		if inputBox and not inputBox:IsFocused() then
			inputBox.Text = string.format("%." .. decimals .. "f", value)
		end

		if options.Flag then
			Library.Flags[options.Flag] = value
		end
		if changed and not silent then
			fire(self, options.Callback, value)
		end
	end

	function Slider:Get()
		return self.Value
	end

	function Slider:SetRange(newMin, newMax)
		min = tonumber(newMin) or min
		max = tonumber(newMax) or max
		if min > max then
			min, max = max, min
		end
		if logarithmic and min <= 0 then
			logarithmic = false
		end
		self.Min, self.Max = min, max
		self:Set(self.Value, true)
	end

	function Slider:_nudge(steps)
		if logarithmic then
			self:Set(fromAlpha(math.clamp(toAlpha(self.Value) + steps * 0.01, 0, 1)))
		else
			self:Set(self.Value + steps * increment)
		end
	end

	-- Dragging (hold Shift for fine control)
	local dragAlpha, lastX = 0, nil

	Slider:_cleanup(bindDrag(area, function(position)
		local width = math.max(trough.AbsoluteSize.X, 1)
		local fine = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
		if fine and lastX then
			dragAlpha = math.clamp(dragAlpha + (position.X - lastX) / width * 0.1, 0, 1)
		else
			dragAlpha = math.clamp((position.X - trough.AbsolutePosition.X) / width, 0, 1)
		end
		lastX = position.X
		Slider:Set(fromAlpha(dragAlpha))
	end, function()
		dragAlpha = toAlpha(Slider.Value)
		lastX = nil
		hoveredSlider = Slider
		playSound("Click")
		tween(knobScale, 0.1, { Scale = 1.15 })
	end, function()
		tween(knobScale, 0.12, { Scale = 1 }, Enum.EasingStyle.Back)
	end, function()
		return not Slider.Locked
	end))

	card.MouseEnter:Connect(function()
		hoveredSlider = Slider
	end)
	card.MouseLeave:Connect(function()
		if hoveredSlider == Slider then
			hoveredSlider = nil
		end
	end)
	Slider:_cleanup(function()
		if hoveredSlider == Slider then
			hoveredSlider = nil
		end
	end)

	if inputBox then
		inputBox.Focused:Connect(function()
			inputStroke.Color = Library.Theme.Accent
		end)
		inputBox.FocusLost:Connect(function()
			inputStroke.Color = Library.Theme.RecessedBorder
			local number = tonumber(inputBox.Text)
			if number and not Slider.Locked then
				Slider:Set(number)
			end
			inputBox.Text = string.format("%." .. decimals .. "f", Slider.Value)
		end)
	end

	registerOption(options.Flag, Slider)
	Slider:Set(options.Default or min, true)

	return Slider
end

--// Dropdown
local openDropdown = nil

onInput("Began", function(input)
	local dropdown = openDropdown
	if not dropdown or input.UserInputType ~= Enum.UserInputType.Keyboard then
		return
	end
	if not dropdown.Instance.Parent or not dropdown.Open then
		openDropdown = nil
		return
	end
	local key = input.KeyCode
	if key == Enum.KeyCode.Down then
		dropdown:_moveHighlight(1)
	elseif key == Enum.KeyCode.Up then
		dropdown:_moveHighlight(-1)
	elseif key == Enum.KeyCode.Return or key == Enum.KeyCode.KeypadEnter then
		dropdown:_chooseHighlighted()
	elseif key == Enum.KeyCode.Escape then
		dropdown:SetOpen(false)
	end
end)

function Container:AddDropdown(options)
	options = type(options) == "table" and options or {}
	local multi = options.Multi == true
	local initialOptions = type(options.Options) == "table" and options.Options or {}

	local top = options.Description and 62 or 48
	local card = newCard(self, top)
	card.ClipsDescendants = true
	addTitle(card, options.Name or "Dropdown", options.Description, 24, 0.45)

	local searchable = options.Searchable
	if searchable == nil then
		searchable = #initialOptions > 6
	end
	local hasTools = searchable or multi
	local listTop = top + (hasTools and 36 or 0)
	local rowHeight = Library.IsMobile and 36 or 28
	local maxVisible = math.floor(clampNumber(options.MaxVisible, 5, 2, 12))

	local headerButton = create("TextButton", {
		Name = "HeaderButton",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, top),
		ZIndex = 3,
		Parent = card,
	})

	local selector, selectorStroke = recessedBox(card, {
		Name = "Selector",
		Position = UDim2.new(1, -14, 0, top / 2),
		Size = UDim2.fromOffset(180, 32),
	})
	responsiveControl(selector, 180, 32)

	local selectedLabel = newText(selector, {
		Name = "Selected",
		Text = "NONE",
		Size = 13,
		Position = UDim2.fromOffset(10, 0),
		Bounds = UDim2.new(1, -36, 1, 0),
		Truncate = true,
	})

	local arrow = newText(selector, {
		Name = "Arrow",
		Text = ">",
		Size = 16,
		AlignX = Enum.TextXAlignment.Center,
		Anchor = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, -14, 0.5, 0),
		Bounds = UDim2.fromOffset(16, 16),
	})
	arrow.Rotation = 90

	local searchBox, searchStroke, allButton, noneButton
	if searchable then
		-- Direct child of the card (same path as v0.0.2)
		local frame
		frame, searchStroke = recessedBox(card, {
			Name = "Search",
			Anchor = Vector2.zero,
			Position = UDim2.fromOffset(14, top),
			Size = UDim2.new(1, multi and -140 or -28, 0, 28),
		})
		searchBox = newTextBox(frame, { Placeholder = "Search...", Size = 13 })
	end

	if multi then
		allButton = smallRecessedButton(card, {
			Name = "SelectAll",
			Text = "ALL",
			Position = UDim2.new(1, -118, 0, top),
			Size = UDim2.fromOffset(50, 28),
		})
		noneButton = smallRecessedButton(card, {
			Name = "ClearAll",
			Text = "NONE",
			Position = UDim2.new(1, -64, 0, top),
			Size = UDim2.fromOffset(50, 28),
		})
	end

	local list = create("ScrollingFrame", {
		Name = "List",
		Position = UDim2.fromOffset(14, listTop),
		Size = UDim2.new(1, -28, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = Library.IsMobile and 6 or 4,
		CanvasSize = UDim2.new(),
		CanvasPosition = Vector2.zero,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = card,
	})
	themed(list, "ScrollBarImageColor3", "Accent")
	addList(list, 4)
	addPadding(list, 2, 2, 2, 8)

	local Dropdown = baseElement(self, card, "Dropdown", options, { Interactive = true })
	Dropdown.Options = {}
	Dropdown.Value = multi and {} or nil
	Dropdown.Open = false
	Dropdown.Multi = multi

	local optionButtons = {}
	local highlighted = nil

	local function isSelected(option)
		if multi then
			return table.find(Dropdown.Value, option) ~= nil
		end
		return Dropdown.Value == option
	end

	local function displayText()
		if multi then
			local count = #Dropdown.Value
			if count == 0 then
				return "NONE"
			elseif count <= 2 then
				local names = {}
				for _, value in Dropdown.Value do
					table.insert(names, tostring(value))
				end
				return table.concat(names, ", ")
			end
			return string.format("%s, %s +%d", tostring(Dropdown.Value[1]), tostring(Dropdown.Value[2]), count - 2)
		end
		return Dropdown.Value ~= nil and tostring(Dropdown.Value) or "NONE"
	end

	local function updateDisplay()
		selectedLabel.Text = upper(displayText())
		local theme = Library.Theme
		for option, entry in optionButtons do
			local selected = isSelected(option)
			local isHighlighted = highlighted == option
			entry.Label.TextColor3 = selected and Palette.Lime or theme.Text
			entry.Indicator.BackgroundColor3 = selected and Palette.Lime or theme.Trough
			entry.Stroke.Color = isHighlighted and theme.Accent or (selected and Palette.Lime or theme.RecessedBorder)
			entry.Stroke.Thickness = isHighlighted and 2 or 1.2
		end
		selectorStroke.Color = Dropdown.Open and theme.Accent or theme.RecessedBorder
	end

	local function visibleOptions()
		local out = {}
		for _, option in Dropdown.Options do
			local entry = optionButtons[option]
			if entry and entry.Button.Visible then
				table.insert(out, option)
			end
		end
		return out
	end

	local function listHeight()
		local visible = math.min(#visibleOptions(), maxVisible)
		return visible > 0 and (visible * (rowHeight + 4) + 4) or 0
	end

	local function resize(instant)
		local height = listHeight()
		list.Size = UDim2.new(1, -28, 0, height)
		local target = Dropdown.Open and (listTop + height + 10) or top
		tween(card, instant and 0 or 0.22, { Size = UDim2.new(1, 0, 0, target) }, Enum.EasingStyle.Quint)
		tween(arrow, instant and 0 or 0.22, { Rotation = Dropdown.Open and -90 or 90 }, Enum.EasingStyle.Quint)
		updateDisplay()
	end

	local function applySearch()
		local query = searchBox and lower(trim(searchBox.Text)) or ""
		for option, entry in optionButtons do
			entry.Button.Visible = query == "" or string.find(lower(option), query, 1, true) ~= nil
		end
	end

	local function commit(silent)
		updateDisplay()
		local value = multi and table.clone(Dropdown.Value) or Dropdown.Value
		if options.Flag then
			Library.Flags[options.Flag] = value
		end
		if not silent then
			fire(Dropdown, options.Callback, value)
		end
	end

	local function choose(option)
		if multi then
			local index = table.find(Dropdown.Value, option)
			if index then
				table.remove(Dropdown.Value, index)
			else
				table.insert(Dropdown.Value, option)
			end
		else
			Dropdown.Value = option
			Dropdown:SetOpen(false)
		end
		commit()
	end

	local function scrollTo(option)
		local visible = visibleOptions()
		local index = table.find(visible, option)
		if not index then
			return
		end
		local step = rowHeight + 4
		local y = (index - 1) * step
		local viewHeight = list.AbsoluteSize.Y
		local canvasY = list.CanvasPosition.Y
		if y < canvasY then
			list.CanvasPosition = Vector2.new(0, y)
		elseif y + step > canvasY + viewHeight then
			list.CanvasPosition = Vector2.new(0, math.max(0, y + step - viewHeight))
		end
	end

	local function build()
		for _, entry in optionButtons do
			entry.Button:Destroy()
		end
		table.clear(optionButtons)

		for index, option in Dropdown.Options do
			local button, stroke = recessedBox(list, {
				Class = "TextButton",
				Name = "Option",
				Anchor = Vector2.zero,
				Size = UDim2.new(1, 0, 0, rowHeight),
			})
			button.LayoutOrder = index

			local indicator = create("Frame", {
				Name = "Indicator",
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 9, 0.5, 0),
				Size = UDim2.fromOffset(12, 12),
				BorderSizePixel = 0,
				ZIndex = 2,
				Parent = button,
			})
			addCorner(indicator, 3)
			addStroke(indicator, Palette.Ink, 1.5)

			local label = newText(button, {
				Name = "Label",
				Text = upper(option),
				Size = 13,
				Dynamic = true,
				Position = UDim2.fromOffset(30, 0),
				Bounds = UDim2.new(1, -40, 1, 0),
				Truncate = true,
				ZIndex = 2,
			})

			button.MouseEnter:Connect(function()
				tween(button, 0.12, { BackgroundColor3 = Library.Theme.RecessedHover })
			end)
			button.MouseLeave:Connect(function()
				tween(button, 0.12, { BackgroundColor3 = Library.Theme.Recessed })
			end)
			onClick(button, function()
				if Dropdown.Locked then
					return
				end
				playSound("Click")
				highlighted = option
				choose(option)
			end)

			optionButtons[option] = { Button = button, Label = label, Stroke = stroke, Indicator = indicator }
		end

		applySearch()
	end

	function Dropdown:Set(value, silent)
		if multi then
			local selected = {}
			if type(value) == "table" then
				for _, item in value do
					if table.find(self.Options, item) and not table.find(selected, item) then
						table.insert(selected, item)
					end
				end
			elseif value ~= nil and table.find(self.Options, value) then
				selected = { value }
			end
			self.Value = selected
		else
			if value ~= nil and table.find(self.Options, value) then
				self.Value = value
			else
				if value ~= nil and not silent then
					report("Dropdown '" .. tostring(options.Name) .. "' has no option '" .. tostring(value) .. "'")
				end
				self.Value = nil
			end
		end
		commit(silent)
	end

	function Dropdown:Get()
		return multi and table.clone(self.Value) or self.Value
	end

	function Dropdown:GetOptions()
		return table.clone(self.Options)
	end

	function Dropdown:Refresh(newOptions, keepSelection)
		if type(newOptions) ~= "table" then
			report("Dropdown:Refresh expects a table of options")
			newOptions = {}
		end
		local unique = {}
		for _, option in newOptions do
			if option ~= nil and not table.find(unique, option) then
				table.insert(unique, option)
			end
		end
		self.Options = unique
		build()
		if keepSelection then
			self:Set(self.Value, true)
		else
			self:Set(multi and {} or nil, true)
		end
		if highlighted ~= nil and not optionButtons[highlighted] then
			highlighted = nil
		end
		resize(true)
	end
	Dropdown.SetOptions = Dropdown.Refresh

	function Dropdown:Add(option)
		if option ~= nil and not table.find(self.Options, option) then
			local copy = table.clone(self.Options)
			table.insert(copy, option)
			self:Refresh(copy, true)
		end
	end

	function Dropdown:Remove(option)
		local index = table.find(self.Options, option)
		if index then
			local copy = table.clone(self.Options)
			table.remove(copy, index)
			self:Refresh(copy, true)
		end
	end

	function Dropdown:SelectAll()
		if not multi then
			return
		end
		self:Set(visibleOptions())
	end

	function Dropdown:ClearAll()
		self:Set(multi and {} or nil)
	end

	function Dropdown:SetOpen(state)
		if self.Locked then
			state = false
		end
		state = state and true or false
		if state and openDropdown and openDropdown ~= self then
			openDropdown:SetOpen(false)
		end
		self.Open = state
		if state then
			openDropdown = self
			if not multi and self.Value ~= nil then
				highlighted = self.Value
			end
		elseif openDropdown == self then
			openDropdown = nil
		end
		resize()
		if state and highlighted ~= nil then
			scrollTo(highlighted)
		end
	end

	function Dropdown:_moveHighlight(delta)
		local visible = visibleOptions()
		if #visible == 0 then
			return
		end
		local index = highlighted ~= nil and table.find(visible, highlighted) or 0
		index = math.clamp(index + delta, 1, #visible)
		highlighted = visible[index]
		updateDisplay()
		scrollTo(highlighted)
	end

	function Dropdown:_chooseHighlighted()
		local visible = visibleOptions()
		local option = (highlighted ~= nil and table.find(visible, highlighted)) and highlighted or visible[1]
		if option ~= nil then
			highlighted = option
			choose(option)
		end
	end

	onClick(headerButton, function()
		if Dropdown.Locked then
			return
		end
		playSound("Click")
		Dropdown:SetOpen(not Dropdown.Open)
	end)

	if allButton then
		onClick(allButton, function()
			if not Dropdown.Locked then
				Dropdown:SelectAll()
			end
		end)
		onClick(noneButton, function()
			if not Dropdown.Locked then
				Dropdown:ClearAll()
			end
		end)
	end

	if searchBox then
		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			applySearch()
			local visible = visibleOptions()
			if highlighted == nil or not table.find(visible, highlighted) then
				highlighted = visible[1]
			end
			if Dropdown.Open then
				resize()
			end
		end)
		searchBox.Focused:Connect(function()
			searchStroke.Color = Library.Theme.Accent
		end)
		searchBox.FocusLost:Connect(function()
			searchStroke.Color = Library.Theme.RecessedBorder
		end)
	end

	Dropdown:_cleanup(addThemeHook(updateDisplay))
	Dropdown:_cleanup(function()
		if openDropdown == Dropdown then
			openDropdown = nil
		end
	end)

	Dropdown.Options = {}
	for _, option in initialOptions do
		if option ~= nil and not table.find(Dropdown.Options, option) then
			table.insert(Dropdown.Options, option)
		end
	end
	build()
	registerOption(options.Flag, Dropdown)
	Dropdown:Set(options.Default, true)
	resize(true)

	return Dropdown
end

--// Player dropdown
function Container:AddPlayerDropdown(options)
	options = table.clone(type(options) == "table" and options or {})

	local function playerNames(excluded)
		local names = {}
		for _, player in Players:GetPlayers() do
			if player ~= excluded and (options.IncludeLocal or player ~= LocalPlayer) then
				table.insert(names, player.Name)
			end
		end
		table.sort(names)
		return names
	end

	options.Options = playerNames()
	if options.Searchable == nil then
		options.Searchable = true
	end

	local dropdown = self:AddDropdown(options)
	dropdown.Type = "PlayerDropdown"

	function dropdown:RefreshPlayers(excluded)
		if self.Instance.Parent then
			self:Refresh(playerNames(excluded), true)
		end
	end

	if options.AutoRefresh ~= false then
		local added = track(Players.PlayerAdded:Connect(function()
			dropdown:RefreshPlayers()
		end))
		local removing = track(Players.PlayerRemoving:Connect(function(player)
			dropdown:RefreshPlayers(player)
		end))
		dropdown:_cleanup(function()
			added:Disconnect()
			removing:Disconnect()
		end)
	end

	function dropdown:GetPlayer()
		if type(self.Value) == "string" then
			return Players:FindFirstChild(self.Value)
		end
		return nil
	end

	return dropdown
end

--// Input
function Container:AddInput(options)
	options = type(options) == "table" and options or {}
	local maxLength = tonumber(options.MaxLength)

	local card = newCard(self, options.Description and 62 or 48)
	addTitle(card, options.Name or "Input", options.Description, 24, 0.45)

	local boxFrame, boxStroke = recessedBox(card, {
		Name = "InputBox",
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.fromOffset(180, 32),
	})
	responsiveControl(boxFrame, 180, 32)
	boxFrame.ClipsDescendants = true

	local box = newTextBox(boxFrame, {
		Placeholder = options.Placeholder or "Type here...",
		Text = options.Default ~= nil and truncateText(tostring(options.Default), maxLength) or "",
		ClearOnFocus = options.ClearOnFocus,
	})

	local Input = baseElement(self, card, "Input", options, { Interactive = true })
	Input.Value = options.Numeric and tonumber(box.Text) or box.Text

	local function normalize(value)
		if options.Numeric then
			return tonumber(value)
		end
		return value ~= nil and truncateText(tostring(value), maxLength) or ""
	end

	function Input:Set(value, silent)
		value = normalize(value)
		if value == nil then
			box.Text = self.Value ~= nil and tostring(self.Value) or ""
			return
		end
		self.Value = value
		box.Text = tostring(value)
		if options.Flag then
			Library.Flags[options.Flag] = value
		end
		if not silent then
			fire(self, options.Callback, value)
		end
	end

	function Input:Get()
		return self.Value
	end

	function Input:Clear()
		self:Set(options.Numeric and 0 or "")
	end

	function Input:SetPlaceholder(text)
		box.PlaceholderText = upper(text or "")
	end

	box:GetPropertyChangedSignal("Text"):Connect(function()
		if options.Numeric then
			local filtered = string.gsub(box.Text, "[^%d%.%-]", "")
			if filtered ~= box.Text then
				box.Text = filtered
				return
			end
		end
		if maxLength and textLength(box.Text) > maxLength then
			box.Text = truncateText(box.Text, maxLength)
			return
		end
		if options.Live and box:IsFocused() then
			local value = normalize(box.Text)
			if value ~= nil then
				Input.Value = value
				if options.Flag then
					Library.Flags[options.Flag] = value
				end
				fire(Input, options.Callback, value, false)
			end
		end
	end)

	box.Focused:Connect(function()
		if Input.Locked then
			box:ReleaseFocus()
			return
		end
		boxStroke.Color = Library.Theme.Accent
	end)

	box.FocusLost:Connect(function(enterPressed)
		boxStroke.Color = Library.Theme.RecessedBorder
		if Input.Locked then
			return
		end
		Input:Set(box.Text, true)
		fire(Input, options.Callback, Input.Value, enterPressed)
	end)

	registerOption(options.Flag, Input)
	if options.Flag then
		Library.Flags[options.Flag] = Input.Value
	end

	return Input
end
Container.AddTextbox = Container.AddInput

--// Text area [NEW]
function Container:AddTextArea(options)
	options = type(options) == "table" and options or {}
	local height = math.floor(clampNumber(options.Height, 120, 60, 400))
	local maxLength = tonumber(options.MaxLength)
	local readOnly = options.ReadOnly == true

	local top = options.Description and 58 or 38
	local card = newCard(self, top + height + 14)

	newText(card, {
		Name = "Title",
		Text = upper(options.Name or "Text"),
		Size = 18,
		Stroke = 2.5,
		Position = UDim2.fromOffset(14, 8),
		Bounds = UDim2.new(1, -170, 0, 22),
		Truncate = true,
	})
	if options.Description then
		newText(card, {
			Name = "Description",
			Text = upper(options.Description),
			Size = 11,
			Color = "Muted",
			Position = UDim2.fromOffset(14, 32),
			Bounds = UDim2.new(1, -170, 0, 16),
			Truncate = true,
		})
	end

	local counter = newText(card, {
		Name = "Counter",
		Text = "",
		Size = 11,
		Color = "Muted",
		AlignX = Enum.TextXAlignment.Right,
		Anchor = Vector2.new(1, 0),
		Position = UDim2.new(1, -78, 0, 10),
		Bounds = UDim2.fromOffset(80, 18),
	})

	local clearButton = smallRecessedButton(card, {
		Name = "Clear",
		Text = "CLEAR",
		Anchor = Vector2.new(1, 0),
		Position = UDim2.new(1, -14, 0, 8),
		Size = UDim2.fromOffset(56, 22),
	})

	local frame, frameStroke = recessedBox(card, {
		Name = "Area",
		Anchor = Vector2.zero,
		Position = UDim2.fromOffset(14, top),
		Size = UDim2.new(1, -28, 0, height),
	})
	frame.ClipsDescendants = true

	local scroller = create("ScrollingFrame", {
		Name = "Scroller",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = Library.IsMobile and 6 or 5,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = frame,
	})
	themed(scroller, "ScrollBarImageColor3", "Accent")
	addPadding(scroller, 6, 6, 8, 12)

	local box = newTextBox(scroller, {
		Name = "TextBox",
		MultiLine = true,
		AlignY = Enum.TextYAlignment.Top,
		Placeholder = options.Placeholder or "Enter text...",
		Text = truncateText(tostring(options.Default or ""), maxLength),
		Position = UDim2.new(),
		Bounds = UDim2.new(1, 0, 0, 0),
	})
	box.AutomaticSize = Enum.AutomaticSize.Y
	box.ClipsDescendants = false
	box.TextEditable = not readOnly
	create("UISizeConstraint", { MinSize = Vector2.new(0, height - 12), Parent = box })

	local TextArea = baseElement(self, card, "TextArea", options, { Interactive = true })
	TextArea.Value = box.Text
	TextArea.ReadOnly = readOnly

	local function updateCounter()
		local length = textLength(box.Text)
		counter.Text = maxLength and string.format("%d / %d", length, maxLength) or tostring(length)
	end

	function TextArea:Set(value, silent)
		value = truncateText(value ~= nil and tostring(value) or "", maxLength)
		self.Value = value
		box.Text = value
		updateCounter()
		if options.Flag then
			Library.Flags[options.Flag] = value
		end
		if not silent then
			fire(self, options.Callback, value)
		end
	end

	function TextArea:Get()
		return self.Value
	end

	function TextArea:Clear()
		self:Set("")
	end

	function TextArea:SetReadOnly(state)
		self.ReadOnly = state and true or false
		box.TextEditable = not self.ReadOnly
		clearButton.Visible = not self.ReadOnly
	end

	function TextArea:SetPlaceholder(text)
		box.PlaceholderText = upper(text or "")
	end

	function TextArea:SetMaxLength(length)
		maxLength = tonumber(length)
		self:Set(self.Value, true)
	end

	box:GetPropertyChangedSignal("Text"):Connect(function()
		if maxLength and textLength(box.Text) > maxLength then
			box.Text = truncateText(box.Text, maxLength)
			return
		end
		updateCounter()
		if options.Live and box:IsFocused() and not TextArea.ReadOnly then
			TextArea.Value = box.Text
			if options.Flag then
				Library.Flags[options.Flag] = box.Text
			end
			fire(TextArea, options.Callback, box.Text)
		end
	end)

	box.Focused:Connect(function()
		if TextArea.Locked then
			box:ReleaseFocus()
			return
		end
		frameStroke.Color = Library.Theme.Accent
	end)

	box.FocusLost:Connect(function()
		frameStroke.Color = Library.Theme.RecessedBorder
		if TextArea.Locked or TextArea.ReadOnly then
			return
		end
		if box.Text ~= TextArea.Value then
			TextArea:Set(box.Text)
		end
	end)

	onClick(clearButton, function()
		if not TextArea.Locked and not TextArea.ReadOnly then
			TextArea:Clear()
		end
	end)

	TextArea:SetReadOnly(readOnly)
	registerOption(options.Flag, TextArea)
	TextArea:Set(TextArea.Value, true)

	return TextArea
end

--// Search box element [NEW]
function Container:AddSearch(options)
	options = type(options) == "table" and options or {}
	local scope = options.FilterScope

	local holder = create("Frame", {
		Name = "SearchSlot",
		Size = UDim2.new(1, 0, 0, Library.IsMobile and 40 or 34),
		BackgroundTransparency = 1,
		LayoutOrder = self:_nextOrder(),
		Parent = self.Holder,
	})

	local frame, stroke = recessedBox(holder, {
		Name = "Box",
		Anchor = Vector2.zero,
		Size = UDim2.fromScale(1, 1),
	})
	stroke.Thickness = 2

	local box = newTextBox(frame, {
		Placeholder = options.Placeholder or options.Name or "Search...",
		Size = 14,
		Position = UDim2.fromOffset(12, 0),
		Bounds = UDim2.new(1, -52, 1, 0),
	})

	local clear = smallRecessedButton(frame, {
		Name = "Clear",
		Text = "X",
		TextSize = 13,
		Anchor = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -6, 0.5, 0),
		Size = UDim2.fromOffset(28, 22),
		ZIndex = 2,
	})
	clear.Visible = false

	local container = self
	local Search = baseElement(self, holder, "Search", options, { Interactive = true, NoSearch = true })
	Search.Value = ""

	local function filterScope(query)
		if scope == "Tab" then
			applyFilter(container.Tab, query)
		elseif scope == "Section" then
			query = lower(trim(query))
			for _, entry in container.Tab._entries do
				if entry.Section == container.Section and entry.Instance ~= holder then
					local match = query == "" or string.find(entry.Text, query, 1, true) ~= nil
					entry.Match = match
					entry.Instance.Visible = match and not entry.Element.Hidden
				end
			end
		end
	end

	function Search:Set(text, silent)
		text = text ~= nil and tostring(text) or ""
		self.Value = text
		if box.Text ~= text then
			box.Text = text
		end
		clear.Visible = text ~= ""
		filterScope(text)
		if not silent then
			fire(self, options.Callback, text)
		end
	end

	function Search:Get()
		return self.Value
	end

	function Search:Clear()
		self:Set("")
	end

	box:GetPropertyChangedSignal("Text"):Connect(function()
		if Search.Locked then
			return
		end
		if box.Text ~= Search.Value then
			Search:Set(box.Text)
		end
	end)
	box.Focused:Connect(function()
		stroke.Color = Library.Theme.Accent
	end)
	box.FocusLost:Connect(function()
		stroke.Color = Library.Theme.RecessedBorder
	end)
	onClick(clear, function()
		Search:Clear()
	end)

	return Search
end

--// Keybind
local mobileActionCount = 0

function Container:AddKeybind(options)
	options = type(options) == "table" and options or {}
	local mode = options.Mode or "Press"
	if mode ~= "Press" and mode ~= "Toggle" and mode ~= "Hold" then
		report("Keybind mode must be Press, Toggle or Hold (got " .. tostring(mode) .. ")")
		mode = "Press"
	end

	local card = newCard(self, options.Description and 62 or 48)
	addTitle(card, options.Name or "Keybind", options.Description, 130)

	local Keybind = baseElement(self, card, "Keybind", options, { Interactive = true })
	Keybind.State = false
	Keybind.Mode = mode

	local function trigger(pressed)
		if Keybind.Locked then
			return
		end
		if mode == "Toggle" then
			if pressed then
				Keybind.State = not Keybind.State
				safeCallback(options.Callback, Keybind.State)
			end
		elseif mode == "Hold" then
			if pressed ~= Keybind.State then
				Keybind.State = pressed
				safeCallback(options.Callback, pressed)
			end
		elseif pressed then
			safeCallback(options.Callback)
		end
		refreshBindList()
	end

	if Library.IsMobile then
		-- Touch-only devices: an on-screen action button replaces the keyboard binding
		Keybind.Value = nil
		local actionButton = nil
		local switch = createStandardButton({
			Name = "MobileSwitch",
			Parent = card,
			Size = UDim2.fromOffset(104, 36),
			Position = UDim2.new(1, -66, 0.5, 0),
			Text = "SHOW",
			TextSize = 18,
			Stroke = 2.5,
			Gradient = ButtonStyles.Codes,
		})

		local MobileOption = { Type = "KeybindMobileButton", Value = false }

		local function setShown(shown)
			shown = shown and true or false
			MobileOption.Value = shown
			if options.Flag then
				Library.Flags[options.Flag .. "_Mobile"] = shown
			end
			switch.Label.Text = shown and "HIDE" or "SHOW"
			switch.ButtonGradient.Color = shown and ButtonStyles.Claimed or ButtonStyles.Codes

			if shown and not actionButton then
				mobileActionCount += 1
				local screen = getScreenSize()
				actionButton = createFloatingButton({
					Name = "ActionButton",
					Text = options.MobileText or string.sub(tostring(options.Name or "KEY"), 1, 3),
					Size = 50,
					Snap = true,
					Position = Vector2.new(screen.X - 70, screen.Y * 0.35 + (mobileActionCount % 5) * 62),
					OnPress = mode == "Hold" and function()
						trigger(true)
					end or nil,
					OnRelease = mode == "Hold" and function()
						trigger(false)
					end or nil,
					OnClick = mode ~= "Hold" and function()
						trigger(true)
					end or nil,
				})
			end
			if actionButton then
				actionButton:SetVisible(shown)
			end
		end

		function MobileOption:Set(value)
			setShown(value)
		end
		function MobileOption:Get()
			return self.Value
		end

		onClick(switch, function()
			if not Keybind.Locked then
				setShown(not MobileOption.Value)
			end
		end)

		function Keybind:Set(key)
			self.Value = key
			if options.Flag then
				Library.Flags[options.Flag] = key
			end
		end
		function Keybind:Get()
			return self.Value
		end
		function Keybind:Clear()
			self:Set(nil)
		end
		function Keybind:SetMode(newMode)
			if newMode == "Press" or newMode == "Toggle" or newMode == "Hold" then
				mode = newMode
				self.Mode = newMode
			end
		end
		function Keybind:SetMobileButton(shown)
			setShown(shown)
		end

		Keybind:_cleanup(function()
			if actionButton then
				actionButton:Destroy()
			end
		end)

		if options.Flag then
			registerOption(options.Flag .. "_Mobile", MobileOption)
		end
		registerOption(options.Flag, Keybind)
		Keybind:Set(options.Default)
		return Keybind
	end

	local binder = createKeyBinder(card, {
		Name = "Bind",
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.fromOffset(104, 32),
		Flag = options.Flag,
		Default = options.Default,
		IsLocked = function()
			return Keybind.Locked
		end,
		OnChanged = function(key)
			Keybind.Value = key
			fire(Keybind, options.OnChanged, key)
		end,
	})
	Keybind.Value = binder.Value
	Keybind:_cleanup(binder.Disconnect)

	function Keybind:Set(key, silent)
		binder:Set(key, silent)
		self.Value = binder.Value
	end

	function Keybind:Get()
		return binder.Value
	end

	function Keybind:Clear()
		self:Set(nil)
	end

	function Keybind:SetMode(newMode)
		if newMode == "Press" or newMode == "Toggle" or newMode == "Hold" then
			mode = newMode
			self.Mode = newMode
			self.State = false
			refreshBindList()
		else
			report("Keybind mode must be Press, Toggle or Hold")
		end
	end

	Keybind:_cleanup(onInput("Began", function(input, gameProcessed)
		if gameProcessed or binder.Binding or input == binder.LastInput then
			return
		end
		if bindMatches(input, binder.Value) then
			trigger(true)
		end
	end))

	Keybind:_cleanup(onInput("Ended", function(input)
		if mode == "Hold" and bindMatches(input, binder.Value) then
			trigger(false)
		end
	end))

	if options.ShowInList ~= false then
		Keybind:_cleanup(registerBind({
			Name = options.Name or "Keybind",
			Instance = card,
			GetKey = function()
				return binder.Value
			end,
			GetState = function()
				if mode == "Press" then
					return nil
				end
				return Keybind.State
			end,
		}))
	end

	registerOption(options.Flag, Keybind)

	return Keybind
end

--// Color picker
local colorClipboard

function Container:AddColorPicker(options)
	options = type(options) == "table" and options or {}
	local mobile = Library.IsMobile

	local top = options.Description and 62 or 48
	local card = newCard(self, top)
	card.ClipsDescendants = true
	addTitle(card, options.Name or "Color", options.Description, 90)

	local svHeight = mobile and 110 or 86
	local hueTop = svHeight + 6
	local hueHit = mobile and 30 or 22
	local rowTop = hueTop + hueHit + 6
	local panelHeight = rowTop + 26

	local headerButton = create("TextButton", {
		Name = "HeaderButton",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, top),
		ZIndex = 3,
		Parent = card,
	})

	local swatch = create("Frame", {
		Name = "Swatch",
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -14, 0, top / 2),
		Size = UDim2.fromOffset(50, 28),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		Parent = card,
	})
	addCorner(swatch, 4)
	addStroke(swatch, Palette.Ink, 2.5)

	local panel = create("Frame", {
		Name = "Panel",
		Position = UDim2.fromOffset(14, top),
		Size = UDim2.new(1, -28, 0, panelHeight),
		BackgroundTransparency = 1,
		Parent = card,
	})

	local svBox = create("TextButton", {
		Name = "SaturationValue",
		Text = "",
		AutoButtonColor = false,
		Size = UDim2.new(1, 0, 0, svHeight),
		BackgroundColor3 = rgb(255, 0, 0),
		BorderSizePixel = 0,
		Parent = panel,
	})
	addCorner(svBox, 4)
	addStroke(svBox, Palette.Ink, 2)

	local whiteLayer = create("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = svBox,
	})
	addCorner(whiteLayer, 4)
	create("UIGradient", {
		Transparency = NumberSequence.new({ nkp(0, 0), nkp(1, 1) }),
		Parent = whiteLayer,
	})

	local blackLayer = create("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Palette.Black,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = svBox,
	})
	addCorner(blackLayer, 4)
	create("UIGradient", {
		Rotation = 90,
		Transparency = NumberSequence.new({ nkp(0, 1), nkp(1, 0) }),
		Parent = blackLayer,
	})

	local svCursor = create("Frame", {
		Name = "Cursor",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(mobile and 16 or 12, mobile and 16 or 12),
		BackgroundTransparency = 1,
		ZIndex = 4,
		Parent = svBox,
	})
	addCorner(svCursor, 8)
	addStroke(svCursor, Palette.White, 2.5)

	-- Hue: a taller invisible hit area around the visible bar
	local hueArea = create("TextButton", {
		Name = "Hue",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, hueTop),
		Size = UDim2.new(1, 0, 0, hueHit),
		Parent = panel,
	})

	local hueBar = create("Frame", {
		Name = "Bar",
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.new(1, 0, 0, 14),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		Parent = hueArea,
	})
	addCorner(hueBar, 4)
	addStroke(hueBar, Palette.Ink, 2)

	local hueKeypoints = {}
	for index = 0, 6 do
		table.insert(hueKeypoints, ckp(index / 6, Color3.fromHSV(index / 6, 1, 1)))
	end
	create("UIGradient", { Color = ColorSequence.new(hueKeypoints), Parent = hueBar })

	local hueCursor = create("Frame", {
		Name = "Cursor",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(mobile and 8 or 6, 20),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = hueArea,
	})
	addCorner(hueCursor, 2)
	addStroke(hueCursor, Palette.Ink, 2)

	local hexFrame = recessedBox(panel, {
		Name = "Hex",
		Anchor = Vector2.zero,
		Position = UDim2.fromOffset(0, rowTop),
		Size = UDim2.fromOffset(104, 26),
	})
	local hexBox = newTextBox(hexFrame, {
		Text = "#FFFFFF",
		Size = 13,
		Position = UDim2.fromOffset(8, 0),
		Bounds = UDim2.new(1, -16, 1, 0),
	})

	local copyButton = smallRecessedButton(panel, {
		Name = "Copy",
		Text = "COPY",
		Position = UDim2.fromOffset(110, rowTop),
		Size = UDim2.fromOffset(54, 26),
	})
	local pasteButton = smallRecessedButton(panel, {
		Name = "Paste",
		Text = "PASTE",
		Position = UDim2.fromOffset(170, rowTop),
		Size = UDim2.fromOffset(60, 26),
	})

	local rgbLabel = newText(panel, {
		Name = "RGB",
		Text = "255, 255, 255",
		Size = 12,
		Color = "Muted",
		AlignX = Enum.TextXAlignment.Right,
		Position = UDim2.fromOffset(236, rowTop),
		Bounds = UDim2.new(1, -236, 0, 26),
		Truncate = true,
	})

	local ColorPicker = baseElement(self, card, "ColorPicker", options, { Interactive = true })
	ColorPicker.Value = Palette.White
	ColorPicker.Open = false

	local hue, saturation, brightness = 0, 0, 1

	local function apply(silent)
		local color = Color3.fromHSV(hue, saturation, brightness)
		ColorPicker.Value = color

		swatch.BackgroundColor3 = color
		svBox.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
		svCursor.Position = UDim2.fromScale(saturation, 1 - brightness)
		hueCursor.Position = UDim2.new(hue, 0, 0.5, 0)
		hexBox.Text = "#" .. string.upper(color:ToHex())
		rgbLabel.Text = string.format(
			"%d, %d, %d",
			math.floor(color.R * 255 + 0.5),
			math.floor(color.G * 255 + 0.5),
			math.floor(color.B * 255 + 0.5)
		)

		if options.Flag then
			Library.Flags[options.Flag] = color
		end
		if not silent then
			fire(ColorPicker, options.Callback, color)
		end
	end

	function ColorPicker:Set(color, silent)
		if type(color) == "string" then
			local ok, parsed = pcall(Color3.fromHex, (string.gsub(color, "#", "")))
			color = ok and parsed or nil
		end
		if typeof(color) ~= "Color3" then
			report("ColorPicker:Set expects a Color3 or hex string")
			return
		end
		hue, saturation, brightness = color:ToHSV()
		apply(silent)
	end

	function ColorPicker:Get()
		return self.Value
	end

	function ColorPicker:SetOpen(state)
		if self.Locked then
			state = false
		end
		self.Open = state and true or false
		tween(card, 0.22, { Size = UDim2.new(1, 0, 0, self.Open and (top + panelHeight + 12) or top) }, Enum.EasingStyle.Quint)
	end

	local function unlocked()
		return not ColorPicker.Locked
	end

	ColorPicker:_cleanup(bindDrag(svBox, function(position)
		local size = svBox.AbsoluteSize
		saturation = math.clamp((position.X - svBox.AbsolutePosition.X) / math.max(size.X, 1), 0, 1)
		brightness = 1 - math.clamp((position.Y - svBox.AbsolutePosition.Y) / math.max(size.Y, 1), 0, 1)
		apply()
	end, nil, nil, unlocked))

	ColorPicker:_cleanup(bindDrag(hueArea, function(position)
		hue = math.clamp((position.X - hueBar.AbsolutePosition.X) / math.max(hueBar.AbsoluteSize.X, 1), 0, 1)
		apply()
	end, nil, nil, unlocked))

	hexBox.FocusLost:Connect(function()
		local text = string.gsub(hexBox.Text, "#", "")
		local ok, parsed = pcall(Color3.fromHex, text)
		if ok and parsed and not ColorPicker.Locked then
			ColorPicker:Set(parsed)
		else
			apply(true)
		end
	end)

	onClick(copyButton, function()
		playSound("Click")
		colorClipboard = ColorPicker.Value
		if setclipboard then
			pcall(setclipboard, "#" .. string.upper(ColorPicker.Value:ToHex()))
		end
	end)

	onClick(pasteButton, function()
		if colorClipboard and not ColorPicker.Locked then
			playSound("Click")
			ColorPicker:Set(colorClipboard)
		end
	end)

	onClick(headerButton, function()
		playSound("Click")
		ColorPicker:SetOpen(not ColorPicker.Open)
	end)

	registerOption(options.Flag, ColorPicker)
	ColorPicker:Set(options.Default or Palette.White, true)

	return ColorPicker
end

--// Progress bar
function Container:AddProgressBar(options)
	options = type(options) == "table" and options or {}

	local min = tonumber(options.Min) or 0
	local max = tonumber(options.Max) or 100
	local top = options.Description and 58 or 38
	local card = newCard(self, top + 40)

	newText(card, {
		Name = "Title",
		Text = upper(options.Name or "Progress"),
		Size = 18,
		Stroke = 2.5,
		Position = UDim2.fromOffset(14, 8),
		Bounds = UDim2.new(1, -28, 0, 22),
		Truncate = true,
	})

	if options.Description then
		newText(card, {
			Name = "Description",
			Text = upper(options.Description),
			Size = 11,
			Color = "Muted",
			Position = UDim2.fromOffset(14, 32),
			Bounds = UDim2.new(1, -28, 0, 16),
			Truncate = true,
		})
	end

	local trough = create("Frame", {
		Name = "Trough",
		Position = UDim2.fromOffset(14, top),
		Size = UDim2.new(1, -28, 0, 26),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = card,
	})
	themed(trough, "BackgroundColor3", "Trough")
	themed(addStroke(trough, Palette.Black, 2), "Color", "TroughBorder")

	local fill = create("Frame", {
		Name = "Fill",
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = trough,
	})
	local fillGradient = create("UIGradient", { Color = toGradient(options.Gradient) or Palette.GoldFill, Rotation = 90, Parent = fill })
	create("Frame", {
		Name = "Bevel",
		Position = UDim2.new(0, 0, 1, -2),
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = Palette.GoldBevel,
		BorderSizePixel = 0,
		ZIndex = 3,
		Parent = fill,
	})

	local label = newText(trough, {
		Name = "Value",
		Size = 15,
		Stroke = 2.6,
		Color = Palette.White,
		AlignX = Enum.TextXAlignment.Center,
		ZIndex = 4,
	})

	local Progress = baseElement(self, card, "ProgressBar", options)
	Progress.Value = min
	local overrideText

	function Progress:Set(value, instant)
		value = math.clamp(tonumber(value) or min, min, max)
		self.Value = value
		local alpha = max > min and (value - min) / (max - min) or 0
		tween(fill, instant and 0 or 0.25, { Size = UDim2.fromScale(alpha, 1) }, Enum.EasingStyle.Quint)

		if overrideText then
			label.Text = upper(overrideText)
		elseif options.Format then
			local ok, result = pcall(options.Format, value, alpha)
			if not ok then
				report("ProgressBar Format error: " .. tostring(result))
			end
			label.Text = ok and upper(result) or ""
		else
			label.Text = string.format("%d%%", math.floor(alpha * 100 + 0.5))
		end
	end

	function Progress:SetText(text)
		overrideText = text
		self:Set(self.Value, true)
	end

	function Progress:SetGradient(gradient)
		local sequence = toGradient(gradient)
		if sequence then
			fillGradient.Color = sequence
		end
	end

	function Progress:Get()
		return self.Value
	end

	Progress:Set(options.Default or min, true)
	return Progress
end

--// Image
function Container:AddImage(options)
	if type(options) == "string" then
		options = { Image = options }
	end
	options = type(options) == "table" and options or {}

	local card = newCard(self, clampNumber(options.Height, 140, 40, 600), true)
	local image = create("ImageLabel", {
		Name = "Image",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, -16, 1, -16),
		BackgroundTransparency = 1,
		Image = options.Image or "",
		ScaleType = Enum.ScaleType.Fit,
		Parent = card,
	})

	local Image = baseElement(self, card, "Image", options)

	function Image:Set(id)
		image.Image = id or ""
	end

	function Image:Get()
		return image.Image
	end

	return Image
end

--// Label
function Container:AddLabel(options)
	if type(options) ~= "table" then
		options = { Text = options }
	end

	local label = newText(self.Holder, {
		Name = "Label",
		Text = tostring(options.Text or ""),
		Size = options.Size or 14,
		Color = options.Color or "Muted",
		RichText = options.RichText,
		Wrapped = true,
		AutoY = true,
		Bounds = UDim2.new(1, 0, 0, 18),
		LayoutOrder = self:_nextOrder(),
	})

	local Label = baseElement(self, label, "Label", options)

	function Label:Set(value)
		label.Text = tostring(value)
	end
	Label.SetText = Label.Set

	function Label:SetColor(color)
		if typeof(color) == "Color3" then
			label.TextColor3 = color
		end
	end

	function Label:Get()
		return label.Text
	end

	return Label
end

--// Paragraph
function Container:AddParagraph(options)
	if type(options) == "string" then
		options = { Content = options }
	end
	options = type(options) == "table" and options or {}

	local card = newCard(self, 0, true)
	card.AutomaticSize = Enum.AutomaticSize.Y
	addPadding(card, 10, 12, 14, 14)
	addList(card, 4)

	local title = newText(card, {
		Name = "Title",
		Text = upper(options.Title or "Info"),
		Size = 16,
		Stroke = 2.5,
		Bounds = UDim2.new(1, 0, 0, 20),
		LayoutOrder = 1,
	})

	local content = newText(card, {
		Name = "Content",
		Text = tostring(options.Content or ""),
		Size = 13,
		Color = "Muted",
		RichText = options.RichText,
		Wrapped = true,
		AutoY = true,
		AlignY = Enum.TextYAlignment.Top,
		Bounds = UDim2.new(1, 0, 0, 0),
		LayoutOrder = 2,
	})

	local Paragraph = baseElement(self, card, "Paragraph", options)

	function Paragraph:Set(newTitle, newContent)
		if newTitle then
			title.Text = upper(newTitle)
		end
		if newContent then
			content.Text = tostring(newContent)
		end
	end

	function Paragraph:SetContent(text)
		content.Text = tostring(text)
	end
	Paragraph.SetText = Paragraph.SetContent

	return Paragraph
end

--// Stats
function Container:AddStats(options)
	options = type(options) == "table" and options or {}
	local rows = type(options.Rows) == "table" and options.Rows or {}

	local card = newCard(self, 0, true)
	card.AutomaticSize = Enum.AutomaticSize.Y
	addPadding(card, 4, 4, 0, 0)
	addList(card)

	local values = {}
	local colors = {}

	for index, key in rows do
		local row = create("Frame", {
			Name = "Row",
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundTransparency = 1,
			LayoutOrder = index,
			Parent = card,
		})

		newText(row, {
			Text = upper(key),
			Size = 14,
			Color = "Muted",
			Position = UDim2.fromOffset(14, 0),
			Bounds = UDim2.new(0.45, -14, 1, 0),
			Truncate = true,
		})

		values[key] = newText(row, {
			Text = "—",
			Size = 14,
			Dynamic = true,
			AlignX = Enum.TextXAlignment.Right,
			Anchor = Vector2.new(1, 0),
			Position = UDim2.new(1, -14, 0, 0),
			Bounds = UDim2.new(0.55, -14, 1, 0),
			Truncate = true,
		})

		if index < #rows then
			local divider = create("Frame", {
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.new(0.5, 0, 1, 0),
				Size = UDim2.new(1, -24, 0, 1),
				BackgroundTransparency = 0.6,
				BorderSizePixel = 0,
				Parent = row,
			})
			themed(divider, "BackgroundColor3", "RecessedBorder")
		end
	end

	local Stats = baseElement(self, card, "Stats", { Name = table.concat(rows, " "), Tooltip = options.Tooltip })

	function Stats:Set(key, value, color)
		local label = values[key]
		if not label then
			report("Stats has no row named '" .. tostring(key) .. "'")
			return
		end
		colors[key] = color
		label.Text = value == nil and "—" or upper(value)
		label.TextColor3 = color or Library.Theme.Text
	end

	function Stats:Get(key)
		local label = values[key]
		return label and label.Text or nil
	end

	Stats:_cleanup(addThemeHook(function()
		for key, label in values do
			if not colors[key] then
				label.TextColor3 = Library.Theme.Text
			end
		end
	end))

	return Stats
end

--// Status [NEW]
local STATUS_PRESETS = {
	online = Palette.Lime, active = Palette.Lime, ready = Palette.Lime, running = Palette.Lime, enabled = Palette.Lime, connected = Palette.Lime,
	offline = Palette.Red, error = Palette.Red, failed = Palette.Red, disabled = Palette.Red, stopped = Palette.Red, disconnected = Palette.Red,
	idle = Palette.Amber, waiting = Palette.Amber, loading = Palette.Amber, paused = Palette.Amber, busy = Palette.Amber,
}

function Container:AddStatus(options)
	options = type(options) == "table" and options or {}

	local card = newCard(self, options.Description and 62 or 48)
	addTitle(card, options.Name or "Status", options.Description, 24, 0.45)

	local pill = recessedBox(card, {
		Name = "Pill",
		Position = UDim2.new(1, -14, 0.5, 0),
		Size = UDim2.fromOffset(0, 30),
	})
	pill.AutomaticSize = Enum.AutomaticSize.X
	create("UISizeConstraint", { MaxSize = Vector2.new(200, 30), Parent = pill })
	addPadding(pill, 0, 0, 10, 12)
	local pillLayout = addList(pill, 8, Enum.FillDirection.Horizontal)
	pillLayout.VerticalAlignment = Enum.VerticalAlignment.Center

	local dot = create("Frame", {
		Name = "Dot",
		Size = UDim2.fromOffset(12, 12),
		BorderSizePixel = 0,
		LayoutOrder = 1,
		Parent = pill,
	})
	addCorner(dot, 3)
	addStroke(dot, Palette.Ink, 2)

	local statusLabel = newText(pill, {
		Name = "StatusText",
		Text = "",
		Size = 13,
		Dynamic = true,
		Bounds = UDim2.new(0, 0, 1, 0),
		AutoSize = Enum.AutomaticSize.X,
		LayoutOrder = 2,
	})

	local Status = baseElement(self, card, "Status", options)
	Status.Value = ""
	Status.Color = Palette.Lime

	function Status:SetColor(color)
		if typeof(color) ~= "Color3" then
			report("Status:SetColor expects a Color3")
			return
		end
		self.Color = color
		dot.BackgroundColor3 = color
		statusLabel.TextColor3 = color
	end

	function Status:SetStatus(text, color)
		text = tostring(text or "")
		self.Value = text
		statusLabel.Text = upper(text)
		self:SetColor(typeof(color) == "Color3" and color or STATUS_PRESETS[lower(text)] or self.Color)
	end

	function Status:Set(text, color)
		self:SetStatus(text, color)
	end

	function Status:Get()
		return self.Value, self.Color
	end

	Status:SetStatus(options.Status or "Unknown", options.Color)
	return Status
end

--// Table [NEW]
function Container:AddTable(options)
	options = type(options) == "table" and options or {}
	local height = math.floor(clampNumber(options.Height, 180, 80, 600))
	local defaultWidth = clampNumber(options.ColumnWidth, 120, 40, 600)
	local rowHeight = Library.IsMobile and 32 or 28

	local columns = {}
	local rows = {}

	local hasTitle = options.Name ~= nil
	local top = hasTitle and (options.Description and 58 or 38) or 10
	local card = newCard(self, top + height + 12)

	if hasTitle then
		newText(card, {
			Name = "Title",
			Text = upper(options.Name),
			Size = 18,
			Stroke = 2.5,
			Position = UDim2.fromOffset(14, 8),
			Bounds = UDim2.new(1, -28, 0, 22),
			Truncate = true,
		})
		if options.Description then
			newText(card, {
				Name = "Description",
				Text = upper(options.Description),
				Size = 11,
				Color = "Muted",
				Position = UDim2.fromOffset(14, 32),
				Bounds = UDim2.new(1, -28, 0, 16),
				Truncate = true,
			})
		end
	end

	local frame = recessedBox(card, {
		Name = "Grid",
		Anchor = Vector2.zero,
		Position = UDim2.fromOffset(12, top),
		Size = UDim2.new(1, -24, 0, height),
	})
	frame.ClipsDescendants = true

	local scroller = create("ScrollingFrame", {
		Name = "Scroller",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = Library.IsMobile and 6 or 5,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.XY,
		ScrollingDirection = Enum.ScrollingDirection.XY,
		Parent = frame,
	})
	themed(scroller, "ScrollBarImageColor3", "Accent")

	local content = create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent = scroller,
	})
	local contentConstraint = create("UISizeConstraint", { Parent = content })
	addList(content)

	local headerRow, emptyLabel

	local function totalWidth()
		local total = 0
		for _, column in columns do
			total += column.Width
		end
		return math.max(total, 1)
	end

	local function makeCells(rowFrame, values, isHeader)
		local total = totalWidth()
		local x = 0
		local cells = {}
		for index, column in columns do
			local cell = newText(rowFrame, {
				Name = "Cell" .. index,
				Text = values[index] ~= nil and (isHeader and upper(values[index]) or tostring(values[index])) or "",
				Size = isHeader and 12 or 13,
				Color = isHeader and "Muted" or "Text",
				Stroke = isHeader and 2 or 1.5,
				Position = UDim2.new(x / total, 8, 0, 0),
				Bounds = UDim2.new(column.Width / total, -12, 1, 0),
				AlignX = column.Align or Enum.TextXAlignment.Left,
				Truncate = true,
			})
			cells[index] = cell
			x += column.Width
		end
		return cells
	end

	local function rowValues(row)
		local values = {}
		if type(row) ~= "table" then
			values[1] = row
			return values
		end
		for index, column in columns do
			local value = row[index]
			if value == nil then
				value = row[column.Key]
			end
			values[index] = value
		end
		return values
	end

	local function paintRow(record, index)
		record.Frame.LayoutOrder = index + 1
		record.Frame.BackgroundTransparency = index % 2 == 0 and 0.6 or 1
	end

	local function renderRow(index)
		local record = rows[index]
		if record.Frame then
			record.Frame:Destroy()
		end
		local rowFrame = create("Frame", {
			Name = "Row",
			Size = UDim2.new(1, 0, 0, rowHeight),
			BorderSizePixel = 0,
			Parent = content,
		})
		themed(rowFrame, "BackgroundColor3", "Card")
		record.Frame = rowFrame
		record.Cells = makeCells(rowFrame, rowValues(record.Data), false)
		paintRow(record, index)
	end

	local function updateEmpty()
		emptyLabel.Visible = #rows == 0
	end

	local function rebuild()
		for _, child in content:GetChildren() do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end

		contentConstraint.MinSize = Vector2.new(totalWidth() + 8, 0)

		headerRow = create("Frame", {
			Name = "HeaderRow",
			Size = UDim2.new(1, 0, 0, rowHeight),
			BackgroundTransparency = 0.2,
			BorderSizePixel = 0,
			LayoutOrder = 0,
			Parent = content,
		})
		themed(headerRow, "BackgroundColor3", "Background")
		local headerValues = {}
		for index, column in columns do
			headerValues[index] = column.Name
		end
		makeCells(headerRow, headerValues, true)

		emptyLabel = create("Frame", {
			Name = "Empty",
			Size = UDim2.new(1, 0, 0, rowHeight),
			BackgroundTransparency = 1,
			LayoutOrder = 1000000,
			Parent = content,
		})
		newText(emptyLabel, { Text = "NO DATA", Size = 12, Color = "Muted", AlignX = Enum.TextXAlignment.Center })

		for index, record in rows do
			record.Frame = nil
			renderRow(index)
		end
		updateEmpty()
	end

	local Table = baseElement(self, card, "Table", options)

	function Table:SetColumns(newColumns)
		table.clear(columns)
		if type(newColumns) ~= "table" then
			report("Table:SetColumns expects a table")
			newColumns = {}
		end
		for _, column in newColumns do
			if type(column) == "table" then
				local name = tostring(column.Name or column[1] or "")
				table.insert(columns, {
					Name = name,
					Key = column.Key or name,
					Width = clampNumber(column.Width, defaultWidth, 30, 800),
					Align = column.Align,
				})
			else
				table.insert(columns, { Name = tostring(column), Key = tostring(column), Width = defaultWidth })
			end
		end
		rebuild()
	end

	function Table:SetRows(newRows)
		for _, record in rows do
			if record.Frame then
				record.Frame:Destroy()
			end
		end
		table.clear(rows)
		if type(newRows) == "table" then
			for _, row in newRows do
				table.insert(rows, { Data = row })
				renderRow(#rows)
			end
		end
		updateEmpty()
	end
	Table.Set = Table.SetRows

	function Table:AddRow(row)
		table.insert(rows, { Data = row })
		renderRow(#rows)
		updateEmpty()
		return #rows
	end

	function Table:UpdateRow(index, row)
		local record = rows[index]
		if not record then
			report("Table:UpdateRow - no row at index " .. tostring(index))
			return false
		end
		record.Data = row
		local values = rowValues(row)
		for cellIndex, cell in record.Cells do
			cell.Text = values[cellIndex] ~= nil and tostring(values[cellIndex]) or ""
		end
		return true
	end

	function Table:RemoveRow(index)
		local record = table.remove(rows, index)
		if not record then
			return false
		end
		if record.Frame then
			record.Frame:Destroy()
		end
		for i = index, #rows do
			paintRow(rows[i], i)
		end
		updateEmpty()
		return true
	end

	function Table:Clear()
		self:SetRows({})
	end

	function Table:GetRows()
		local out = {}
		for _, record in rows do
			table.insert(out, record.Data)
		end
		return out
	end
	Table.Get = Table.GetRows

	function Table:Refresh()
		rebuild()
	end

	Table:SetColumns(options.Columns or { "Name", "Value" })
	if type(options.Rows) == "table" then
		Table:SetRows(options.Rows)
	end

	return Table
end

--// Divider
function Container:AddDivider()
	local holder = create("Frame", {
		Name = "Divider",
		Size = UDim2.new(1, 0, 0, 8),
		BackgroundTransparency = 1,
		LayoutOrder = self:_nextOrder(),
		Parent = self.Holder,
	})

	themed(create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		Size = UDim2.new(1, 0, 0, 3),
		BorderSizePixel = 0,
		Parent = holder,
	}), "BackgroundColor3", "Border")

	return baseElement(self, holder, "Divider", {})
end

--// File helpers
local function sanitizeName(name)
	if type(name) ~= "string" and type(name) ~= "number" then
		return nil
	end
	name = trim(tostring(name))
	name = string.gsub(name, '[\\/:%*%?"<>|]', "")
	if name == "" or #name > 60 then
		return nil
	end
	return name
end

local function canWriteFiles()
	return writefile ~= nil and makefolder ~= nil and isfolder ~= nil
end

local function ensureFolder(path)
	if not isfolder(path) then
		makefolder(path)
	end
end

local function windowStatePath(key)
	return Library.Folder .. "/windows/" .. key .. ".json"
end

local function readWindowState(key)
	if not (readfile and isfile) then
		return nil
	end
	local ok, data = pcall(function()
		local path = windowStatePath(key)
		if isfile(path) then
			return HttpService:JSONDecode(readfile(path))
		end
		return nil
	end)
	return ok and type(data) == "table" and data or nil
end

local function writeWindowState(key, data)
	if not canWriteFiles() then
		return
	end
	local ok, err = pcall(function()
		ensureFolder(Library.Folder)
		ensureFolder(Library.Folder .. "/windows")
		writefile(windowStatePath(key), HttpService:JSONEncode(data))
	end)
	if not ok then
		report("Couldn't save window state: " .. tostring(err))
	end
end

--// Intro splash
local function playIntro(title, text, onDone)
	local gui = getGui()
	local reduced = Library.ReducedAnimations

	local holder = create("Frame", {
		Name = "Intro",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(380, 170),
		BackgroundTransparency = 1,
		ZIndex = 200,
		Parent = gui,
	})
	local scale = create("UIScale", { Scale = 0.01, Parent = holder })

	local sunburst = create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(620, 620),
		BackgroundTransparency = 1,
		Image = Assets.Sunburst,
		ImageTransparency = 0.4,
		ScaleType = Enum.ScaleType.Fit,
		Visible = Library.SunburstEnabled,
		ZIndex = 0,
		Parent = holder,
	})
	themed(sunburst, "ImageColor3", "TopHighlight")

	local card = create("Frame", {
		Size = UDim2.fromScale(1, 1),
		BorderSizePixel = 0,
		ZIndex = 1,
		Parent = holder,
	})
	themed(card, "BackgroundColor3", "Background")
	addCorner(card, 4)
	themed(addStroke(card, Palette.Black, 3.5), "Color", "Border")

	local header = create("Frame", {
		Size = UDim2.new(1, 0, 0, 56),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		Parent = card,
	})
	addCorner(header, 4)
	themeGradient(create("UIGradient", { Parent = header }))
	themed(create("Frame", {
		Position = UDim2.new(0, 0, 1, -6),
		Size = UDim2.new(1, 0, 0, 3),
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = header,
	}), "BackgroundColor3", "DivDark")
	create("Frame", {
		Position = UDim2.new(0, 0, 1, -3),
		Size = UDim2.new(1, 0, 0, 3),
		BackgroundColor3 = Palette.Black,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = header,
	})

	newText(header, {
		Text = upper(title),
		Size = 26,
		Stroke = 3.5,
		Color = Palette.White,
		AlignX = Enum.TextXAlignment.Center,
		Bounds = UDim2.new(1, -20, 1, -6),
		Position = UDim2.fromOffset(10, 0),
		Truncate = true,
		ZIndex = 3,
	})

	newText(card, {
		Text = upper(text or ("Loading v" .. Library.Version .. "...")),
		Size = 14,
		Color = "Muted",
		AlignX = Enum.TextXAlignment.Center,
		Position = UDim2.fromOffset(0, 66),
		Bounds = UDim2.new(1, 0, 0, 20),
	})

	local trough = create("Frame", {
		Position = UDim2.new(0, 20, 1, -54),
		Size = UDim2.new(1, -40, 0, 30),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = card,
	})
	themed(trough, "BackgroundColor3", "Trough")
	themed(addStroke(trough, Palette.Black, 2), "Color", "TroughBorder")

	local fill = create("Frame", {
		Size = UDim2.fromScale(0, 1),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = trough,
	})
	create("UIGradient", { Color = Palette.GoldFill, Rotation = 90, Parent = fill })

	local percent = newText(trough, {
		Text = "0%",
		Size = 16,
		Stroke = 2.6,
		Color = Palette.White,
		AlignX = Enum.TextXAlignment.Center,
		ZIndex = 3,
	})

	local progress = create("NumberValue", { Value = 0 })
	progress.Changed:Connect(function(value)
		percent.Text = string.format("%d%%", math.floor(value * 100 + 0.5))
		fill.Size = UDim2.fromScale(value, 1)
	end)

	if not reduced and Library.SunburstAnimated then
		bindStep("IntroSunburst", function(dt)
			sunburst.Rotation = (sunburst.Rotation + SUNBURST_SPEED * dt) % 360
		end)
	end

	task.spawn(function()
		tween(scale, 0.4, { Scale = getDeviceScale() }, Enum.EasingStyle.Back)
		task.wait(reduced and 0.05 or 0.35)
		local t = tween(progress, reduced and 0.3 or 1.3, { Value = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, true)
		t.Completed:Wait()
		task.wait(reduced and 0.05 or 0.25)
		local out = tween(scale, 0.25, { Scale = 0.01 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
		out.Completed:Wait()
		unbindStep("IntroSunburst")
		holder:Destroy()
		progress:Destroy()
		if not Library.Unloaded then
			onDone()
		end
	end)
end

--// Window
local buildSettingsTab

function Library:CreateWindow(options)
	options = type(options) == "table" and options or {}

	if options.ForceMobile ~= nil then
		self.IsMobile = options.ForceMobile == true
	end
	if options.Theme ~= nil then
		self:SetTheme(options.Theme)
	end

	local gui = getGui()
	local windowId = #self.Windows + 1
	local titleText = tostring(options.Title or self.Name)

	local minWidth = clampNumber(options.MinWidth, 460, 300, 2400)
	local maxWidth = math.max(minWidth, clampNumber(options.MaxWidth, 1200, 300, 2400))
	local minHeight = clampNumber(options.MinHeight, 320, 200, 1600)
	local maxHeight = math.max(minHeight, clampNumber(options.MaxHeight, 800, 200, 1600))
	local defaultWidth = clampNumber(options.Width, 600, 300, 2400)
	local defaultHeight = clampNumber(options.Height, 440, 200, 1600)

	if options.MobileTabMode ~= nil and not TAB_MODES[options.MobileTabMode] then
		report("MobileTabMode must be Sidebar, BottomBar or Dropdown (got " .. tostring(options.MobileTabMode) .. ")")
	end

	local remember = {
		Position = options.RememberPosition == true,
		Size = options.RememberSize == true,
		Minimized = options.RememberMinimizedState == true,
	}
	local rememberAny = remember.Position or remember.Size or remember.Minimized
	local saveKey = sanitizeName(options.SaveKey or titleText) or ("window" .. windowId)
	local saved = rememberAny and readWindowState(saveKey) or nil

	local Window = {
		Theme = self.Theme,
		Tabs = {},
		ActiveTab = nil,
		Visible = false,
		Minimized = false,
		MinimizedToButton = false,
		ToggleKey = options.ToggleKey or Enum.KeyCode.RightShift,
		Resizable = options.Resizable == true,
		MinWidth = minWidth,
		MaxWidth = maxWidth,
		MinHeight = minHeight,
		MaxHeight = maxHeight,
		BaseWidth = defaultWidth,
		BaseHeight = defaultHeight,
		MobileSidebar = options.MobileSidebar ~= false,
		MobileTabMode = TAB_MODES[options.MobileTabMode] and options.MobileTabMode or "Sidebar",
		SidebarOpen = true,
		Compact = false,
		Profile = nil,
		_query = "",
		_scale = 1,
		_width = defaultWidth,
		_height = defaultHeight,
		_pos = nil,
		_floatingEnabled = false,
	}
	table.insert(self.Windows, Window)

	if saved and remember.Size and tonumber(saved.Width) and tonumber(saved.Height) then
		Window.BaseWidth = math.clamp(tonumber(saved.Width), minWidth, maxWidth)
		Window.BaseHeight = math.clamp(tonumber(saved.Height), minHeight, maxHeight)
	end

	local floatingEnabled = options.MobileButton
	if floatingEnabled == nil then
		floatingEnabled = self.IsMobile
	end
	Window._floatingEnabled = floatingEnabled == true
	local buttonSnap = options.MinimizeButtonSnap == true
	Window.ButtonSnap = buttonSnap

	--// Root
	local Holder = create("Frame", {
		Name = "Window",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromOffset(Window.BaseWidth, Window.BaseHeight),
		BackgroundTransparency = 1,
		Visible = false,
		Parent = gui,
	})
	local WindowScale = create("UIScale", { Name = "WindowScale", Scale = 0.01, Parent = Holder })
	Window.Instance = Holder

	local Sunburst
	if options.Sunburst ~= false then
		local size = math.max(Window.BaseWidth, Window.BaseHeight) * 1.6
		Sunburst = create("ImageLabel", {
			Name = "Sunburst",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(size, size),
			BackgroundTransparency = 1,
			Image = Assets.Sunburst,
			ImageTransparency = 0.45,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 0,
			Parent = Holder,
		})
		themed(Sunburst, "ImageColor3", "TopHighlight")
	end

	local Main = create("Frame", {
		Name = "Main",
		Size = UDim2.fromScale(1, 1),
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = Holder,
	})
	themed(Main, "BackgroundColor3", "Background")
	addCorner(Main, 4)
	themed(addStroke(Main, Palette.Black, 3.5), "Color", "Border")

	--// Header
	local Header = create("Frame", {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, HEADER_HEIGHT),
		BackgroundColor3 = Palette.White,
		BorderSizePixel = 0,
		ZIndex = 2,
		Parent = Main,
	})
	addCorner(Header, 4)
	themeGradient(create("UIGradient", { Parent = Header }))

	local headerDamier = create("ImageLabel", {
		Name = "Damier",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = Assets.Damier,
		ScaleType = Enum.ScaleType.Tile,
		TileSize = UDim2.fromOffset(24, 24),
		ZIndex = 3,
		Parent = Header,
	})
	themed(headerDamier, "ImageColor3", "Damier")
	create("UIGradient", {
		Rotation = 90,
		Transparency = NumberSequence.new({ nkp(0, 1), nkp(0.33, 0.82), nkp(0.66, 0.35), nkp(1, 0.1) }),
		Parent = headerDamier,
	})

	themed(create("Frame", {
		Name = "TopHighlight",
		Position = UDim2.fromOffset(4, 2),
		Size = UDim2.new(1, -8, 0, 2),
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = Header,
	}), "BackgroundColor3", "TopHighlight")

	themed(create("Frame", {
		Name = "DividerAccent",
		Position = UDim2.new(0, 0, 1, -6),
		Size = UDim2.new(1, 0, 0, 3),
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = Header,
	}), "BackgroundColor3", "DivDark")

	create("Frame", {
		Name = "DividerShadow",
		Position = UDim2.new(0, 0, 1, -3),
		Size = UDim2.new(1, 0, 0, 3),
		BackgroundColor3 = Palette.Black,
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = Header,
	})

	local rightButtons = options.MinimizeToButton and 3 or 2
	local titleReserve = 34 + 46 * (rightButtons - 1) + 30

	local TitleLabel = newText(Header, {
		Name = "Title",
		Text = upper(titleText),
		Size = 26,
		Stroke = 3.5,
		Color = Palette.White,
		Position = UDim2.fromOffset(18, 6),
		Bounds = UDim2.new(1, -(18 + titleReserve), 0, 30),
		Truncate = true,
		ZIndex = 5,
	})

	local SubtitleLabel = newText(Header, {
		Name = "Subtitle",
		Text = upper(options.Subtitle or (self.Name .. " · v" .. self.Version)),
		Size = 12,
		Stroke = 2,
		Color = "TopHighlight",
		Position = UDim2.fromOffset(18, 34),
		Bounds = UDim2.new(1, -(18 + titleReserve), 0, 16),
		Truncate = true,
		ZIndex = 5,
	})

	local CloseButton = createBevelSquare(Header, {
		Name = "CloseButton",
		Position = UDim2.new(1, -34, 0.5, -3),
		Text = "X",
		Base = rgb(115, 0, 16),
		Face = ColorSequence.new(rgb(255, 125, 175), rgb(255, 20, 40)),
		Highlight = rgb(255, 210, 235),
		Sep = rgb(70, 0, 10),
	})
	attachTooltip(CloseButton, function()
		return "Close"
	end)

	local MinimizeButton, MinimizeLabel = createBevelSquare(Header, {
		Name = "MinimizeButton",
		Position = UDim2.new(1, -80, 0.5, -3),
		Text = "-",
		Base = rgb(153, 76, 0),
		Face = ButtonStyles.Skip,
		Highlight = rgb(255, 240, 160),
		Sep = rgb(110, 50, 0),
	})
	attachTooltip(MinimizeButton, function()
		return Window.Minimized and "Expand" or "Collapse"
	end)

	local ToButtonButton
	if options.MinimizeToButton then
		ToButtonButton = createBevelSquare(Header, {
			Name = "MinimizeToButton",
			Position = UDim2.new(1, -126, 0.5, -3),
			Text = "v",
			TextSize = 24,
			Base = rgb(0, 50, 110),
			Face = ButtonStyles.Codes,
			Highlight = rgb(180, 240, 255),
			Sep = rgb(0, 30, 80),
		})
		attachTooltip(ToButtonButton, function()
			return "Minimize to button"
		end)
	end

	-- Hamburger (compact layouts with a collapsible sidebar)
	local SidebarButton, _, sidebarFaceGradient, sidebarFace = createBevelSquare(Header, {
		Name = "SidebarButton",
		Position = UDim2.new(0, 32, 0.5, -3),
		Text = "",
		Face = self.Theme.Gradient,
		Highlight = Palette.White,
		HighlightTransparency = 0.4,
	})
	themed(SidebarButton, "BackgroundColor3", "DivDark")
	themeGradient(sidebarFaceGradient)
	for index = 1, 3 do
		local bar = create("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.25 + (index - 1) * 0.25, 0),
			Size = UDim2.fromOffset(18, 3),
			BackgroundColor3 = Palette.White,
			BorderSizePixel = 0,
			ZIndex = SidebarButton.ZIndex + 3,
			Parent = sidebarFace,
		})
		addStroke(bar, Palette.Black, 1)
	end
	SidebarButton.Visible = false
	attachTooltip(SidebarButton, function()
		return "Tabs"
	end)

	--// Body
	local Body = create("Frame", {
		Name = "Body",
		Position = UDim2.fromOffset(0, HEADER_HEIGHT),
		Size = UDim2.new(1, 0, 1, -HEADER_HEIGHT),
		BackgroundTransparency = 1,
		ZIndex = 2,
		Parent = Main,
	})

	local Sidebar = create("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, SIDEBAR_WIDTH, 1, 0),
		BackgroundTransparency = 1,
		Parent = Body,
	})

	local searchFrame, searchStroke = recessedBox(Sidebar, {
		Name = "Search",
		Anchor = Vector2.zero,
		Position = UDim2.fromOffset(10, 12),
		Size = UDim2.fromOffset(SIDEBAR_WIDTH - 18, 32),
	})
	local SearchBox = newTextBox(searchFrame, { Placeholder = "Search...", Size = 13 })

	local TabList = create("ScrollingFrame", {
		Name = "Tabs",
		Position = UDim2.fromOffset(0, 50),
		Size = UDim2.new(1, 0, 1, -50),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = Sidebar,
	})
	addPadding(TabList, 6, 12, 10, 8)
	addList(TabList, 6)

	local SidebarDivider = themed(create("Frame", {
		Name = "SidebarDivider",
		Position = UDim2.fromOffset(SIDEBAR_WIDTH, 0),
		Size = UDim2.new(0, 3, 1, 0),
		BorderSizePixel = 0,
		Parent = Body,
	}), "BackgroundColor3", "Border")

	-- Top bar (search + tab picker when the sidebar is hidden)
	local TopBar = create("Frame", {
		Name = "TopBar",
		Size = UDim2.new(1, 0, 0, 50),
		BackgroundTransparency = 1,
		Visible = false,
		ZIndex = 3,
		Parent = Body,
	})

	local TabPicker = recessedBox(TopBar, {
		Class = "TextButton",
		Name = "TabPicker",
		Anchor = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.new(0.5, -15, 0, 34),
		ZIndex = 3,
	})
	bindRecessedHover(TabPicker)
	local tabPickerLabel = newText(TabPicker, {
		Name = "Label",
		Text = "TABS",
		Size = 14,
		Position = UDim2.fromOffset(10, 0),
		Bounds = UDim2.new(1, -36, 1, 0),
		Truncate = true,
		ZIndex = 4,
	})
	local tabPickerArrow = newText(TabPicker, {
		Name = "Arrow",
		Text = ">",
		Size = 16,
		AlignX = Enum.TextXAlignment.Center,
		Anchor = Vector2.new(0.5, 0.5),
		Position = UDim2.new(1, -14, 0.5, 0),
		Bounds = UDim2.fromOffset(16, 16),
		ZIndex = 4,
	})
	tabPickerArrow.Rotation = 90

	local topSearchFrame, topSearchStroke = recessedBox(TopBar, {
		Name = "Search",
		Anchor = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		Size = UDim2.new(1, -20, 0, 34),
		ZIndex = 3,
	})
	local TopSearchBox = newTextBox(topSearchFrame, { Placeholder = "Search...", Size = 13, ZIndex = 4 })

	-- Tab menu (Dropdown tab mode)
	local TabMenu = create("Frame", {
		Name = "TabMenu",
		Position = UDim2.fromOffset(10, 46),
		Size = UDim2.new(0.5, -15, 0, 0),
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 60,
		Parent = Body,
	})
	themed(TabMenu, "BackgroundColor3", "Background")
	addCorner(TabMenu, 4)
	themed(addStroke(TabMenu, Palette.Black, 3), "Color", "Border")

	local TabMenuList = create("ScrollingFrame", {
		Name = "List",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ZIndex = 61,
		Parent = TabMenu,
	})
	themed(TabMenuList, "ScrollBarImageColor3", "Accent")
	addPadding(TabMenuList, 6, 6, 6, 10)
	addList(TabMenuList, 6)

	-- Bottom bar (BottomBar tab mode)
	local BottomBar = create("Frame", {
		Name = "BottomBar",
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 58),
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 3,
		Parent = Body,
	})
	themed(BottomBar, "BackgroundColor3", "Background")
	themed(create("Frame", {
		Size = UDim2.new(1, 0, 0, 3),
		BorderSizePixel = 0,
		ZIndex = 4,
		Parent = BottomBar,
	}), "BackgroundColor3", "Border")

	local BottomTabs = create("ScrollingFrame", {
		Name = "Tabs",
		Position = UDim2.fromOffset(0, 3),
		Size = UDim2.new(1, 0, 1, -3),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.X,
		ScrollingDirection = Enum.ScrollingDirection.X,
		ZIndex = 4,
		Parent = BottomBar,
	})
	addPadding(BottomTabs, 0, 0, 8, 8)
	local bottomLayout = addList(BottomTabs, 6, Enum.FillDirection.Horizontal)
	bottomLayout.VerticalAlignment = Enum.VerticalAlignment.Center

	local Pages = create("Frame", {
		Name = "Pages",
		Position = UDim2.fromOffset(SIDEBAR_WIDTH + 3, 0),
		Size = UDim2.new(1, -(SIDEBAR_WIDTH + 3), 1, 0),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = Body,
	})

	-- Resize grip
	local ResizeGrip
	if Window.Resizable then
		local gripSize = self.IsMobile and 34 or 22
		ResizeGrip = create("TextButton", {
			Name = "ResizeGrip",
			Text = "",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -2, 1, -2),
			Size = UDim2.fromOffset(gripSize, gripSize),
			ZIndex = 30,
			Parent = Main,
		})
		for row = 0, 2 do
			for column = 0, 2 - row do
				local dot = create("Frame", {
					AnchorPoint = Vector2.new(1, 1),
					Position = UDim2.new(1, -3 - column * 6, 1, -3 - row * 6),
					Size = UDim2.fromOffset(4, 4),
					BorderSizePixel = 0,
					ZIndex = 31,
					Parent = ResizeGrip,
				})
				themed(dot, "BackgroundColor3", "TopHighlight")
				addStroke(dot, Palette.Ink, 1)
			end
		end
		attachTooltip(ResizeGrip, function()
			return "Drag to resize"
		end)
	end

	--// State helpers
	local saveToken = 0
	local floating = nil

	local function saveState()
		if not rememberAny then
			return
		end
		saveToken += 1
		local token = saveToken
		task.delay(0.4, function()
			if token ~= saveToken or Library.Unloaded or not Window._pos then
				return
			end
			local data = {}
			if remember.Position then
				data.X, data.Y = Window._pos.X, Window._pos.Y
				if floating and floating.Center then
					data.ButtonX, data.ButtonY = floating.Center.X, floating.Center.Y
				end
			end
			if remember.Size then
				data.Width, data.Height = Window.BaseWidth, Window.BaseHeight
			end
			if remember.Minimized then
				data.Minimized = Window.Minimized
				data.MinimizedToButton = Window.MinimizedToButton
			end
			writeWindowState(saveKey, data)
		end)
	end

	local function initialPosition(ignoreSaved)
		local screen = getScreenSize()
		if not ignoreSaved and saved and remember.Position and tonumber(saved.X) and tonumber(saved.Y) then
			return Vector2.new(tonumber(saved.X), tonumber(saved.Y))
		end
		local position = typeof(options.Position) == "UDim2" and options.Position or UDim2.fromScale(0.5, 0.5)
		local centerX = screen.X * position.X.Scale + position.X.Offset
		local centerY = screen.Y * position.Y.Scale + position.Y.Offset
		return Vector2.new(centerX, centerY - Window._height * Window._scale / 2)
	end

	local function applyPosition(animate)
		local height = (Window.Minimized and HEADER_HEIGHT or Window._height) * Window._scale
		local goal = UDim2.fromOffset(Window._pos.X, Window._pos.Y + height / 2)
		if animate then
			tween(Holder, 0.25, { Position = goal }, Enum.EasingStyle.Quint)
		else
			Holder.Position = goal
		end
	end

	function Window:_clampPosition(animate)
		local screen = getScreenSize()
		local width = self._width * self._scale
		local height = self._height * self._scale
		local margin = self.Compact and 4 or 8
		local x = math.clamp(self._pos.X, width / 2 + margin, math.max(width / 2 + margin, screen.X - width / 2 - margin))
		local y = math.clamp(self._pos.Y, margin, math.max(margin, screen.Y - height - margin))
		self._pos = Vector2.new(x, y)
		applyPosition(animate)
	end

	local function setTabMenuOpen(open)
		TabMenu.Visible = open
		local rowHeight = Library.IsMobile and 40 or 32
		local count = math.min(#Window.Tabs, 6)
		TabMenu.Size = UDim2.new(0.5, -15, 0, count * (rowHeight + 6) + 12)
		tween(tabPickerArrow, 0.2, { Rotation = open and -90 or 90 }, Enum.EasingStyle.Quint)
	end

	local function applyBodyLayout()
		local mode = Window.Compact and Window.MobileTabMode or "Sidebar"
		local collapsible = mode == "Sidebar" and Window.Compact and Window.MobileSidebar
		local sidebarVisible = mode == "Sidebar" and (not collapsible or Window.SidebarOpen)
		local topBarVisible = not sidebarVisible
		local bottomBarVisible = mode == "BottomBar"

		Sidebar.Visible = sidebarVisible
		SidebarDivider.Visible = sidebarVisible
		TopBar.Visible = topBarVisible
		BottomBar.Visible = bottomBarVisible
		TabPicker.Visible = mode == "Dropdown"
		if mode ~= "Dropdown" then
			setTabMenuOpen(false)
		end

		if mode == "Dropdown" then
			topSearchFrame.Size = UDim2.new(0.5, -15, 0, 34)
		else
			topSearchFrame.Size = UDim2.new(1, -20, 0, 34)
		end

		local left = sidebarVisible and SIDEBAR_WIDTH + 3 or 0
		local top = topBarVisible and 50 or 0
		local bottom = bottomBarVisible and 58 or 0
		TopBar.Position = UDim2.fromOffset(left, 0)
		TopBar.Size = UDim2.new(1, -left, 0, 50)
		Pages.Position = UDim2.fromOffset(left, top)
		Pages.Size = UDim2.new(1, -left, 1, -(top + bottom))

		SidebarButton.Visible = collapsible
		local titleLeft = collapsible and 62 or 18
		TitleLabel.Position = UDim2.fromOffset(titleLeft, 6)
		TitleLabel.Size = UDim2.new(1, -(titleLeft + titleReserve), 0, 30)
		SubtitleLabel.Position = UDim2.fromOffset(titleLeft, 34)
		SubtitleLabel.Size = UDim2.new(1, -(titleLeft + titleReserve), 0, 16)
	end

	function Window:_layout(animateSize, skipScale)
		local screen = getScreenSize()
		local profile, compact = getProfile(screen)
		local profileChanged = profile ~= self.Profile
		self.Profile, self.Compact = profile, compact

		local margin = compact and 8 or 16
		local availableWidth = math.max(200, screen.X - margin * 2)
		local availableHeight = math.max(200, screen.Y - margin * 2)

		local scale
		if compact then
			local phone = profile == "PhonePortrait" or profile == "PhoneLandscape"
			scale = Library.UIScale * (phone and 0.88 or 0.96)
		else
			scale = math.min(getDeviceScale(), availableWidth / self.BaseWidth, availableHeight / self.BaseHeight)
		end
		scale = math.max(scale, 0.4)

		local width = math.min(self.BaseWidth, availableWidth / scale)
		local height = math.min(self.BaseHeight, availableHeight / scale)
		self._scale, self._width, self._height = scale, width, height

		if profileChanged and compact and self.MobileSidebar then
			self.SidebarOpen = width >= 520
		end

		local targetHeight = self.Minimized and HEADER_HEIGHT or height
		if animateSize then
			tween(Holder, 0.25, { Size = UDim2.fromOffset(width, targetHeight) }, Enum.EasingStyle.Quint)
		else
			Holder.Size = UDim2.fromOffset(width, targetHeight)
		end
		if self.Visible and not skipScale then
			WindowScale.Scale = scale
		end

		applyBodyLayout()
		if not self._pos then
			self._pos = initialPosition()
		end
		self:_clampPosition(animateSize)
	end

	--// Floating button (minimize-to-button + mobile toggle)
	local function ensureFloating()
		if floating then
			return floating
		end
		local position = options.MinimizeButtonPosition
		if saved and remember.Position and tonumber(saved.ButtonX) and tonumber(saved.ButtonY) then
			position = Vector2.new(tonumber(saved.ButtonX), tonumber(saved.ButtonY))
		end
		floating = createFloatingButton({
			Name = "WindowButton",
			Text = options.MinimizeButtonText or options.MobileButtonText or "RS",
			Size = options.MinimizeButtonSize,
			Position = position,
			Snap = buttonSnap,
			OnClick = function()
				if Window.MinimizedToButton then
					Window:SetMinimizedToButton(false)
				else
					Window:Toggle()
				end
			end,
			OnMoved = saveState,
		})
		Window.FloatingButton = floating
		Window.MobileButton = floating.Button
		return floating
	end

	local function updateFloating()
		local show = Window.MinimizedToButton or Window._floatingEnabled
		if show then
			ensureFloating():SetVisible(true)
		elseif floating then
			floating:SetVisible(false)
		end
	end

	local function refreshEffects()
		if not Sunburst then
			return
		end
		Sunburst.Visible = Library.SunburstEnabled
		local key = "Sunburst" .. windowId
		if Window.Visible and Library.SunburstEnabled and Library.SunburstAnimated and not Library.ReducedAnimations then
			bindStep(key, function(dt)
				Sunburst.Rotation = (Sunburst.Rotation + SUNBURST_SPEED * dt) % 360
			end)
		else
			unbindStep(key)
		end
	end
	Window._refreshEffects = refreshEffects

	local function closePopups()
		hideTooltip()
		setTabMenuOpen(false)
		if openDropdown and openDropdown.Instance:IsDescendantOf(Holder) then
			openDropdown:SetOpen(false)
		end
		if Library._activeBinder then
			Library._activeBinder:Cancel()
		end
	end

	--// Window API
	function Window:SetVisible(visible, onComplete)
		visible = visible and true or false
		if visible and self.MinimizedToButton then
			self.MinimizedToButton = false
			saveState()
		end
		self.Visible = visible

		if visible then
			if not Holder.Visible then
				WindowScale.Scale = 0.01
			end
			Holder.Visible = true
			self:_layout(false, true)
			tween(WindowScale, 0.35, { Scale = self._scale }, Enum.EasingStyle.Back)
			if onComplete then
				task.delay(Library.ReducedAnimations and 0 or 0.35, onComplete)
			end
		else
			closePopups()
			local t = tween(WindowScale, 0.2, { Scale = 0.01 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			t.Completed:Once(function()
				if not self.Visible then
					Holder.Visible = false
				end
				if onComplete then
					onComplete()
				end
			end)
		end

		refreshEffects()
		updateFloating()
	end

	function Window:Toggle()
		if self.MinimizedToButton then
			self:SetMinimizedToButton(false)
		else
			self:SetVisible(not self.Visible)
		end
	end

	function Window:SetMinimized(state)
		self.Minimized = state and true or false
		MinimizeLabel.Text = self.Minimized and "+" or "-"
		if ResizeGrip then
			ResizeGrip.Visible = not self.Minimized
		end
		if self.Minimized then
			closePopups()
		end
		tween(Holder, 0.25, {
			Size = UDim2.fromOffset(self._width, self.Minimized and HEADER_HEIGHT or self._height),
		}, Enum.EasingStyle.Quint)
		if self._pos then
			applyPosition(true)
		end
		saveState()
	end

	function Window:SetMinimizedToButton(state)
		state = state and true or false
		if state == self.MinimizedToButton then
			return
		end
		if state then
			self.MinimizedToButton = true
			ensureFloating()
			self:SetVisible(false)
		else
			self.MinimizedToButton = false
			self:SetVisible(true)
		end
		updateFloating()
		saveState()
	end

	function Window:ToggleMinimizedToButton()
		self:SetMinimizedToButton(not self.MinimizedToButton)
	end

	function Window:SetFloatingButton(enabled)
		self._floatingEnabled = enabled and true or false
		updateFloating()
	end

	function Window:SetButtonSnap(enabled)
		buttonSnap = enabled and true or false
		self.ButtonSnap = buttonSnap
		if floating then
			floating:SetSnap(buttonSnap)
		end
	end

	function Window:SetTitle(title, subtitle)
		if title then
			TitleLabel.Text = upper(title)
		end
		if subtitle then
			SubtitleLabel.Text = upper(subtitle)
		end
	end

	function Window:SetToggleKey(key)
		if key ~= nil and typeof(key) ~= "EnumItem" then
			report("SetToggleKey expects a KeyCode")
			return
		end
		self.ToggleKey = key
	end

	function Window:SetTheme(name)
		return Library:SetTheme(name)
	end

	function Window:Center()
		local screen = getScreenSize()
		self._pos = Vector2.new(screen.X / 2, screen.Y / 2 - self._height * self._scale / 2)
		self:_clampPosition(true)
		saveState()
	end

	function Window:ResetPosition()
		self._pos = initialPosition(true)
		self:_clampPosition(true)
		saveState()
	end

	function Window:SetPosition(x, y)
		if typeof(x) == "Vector2" then
			x, y = x.X, x.Y
		elseif typeof(x) == "UDim2" then
			local screen = getScreenSize()
			x, y = screen.X * x.X.Scale + x.X.Offset, screen.Y * x.Y.Scale + x.Y.Offset
		end
		x, y = tonumber(x), tonumber(y)
		if not x or not y then
			report("Window:SetPosition expects x, y numbers, a Vector2 or a UDim2")
			return
		end
		self._pos = Vector2.new(x + self._width * self._scale / 2, y)
		self:_clampPosition(false)
		saveState()
	end

	function Window:GetPosition()
		return Vector2.new(self._pos.X - self._width * self._scale / 2, self._pos.Y)
	end

	function Window:SetSize(width, height)
		if typeof(width) == "Vector2" then
			width, height = width.X, width.Y
		end
		self.BaseWidth = math.clamp(tonumber(width) or self.BaseWidth, self.MinWidth, self.MaxWidth)
		self.BaseHeight = math.clamp(tonumber(height) or self.BaseHeight, self.MinHeight, self.MaxHeight)
		self:_layout(true)
		saveState()
	end

	function Window:GetSize()
		return Vector2.new(self._width, self._height)
	end

	function Window:ResetSize()
		self:SetSize(defaultWidth, defaultHeight)
	end

	function Window:SetSidebarOpen(open)
		self.SidebarOpen = open and true or false
		applyBodyLayout()
	end

	function Window:ToggleSidebar()
		self:SetSidebarOpen(not self.SidebarOpen)
	end

	function Window:SetMobileTabMode(mode)
		if not TAB_MODES[mode] then
			report("MobileTabMode must be Sidebar, BottomBar or Dropdown")
			return false
		end
		self.MobileTabMode = mode
		applyBodyLayout()
		return true
	end

	function Window:CreateSettingsTab(settingsOptions)
		return buildSettingsTab(self, settingsOptions)
	end

	function Window:Destroy()
		self:SetVisible(false, function()
			Library:Destroy()
		end)
	end

	function Window:_refreshTheme()
		self.Theme = Library.Theme
		if self.ActiveTab then
			self:SelectTab(self.ActiveTab)
		end
	end

	function Window:_applySearch(query)
		self._query = query or ""
		for _, tab in self.Tabs do
			applyFilter(tab, self._query)
		end
	end

	--// Tabs
	function Window:CreateTab(tabOptions)
		if type(tabOptions) ~= "table" then
			tabOptions = { Name = tabOptions }
		end
		local name = tostring(tabOptions.Name or "Tab")
		local index = #self.Tabs + 1

		-- Sidebar button
		local slot = create("Frame", {
			Name = "TabSlot",
			Size = UDim2.new(1, 0, 0, 44),
			BackgroundTransparency = 1,
			LayoutOrder = index,
			Parent = TabList,
		})

		local button = createStandardButton({
			Name = "TabButton",
			Parent = slot,
			Size = UDim2.new(1, -6, 0, 40),
			Text = upper(name),
			TextSize = 17,
			Stroke = 2.5,
			TextColor = Library.Theme.Muted,
			Gradient = Library.Theme.TabIdle,
			Icon = tabOptions.Icon,
			Hover = 1.04,
			Click = 0.95,
		})

		-- Bottom bar button
		local bottomSlot = create("Frame", {
			Name = "TabSlot",
			Size = UDim2.fromOffset(122, 46),
			BackgroundTransparency = 1,
			LayoutOrder = index,
			Parent = BottomTabs,
		})
		local bottomButton = createStandardButton({
			Name = "BottomTab",
			Parent = bottomSlot,
			Size = UDim2.fromOffset(118, 42),
			Text = upper(name),
			TextSize = 15,
			Stroke = 2.5,
			TextColor = Library.Theme.Muted,
			Gradient = Library.Theme.TabIdle,
			Hover = 1.04,
			Click = 0.95,
		})

		-- Tab menu entry
		local menuEntry = recessedBox(TabMenuList, {
			Class = "TextButton",
			Name = "MenuTab",
			Anchor = Vector2.zero,
			Size = UDim2.new(1, 0, 0, Library.IsMobile and 40 or 32),
			LayoutOrder = index,
			ZIndex = 62,
		})
		bindRecessedHover(menuEntry)
		local menuLabel = newText(menuEntry, {
			Text = upper(name),
			Size = 14,
			Dynamic = true,
			Position = UDim2.fromOffset(12, 0),
			Bounds = UDim2.new(1, -24, 1, 0),
			Truncate = true,
			ZIndex = 63,
		})

		local page = create("ScrollingFrame", {
			Name = "Page",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = Library.IsMobile and 7 or 6,
			CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Visible = false,
			Parent = Pages,
		})
		themed(page, "ScrollBarImageColor3", "Accent")
		addPadding(page, 12, 14, 12, 16)
		addList(page, 10)

		local Tab = newContainer(self, page, nil, nil)
		Tab.Tab = Tab
		Tab.Name = name
		Tab.Button = button
		Tab.BottomButton = bottomButton
		Tab.MenuLabel = menuLabel
		Tab.Page = page
		Tab._entries = {}
		Tab._sections = {}

		function Tab:Select()
			Window:SelectTab(self)
		end

		onClick(button, function()
			Window:SelectTab(Tab)
		end)
		onClick(bottomButton, function()
			Window:SelectTab(Tab)
		end)
		onClick(menuEntry, function()
			Window:SelectTab(Tab)
			setTabMenuOpen(false)
		end)

		table.insert(self.Tabs, Tab)
		if index == 1 then
			self:SelectTab(Tab)
		end

		return Tab
	end
	Window.AddTab = Window.CreateTab

	function Window:SelectTab(target)
		if type(target) == "string" then
			local found
			for _, tab in self.Tabs do
				if tab.Name == target then
					found = tab
					break
				end
			end
			if not found then
				report("No tab named '" .. target .. "'")
				return
			end
			target = found
		end
		if type(target) ~= "table" then
			return
		end

		local theme = Library.Theme
		for _, tab in self.Tabs do
			local active = tab == target
			for _, tabButton in { tab.Button, tab.BottomButton } do
				tabButton.ButtonGradient.Color = active and theme.Gradient or theme.TabIdle
				tabButton.ButtonGradient.Rotation = active and theme.Rotation or 90
				tabButton.Label.TextColor3 = active and Palette.White or theme.Muted
			end
			tab.MenuLabel.TextColor3 = active and Palette.Lime or theme.Text

			if active and not tab.Page.Visible then
				tab.Page.Visible = true
				tab.Page.Position = UDim2.fromOffset(0, 12)
				tween(tab.Page, 0.25, { Position = UDim2.new() }, Enum.EasingStyle.Quint)
			elseif not active then
				tab.Page.Visible = false
			end
		end

		tabPickerLabel.Text = upper(target.Name)
		self.ActiveTab = target

		if self.Compact and self.MobileSidebar and self.Profile == "PhonePortrait" and self.SidebarOpen then
			self:SetSidebarOpen(false)
		end
	end

	--// Dialogs
	function Window:Dialog(dialogOptions)
		dialogOptions = type(dialogOptions) == "table" and dialogOptions or {}
		local buttons = type(dialogOptions.Buttons) == "table" and #dialogOptions.Buttons > 0 and dialogOptions.Buttons
			or { { Text = "OK", Style = "Claim" } }

		closePopups()

		local overlay = create("TextButton", {
			Name = "Dialog",
			Text = "",
			AutoButtonColor = false,
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Palette.Black,
			BackgroundTransparency = 1,
			ZIndex = 100,
			Parent = Main,
		})
		tween(overlay, 0.2, { BackgroundTransparency = 0.45 })

		local box = create("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(math.min(360, self._width - 24), 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BorderSizePixel = 0,
			Parent = overlay,
		})
		themed(box, "BackgroundColor3", "Background")
		addCorner(box, 4)
		themed(addStroke(box, Palette.Black, 3.5), "Color", "Border")
		addList(box)
		local boxScale = create("UIScale", { Scale = 0.8, Parent = box })
		tween(boxScale, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)

		local header = create("Frame", {
			Size = UDim2.new(1, 0, 0, 46),
			BackgroundColor3 = Palette.White,
			BorderSizePixel = 0,
			LayoutOrder = 1,
			Parent = box,
		})
		addCorner(header, 4)
		themeGradient(create("UIGradient", { Parent = header }))
		themed(create("Frame", {
			Position = UDim2.new(0, 0, 1, -6),
			Size = UDim2.new(1, 0, 0, 3),
			BorderSizePixel = 0,
			ZIndex = 2,
			Parent = header,
		}), "BackgroundColor3", "DivDark")
		create("Frame", {
			Position = UDim2.new(0, 0, 1, -3),
			Size = UDim2.new(1, 0, 0, 3),
			BackgroundColor3 = Palette.Black,
			BorderSizePixel = 0,
			ZIndex = 2,
			Parent = header,
		})
		newText(header, {
			Text = upper(dialogOptions.Title or "Are you sure?"),
			Size = 20,
			Stroke = 3,
			Color = Palette.White,
			Position = UDim2.fromOffset(14, 0),
			Bounds = UDim2.new(1, -28, 1, -6),
			Truncate = true,
			ZIndex = 3,
		})

		local content = create("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Parent = box,
		})
		addPadding(content, 14, 14, 16, 16)
		addList(content, 14)

		newText(content, {
			Text = tostring(dialogOptions.Content or ""),
			Size = 14,
			Wrapped = true,
			AutoY = true,
			RichText = dialogOptions.RichText,
			AlignY = Enum.TextYAlignment.Top,
			Bounds = UDim2.new(1, 0, 0, 0),
			LayoutOrder = 1,
		})

		local buttonHeight = Library.IsMobile and 48 or 44
		local row = create("Frame", {
			Size = UDim2.new(1, 0, 0, buttonHeight),
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Parent = content,
		})
		local rowLayout = addList(row, 10, Enum.FillDirection.Horizontal)
		rowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		local Dialog = { Closed = false }

		function Dialog:Close()
			if self.Closed then
				return
			end
			self.Closed = true
			tween(overlay, 0.2, { BackgroundTransparency = 1 })
			local t = tween(boxScale, 0.2, { Scale = 0.01 }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			t.Completed:Once(function()
				overlay:Destroy()
			end)
		end

		local count = math.min(#buttons, 3)
		for index = 1, count do
			local info = buttons[index]
			local slot = create("Frame", {
				Size = UDim2.new(1 / count, -(10 * (count - 1)) / count, 1, 0),
				BackgroundTransparency = 1,
				LayoutOrder = index,
				Parent = row,
			})
			local button = createStandardButton({
				Parent = slot,
				Size = UDim2.new(1, -4, 1, -4),
				Text = upper(info.Text or "OK"),
				TextSize = self.Compact and 17 or 20,
				Stroke = 2.5,
				Gradient = ButtonStyles[info.Style or "Claim"] or ButtonStyles.Claim,
				ZIndex = 2,
			})
			onClick(button, function()
				if Dialog.Closed then
					return
				end
				Dialog:Close()
				safeCallback(info.Callback)
			end)
		end

		return Dialog
	end

	--// Wiring
	onClick(CloseButton, function()
		Window:Dialog({
			Title = "Close " .. titleText .. "?",
			Content = "Closing unloads everything. Use the menu key to just hide it instead.",
			Buttons = {
				{ Text = "Close", Style = "Locked", Callback = function()
					Window:Destroy()
				end },
				{ Text = "Hide", Style = "Skip", Callback = function()
					if options.MinimizeToButton then
						Window:SetMinimizedToButton(true)
					else
						Window:SetVisible(false)
					end
				end },
				{ Text = "Cancel", Style = "Claimed" },
			},
		})
	end)

	onClick(MinimizeButton, function()
		Window:SetMinimized(not Window.Minimized)
	end)

	if ToButtonButton then
		onClick(ToButtonButton, function()
			Window:SetMinimizedToButton(true)
		end)
	end

	onClick(SidebarButton, function()
		Window:ToggleSidebar()
	end)

	onClick(TabPicker, function()
		setTabMenuOpen(not TabMenu.Visible)
	end)

	-- Search (sidebar + top bar stay in sync)
	local syncingSearch = false
	local function onSearchChanged(source)
		if syncingSearch then
			return
		end
		syncingSearch = true
		local text = source.Text
		if SearchBox.Text ~= text then
			SearchBox.Text = text
		end
		if TopSearchBox.Text ~= text then
			TopSearchBox.Text = text
		end
		syncingSearch = false
		Window:_applySearch(text)
	end

	for box, stroke in { [SearchBox] = searchStroke, [TopSearchBox] = topSearchStroke } do
		box:GetPropertyChangedSignal("Text"):Connect(function()
			onSearchChanged(box)
		end)
		box.Focused:Connect(function()
			stroke.Color = Library.Theme.Accent
		end)
		box.FocusLost:Connect(function()
			stroke.Color = Library.Theme.RecessedBorder
		end)
	end

	-- Window dragging (clamped to the screen)
	Header.InputBegan:Connect(function(input)
		if not isPress(input) then
			return
		end
		local startInput = input.Position
		local startPos = Window._pos
		beginDrag(input, {
			OnMove = function(position)
				Window._pos = Vector2.new(startPos.X + position.X - startInput.X, startPos.Y + position.Y - startInput.Y)
				Window:_clampPosition(false)
			end,
			OnEnd = saveState,
		})
	end)

	-- Resizing
	if ResizeGrip then
		ResizeGrip.InputBegan:Connect(function(input)
			if not isPress(input) or Window.Minimized then
				return
			end
			local startInput = input.Position
			local startWidth, startHeight = Window._width, Window._height
			local left = Window._pos.X - startWidth * Window._scale / 2
			Window.BaseWidth, Window.BaseHeight = startWidth, startHeight

			beginDrag(input, {
				OnMove = function(position)
					local scale = Window._scale
					Window.BaseWidth = math.clamp(startWidth + (position.X - startInput.X) / scale, Window.MinWidth, Window.MaxWidth)
					Window.BaseHeight = math.clamp(startHeight + (position.Y - startInput.Y) / scale, Window.MinHeight, Window.MaxHeight)
					Window:_layout()
					Window._pos = Vector2.new(left + Window._width * Window._scale / 2, Window._pos.Y)
					Window:_clampPosition(false)
				end,
				OnEnd = saveState,
			})
		end)
	end

	-- Menu key
	onInput("Began", function(input, gameProcessed)
		if gameProcessed or not Window.ToggleKey or Library._activeBinder or input == Library._lastBindInput then
			return
		end
		if bindMatches(input, Window.ToggleKey) then
			Window:Toggle()
		end
	end)

	table.insert(Library._scaleTargets, function()
		Window:_layout()
	end)

	--// Open
	Window:_layout(false, true)

	local function open()
		if saved and remember.Minimized and saved.MinimizedToButton then
			Window.MinimizedToButton = true
			updateFloating()
		else
			Window:SetVisible(true)
		end
		if saved and remember.Minimized and saved.Minimized then
			Window:SetMinimized(true)
		end
		updateFloating()
	end

	if options.Intro ~= false then
		playIntro(titleText, options.IntroText, open)
	else
		open()
	end

	return Window
end

--// Built-in settings tab
function buildSettingsTab(Window, settingsOptions)
	settingsOptions = type(settingsOptions) == "table" and settingsOptions or {}
	local Tab = Window:CreateTab({ Name = settingsOptions.Name or "Settings", Icon = settingsOptions.Icon })
	local mobile = Library.IsMobile

	-- Interface
	local Interface = Tab:CreateSection("Interface")

	Interface:AddToggle({
		Name = "Watermark",
		Description = "FPS, ping and time in the corner",
		Flag = "__Watermark",
		Callback = function(state)
			Library:SetWatermark(state)
		end,
	})

	if not mobile then
		Interface:AddToggle({
			Name = "Keybind List",
			Description = "Shows your active keybinds",
			Flag = "__KeybindList",
			Callback = function(state)
				Library:SetKeybindList(state)
			end,
		})
	end

	Interface:AddDropdown({
		Name = "Notifications",
		Description = "Where notifications appear",
		Options = { "TopLeft", "Top", "TopRight", "BottomLeft", "Bottom", "BottomRight" },
		Default = select(2, currentNotifyPosition()),
		Flag = "__NotifyPosition",
		Callback = function(position)
			if position then
				Library:SetNotificationPosition(position)
			end
		end,
	})

	Interface:AddSlider({
		Name = "Max Notifications",
		Description = "Extra ones wait in a queue",
		Min = 1,
		Max = 10,
		Default = Library.NotificationLimit,
		Flag = "__NotifyLimit",
		Callback = function(value)
			Library:SetNotificationLimit(value)
		end,
	})

	Interface:AddDropdown({
		Name = "Mobile Tab Layout",
		Description = "Used on phones and small windows",
		Options = { "Sidebar", "BottomBar", "Dropdown" },
		Default = Window.MobileTabMode,
		Flag = "__MobileTabMode",
		Callback = function(mode)
			if mode then
				Window:SetMobileTabMode(mode)
			end
		end,
	})

	Interface:AddButton({
		Name = "Center Window",
		ButtonText = "Center",
		Style = "Codes",
		Callback = function()
			Window:Center()
		end,
	})

	if Window.Resizable then
		Interface:AddButton({
			Name = "Reset Size",
			ButtonText = "Reset",
			Style = "Skip",
			Callback = function()
				Window:ResetSize()
			end,
		})
	end

	Interface:AddButton({
		Name = "Minimize To Button",
		Description = "Hides the window behind a floating button",
		ButtonText = "Minimize",
		Style = "Skip",
		Callback = function()
			Window:SetMinimizedToButton(true)
		end,
	})

	-- Appearance
	local Appearance = Tab:CreateSection("Appearance")

	local themeDropdown = Appearance:AddDropdown({
		Name = "Theme",
		Description = "Recolors the whole UI",
		Options = Library:GetThemes(),
		Default = Library.ThemeName,
		Searchable = true,
		Flag = "__Theme",
		Callback = function(name)
			if name then
				Library:SetTheme(name)
			end
		end,
	})
	table.insert(Library._themeListListeners, function()
		themeDropdown:Refresh(Library:GetThemes(), true)
	end)

	Appearance:AddToggle({
		Name = "Sunburst",
		Description = "Rays behind the window",
		Default = Library.SunburstEnabled,
		Flag = "__Sunburst",
		Callback = function(state)
			Library:SetSunburst(state, nil)
		end,
	})

	local Editor = Appearance:AddCard({
		Title = "Theme Editor",
		Description = "Edits are saved to the CUSTOM theme",
	})

	local editorFields = {
		{ Name = "Accent", Key = "Accent" },
		{ Name = "Gradient Top", Key = "GradientTop" },
		{ Name = "Gradient Bottom", Key = "GradientBottom" },
		{ Name = "Background", Key = "Background" },
		{ Name = "Card", Key = "Card" },
		{ Name = "Text", Key = "Text" },
		{ Name = "Border", Key = "Border" },
		{ Name = "Notifications", Key = "Notification" },
	}
	local pickers = {}
	local seeding, pending, pendingSwitch = false, false, false

	local function currentValue(key)
		local theme = Library.Theme
		if key == "GradientTop" then
			return gradientStart(theme.Gradient)
		elseif key == "GradientBottom" then
			return gradientEnd(theme.Gradient)
		elseif key == "Notification" then
			return gradientStart(theme.Notification)
		end
		return theme[key]
	end

	local function applyEditor()
		local switch = pendingSwitch
		pending, pendingSwitch = false, false
		local function value(key)
			return pickers[key].Value
		end
		Library:AddTheme("Custom", {
			Gradient = { value("GradientTop"), value("GradientBottom") },
			Accent = value("Accent"),
			Background = value("Background"),
			Card = value("Card"),
			Recessed = darken(value("Card"), 0.2),
			Text = value("Text"),
			Border = value("Border"),
			Notification = value("Notification"),
			Rotation = 90,
		})
		if switch and Library.ThemeName ~= "Custom" then
			Library:SetTheme("Custom")
			themeDropdown:Set("Custom", true)
		end
	end

	local function seed()
		seeding = true
		for _, field in editorFields do
			pickers[field.Key]:Set(currentValue(field.Key), true)
		end
		seeding = false
	end

	for _, field in editorFields do
		pickers[field.Key] = Editor:AddColorPicker({
			Name = field.Name,
			Flag = "__ThemeEditor" .. field.Key,
			Default = currentValue(field.Key),
			Callback = function()
				if seeding then
					return
				end
				-- Remember whether this edit came from the user (switch to Custom) or from a config load
				pendingSwitch = pendingSwitch or not Library._loadingConfig
				if pending then
					return
				end
				pending = true
				task.defer(applyEditor)
			end,
		})
	end

	Editor:AddButton({
		Name = "Load Current Theme",
		Description = "Copies the active theme into the editor",
		ButtonText = "Load",
		Style = "Codes",
		Callback = seed,
	})

	-- Accessibility
	local Access = Tab:CreateSection("Accessibility")

	Access:AddToggle({
		Name = "Reduced Animations",
		Description = "Skips most motion",
		Default = Library.ReducedAnimations,
		Flag = "__ReducedAnimations",
		Callback = function(state)
			Library:SetReducedAnimations(state)
		end,
	})

	local scaleSlider
	Access:AddToggle({
		Name = "Large UI",
		Description = "Makes everything 15% bigger",
		Default = Library.UIScale >= 1.15,
		Flag = "__LargeUI",
		Callback = function(state)
			Library:SetUIScale(state and 1.15 or 1)
			if scaleSlider then
				scaleSlider:Set(Library.UIScale * 100, true)
			end
		end,
	})
	Library.ConfigIgnore.__LargeUI = true

	scaleSlider = Access:AddSlider({
		Name = "UI Scale",
		Min = 75,
		Max = 150,
		Increment = 5,
		Default = Library.UIScale * 100,
		Suffix = "%",
		Flag = "__UIScale",
		Callback = function(value)
			Library:SetUIScale(value / 100)
		end,
	})

	Access:AddToggle({
		Name = "High Contrast",
		Description = "Brighter text and borders",
		Default = Library.HighContrast,
		Flag = "__HighContrast",
		Callback = function(state)
			Library:SetHighContrast(state)
		end,
	})

	if not mobile then
		Access:AddToggle({
			Name = "Tooltips",
			Default = Library.TooltipsEnabled,
			Flag = "__Tooltips",
			Callback = function(state)
				Library:SetTooltips(state)
			end,
		})
	end

	-- Input
	local InputSection = Tab:CreateSection("Input")

	if not mobile then
		InputSection:AddKeybind({
			Name = "Menu Key",
			Description = "Hides and shows this window",
			Default = Window.ToggleKey,
			Flag = "__MenuKey",
			ShowInList = false,
			OnChanged = function(key)
				Window:SetToggleKey(key)
			end,
		})
	end

	InputSection:AddToggle({
		Name = "Floating Button",
		Description = mobile and "Tap it to open and close the menu" or "A draggable open / close button",
		Default = Window._floatingEnabled,
		Flag = "__FloatingButton",
		Callback = function(state)
			Window:SetFloatingButton(state)
		end,
	})

	InputSection:AddToggle({
		Name = "Snap Button To Edge",
		Default = Window.ButtonSnap,
		Flag = "__ButtonSnap",
		Callback = function(state)
			Window:SetButtonSnap(state)
		end,
	})

	-- Sounds
	local SoundSection = Tab:CreateSection("Sounds")

	SoundSection:AddToggle({
		Name = "UI Sounds",
		Description = "Hover and click sounds",
		Flag = "__Sounds",
		Default = Library.SoundsEnabled,
		Callback = function(state)
			Library:SetSounds(state)
		end,
	})

	SoundSection:AddToggle({
		Name = "Notification Sounds",
		Flag = "__NotifySounds",
		Default = Library.NotificationSounds,
		Callback = function(state)
			Library:SetNotificationSounds(state)
		end,
	})

	-- Configs
	local Configs = Tab:CreateSection("Configs")
	local configName = ""

	local autoloadLabel = Configs:AddLabel("AUTOLOAD: " .. upper(Library:GetAutoload() or "None"))

	Configs:AddInput({
		Name = "Config Name",
		Placeholder = "my config",
		MaxLength = 60,
		Callback = function(text)
			configName = trim(text)
		end,
	})

	local list = Configs:AddDropdown({
		Name = "Saved Configs",
		Options = Library:ListConfigs(),
		Searchable = true,
		Callback = function(name)
			if name then
				configName = name
			end
		end,
	})

	local function refreshList()
		list:Refresh(Library:ListConfigs(), true)
		autoloadLabel:Set("AUTOLOAD: " .. upper(Library:GetAutoload() or "None"))
	end

	local function requireName()
		if not sanitizeName(configName) then
			Library:Notify({ Title = "Config", Content = "Type or pick a config name first.", Style = "Warning", Duration = 3 })
			return false
		end
		return true
	end

	Configs:AddButton({
		Name = "Save Config",
		ButtonText = "Save",
		Style = "Claim",
		Callback = function()
			if requireName() then
				Library:SaveConfig(configName)
				refreshList()
			end
		end,
	})

	Configs:AddButton({
		Name = "Load Config",
		ButtonText = "Load",
		Style = "Codes",
		Callback = function()
			if requireName() then
				Library:LoadConfig(configName)
			end
		end,
	})

	Configs:AddButton({
		Name = "Delete Config",
		ButtonText = "Delete",
		Style = "Locked",
		Confirm = true,
		Callback = function()
			if requireName() then
				Library:DeleteConfig(configName)
				refreshList()
			end
		end,
	})

	Configs:AddButton({
		Name = "Set Autoload",
		Description = "Loads this config every time you execute",
		ButtonText = "Autoload",
		Style = "Skip",
		Callback = function()
			if requireName() then
				Library:SetAutoload(configName)
				refreshList()
			end
		end,
	})

	Configs:AddButton({
		Name = "Clear Autoload",
		ButtonText = "Clear",
		Style = "Claimed",
		Callback = function()
			Library:SetAutoload(nil)
			refreshList()
		end,
	})

	Configs:AddButton({
		Name = "Refresh List",
		ButtonText = "Refresh",
		Style = "Codes",
		Callback = refreshList,
	})

	-- Performance
	local Performance = Tab:CreateSection({ Name = "Performance", Collapsed = true })

	Performance:AddToggle({
		Name = "Animated Sunburst",
		Description = "Turn off to save a little FPS",
		Default = Library.SunburstAnimated,
		Flag = "__SunburstAnimated",
		Callback = function(state)
			Library:SetSunburst(nil, state)
		end,
	})

	local perfStats = Performance:AddStats({
		Rows = { "Connections", "Frame Tasks", "Themed Objects", "Notifications" },
	})

	local function updatePerf()
		local stats = Library:GetStats()
		perfStats:Set("Connections", stats.Connections)
		perfStats:Set("Frame Tasks", stats.FrameTasks)
		perfStats:Set("Themed Objects", stats.ThemedObjects)
		perfStats:Set("Notifications", string.format("%d (+%d queued)", stats.Notifications, stats.Queued))
	end

	Performance:AddButton({
		Name = "Refresh Stats",
		ButtonText = "Refresh",
		Style = "Codes",
		Callback = updatePerf,
	})
	updatePerf()

	-- Danger zone
	local Danger = Tab:CreateSection("Danger Zone")

	Danger:AddButton({
		Name = "Reset UI Settings",
		Description = "Theme, scale, accessibility and position",
		ButtonText = "Reset",
		Style = "Skip",
		Confirm = true,
		Callback = function()
			local defaults = {
				__Theme = "Rebirth",
				__UIScale = 100,
				__ReducedAnimations = false,
				__HighContrast = false,
				__Tooltips = true,
				__Sounds = true,
				__NotifySounds = true,
				__Sunburst = true,
				__SunburstAnimated = true,
			}
			for flag, value in defaults do
				local option = Library.Options[flag]
				if option then
					option:Set(value)
				end
			end
			local large = Library.Options.__LargeUI
			if large then
				large:Set(false, true)
			end
			Window:ResetPosition()
		end,
	})

	Danger:AddButton({
		Name = "Unload",
		Description = "Removes the UI and stops everything",
		ButtonText = "Unload",
		Style = "Locked",
		Callback = function()
			Window:Dialog({
				Title = "Unload?",
				Content = "This removes the UI and stops every feature. You'll need to re-execute to get it back.",
				Buttons = {
					{ Text = "Unload", Style = "Locked", Callback = function()
						Window:Destroy()
					end },
					{ Text = "Cancel", Style = "Claimed" },
				},
			})
		end,
	})

	-- About
	local About = Tab:CreateSection({ Name = "About", Collapsed = true })
	local profile = Library:GetDevice()
	About:AddParagraph({
		Title = Library.Name .. " v" .. Library.Version,
		Content = "Cartoon simulator-style UI built on the Check-UI design standard.\nDevice: "
			.. tostring(profile) .. (mobile and " (touch)" or ""),
	})

	return Tab
end

--// Themes API
function Library:_applyTheme()
	self.Theme = resolveTheme(Themes[self.ThemeName] or Themes.Rebirth)
	local gui = self.Gui

	for index = #self._themed, 1, -1 do
		local entry = self._themed[index]
		local instance = entry.Instance
		if gui and instance:IsDescendantOf(gui) then
			instance[entry.Property] = self.Theme[entry.Key]
		else
			table.remove(self._themed, index)
		end
	end

	for _, hook in table.clone(self._themeHooks) do
		local ok, err = pcall(hook)
		if not ok then
			report("Theme hook error: " .. tostring(err))
		end
	end

	for _, window in self.Windows do
		window:_refreshTheme()
	end
end

function Library:SetTheme(name)
	if not Themes[name] then
		report("Unknown theme '" .. tostring(name) .. "'")
		return false
	end
	self.ThemeName = name
	self:_applyTheme()
	return true
end

function Library:AddTheme(name, definition)
	if type(name) ~= "string" or name == "" then
		report("AddTheme needs a theme name")
		return false
	end
	local theme, err = buildTheme(definition)
	if not theme then
		report("AddTheme('" .. name .. "'): " .. tostring(err))
		return false
	end
	Themes[name] = theme
	if not table.find(ThemeOrder, name) then
		table.insert(ThemeOrder, name)
		for _, listener in self._themeListListeners do
			local ok, listenerErr = pcall(listener)
			if not ok then
				report("Theme list listener error: " .. tostring(listenerErr))
			end
		end
	end
	if self.ThemeName == name then
		self:_applyTheme()
	end
	return true
end

function Library:GetThemes()
	return table.clone(ThemeOrder)
end

function Library:GetTheme(name)
	local theme = Themes[name or self.ThemeName]
	return theme and table.clone(theme) or nil
end

--// Preferences & accessibility
function Library:SetSounds(enabled)
	self.SoundsEnabled = enabled and true or false
end

function Library:SetNotificationSounds(enabled)
	self.NotificationSounds = enabled and true or false
end

function Library:SetTooltips(enabled)
	self.TooltipsEnabled = enabled and true or false
	if not self.TooltipsEnabled then
		hideTooltip()
	end
end

function Library:SetReducedAnimations(enabled)
	self.ReducedAnimations = enabled and true or false
	for _, window in self.Windows do
		window._refreshEffects()
	end
end

function Library:SetUIScale(scale)
	scale = tonumber(scale)
	if not scale then
		report("SetUIScale expects a number")
		return
	end
	self.UIScale = math.clamp(scale, 0.75, 1.5)
	refreshScales()
end

function Library:SetHighContrast(enabled)
	self.HighContrast = enabled and true or false
	self:_applyTheme()
end

function Library:SetSunburst(enabled, animated)
	if enabled ~= nil then
		self.SunburstEnabled = enabled and true or false
	end
	if animated ~= nil then
		self.SunburstAnimated = animated and true or false
	end
	for _, window in self.Windows do
		window._refreshEffects()
	end
end

function Library:GetDevice()
	local profile = getProfile(getScreenSize())
	return profile, self.IsMobile
end

function Library:GetStats()
	return {
		Connections = #self._connections,
		FrameTasks = stepCount,
		ThemedObjects = #self._themed,
		Windows = #self.Windows,
		Notifications = #notifyState.Active,
		Queued = #notifyState.Queue,
		InputHandlers = #inputHandlers.Began + #inputHandlers.Changed + #inputHandlers.Ended,
	}
end

--// Configs
local function encodeValue(value)
	local kind = typeof(value)
	if kind == "Color3" then
		return { __type = "Color3", value = value:ToHex() }
	elseif kind == "EnumItem" then
		return { __type = "Enum", enum = tostring(value.EnumType), value = value.Name }
	elseif kind == "table" then
		local copy = {}
		for key, item in value do
			copy[key] = encodeValue(item)
		end
		return copy
	end
	return value
end

local function decodeValue(value)
	if type(value) ~= "table" then
		return value
	end
	if value.__type == "Color3" then
		local ok, color = pcall(Color3.fromHex, value.value)
		return ok and color or nil
	elseif value.__type == "Enum" then
		local ok, item = pcall(function()
			return Enum[value.enum][value.value]
		end)
		return ok and item or nil
	end
	local copy = {}
	for key, item in value do
		copy[key] = decodeValue(item)
	end
	return copy
end

local function configFolder()
	return Library.Folder .. "/configs"
end

local function configPath(name)
	return configFolder() .. "/" .. name .. ".json"
end

local function ensureConfigFolders()
	if not canWriteFiles() then
		return false
	end
	local ok = pcall(function()
		ensureFolder(Library.Folder)
		ensureFolder(configFolder())
	end)
	return ok
end

function Library:SaveConfig(name)
	local clean = sanitizeName(name)
	if not clean then
		self:Notify({ Title = "Config", Content = "That config name isn't valid.", Style = "Warning", Duration = 3 })
		return false
	end
	if not ensureConfigFolders() then
		self:Notify({ Title = "Config", Content = "Your executor doesn't support saving files.", Style = "Error" })
		return false
	end

	local data = {}
	for flag, value in self.Flags do
		if not self.ConfigIgnore[flag] then
			data[flag] = encodeValue(value)
		end
	end

	local ok, err = pcall(function()
		writefile(configPath(clean), HttpService:JSONEncode(data))
	end)

	if ok then
		self:Notify({ Title = "Config Saved", Content = "Saved as \"" .. clean .. "\".", Style = "Success", Duration = 3 })
	else
		self:Notify({ Title = "Config", Content = "Failed to save: " .. tostring(err), Style = "Error" })
	end
	return ok
end

function Library:LoadConfig(name, silent)
	local clean = sanitizeName(name)
	if not (readfile and isfile) then
		self:Notify({ Title = "Config", Content = "Your executor doesn't support reading files.", Style = "Error" })
		return false
	end
	if not clean or not isfile(configPath(clean)) then
		self:Notify({ Title = "Config", Content = "No config named \"" .. tostring(name) .. "\".", Style = "Warning" })
		return false
	end

	local ok, data = pcall(function()
		return HttpService:JSONDecode(readfile(configPath(clean)))
	end)
	if not ok or type(data) ~= "table" then
		self:Notify({ Title = "Config", Content = "That config file is corrupted.", Style = "Error" })
		return false
	end

	self._loadingConfig = true
	local themeValue = nil
	for flag, raw in data do
		local option = self.Options[flag]
		if option and option.Set and not self.ConfigIgnore[flag] then
			if flag == "__Theme" then
				themeValue = raw
			else
				local setOk, setErr = pcall(option.Set, option, decodeValue(raw))
				if not setOk then
					report("Couldn't load flag '" .. tostring(flag) .. "': " .. tostring(setErr))
				end
			end
		end
	end
	self._loadingConfig = false

	-- Theme last, so theme-editor colors from the same config are already in place
	if themeValue ~= nil and self.Options.__Theme then
		pcall(self.Options.__Theme.Set, self.Options.__Theme, decodeValue(themeValue))
	end

	if not silent then
		self:Notify({ Title = "Config Loaded", Content = "Loaded \"" .. clean .. "\".", Style = "Success", Duration = 3 })
	end
	return true
end

function Library:DeleteConfig(name)
	local clean = sanitizeName(name)
	if not (delfile and isfile) then
		self:Notify({ Title = "Config", Content = "Your executor doesn't support deleting files.", Style = "Error" })
		return false
	end
	if not clean or not isfile(configPath(clean)) then
		self:Notify({ Title = "Config", Content = "No config named \"" .. tostring(name) .. "\".", Style = "Warning" })
		return false
	end
	delfile(configPath(clean))
	if self:GetAutoload() == clean then
		self:SetAutoload(nil)
	end
	self:Notify({ Title = "Config Deleted", Content = "Deleted \"" .. clean .. "\".", Style = "Warning", Duration = 3 })
	return true
end

function Library:ListConfigs()
	local names = {}
	if not (listfiles and isfolder) then
		return names
	end
	local ok = pcall(function()
		if not isfolder(configFolder()) then
			return
		end
		for _, path in listfiles(configFolder()) do
			local name = string.match(path, "([^/\\]+)%.json$")
			if name then
				table.insert(names, name)
			end
		end
	end)
	if not ok then
		return {}
	end
	table.sort(names)
	return names
end

function Library:SetAutoload(name)
	if not ensureConfigFolders() then
		return false
	end
	local path = self.Folder .. "/autoload.txt"
	local clean = name ~= nil and sanitizeName(name) or nil
	if clean then
		writefile(path, clean)
		self:Notify({ Title = "Autoload", Content = "\"" .. clean .. "\" will load on execute.", Style = "Info", Duration = 3 })
	elseif delfile and isfile and isfile(path) then
		delfile(path)
	end
	return true
end

function Library:GetAutoload()
	local path = self.Folder .. "/autoload.txt"
	if readfile and isfile then
		local ok, name = pcall(function()
			return isfile(path) and readfile(path) or nil
		end)
		if ok and type(name) == "string" and trim(name) ~= "" then
			return trim(name)
		end
	end
	return nil
end

function Library:LoadAutoload()
	local name = self:GetAutoload()
	if name then
		return self:LoadConfig(name)
	end
	return false
end

--// Lifecycle
function Library:Track(connection)
	return track(connection)
end

function Library:OnUnload(callback)
	if type(callback) ~= "function" then
		report("OnUnload expects a function")
		return
	end
	table.insert(self._unloadCallbacks, callback)
end

function Library:Destroy()
	if self.Unloaded then
		return
	end
	self.Unloaded = true

	for _, callback in self._unloadCallbacks do
		local ok, err = pcall(callback)
		if not ok then
			report("Unload callback error: " .. tostring(err))
		end
	end

	for _, connection in self._connections do
		pcall(function()
			connection:Disconnect()
		end)
	end
	table.clear(self._connections)

	if stepConnection then
		stepConnection:Disconnect()
		stepConnection = nil
	end
	table.clear(stepTasks)
	stepCount = 0

	for _, list in inputHandlers do
		table.clear(list)
	end
	activeDrag = nil
	hoveredSlider = nil
	openDropdown = nil

	table.clear(self._scaleTargets)
	table.clear(self._themed)
	table.clear(self._themeHooks)
	table.clear(self._themeListListeners)
	table.clear(self._binds)
	table.clear(notifyState.Active)
	table.clear(notifyState.Queue)
	notifyState.Holder = nil
	self._activeBinder = nil

	if self.Gui then
		self.Gui:Destroy()
		self.Gui = nil
	end
	table.clear(self.Windows)

	if env.__RetroSlop == self then
		env.__RetroSlop = nil
	end
end

return Library
