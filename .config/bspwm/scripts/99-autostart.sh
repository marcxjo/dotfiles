# Start up desktop environment utilities if not running

# Start compositor
is_not_running picom && picom &

# Set background.
set-background -t bspwm -w &

# Set desktop colors.
# TODO: fix symlinking in themer script.
#set-desktop-colors &

[[ -f "$HOME/.Xresources" ]] && \
	xrdb "$HOME/.Xresources" &

[[ -f "$HOME/.local/share/themes/bspwm/colors.xresources" ]] && \
	xrdb -merge "$HOME/.local/share/themes/bspwm/colors.xresources"

[[ -x "$HOME/.local/share/themes/bspwm/colors.sh" ]] && \
	. "$HOME/.local/share/themes/bspwm/colors.sh"

[[ -x "$HOME/.local/share/themes/bspwm/post_theme" ]] && \
	. "$HOME/.local/share/themes/bspwm/post_theme" &

# Start panels.
is_not_running polybar && panel -s &

# Start notifier.
is_not_running dunst && ddunst &

is_not_running xscreensaver && xscreensaver -no-splash &

is_not_running pulseaudio && pulseadio --start

