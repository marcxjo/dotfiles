local function to_gdk_rgba(hex_color, alpha)
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

local fg = "#FBFADA"
local bg = "#0E1F13"
local bg_trans = to_gdk_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#445630",
	color_1 = "#316749",
	color_2 = "#50724F",
	color_3 = "#6A7752",
	color_4 = "#967547",
	color_5 = "#2F9465",
	color_6 = "#6D8B65",
	color_7 = "#8E956D",
	color_8 = "#A39E6C",
	color_9 = "#D5B16C",
	color_10 = "#7B7983",
	color_11 = "#65A896",
	color_12 = "#A8B18A",
	color_13 = "#CEB88A",
	color_14 = "#B0CA9E",
	color_15 = "#E7D9A1",
}
