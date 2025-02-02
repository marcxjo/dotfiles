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

local fg = "#ffcb83"
local bg = "#262626"
local bg_trans = to_rgba(bg, 0.95)

return {
	color_foreground = fg,
	color_background = bg_trans,
	color_window_background = bg_trans,

	color_0 = "#000000",
	color_1 = "#c13900",
	color_2 = "#a4a900",
	color_3 = "#caaf00",
	color_4 = "#bd6d00",
	color_5 = "#fc5e00",
	color_6 = "#f79500",
	color_7 = "#ffc88a",
	color_8 = "#6a4f2a",
	color_9 = "#ff8c68",
	color_10 = "#f6ff40",
	color_11 = "#ffe36e",
	color_12 = "#ffbe55",
	color_13 = "#fc874f",
	color_14 = "#c69752",
	color_15 = "#fafaff",
}
