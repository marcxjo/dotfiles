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

local fg = "#d9e6f2"
local bg = "#0d1926"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#000000",
	color_1 = "#b87a7a",
	color_2 = "#7ab87a",
	color_3 = "#b8b87a",
	color_4 = "#7a7ab8",
	color_5 = "#b87ab8",
	color_6 = "#7ab8b8",
	color_7 = "#d9d9d9",
	color_8 = "#262626",
	color_9 = "#dbbdbd",
	color_10 = "#bddbbd",
	color_11 = "#dbdbbd",
	color_12 = "#bdbddb",
	color_13 = "#dbbddb",
	color_14 = "#bddbdb",
	color_15 = "#ffffff",
}
