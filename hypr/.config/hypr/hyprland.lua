local HOME = os.getenv("HOME")
local XDG_RUNTIME_DIR = os.getenv("XDG_RUNTIME_DIR") or ""

-----------------------------------------------------
-- PROGRAMS / PATHS
-----------------------------------------------------

local terminal = "wezterm"
local fileManager = "dolphin"
local menu = "rofi -show drun"

local init = HOME .. "/.config/hypr/scripts/init.sh"
local switchTheme = HOME .. "/.local/bin/wall.sh"
local nightLight = HOME .. "/.local/bin/night-light.sh"
local waybarReload = HOME .. "/.config/waybar/scripts/reload.sh"
local record = HOME .. "/.config/hypr/scripts/recording_mp4.sh"
local recordGif = HOME .. "/.config/hypr/scripts/recording_gif.sh"
local clipboard = HOME .. "/.config/hypr/scripts/clipboard-rofi.sh"
local keyboard = HOME .. "/.config/hypr/scripts/kb-toggle.sh"

local mainMod = "SUPER"

-- Convenience wrapper for external commands.
local function exec(command)
    return hl.dsp.exec_cmd(command)
end

-----------------------------------------------------
-- ENVIRONMENT VARIABLES
-----------------------------------------------------

hl.env("SSH_AUTH_SOCK", XDG_RUNTIME_DIR .. "/keyring/ssh")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "fcitx")

-----------------------------------------------------
-- MONITORS
-----------------------------------------------------

hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@80",
    position = "0x0",
    scale = 1,
})

-----------------------------------------------------
-- AUTOSTART
-----------------------------------------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")

    hl.exec_cmd("ssh-agent -s")
    hl.exec_cmd(init)
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,ssh,pkcs11")
    hl.exec_cmd("mako")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("fcitx5 -d")

    -- Switch on clipboard history
    hl.exec_cmd("wl-paste --watch cliphist store")
end)

-----------------------------------------------------
-- LOOK AND FEEL
-----------------------------------------------------

hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 4,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "master",
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,
        active_opacity = 0.95,
        inactive_opacity = 0.7,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 2,
            passes = 3,
            new_optimizations = true,
            xray = true,
            ignore_opacity = true,
            vibrancy = 0.1696,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        orientation = "left",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})

-----------------------------------------------------
-- ANIMATIONS
-----------------------------------------------------

hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1.0 }, { 0.32, 1.0 } },
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { { 0.65, 0.05 }, { 0.36, 1.0 } },
})

hl.curve("linear", {
    type = "bezier",
    points = { { 0.0, 0.0 }, { 1.0, 1.0 } },
})

hl.curve("almostLinear", {
    type = "bezier",
    points = { { 0.5, 0.5 }, { 0.75, 1.0 } },
})

hl.curve("quick", {
    type = "bezier",
    points = { { 0.15, 0.0 }, { 0.1, 1.0 } },
})

-- animations.enabled = yes, please :)
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4.0, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-----------------------------------------------------
-- INPUT
-----------------------------------------------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "compose:ralt",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

-----------------------------------------------------
-- KEYBINDINGS
-----------------------------------------------------

-- Applications
hl.bind(mainMod .. " + Return", exec(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + D", exec(fileManager))
hl.bind(mainMod .. " + T", hl.dsp.window.float())
hl.bind(mainMod .. " + SPACE", exec(menu))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + minus", exec([[wtype "—"]]))

-- Lock
hl.bind(mainMod .. " + L", exec("swaylock -f -c 000000"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 9 do
    hl.bind(
        mainMod .. " + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i, follow = true })
    )
end
hl.bind(
    mainMod .. " + SHIFT + 0",
    hl.dsp.window.move({ workspace = 10, follow = true })
)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" })
)
hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" })
)

-- Toggle Fullscreen
hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen({ mode = "maximized" })
)

-- Reload Waybar
hl.bind(mainMod .. " + R", exec(waybarReload))

-- Screenshots
hl.bind(
    "SHIFT + Print",
    exec([[grim -g "$(slurp)" ~/Pictures/Screenshots/Screenshot-$(date +'%Y%m%d-%H%M%S').png]])
)

hl.bind(
    "CTRL + Print",
    exec([[grim - | wl-copy]])
)

hl.bind(
    mainMod .. " + Print",
    exec([[grim -g "$(slurp)" - | wl-copy && wl-paste | swappy -f -]])
)

-- Record region and save it in mp4
hl.bind(mainMod .. " + V", exec(record))

-- Record region and save it to gif
hl.bind(mainMod .. " + SHIFT + V", exec(recordGif))

-- Clipboard history
hl.bind(mainMod .. " + Z", exec(clipboard))

-- Configs
hl.bind(
    mainMod .. " + H",
    exec([[code ~/dotfiles ~/dotfiles/hypr/.config/hypr/hyprland.lua]])
)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

-----------------------------------------------------
-- LAPTOP MULTIMEDIA KEYS
-----------------------------------------------------

hl.bind(
    "XF86AudioRaiseVolume",
    exec([[wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+]]),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    exec([[wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-]]),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86AudioMute",
    exec([[wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle]]),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86AudioMicMute",
    exec([[wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle]]),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86MonBrightnessUp",
    exec([[brightnessctl -e4 -n2 set 5%+]]),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    exec([[brightnessctl -e4 -n2 set 5%-]]),
    { repeating = true, locked = true }
)

-- Requires playerctl
hl.bind(
    "XF86AudioNext",
    exec([[playerctl next]]),
    { locked = true }
)

hl.bind(
    "XF86AudioPause",
    exec([[playerctl play-pause]]),
    { locked = true }
)

hl.bind(
    "XF86AudioPlay",
    exec([[playerctl play-pause]]),
    { locked = true }
)

hl.bind(
    "XF86AudioPrev",
    exec([[playerctl previous]]),
    { locked = true }
)

-----------------------------------------------------
-- CUSTOM SCRIPTS
-----------------------------------------------------

hl.bind(mainMod .. " + W", exec(switchTheme))
hl.bind("SUPER + N", exec(nightLight .. " toggle"))
hl.bind(mainMod .. " + K", exec(keyboard))

-----------------------------------------------------
-- WINDOWS AND WORKSPACES
-----------------------------------------------------

hl.window_rule({
    match = {
        class = "(.*)",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_initial_focus = true,
})

-----------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------

-- Permission enforcement remains disabled, matching the original config,
-- where ecosystem.enforce_permissions was commented out.

hl.permission({
    binary = "/usr/(bin|local/bin)/grim",
    type = "screencopy",
    mode = "allow",
})

hl.permission({
    binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",
    type = "screencopy",
    mode = "allow",
})

-- ecosystem permissions from the old config were intentionally not enabled:
-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })