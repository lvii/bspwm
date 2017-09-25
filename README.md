
# Fedora

Fedora 26 vmware VM 软件包：

    PKGS=$(echo 'bash-completion
    git
    keychain
    rsync
    tree
    tmux
    wget
    figlet
    bzip2
    unzip
    unar
    xz
    fping
    iftop
    iotop
    ethtool
    telnet
    nmap-ncat
    virt-what
    xorg-x11-server-Xorg
    xorg-x11-xinit
    xorg-x11-drv-evdev
    xorg-x11-drv-libinput
    xorg-x11-drv-synaptics
    xorg-x11-drv-vmware
    mesa-dri-drivers
    open-vm-tools
    open-vm-tools-desktop
    feh
    dmenu
    st
    bitstream-vera-sans-mono-fonts
    liberation-mono-fonts
    wqy-microhei-fonts
    emacs
    firefox
    gnome-terminal
    gnome-screenshot
    ibus-libpinyin
    im-chooser
    python3-shadowsocks
    tigervnc'|tr '\n' ' ')

    dnf install -y $PKG

    ls -lh /etc/fonts/conf.d/57-dejavu-sans-mono.conf
    rm -fv /etc/fonts/conf.d/57-dejavu-sans-mono.conf

https://copr.fedorainfracloud.org/coprs/outman/bspwm/

    dnf copr enable -y outman/bspwm
    dnf install -y bspwm sxhkd xdo xtitle lemonbar-xft compton

# xinitrc

尽量存放和 X11 相关配置

https://www.transparenttextures.com/random-grey-variations.html

https://wiki.archlinux.org/index.php/Xinit

https://wiki.archlinux.org/index.php/Xprofile

# gnome-terminal

禁用光标闪烁：

    _uuid=$(gsettings get org.gnome.Terminal.ProfilesList default|sed "s/'//g")

    gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ cursor-blink-mode

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ cursor-blink-mode 'off'

自定义 Dark Pastels 主题：

    gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ palette

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ palette "['rgb(63,63,63)', 'rgb(112,80,80)', 'rgb(96,180,138)', 'rgb(223,175,143)', 'rgb(154,184,215)', 'rgb(220,140,195)', 'rgb(140,208,211)', 'rgb(220,220,204)', 'rgb(112,144,128)', 'rgb(220,163,163)', 'rgb(114,213,163)', 'rgb(240,223,175)', 'rgb(148,191,243)', 'rgb(236,147,211)', 'rgb(147,224,227)', 'rgb(255,255,255)']"

背景透明：

    gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ background-transparency-percent

    dconf write /org/gnome/terminal/legacy/profiles:/:${_uuid}/background-transparency-percent 8

快捷键：

    $ gsettings get org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ help
    'F1'

    gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ help ""

递归遍历所有配置项：

    gsettings list-recursively | grep Terminal.Legacy.Keybindings

修改 `sxhkdrc` 快捷键对应的命令：

    super + Return
        gnome-terminal --hide-menubar

缩小 gnome-terminal 标签页高度：

    $ cat ~/.config/gtk-3.0/gtk.css
    /*
     * Decrease the tabs bar height in gnome-terminal
     * See:
     * https://stackoverflow.com/questions/36869701/decrease-the-tabs-bar-height-in-gnome-terminal
     */
    terminal-window notebook > header.top button {
      background-image: none;
      border: 0 0 0 0;
      margin: 0 0 0 0;
      padding: 0 10;
    }
    terminal-window notebook > header.top > tabs > tab {
      border: 0 0 0 0;
      margin: 0 0 0 0;
      padding: 0 0 0 0;
    }
    terminal-window notebook > header.top > tabs > tab label {
      border: 0 0 0 0;
      padding: 0 0 0 0;
      margin: 0 0 0 0;
    }


# gnome-screenshot

    gnome-screenshot -a -e shadow -f img.png

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

## tips

`Ctrl + button2` 鼠标 **中键** 弹出 `urxvt` **设置菜单** 类似 `xterm`

# bspwm

https://github.com/baskerville/bspwm/blob/master/examples/sxhkdrc

https://github.com/baskerville/bspwm/commits/master/examples/sxhkdrc

## command

命令 | 操作
---- | ----
`bspc node @focused:/ --rotate 90` | **顺时针** 切换布局
`bspc node -i` | 创建 Receptacle
`bspc node @/2 -g hidden` | 隐藏节点
`bspc node -s @/2` | 互换节点

## feature

### receptacle

[Is it possible to create a startup workspace? #371](https://github.com/baskerville/bspwm/issues/371)

2016-05-27 [e8aa679](https://github.com/baskerville/bspwm/commit/e8aa679cd14fad3bdc89119c53d5c6eca6512bf0) 引入 receptacle 支持自动创建 layout 并启动相关程序

> **Receptacles** are used for building a tree without creating windows.

[Arbitrary splits without new windows? #259](https://github.com/baskerville/bspwm/issues/259)

TODO: `urxvt` 通过 `tmux` 自动启动的程序退出会导致 `tmux` 和 `urxvt` 同时退出

    set-option -g detach-on-destroy off

上面选项可以避免 `tmux` 和 `urxvt` 退出。此时 `urxvt` 中的 `tmux` 会 `attach` 其他 `tmux` 会话

# lemonbar-xft

依赖的 **字体** 及 `vmstat` 命令所属 **软件包**：

    PANEL_FONT_EN="Bitstream Vera Sans Mono-11"
    PANEL_FONT_CN="WenQuanYi Micro Hei Mono-11"

    ## free memory
    $ rpm -qf $(which vmstat)
    procps-ng-3.3.10-13.fc26.x86_64

安装依赖：

    dnf install -y bitstream-vera-sans-mono-fonts wqy-microhei-fonts procps-ng

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
    curl -m 8 -Ss -x socks5h://127.0.0.1:9090 -L "$img_url" -o $img_wallpaper && \
    feh --bg-tile $img_wallpaper

urxvt 透明效果：

![img_urxvt_transparent_bg](https://www.dropbox.com/s/5ksbtgsxy7p2o6o/urxvt-bg-img.png?dl=1)

https://wiki.archlinux.org/index.php/Compton

https://github.com/yurisuika/Dotfiles/blob/master/.config/compton.conf

https://github.com/neynt/dotfiles/blob/master/compton.conf

