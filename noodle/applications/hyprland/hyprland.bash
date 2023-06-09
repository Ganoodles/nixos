# Source a file (multi-file configs)
# source = ~/.config/hypr/myColors.conf

### startup apps
exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# status bar
exec-once = waybar &

# wallpapers
exec-once = swww init
exec = swww img ~/.nix/wallpapers/leaves-1.jpg
# exec = swww img -o DP-3 ~/.nix/wallpapers/spider-mocha.png
# exec = swww img -o HDMI-A-1 ~/.nix/wallpapers/spider-v-mocha.png

# polkit is started in ~/.nix/system/configuration.nix under systemd
# clipboard manager
exec-once = wl-paste -p -t text --watch clipman store -P --histpath="~/.local/share/clipman-primary.json"
# auto mount
exec-once = udiskie &


autogenerated = 0 # remove this line to remove the warning

# See https://wiki.hyprland.org/Configuring/Monitors/
monitor = DP-3, highrr, 1080x0, 1
monitor = HDMI-A-1, highrr, 0x0, 1, transform, 1

# Some default env vars.
env = XCURSOR_SIZE,24

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0.25 # -1.0 - 1.0, 0 means no modifications
    accel_profile = flat
}


decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 5
    blur = yes
    blur_size = 3
    blur_passes = 1
    blur_new_optimizations = on

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}


animations {
    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    enabled = yes

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 3, default, popin
    animation = windowsOut, 1, 7, default, popin 80%
    animation = borderangle, 1, 8, default
    animation = fade, 1, 3, default
    animation = workspaces, 1, 6, default
    # animation = border, 2, 10, default
}


dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = true
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = off
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device:epic-mouse-v1 {
    sensitivity = -0.5
}

# Example windowrule v2
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
windowrule = float, pavucontrol

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# custom
bind = $mainMod SHIFT, V, exec, clipman pick -t rofi
bind = $mainMod, F, fullscreen

### screenshot bindings
# bind = $mainMod, P, exec, grim -g "$(slurp -d)" - | wl-copy -t 'image/png'
# bind = $mainMod SHIFT, P, exec, grim -o "$(hyprctl monitors | awk '/focused: yes/ {print $2}') - | wl-copy -t 'image/png'"

$scriptsDir = $HOME/.nix/dotfiles/hypr/scripts

# Screenshots
# bind = , Print, submap, screenshot
# submap = screenshot

# copies screen to clipboard
bind = $mainMod SHIFT, L, exec, $scriptsDir/grimblast -n copy screen
# copies monitor to clipboard
bind = $mainMod SHIFT, P, exec, $scriptsDir/grimblast -n copy output
# copies region to clipboard 
bind = $mainMod, P, exec, $scriptsDir/grimblast -n copy area

# bind = , 1, submap, reset
# bind = , 2, exec, $scriptsDir/grimblast -n copysave output
# bind = , 2, submap, reset
# bind = , 3, exec, $scriptsDir/grimblast -n copysave active
# bind = , 3, submap, reset
# bind = , 4, exec, $scriptsDir/grimblast -n copysave area
# bind = , 4, submap, reset
# bind = , escape, submap, reset
# submap = reset
# bind = SHIFT, Print, exec, $scriptsDir/grimblast -n copy output


# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, RETURN, exec, kitty
bind = $mainMod SHIFT, Q, killactive, 
bind = $mainMod SHIFT, M, exit, 
bind = $mainMod, E, exec, nautilus
bind = $mainMod, SPACE, togglefloating, 
bind = $mainMod, D, exec, rofi -show drun -theme dmenu -font "hack 10" 
# bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
