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

local fg = "#d9e7ff"
local bg = "#101211"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#375b5a",
	color_1 = "#5b5d60",
	color_2 = "#506d6d",
	color_3 = "#6f8567",
	color_4 = "#5b72ff",
	color_5 = "#687c81",
	color_6 = "#a2a556",
	color_7 = "#d1d1bc",
	color_8 = "#657aff",
	color_9 = "#6e8985",
	color_10 = "#748cff",
	color_11 = "#c1c48c",
	color_12 = "#8da5fe",
	color_13 = "#93adff",
	color_14 = "#a9caff",
	color_15 = "#c7e1ff",
}
