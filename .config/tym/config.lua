-- At first, you need to require tym module
local tym = require("tym")
local string = require("string")

local function is_hex(color)
	local match = string.match(color, "^#%x%x%x%x%x%x")

	return match ~= nil
end

local function is_rgba(color)
	local match = string.match(color, "^rgba")

	return match ~= nil
end

local function to_rgba(hex_color, alpha)
	local current_locale = os.setlocale(nil)

	os.setlocale("C")

	local hex_num = hex_color:gsub("#", "")
	local rgba_str = "rgba("

	rgba_str = rgba_str .. tonumber("0x" .. hex_num:sub(1, 2)) .. ", "
	rgba_str = rgba_str .. tonumber("0x" .. hex_num:sub(3, 4)) .. ", "
	rgba_str = rgba_str .. tonumber("0x" .. hex_num:sub(5, 6)) .. ", "
	rgba_str = rgba_str .. tonumber(alpha) .. ")"

	os.setlocale(current_locale)

	return rgba_str
end

local function to_hex(rgba_color)
	local i = 1
	local matches = {}
	local r, g, b
	for match in string.gmatch(rgba_color, "%d+,") do
		while i <= 3 do
			local digits = string.gsub(match, ",", "")
			digits = string.format("%02x", tonumber(digits))

			matches[i] = digits

			i = i + 1
		end
	end

	r = matches[1]
	g = matches[2]
	b = matches[3]

	if r == nil or g == nil or b == nil then
		return rgba_color
	end

	return "#" .. string.gsub(r, ",", "") .. string.gsub(r, ",", "") .. string.gsub(r, ",", "")
end

-- set by table
tym.set_config({
	font = "JetBrains Mono 9",
	cursor_blink_mode = "system",
	bold_is_bright = "true",
	audible_bell = "true",
})

tym.set_keymaps({
	["<Ctrl><Shift>r"] = function()
		tym.reload()
		tym.notify("Reloaded configuration")
	end,
	["<Ctrl><Alt><Shift>r"] = function()
		tym.reset_config()
		tym.reload()
		tym.notify("Reset and reloaded configuration")
	end,
	["<Ctrl><Shift>l"] = function()
		local old_bg = tym.get("color_background")
		local old_fg = tym.get("color_foreground")

		tym.set("color_background", old_fg)
		tym.set("color_window_background", old_fg)
		tym.set("color_foreground", old_bg)

		tym.notify("Toggled light/dark mode")
	end,
	["<Ctrl><Shift>t"] = function()
		local bg = tym.get("color_background")

		if is_rgba(bg) then
			local new_bg = to_hex(bg)

			tym.set("color_background", new_bg)
			tym.set("color_window_background", new_bg)
		elseif is_hex(bg) then
			local new_bg = to_rgba(bg, 0.95)

			tym.set("color_background", new_bg)
			tym.set("color_window_background", new_bg)
		else
			return
		end

		tym.notify("Toggled transparency")
	end,
	["<Ctrl>equal"] = function()
		tym.set("scale", 100)
		tym.notify("Reset font scale")
	end,
	["<Ctrl><Shift>plus"] = function()
		local s = tym.get("scale") + 10
		tym.set("scale", s)
		tym.notify("Scale:" .. s)
	end,
	["<Ctrl>minus"] = function()
		local s = tym.get("scale") - 10
		tym.set("scale", s)
		tym.notify("Scale:" .. s)
	end,
})

-- tym.set_hook(
--   "signal",
--   function(p)
--   end
-- )
