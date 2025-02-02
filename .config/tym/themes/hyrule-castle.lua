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

local fg = "#ebe9db"
local bg = "#242a16"
local bg_trans = to_rgba(bg, "0.95")

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#837b5c",
	color_1 = "#708734",
	color_2 = "#74874f",
	color_3 = "#ac942a",
	color_4 = "#8d8d67",
	color_5 = "#7a93fe",
	color_6 = "#999894",
	color_7 = "#90a9fe",
	color_8 = "#b5aa7f",
	color_9 = "#c1c7b1",
	color_10 = "#cfd4c7",
	color_11 = "#d1c79b",
	color_12 = "#bfbf8c",
	color_13 = "#9db0fe",
	color_14 = "#bab9b4",
	color_15 = "#d8e0fe",
}
