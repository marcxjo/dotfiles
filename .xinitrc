. /etc/X11/xinit/xinitrc-common

# Based on a very individual Fedora setup.
# Be prepared to tailor according to your needs.

# Set up proper monitor alignment before login.
# This is helpful to get things set up right in bspwm.

MONITORS=$(xrandr --listactivemonitors | grep -E "DVI-[01]$" | wc -l)

if [ $MONITORS -eq 2 ]; then
	xrandr --output DVI-1 --primary --left-of DVI-0
fi

# I WANT MY DAMN NUM LOCK ON WHEN I LOG IN.

NUM_LOCK_STATE=$(xset -q | grep Caps | awk '{print $8}')

if [ "$NUM_LOCK_STATE" == "off" ]; then
	xdotool key Num_Lock
fi

# bspwm inherits X11's default "X" shaped cursor.
# Here we fix that.

xsetroot -cursor_name left_ptr

# Make sure X recognizes our font dir.
# Without this lemonbar won't show icons from Siji.

xset +fp ~/.fonts
xset fp rehash

xscreensaver &
sxhkd &
exec bspwm
