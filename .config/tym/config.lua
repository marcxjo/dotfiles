-- At first, you need to require tym module
local tym = require("tym")

-- set by table
tym.set_config({
  font = "JetBrains Mono 9",
  cursor_blink_mode = "system",
  bold_is_bright = "true",
  audible_bell = "true",
})

tym.set_keymaps({
  ["<Ctrl><Shift>r"] = function()
    tym.reload()
    tym.notify("Reloaded")
  end,
  ["<Ctrl><Alt><Shift>r"] = function()
    tym.reset_config()
    tym.reload()
    tym.notify("Reset and Reloaded")
  end,
  ["<Ctrl>equal"] = function()
    tym.set("scale", 100)
    tym.notify("Reset font scale")
  end,
  ["<Ctrl><Shift>plus"] = function()
    local s = tym.get("scale") + 10
    tym.set("scale", s)
    tym.notify("Scale:" .. s)
  end,
  ["<Ctrl>minus"] = function()
    local s = tym.get("scale") - 10
    tym.set("scale", s)
    tym.notify("Scale:" .. s)
  end,
})

-- tym.set_hook(
--   "signal",
--   function(p)
--   end
-- )
