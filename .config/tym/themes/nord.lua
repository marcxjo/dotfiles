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

local fg = "#d8dee9"
local bg = "#2e3440"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#3b4252",
	color_1 = "#bf616a",
	color_2 = "#a3be8c",
	color_3 = "#ebcb8b",
	color_4 = "#81a1c1",
	color_5 = "#b48ead",
	color_6 = "#88c0d0",
	color_7 = "#e5e9f0",
	color_8 = "#4c566a",
	color_9 = "#bf616a",
	color_10 = "#a3be8c",
	color_11 = "#ebcb8b",
	color_12 = "#81a1c1",
	color_13 = "#b48ead",
	color_14 = "#8fbcbb",
	color_15 = "#eceff4",
}
