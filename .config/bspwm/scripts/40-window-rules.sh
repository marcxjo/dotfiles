# Special case window handling

bspc rule -a Gimp     state=floating
# Media player gets the whole laptop screen to itself
bspc rule -a mpv      monitor=DP-1 focus=off state=floating sticky=on
bspc rule -a Surf     state=tiled

