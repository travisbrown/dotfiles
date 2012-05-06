setxkbmap -option terminate:ctrl_alt_bksp
xmodmap -e "keycode 133 = Multi_key"
xrdb -merge ~/.Xresources
exec ck-launch-session xmonad

