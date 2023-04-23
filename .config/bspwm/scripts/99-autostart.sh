# Start up desktop environment utilities if not running

# Start compositor
is_running picom || picom &

# Set background.
set-background -t bspwm -w &

# Set desktop colors.
# TODO: fix symlinking in themer script.
#set-desktop-colors &

test -f "$HOME/.Xresources" && \
	xrdb "$HOME/.Xresources" &

test -f "$HOME/.local/share/themes/bspwm/colors.xresources" && \
	xrdb -merge "$HOME/.local/share/themes/bspwm/colors.xresources"

test -x "$HOME/.local/share/themes/bspwm/colors.sh" && \
	. "$HOME/.local/share/themes/bspwm/colors.sh"

test -x "$HOME/.local/share/themes/bspwm/post_theme" && \
	. "$HOME/.local/share/themes/bspwm/post_theme" &

# Start panels.
is_running polybar || panel -s &

# Start notifier.
is_running dunst || ddunst &

is_running xscreensaver || xscreensaver -no-splash &

is_running pulseaudio || pulseadio --start

