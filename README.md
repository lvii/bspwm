
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

需要创建 `~/.Xdefaults`、`~/.Xdefaults-$HOSTNAME` **软链** 接指向 `~/.Xresources` ：

    $ ll ~/.Xdefaults-$HOSTNAME ~/.Xdefaults
    lrwxrwxrwx 1 i i 11 | 2017-05-10 14:49 | /home/user/.Xdefaults -> .Xresources
    lrwxrwxrwx 1 i i 11 | 2017-05-10 11:12 | /home/user/.Xdefaults-fedora -> .Xresources

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

[Arbitrary splits without new windows? #259](https://github.com/baskerville/bspwm/issues/259)

# lemonbar-xft

字体：

    PANEL_FONT_EN="Bitstream Vera Sans Mono-11"
    PANEL_FONT_CN="WenQuanYi Micro Hei Mono-11"

软件包：

    ## free memory
    $ rpm -qf $(which vmstat)
    procps-ng-3.3.10-13.fc26.x86_64

# composite manager

## compton

命令：`compton -b -cCG -l0 -t0 -r3 -o0.4 -e0.8 -m0.9 -f -D2`

参数 | 参数 | 释义
---- | ---- | ----
`-b` | `--daemon` | 后台进程
`-c` | `--shadow` | 启用阴影效果
`-C` | `--no-dock-shadow` | dock 及 panel 不启用阴影
`-G` | `--no-dnd-shadow` | `drag-and-drop` 窗口不启用阴影
`-l` | `--shadow-offset-x` | 阴影 X 座标
`-t` | `--shadow-offset-y` | 阴影 Y 座标
`-r` | `--shadow-radius` | 阴影模糊半径，默认 `12px`
`-o` | `--shadow-opacity` | 阴影透明，默认 `0.75`
`-e` | `--frame-opacity` | 边框透明，默认 **禁用**
`-m` | `--menu-opacity` | 菜单透明，默认 **禁用**
`-f` | `--fading` | 启用淡出效果
`-D` | `--fade-delta` | 淡出效果时间，默认 `10ms`

壁纸预览：

![img_tile_random_pixel](https://www.dropbox.com/s/6ybjv48tct5ing2/tile-random-pixel.gif?dl=1)

下载桌面：

    img_wallpaper=~/.bg.gif
    img_url="https://www.dropbox.com/s/6ybjv48tct5ing2/tile-random-pixel.gif?dl=1"
    curl -m 8 -Ss -x socks5h://127.0.0.1:9090 -L "$img_url" \
         -o $img_wallpaper && feh --bg-tile $img_wallpaper

urxvt 透明效果：

![img_urxvt_transparent_bg](https://www.dropbox.com/s/sb5hr6u9n2ffrg2/urxvt-bg-img.png?dl=1)

https://wiki.archlinux.org/index.php/Compton

https://github.com/yurisuika/Dotfiles/blob/master/.config/compton.conf

https://github.com/neynt/dotfiles/blob/master/compton.conf

