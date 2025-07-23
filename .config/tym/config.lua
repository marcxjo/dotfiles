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
		if i > 3 then
			break
		end

		local digits = string.gsub(match, ",", "")
		digits = string.format("%02x", tonumber(digits))

		matches[i] = digits

		i = i + 1
	end

	r = matches[1]
	g = matches[2]
	b = matches[3]

	if r == nil or g == nil or b == nil then
		return rgba_color
	end

	return "#" .. string.gsub(r, ",", "") .. string.gsub(g, ",", "") .. string.gsub(b, ",", "")
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
	end,
	["<Ctrl><Alt><Shift>r"] = function()
		tym.reset_config()
		tym.reload()
	end,
	["<Ctrl><Shift>l"] = function()
		local old_bg = tym.get("color_background")
		local old_fg = tym.get("color_foreground")

		tym.set("color_background", old_fg)
		tym.set("color_window_background", old_fg)
		tym.set("color_foreground", old_bg)
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
	end,
	["<Ctrl>equal"] = function()
		tym.set("scale", 100)
	end,
	["<Ctrl><Shift>plus"] = function()
		local s = tym.get("scale") + 10
		tym.set("scale", s)
	end,
	["<Ctrl>minus"] = function()
		local s = tym.get("scale") - 10
		tym.set("scale", s)
	end,
})

-- tym.set_hook(
--   "signal",
--   function(p)
--   end
-- )
