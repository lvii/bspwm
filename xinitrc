#! /bin/sh

img_wallpaper=~/.bg.gif
usr_resources=~/.Xresources
sys_resources=/etc/X11/xinit/Xresources


# [ -s "$sysresources" ] && xrdb -merge "$sysresources"
# [ -s "$usrresources" ] && xrdb -merge "$usrresources"

## Fedora: /etc/X11/xinit/xinitrc
source /etc/X11/xinit/xinitrc-common

# xset +fp /usr/share/fonts/local &
# xset +fp /usr/share/fonts/misc &
# xset +fp ~/.fonts &
# xset fp rehash &
# fc-cache -fv &

# ## https://github.com/noctuid/dotfiles/blob/master/startup/.xinitrc
# ## faster key repeat rate and shorter delay (default is 660 25)
# xset r rate 300 35

xsetroot -cursor_name left_ptr &
# hsetroot -fill wallpaper_img
# urxvtd -q -o -f

ibus-daemon --daemonize --replace --xim

[ -f /usr/bin/vmware-user-suid-wrapper ] && vmware-user-suid-wrapper &

[ -s "$img_wallpaper" ] && feh --bg-tile $img_wallpaper

compton -b -cCG -l0 -t0 -r3 -o0.4 -m0.9 -f -D2

exec bspwm

## END
