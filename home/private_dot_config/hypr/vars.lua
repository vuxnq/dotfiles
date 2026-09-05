local home = os.getenv("HOME")

local M = {}

M.mainMod = "SUPER"

M.terminal = "kitty"
M.fileManager = "thunar"
M.wallpaper = home .. "/.local/share/backgrounds/waves.png"

-- rofi
M.emoji = home .. "/.config/rofi/emoji.sh"
M.launcher = home .. "/.config/rofi/launcher.sh"
M.powermenu = home .. "/.config/rofi/powermenu.sh"
M.screenshot = home .. "/.config/rofi/screenshot.sh"

-- scripts
M.lidhandle = home .. "/.local/bin/lidhandle.sh"
M.brightness = home .. "/.local/bin/brightness.sh"
M.volume = home .. "/.local/bin/volume.sh"
M.autofilen = home .. "/.local/bin/autofilen.sh"
M.setlockimg = home .. "/.local/bin/setlockimage.sh"

-- cz keyboard layout digit fix
M.czDigits = { "PLUS", "ECARON", "SCARON", "CCARON", "RCARON", "ZCARON", "YACUTE", "AACUTE", "IACUTE", "EACUTE" }

return M
