# sudo aptitude install feh
# sudo aptitude install dmenu

# Keyboard layout
setxkbmap ch

xrandr --output DP-2 --left-of DP-1
xrandr --output DP-1 --mode 1920x1200
xrandr --output DP-2 --mode 1280x1024

# Wallpaper
feh --bg-fill  ~/Pictures/debian_1920x1080.png

# Set startup volume
#pactl set-sink-volume 0 '20%' &

# Disable beeps
xset -b &

## DPMS monitor setting (standby -> suspend -> off) (seconds)
xset dpms 300 600 900 &

## Set LCD brightness
#xbacklight -set 90 &

# Dunst daemon
killall dunst ; dunst -conf ~/.dunstrc &

