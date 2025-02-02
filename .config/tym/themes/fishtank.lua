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

local fg = "#ecf0fe"
local bg = "#232537"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#03073c",
	color_1 = "#c6004a",
	color_2 = "#acf157",
	color_3 = "#fecd5e",
	color_4 = "#525fb8",
	color_5 = "#986f82",
	color_6 = "#968763",
	color_7 = "#ecf0fc",
	color_8 = "#6c5b30",
	color_9 = "#da4b8a",
	color_10 = "#dbffa9",
	color_11 = "#fee6a9",
	color_12 = "#b2befa",
	color_13 = "#fda5cd",
	color_14 = "#a5bd86",
	color_15 = "#f6ffec",
}
