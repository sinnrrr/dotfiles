-- https://github.com/lackac/dotfiles/blob/32cab1e85c0bdec72d55ace9530e44e326549bef/tag-osx/config/hammerspoon/ext/system.lua#L39-L45
local function isDarkModeEnabled()
	local _, res = hs.osascript.javascript([[
    Application("System Events").appearancePreferences.darkMode()
  ]])

	return res == true -- getting nil here sometimes
end

local function themeToName(isDarkMode)
	return isDarkMode and "One" or "latte"
end

local function buildKittyCommand(isDarkMode)
	local catppuccinTheme = themeToCatppuccinTheme(isDarkMode)
	local capitalizedTheme = catppuccinTheme:sub(1, 1):upper() .. catppuccinTheme:sub(2)

	return "kitty +kitten themes --reload-in=all --config-file-name themes.conf Catppuccin-" .. capitalizedTheme
end

local function buildEmacsCommand(isDarkMode)
	local catppuccinTheme = themeToCatppuccinTheme(isDarkMode)

	return "emacsclient --socket-name ~/.config/emacs/server/server --eval '"
		.. string.format("(my/catppuccin-set-and-reload \\'%s)", catppuccinTheme)
		.. "' --quiet -no-wait --suppress-output -a true"
end

local function executeCommand(command, appName)
	print(appName .. ": command: " .. command)

	local _output, status, _type, _rc = hs.execute(command, true)

	if status then
		print(appName .. ": succeeded")
	else
		print(appName .. ": failed")
	end
end

local cb = function()
	local isDarkMode = isDarkModeEnabled()

	print("theme changed. Dark mode: " .. tostring(isDarkMode))

	local commands = {
		{ builder = buildKittyCommand, appName = "kitty" },
		{ builder = buildEmacsCommand, appName = "emacs" },
		-- TODO: Neovim
		-- TODO: Helix
	}

	for _, cmdInfo in ipairs(commands) do
		local command = cmdInfo.builder(isDarkMode)
		executeCommand(command, cmdInfo.appName)
	end
end

local notificationName = "AppleInterfaceThemeChangedNotification"

local appearanceWatcher = hs.distributednotifications.new(cb, notificationName, nil)

appearanceWatcher:start()
