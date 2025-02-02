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

local fg = "#091116"
local bg = "#cfd6d9"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#282a2e",
	color_1 = "#a54242",
	color_2 = "#a1b56c",
	color_3 = "#de935f",
	color_4 = "#225555",
	color_5 = "#85678f",
	color_6 = "#5e8d87",
	color_7 = "#777777",
	color_8 = "#373b41",
	color_9 = "#c63535",
	color_10 = "#608360",
	color_11 = "#fa805a",
	color_12 = "#449da1",
	color_13 = "#ba8baf",
	color_14 = "#86c1b9",
	color_15 = "#c5c8c6",
}
