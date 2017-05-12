
# xinitrc

尽量存放和 X11 相关配置

https://www.transparenttextures.com/random-grey-variations.html

https://wiki.archlinux.org/index.php/Xinit

https://wiki.archlinux.org/index.php/Xprofile

# urxvt

配置文件 **匹配顺序** `man urxvt` 手册：

You can set and change the resources using X11 tools like `xrdb`. Many distribution do also load settings from the `~/.Xresources` file when X starts. urxvt will consult the following files/resources in order, with **later settings overwriting earlier ones**:

1. app-defaults file in `$XAPPLRESDIR`
2. `$HOME/.Xdefaults`
3. `RESOURCE_MANAGER` property on root-window of screen 0
4. `SCREEN_RESOURCES` property on root-window of the current screen
5. `$XENVIRONMENT` file OR `$HOME/.Xdefaults-<nodename>`
6. resources specified via `-xrm` on the commandline

需要创建 `~/.Xdefaults`、`~/.Xdefaults-$HOSTNAME` 软链接指向 `~/.Xresources`

# bspwm

https://github.com/baskerville/bspwm/blob/master/examples/sxhkdrc

https://github.com/baskerville/bspwm/commits/master/examples/sxhkdrc

## command

命令 | 操作
---- | ----
`bspc node @focused:/ --rotate 90` | **顺时针** 切换布局
`bspc node -i` | 创建 Receptacle

## feature

### receptacle

[Is it possible to create a startup workspace? #371](https://github.com/baskerville/bspwm/issues/371)

2016-05-27 [e8aa679](https://github.com/baskerville/bspwm/commit/e8aa679cd14fad3bdc89119c53d5c6eca6512bf0) 引入 receptacle 支持自动创建 layout 并启动相关程序

> **Receptacles** are used for building a tree without creating windows.

# composite manager

## compton

https://wiki.archlinux.org/index.php/Compton

https://github.com/yurisuika/Dotfiles/blob/master/.config/compton.conf

https://github.com/neynt/dotfiles/blob/master/compton.conf

壁纸预览：

![img_tile_random_pixel](https://www.dropbox.com/s/6ybjv48tct5ing2/tile-random-pixel.gif?dl=1)

下载桌面：

    img_wallpaper=~/.bg.gif
    img_url="https://www.dropbox.com/s/6ybjv48tct5ing2/tile-random-pixel.gif?dl=1"
    curl -m 8 -Ss -x socks5h://127.0.0.1:9090 -L "$img_url" \
         -o $img_wallpaper && feh --bg-tile $img_wallpaper

urxvt 透明效果：

![img_urxvt_transparent_bg](https://www.dropbox.com/s/48zcmxizrjq0gfk/urxvt-with-transparent-background.png?dl=1)

## xcompmgr

使用 `xcompmgr` 缩放 urxvt 窗口会出现无法输入的 bug

https://www.freedesktop.org/wiki/Software/xapps/

apps | about
---- | -----
`fdclock` | the Freedesktop clock (uses cairo)
`transset` | manipulate the `_NET_WM_WINDOW_OPACITY` property
`uncover` | demonstrates transformed windows with Composite
`wininfo` | a window information utility for X
`xclock` | regular xclock app with Render support
`xcompmgr` | Sample X Compositing Manager
`xdamage` | Test application for Damage extension
`xditview` | What the heck is this doing here?
`xdpyinfo` | X Display Information
`xev` | print contents of X events
`xrandr` | X Resize and Rotate command line app
`xrestop` | 'top' for X resources



