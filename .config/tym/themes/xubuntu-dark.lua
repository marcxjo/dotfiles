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

local fg = "#b7b7b7"
local bg = "#131925"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#000000",
	color_1 = "#aa0000",
	color_2 = "#44aa44",
	color_3 = "#aa5500",
	color_4 = "#0039aa",
	color_5 = "#aa22aa",
	color_6 = "#1a92aa",
	color_7 = "#aaaaaa",
	color_8 = "#777777",
	color_9 = "#ff8787",
	color_10 = "#4ce64c",
	color_11 = "#ded82c",
	color_12 = "#295fcc",
	color_13 = "#cc58cc",
	color_14 = "#4ccce6",
	color_15 = "#ffffff",
}
