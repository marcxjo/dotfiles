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

local fg = "#ffffff"
local bg = "#1a1a1a"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#2e3436",
	color_1 = "#cc0000",
	color_2 = "#4d9a05",
	color_3 = "#c3a000",
	color_4 = "#3464a3",
	color_5 = "#754f7b",
	color_6 = "#05979a",
	color_7 = "#555753",
	color_8 = "#545652",
	color_9 = "#ef2828",
	color_10 = "#89e234",
	color_11 = "#fbe84f",
	color_12 = "#729ecf",
	color_13 = "#ac7ea8",
	color_14 = "#34e2e2",
	color_15 = "#ededeb",
}
