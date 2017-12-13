# sudo aptitude install feh
# sudo aptitude install dmenu

# Keyboard layout
setxkbmap us

#xrandr --output DP-2 --left-of DP-1
# xrandr --output VGA-1 --left-of DP-1
##xrandr --output DVI-I-1 --mode 1920x1080
xrandr --output HDMI-0 --mode 1920x1080
xrandr --output DVI-I-1 --left-of HDMI-0
# xrandr --output DP-2 --mode 1280x1024
#xrandr --output DP-2 --mode 1920x1200
# xrandr --output VGA-1 --mode 1920x1080

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
#killall dunst ; dunst -conf ~/.dunstrc &

