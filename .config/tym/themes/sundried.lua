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

local fg = "#c9c9c9"
local bg = "#1a1818"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#302b2a",
	color_1 = "#a7463d",
	color_2 = "#587744",
	color_3 = "#9d602a",
	color_4 = "#485b98",
	color_5 = "#864651",
	color_6 = "#9c814f",
	color_7 = "#c9c9c9",
	color_8 = "#4d4e48",
	color_9 = "#aa000c",
	color_10 = "#128c21",
	color_11 = "#fc6a21",
	color_12 = "#7999f7",
	color_13 = "#fd8aa1",
	color_14 = "#fad484",
	color_15 = "#ffffff",
}
