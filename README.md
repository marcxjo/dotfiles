# dotfiles

Config files for a setup based primarily on bspwm, polybar, dunst, and stupidterm.

One of the highlights of this repo is a collection of scripts that allows the user to create and switch color themes for the main applications. Ini file creation is automated for the apps that rely on them.

A few starter color schemes are included. Most of the files are {minorly ,un-}modified colorshemes generated by the shell script/recently obsoleted version of wal. Note that this version of wal tends to generate far more colors than the Python version, at least in its default configuration.

---

# TODO

* Links to wallpapers that match included color schemes for a nice theme starter.

* Easy automation of switching themes non-destructively (i.e., without just needlessly re-writing existing copies of files.)

---

# About directories

Config files are placed in the usual xdg directory.

Themes are placed under ~/.local/share to match the conventions of system-level themes for frameworks like GTK+. This does not accord with the convention of ~/.themes for home themes in order to keep X11 theme elements from creating directories which conflict with GTK+ or other themes.

Scripts are placed under ~/bin, as Python's Pip installer and other FHS-adherent programs tend to use ~/.local/bin for user-level installs. Helper scripts or "plugin"-style scripts (such as the themer components of `wal-post-script`) are placed in subdirectories under ~/bin.

---

# Thanks

* The Python script "player-mpris-tail.py" (used in the polybar config) is a slight modification of the script found at https://github.com/x70b1/polybar-scripts/blob/master/polybar-scripts/player-mpris-tail/player-mpris-tail.py. See the aforementioned git repo for the accompanying shell script.

* The Python script "weather" (also used in the polybar config) is a slight modification of the script found at https://github.com/anchnk/dotfiles/blob/master/polybar/.config/polybar/weather.
