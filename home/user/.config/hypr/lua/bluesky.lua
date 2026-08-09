-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "foot"
local fileManager = "pcmanfm"
local menu        = "fuzzel"
local screenshot  = "screenshot"
local SmartTerm   = "foot -a SmartTerm"
local wlshot      = "wlshot"
local waypaper    = "waypaper"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
   hl.exec_cmd("hyprbar & reloadwaybar & waypaper --restore &  mako & waybar & dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY XAUTHORITY  &")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

 hl.env("XCURSOR_SIZE", "24")
 hl.env("HYPRCURSOR_SIZE", "24")
 hl.env("XDG_SESSION_TYPE", "wayland")
 hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
 hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 6,
        gaps_out = 13,

        border_size = 6,

        col = {
            active_border   = { colors = {"rgb(6895CF)", "rgb(435B8E)", "rgb(435B8E)"}, angle = 99 },
            inactive_border = "rgb(6895CF)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,
        extend_border_grab_area = 1,
        hover_icon_on_border = true,
        layout = "master",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 6,
            render_power = 6,
            color        = 0xee444444,
        },

        blur = {
            enabled   = true,
            size      = 4,
            passes    = 4,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
    plugin = {
        hyprbars = {
        bar_height = 24,
        bar_title_enabled = true,
        bar_text_align = "left",
        bar_text_font = "DejaVu Sans Mono Bold",
        bar_text_size = 14,
        icon_on_hover = true, 
        bar_color = "rgb(6895CF)",
        bar_part_of_window = true,
        bar_precedence_over_border = true,
        bar_button_padding = 15,
        bar_padding = 12,
        ["col.text"] = "rgb(ffffff)",
        },
    },
})

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(5378B6)",
    fg_color = "rgb(5378B6)",
    size = 18,
    icon = "  ", -- Ícone Nerd Font ou caractere
    action = "hyprctl dispatch 'hl.dsp.window.close()'",
})

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(5378B6)",
    fg_color = "rgb(5378B6)",
    size = 18,
    icon = "",
    action = "maximize",
})

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(5378B6)",
    fg_color = "rgb(5378B6)",
    size = 18,
    icon = "",
    action = "move_top_level_to",
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 3,       bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39,    bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79,    spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,     spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49,    bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 3,       bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 3,       bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03,    bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81,    bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 3,       bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 3,       bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 3,       bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 3,       bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 3,       bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 3,       bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 3,       bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,       bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
for i = 1, 7 do
    hl.workspace_rule({
        workspace = tostring(i),
        persistent = true,
    })
end
-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
        mfact = "0.50",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------



hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "br",
        kb_variant = "",
        kb_model   = "thinkpad",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 0,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "MOD5" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + T", hl.dsp.exec_cmd(SmartTerm))
hl.bind("PRINT", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(waypaper))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd(wlshot))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
local closeWindowBind = hl.bind(mainMod .. "+ K", hl.dsp.window.close())
local closeWindowBind = hl.bind("SUPER + K", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. "+ SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. "+ SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. "+ SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. "+ SHIFT + down",  hl.dsp.window.move({ direction = "down" }))


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind("SUPER + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Fullscreen
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("mixer vol=+0.05"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("mixer vol=-0.05"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(""),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(""),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("backlight incr 5"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("backlight decr 5"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "",
    match = { class = ""},
    workspace = 1,
})

hl.window_rule({
    name  = "SmartTerm",
    match = { class = "SmartTerm" },
    float      = true,
})

hl.window_rule({
    name  = "galculator",
    match = { class = "galculator" },
    float      = true,
})

hl.window_rule({
    name  = "lxtask",
    match = { class = "lxtask" },
    float      = true,
    size = {300, 500},
    move = {810, 300},
})

hl.window_rule({
    name  = "xdg-desktop-portal-gtk",
    match = { class = "xdg-desktop-portal-gtk" },
    float      = true,
    size = {900, 700},
    move = {500, 200},
})

hl.window_rule({
    name  = "Kotatogram",
    match = { class = "io.github.kotatogram"},
    workspace = "1",
})

hl.window_rule({
    name  = "deadbeef",
    match = { class = "deadbeef"},
    workspace = 1,
})

hl.window_rule({
    name  = "foot",
    match = { class = "foot" },
    workspace = 5,
})

hl.window_rule({
    name  = "firefox",
    match = { class = "firefox"},
    workspace = 2,
})

hl.window_rule({
    name  = "transmission",
    match = { class = "transmission"},
    workspace = 3,
})

hl.window_rule({
    name  = "lite-xl",
    match = { class = "lite-xl"},
    workspace = 4,
})

hl.window_rule({
    name  = "org.xfce.mousepad",
    match = { class = "org.xfce.mousepad"},
    workspace = 4,
})

hl.window_rule({
    name  = "SDL_App",
    match = { class = "SDL_App"},
    workspace = 4,
})

hl.window_rule({
    name  = "gucharmap",
    match = { class = "gucharmap"},
    workspace = 4,
})

hl.window_rule({
    name  = "vi",
    match = { class = "vi"},
    workspace = 4,
})

hl.window_rule({
    name  = "mpv",
    match = { class = "mpv"},
    workspace = 6,
})

hl.window_rule({
    name  = "ffplay",
    match = { class = "ffplay"},
    workspace = 6,
})

hl.window_rule({
    name  = "imv",
    match = { class = "imv"},
    workspace = 6,
})

hl.window_rule({
    name  = "Gimp-2.10",
    match = { class = "Gimp-2.10"},
    workspace = 6,
})

hl.window_rule({
    name  = "nwg-look",
    match = { class = "nwg-look"},
    float = true, 
    workspace = 7,
})

hl.window_rule({
    name  = "<unknown>",
    match = { class = "<unknown>"},
    float = true, 
    workspace = 7,
})

hl.window_rule({
    name  = "Waypaper",
    match = { class = "Waypaper" },
    float = true,
    workspace = 7,
})

hl.window_rule({
    name  = "waypaper",
    match = { class = "waypaper"},
    float = true,
    workspace = 7,
})

hl.window_rule({
    name  = "gsimplecal",
    match = { class = "gsimplecal"},
    border_size = 0,
    move = {1430, 40},
})


local myLayerRule = hl.layer_rule({
  name  = "my-layer-rule",
  match = { namespace = "waybar" },
  blur  = true,
})

