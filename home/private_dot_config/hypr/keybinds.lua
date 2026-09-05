-- https://wiki.hypr.land/Configuring/Basics/Binds/
-- https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local vars = require("vars")
local mainMod = vars.mainMod

-- general
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind("CTRL + ALT + DELETE", hl.dsp.exit())
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(vars.fileManager))

-- rofi
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(vars.emoji))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(vars.launcher))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(vars.powermenu))

-- window manipulation
hl.bind(mainMod .. " + SPACE", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.center())
end)

hl.bind(mainMod .. " + W", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pin())

-- window manipulation with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- change focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- move active
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- move floating
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.move({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.move({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.move({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.move({ x = 20, y = 0, relative = true }), { repeating = true })

-- resize active
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 20 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -20 }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 20, y = 0 }), { repeating = true })

-- cycle windows
hl.bind(mainMod .. " + TAB", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end, { repeating = true })

hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.cycle_next({ next = false }), { repeating = true })

-- previous workspace
hl.bind(mainMod .. " + GRAVE", hl.dsp.focus({ workspace = "previous" }))

-- switch workspaces
for i = 1, 10 do
    local key = i % 10
    local czKey = vars.czDigits[i]

    hl.bind(mainMod .. " + " .. czKey, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

    hl.bind(mainMod .. " + SHIFT + " .. czKey, hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("s"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:s" }))
hl.bind(mainMod .. " + G", hl.dsp.workspace.toggle_special("g"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.window.move({ workspace = "special:g" }))

-- groups
hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + CTRL + TAB", hl.dsp.group.next())

-- scroll through workspaces
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))

-- media control
hl.bind("PRINT", hl.dsp.exec_cmd(vars.screenshot))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(vars.volume .. " up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(vars.volume .. " down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(vars.volume .. " mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind(mainMod .. " + mouse:275", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(vars.brightness .. " up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(vars.brightness .. " down"), { locked = true, repeating = true })

hl.bind("XF86Search", hl.dsp.exec_cmd(vars.launcher), { locked = true, repeating = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- lid behaviours
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd(vars.lidhandle .. " close"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd(vars.lidhandle .. " open"), { locked = true })
