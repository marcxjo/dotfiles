# Basic tiling heuristic
# In general, split the focused window's longer side

function get_dimensions() {
  xdotool getwindowgeometry ${1} | grep "Geometry:" | awk '{print $2}' | sed 's|x| |'
}

fwid=$(bspc query -N -n focused.automatic)

if [ -n "$fwid" ] ; then
  get_dimensions $fwid | {
    read width height
      if [ $width -gt $height ] ; then
        echo "split_dir=east"
      else
        echo "split_dir=south"
      fi
  }
fi
