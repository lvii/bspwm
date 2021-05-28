
# RockyLinux 8

**NOTE**: `~/.config/bspwm/bspwmrc` 文件要有 **可执行** 权限：

[The n00b’s guide to bspwm (with XFCE)](https://bgdawes.github.io/bspwm-xfce-dotfiles/)

> **IMPORTANT: MAKE SURE YOUR `bspwmrc` FILE IS *EXECUTABLE* - THIS IS THE BIGGEST ROOKIE MISTAKE**

```
# pgrep -af bspwm
6003 /usr/libexec/gdm-x-session --register-session --run-script bspwm
6026 bspwm
6047 /usr/bin/ssh-agent /bin/sh -c exec -l /bin/bash -c "bspwm"

# service gdm restart
Redirecting to /bin/systemctl restart gdm.service

# pgrep -x bspwm|xargs kill

$ chmod +x ~/.config/bspwm/bspwmrc

$ pgrep -af bspwm
3016 /usr/libexec/gdm-x-session --register-session --run-script bspwm
3038 bspwm
3058 /usr/bin/ssh-agent /bin/sh -c exec -l /bin/bash -c "bspwm"
3082 /bin/sh /home/i/.config/bspwm/bspwmrc 0                         <--
```

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
    atop
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

package | `lemonbar` dep
------- | --------------
`procps-ng` | `vmstat` 计算内存
`xdo` | windows ID
`xtitle` | 标题栏

https://copr.fedorainfracloud.org/coprs/outman/bspwm/

    dnf copr enable -y outman/bspwm
    dnf install -y bspwm sxhkd xdo xtitle lemonbar-xft compton

# Xorg

## xinitrc

尽量存放和 X11 相关配置

https://www.transparenttextures.com/random-grey-variations.html

https://wiki.archlinux.org/index.php/Xinit

https://wiki.archlinux.org/index.php/Xprofile

    yum install xorg-x11-xinit-session

    # rpm -qi xorg-x11-xinit-session|grep '^Summary'
    Summary     : Display manager support for ~/.xsession and ~/.Xclients

## X11

cmd | about
--- | ----
`xprop` | 窗口信息
`xrandr`  | 显示器分辨率
`xwininfo -root` | 显示器分辨率
`xwininfo` | 窗口位置坐标

# ibus

[Getting Ibus working with tiling window manager](https://unix.stackexchange.com/questions/277692/getting-ibus-working-with-tiling-window-manager)

    $ ibus engine
    (process:23349): IBUS-CRITICAL **: 15:17:44.821: ibus_bus_get_global_engine: assertion 'IBUS_IS_BUS (bus)' failed
    No engine is set.

    $ pgrep -af ibus
    1318 ibus-daemon --xim --panel disable
    1321 /usr/libexec/ibus-dconf
    1323 /usr/libexec/ibus-x11 --kill-daemon
    1329 /usr/libexec/ibus-portal
    1420 /usr/libexec/ibus-engine-simple

    $ ibus-setup
    Gtk-Message: 15:18:01.324: GtkDialog mapped without a transient parent. This is discouraged.
    Gtk-Message: 15:18:04.431: GtkDialog mapped without a transient parent. This is discouraged.

    $ ibus engine
    libpinyin

    $ echo $GTK_IM_MODULE
    ibus

    $ pgrep -af ibus
    1318 ibus-daemon --xim --panel disable
    1321 /usr/libexec/ibus-dconf
    1323 /usr/libexec/ibus-x11 --kill-daemon
    1329 /usr/libexec/ibus-portal
    1420 /usr/libexec/ibus-engine-simple
    23405 ibus-daemon --xim
    23410 /usr/libexec/ibus-dconf
    23412 /usr/libexec/ibus-ui-gtk3
    23413 /usr/libexec/ibus-extension-gtk3
    23415 /usr/libexec/ibus-x11 --kill-daemon
    23421 /usr/libexec/ibus-portal
    23434 /usr/libexec/ibus-engine-libpinyin --ibus

    $ pgrep -af ibus -u i
    23405 ibus-daemon --xim
    23410 /usr/libexec/ibus-dconf
    23412 /usr/libexec/ibus-ui-gtk3
    23413 /usr/libexec/ibus-extension-gtk3
    23415 /usr/libexec/ibus-x11 --kill-daemon
    23421 /usr/libexec/ibus-portal
    23434 /usr/libexec/ibus-engine-libpinyin --ibus
    23507 /usr/libexec/ibus-engine-simple


# tray

## stalonetray

<https://src.fedoraproject.org/rpms/stalonetray>

<https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/s/>

    --geometry geometry_spec, geometry geometry_spec
    Set tray`s initial geometry to geometry_spec, specified in standard X notation: widthxheight[+x[+y]],
    where width and height are specified in icon slot multiples. Default value: 1x1+0-0.

其中 width 和 height 并不是像素，而是图标槽数量。

    stalonetray --geometry 100x1+0-0 --icon-size=16 --kludges=force_icons_size --skip-taskbar --sticky --window-strut bottom --transparent --tint-color black --tint-level 180 &

[elementaryOS 系统托盘解决方案 2013-11-11](https://www.bbsmax.com/A/xl569j7YJr/)

其 `+` 表示左边与上边 `-` 表示下边与右边

[配置及运行 stalonetray 2021-04-28](https://www.cnblogs.com/k4nz/p/14713418.html)


<https://github.com/derrickcope/config/blob/master/bspwm/bspwmrc>

    bspc rule -a stalonetray state=floating rectangle=5x5+3000+1
    bspc rule -a XTerm:* monitor=focused state=floating focus=on follow=on rectangle=300x20+500+0


# font

    $ head -15 ~/.Xresources
    !! xrdb -q 命令查看当前已加载的 Xdefaults / Xresources 配置信息
    !! https://wiki.archlinux.org/index.php/Font_Configuration
    !! 对 "不支持" fontconfig 字体配置的程序 (LibreOffice) 指定字体渲染方式
    Xft.antialias                           : 1
    Xft.hinting                             : 1
    Xft.hintstyle                           : hintslight
    !Xft.autohint                           : 0
    !Xft.rgba                               : rgb
    !Xft.lcdfilter                          : lcddefault
    !Xft.dpi                                : 96
    !Xft.embolden                           : true

<https://github.com/addy-dclxvi/almighty-dotfiles/blob/master/.config/bspwm/bspwmrc>

    # Load bitmap fonts
    xset fp+ ~/.fonts/misc &

## Bitstream Vera Sans Mono

<https://src.fedoraproject.org/rpms/bitstream-vera-fonts>

<https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/b/>

<https://wiki.archlinux.org/title/Fonts>

    # yum install https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/b/bitstream-vera-sans-mono-fonts-1.10-44.fc35.noarch.rpm
    Last metadata expiration check: 2:45:08 ago on Wed 26 May 2021 10:59:52 AM CST.
    bitstream-vera-sans-mono-fonts-1.10-44.fc35.noarch.rpm                69 kB/s |  99 kB     00:01
    Dependencies resolved.
    ================================================================================================
     Package                             Architecture       Version          Repository        Size
    ================================================================================================
    Installing:
     bitstream-vera-sans-mono-fonts      noarch             1.10-44.fc35     @commandline      99 k

    Transaction Summary
    ================================================================================================
    Install  1 Package

    Total size: 99 k
    Installed size: 221 k

    $ rpm -ql bitstream-vera-sans-mono-fonts
    /etc/fonts/conf.d/55-bitstream-vera-sans-mono-fonts.conf
    /usr/share/doc/bitstream-vera-sans-mono-fonts
    /usr/share/doc/bitstream-vera-sans-mono-fonts/README.TXT
    /usr/share/doc/bitstream-vera-sans-mono-fonts/RELEASENOTES.TXT
    /usr/share/fontconfig/conf.avail/55-bitstream-vera-sans-mono-fonts.conf
    /usr/share/fonts/bitstream-vera-sans-mono-fonts
    /usr/share/fonts/bitstream-vera-sans-mono-fonts/VeraMoBI.ttf
    /usr/share/fonts/bitstream-vera-sans-mono-fonts/VeraMoBd.ttf
    /usr/share/fonts/bitstream-vera-sans-mono-fonts/VeraMoIt.ttf
    /usr/share/fonts/bitstream-vera-sans-mono-fonts/VeraMono.ttf
    /usr/share/licenses/bitstream-vera-sans-mono-fonts
    /usr/share/licenses/bitstream-vera-sans-mono-fonts/COPYRIGHT.TXT
    /usr/share/metainfo/org.fedoraproject.bitstream-vera-sans-mono-fonts.metainfo.xml

禁止 `"DejaVu Sans Mono` 替换 `Bitstream Vera Sans Mono` 字体：

    $ cat ~/.config/fontconfig/fonts.conf
    <?xml version='1.0'?>
    <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
    <fontconfig>
      <match target="font">
        <edit mode="assign" name="hinting">
          <bool>true</bool>
        </edit>
      </match>
      <match target="font">
        <edit mode="assign" name="hintstyle">
          <const>hintslight</const>
        </edit>
      </match>
      <match target="font">
        <edit mode="assign" name="antialias">
          <bool>true</bool>
        </edit>
      </match>
      <match target="font">
        <edit mode="assign" name="lcdfilter">
          <const>lcddefault</const>
        </edit>
      </match>
      <alias binding="same">
        <family>DejaVu Sans Mono</family>
        <accept>
          <family>Bitstream Vera Sans Mono</family>
        </accept>
      </alias>
      <alias>
        <family>Bitstream Vera Sans Mono</family>
        <default>
          <family>monospace</family>
        </default>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>Bitstream Vera Sans Mono</family>
          <family>DejaVu Sans Mono</family>
        </prefer>
      </alias>
      <alias>
        <family>Courier</family>
        <prefer>
          <family>Bitstream Vera Sans Mono</family>
          <family>DejaVu Sans Mono</family>
        </prefer>
      </alias>
    </fontconfig>

删除并修改相关配置：

    ls -lh /etc/fonts/conf.d/57-dejavu-sans-mono.conf
    rm -fv /etc/fonts/conf.d/57-dejavu-sans-mono.conf

    # cp -iv /usr/share/fontconfig/conf.avail/57-dejavu-sans-mono.conf{,.ori}

    # diff /usr/share/fontconfig/conf.avail/57-dejavu-sans-mono.conf{,.ori}
    18a19,30
    >     <family>Bitstream Prima Sans Mono</family>
    >     <accept>
    >       <family>DejaVu Sans Mono</family>
    >     </accept>
    >   </alias>
    >   <alias binding="same">
    >     <family>Bitstream Vera Sans Mono</family>
    >     <accept>
    >       <family>DejaVu Sans Mono</family>
    >     </accept>
    >   </alias>
    >   <alias binding="same">

    $ fc-match monospace
    VeraMono.ttf: "Bitstream Vera Sans Mono" "Roman"

    $ fc-match sans -s | head -n5
    DejaVuSans.ttf: "DejaVu Sans" "Book"
    DejaVuSans-Bold.ttf: "DejaVu Sans" "Bold"
    DejaVuSans-Oblique.ttf: "DejaVu Sans" "Oblique"
    DejaVuSans-BoldOblique.ttf: "DejaVu Sans" "Bold Oblique"
    NimbusSans-Regular.otf: "Nimbus Sans" "Regular"

    $ fc-match mono -s | head -n5
    VeraMono.ttf: "Bitstream Vera Sans Mono" "Roman"
    DejaVuSansMono.ttf: "DejaVu Sans Mono" "Book"
    DejaVuSansMono-Bold.ttf: "DejaVu Sans Mono" "Bold"
    DejaVuSansMono-Oblique.ttf: "DejaVu Sans Mono" "Oblique"
    NimbusMonoPS-Regular.otf: "Nimbus Mono PS" "Regular"

## Google Noto Sans CJK JP

    $ rpm -ql google-noto-sans-cjk-ttc-fonts
    /etc/fonts/conf.d/65-0-google-noto-sans-cjk-ttc.conf
    /usr/share/fontconfig/conf.avail/65-0-google-noto-sans-cjk-ttc.conf
    /usr/share/fonts/google-noto-cjk
    /usr/share/fonts/google-noto-cjk/NotoSansCJK-Black.ttc
    /usr/share/fonts/google-noto-cjk/NotoSansCJK-Bold.ttc
    /usr/share/fonts/google-noto-cjk/NotoSansCJK-DemiLight.ttc
    /usr/share/fonts/google-noto-cjk/NotoSansCJK-Light.ttc
    /usr/share/fonts/google-noto-cjk/NotoSansCJK-Medium.ttc
    /usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc
    /usr/share/fonts/google-noto-cjk/NotoSansCJK-Thin.ttc

    $ fc-match sans -s|grep -i cjk
    NotoSansCJK-Regular.ttc: "Noto Sans CJK JP" "Regular"

    (add-to-list 'default-frame-alist '(font . "Bitstream Vera Sans Mono-11:antialias=1"))
    (set-fontset-font "fontset-default" 'unicode "Noto Sans CJK JP-13.5")

# gnome-terminal

禁用光标闪烁：

    _uuid=$(gsettings get org.gnome.Terminal.ProfilesList default|sed "s/'//g")

    $ gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ cursor-blink-mode
    'on'

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ cursor-blink-mode 'off'

关闭滚动条：

    $ gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ scrollbar-policy
    'always'

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ scrollbar-policy never

自定义 Dark Pastels 主题：

    gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ palette

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ palette "['rgb(63,63,63)', 'rgb(112,80,80)', 'rgb(96,180,138)', 'rgb(223,175,143)', 'rgb(154,184,215)', 'rgb(220,140,195)', 'rgb(140,208,211)', 'rgb(220,220,204)', 'rgb(112,144,128)', 'rgb(220,163,163)', 'rgb(114,213,163)', 'rgb(240,223,175)', 'rgb(148,191,243)', 'rgb(236,147,211)', 'rgb(147,224,227)', 'rgb(255,255,255)']"

修改背景色：

    $ gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ use-theme-colors
    true

    gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ use-theme-colors
    gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ background-color

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ use-theme-colors false
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ background-color 'rgb(44,44,44)'
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ background-color 'rgb(36,36,36)'

背景透明：

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ use-transparent-background true
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ background-transparency-percent 8

    dconf write /org/gnome/terminal/legacy/profiles:/:${_uuid}/background-transparency-percent 8

自定义字体：

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ use-system-font false
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ 'Bitstream Vera Sans Mono 11.5'

快捷键：

    $ gsettings get org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ help
    'F1'

    gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ help ""

递归遍历所有配置项：

    gsettings list-recursively | grep Terminal.Legacy.Keybindings

修改 `sxhkdrc` 快捷键对应的命令：

    super + Return
        gnome-terminal --hide-menubar

查看所有自定义配置：

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${_uuid}/ visible-name default

    $ dconf dump /org/gnome/terminal/legacy/profiles:/
    [:]
    cursor-blink-mode='off'

    [/]
    list=['b1dcc9dd-5262-4d8d-a863-c897e6d979b9']
    default='b1dcc9dd-5262-4d8d-a863-c897e6d979b9'

    [:b1dcc9dd-5262-4d8d-a863-c897e6d979b9]
    visible-name='default'
    palette=['rgb(63,63,63)', 'rgb(112,80,80)', 'rgb(96,180,138)', 'rgb(223,175,143)', 'rgb(154,184,215)', 'rgb(220,140,195)', 'rgb(140,208,211)', 'rgb(220,220,204)', 'rgb(112,144,128)', 'rgb(220,163,163)', 'rgb(114,213,163)', 'rgb(240,223,175)', 'rgb(148,191,243)', 'rgb(236,147,211)', 'rgb(147,224,227)', 'rgb(255,255,255)']
    use-system-font=false
    use-transparent-background=true
    use-theme-colors=false
    font='Bitstream Vera Sans Mono 11.5'
    cursor-blink-mode='off'
    background-color='rgb(44,44,44)'
    background-transparency-percent=8
    scrollbar-policy='never'

缩小 gnome-terminal 标签页高度：

https://developer.gnome.org/gtk3/stable/chap-css-overview.html

    $ cat ~/.config/gtk-3.0/gtk.css
    /*
     * Decrease the tabs bar height in gnome-terminal
     * See:
     * https://stackoverflow.com/questions/36869701/decrease-the-tabs-bar-height-in-gnome-terminal
     */

    terminal-window notebook > header.top {
      background-color: #2c2c2c;
    }
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

https://gist.github.com/drmats/564170a63f9ad693366ecb7e91ac456c

https://heartbeats.jp/hbblog/2018/01/archlinuxpc.html

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

# sxhkd

    $ xmodmap
    xmodmap:  up to 4 keys per modifier, (keycodes in parentheses):

    shift       Shift_L (0x32),  Shift_R (0x3e)
    lock        Caps_Lock (0x42)
    control     Control_L (0x25),  Control_R (0x69)
    mod1        Alt_L (0x40),  Alt_R (0x6c),  Meta_L (0xcd)
    mod2        Num_Lock (0x4d)
    mod3
    mod4        Super_L (0x85),  Super_R (0x86),  Super_L (0xce),  Hyper_L (0xcf)
    mod5        ISO_Level3_Shift (0x5c),  Mode_switch (0xcb)

`bspwmrc` 配置 `pointer_modifier` 键：

    bspc config pointer_modifier mod4

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

## rule

格式 `bspc rule -a class:instance` 通过 `xprop` 获取窗口 `class:instance` 属性：

    $ xprop|egrep '^WM_(CLASS|NAME)'
    WM_CLASS(STRING) = "nautilus", "Nautilus"
    WM_NAME(STRING) = "Home"

通过 `bspc rule -l` 检查是否存在 **冲突** 规则：

    $ bspc rule -l
    Emacs:*:* => state=tiled
    Firefox:*:* => private=on
    Chromium:*:* => private=on
    Chromium:*:* => private=on
    net-sourceforge-jnlp-runtime-Boot:*:* => state=floating
    java-lang-Thread:*:* => state=floating
    sun-awt-X11-XFramePeer:*:* => state=floating
    stalonetray:*:* => state=floating rectangle=5x5+3000+1

    $ bspc rule -r Chromium

    $ bspc rule -l
    Emacs:*:* => state=tiled
    Firefox:*:* => private=on
    net-sourceforge-jnlp-runtime-Boot:*:* => state=floating
    java-lang-Thread:*:* => state=floating
    sun-awt-X11-XFramePeer:*:* => state=floating
    stalonetray:*:* => state=floating rectangle=5x5+3000+1

## feature

### external_rules

<https://github.com/baskerville/bspwm/tree/master/examples/external_rules>

### overwriting_borders

<https://github.com/baskerville/bspwm/blob/master/examples/overlapping_borders/bspwmrc>

    BW=3
    bspc config border_width $BW
    bspc config window_gap -$BW
    for side in top right bottom left ; dobspc config ${side}_padding $BW done





### receptacle

<https://github.com/baskerville/bspwm/tree/master/examples/receptacles>

[Is it possible to create a startup workspace? #371](https://github.com/baskerville/bspwm/issues/371)

2016-05-27 [e8aa679](https://github.com/baskerville/bspwm/commit/e8aa679cd14fad3bdc89119c53d5c6eca6512bf0) 引入 receptacle 支持自动创建 layout 并启动相关程序

> **Receptacles** are used for building a tree without creating windows.

[Arbitrary splits without new windows? #259](https://github.com/baskerville/bspwm/issues/259)

TODO: `urxvt` 通过 `tmux` 自动启动的程序退出会导致 `tmux` 和 `urxvt` 同时退出

    set-option -g detach-on-destroy off

上面选项可以避免 `tmux` 和 `urxvt` 退出。此时 `urxvt` 中的 `tmux` 会 `attach` 其他 `tmux` 会话

# lemonbar-xft

依赖的 **字体** 及 `vmstat` 命令所属 **软件包**：

    PANEL_FONT_EN="Bitstream Vera Sans Mono-12"
    PANEL_FONT_CN="WenQuanYi Micro Hei Mono-12"

    ## free memory
    $ rpm -qf $(which vmstat)
    procps-ng-3.3.10-13.fc26.x86_64

安装依赖：

    dnf install -y bitstream-vera-sans-mono-fonts wqy-microhei-fonts procps-ng

**NOTE**: `Noto Sans CJK JP-12` 字体会导致 lemonbar 对齐有问题

## config

<https://github.com/baskerville/bspwm/tree/master/examples/panel>

[[lemonbar] Workspaces indicator stuck after recent update #700](https://github.com/baskerville/bspwm/issues/700)

    while [ $(pgrep -cx panel.sh) -gt 1 ] ; do
        pkill -ox -9 panel.sh
    done

[Clock stuck on lemonbar #14](https://github.com/baskerville/sutils/issues/14)

<https://github.com/sguilfoyle/dotfiles-10/tree/master/bspwm/.config/bspwm/panel>

    # Kill the panel if it is currently running
    if [ $(pgrep -cx lemonbar) -gt 1 ] ; then
        printf "%s\n" "The panel is already running."
        while [[ $(pgrep -c "lemonbar") != 0 ]]
        do
            pkill -n -9 "lemonbar"
        done
    fi
    trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

    # Store pid to kill this process later(toggle gaps/panel)
    echo $$ > /tmp/panel-pid

    # Get the number of monitors we will be making bars for
    num_mon=$(bspc query -M)

<https://www.reddit.com/r/unixporn/comments/h8fvrm/bspwm_switched_to_lemonbar/>

<https://github.com/b3nj5m1n/dotfiles/blob/master/scripts/lemonblocks/bspwm.sh>

<https://github.com/replaceits/Simple-Lemonbar>

<https://github.com/jordansissel/xdotool>

# composite manager

## picom

<https://github.com/ChocolateBread799/Awespwm/blob/main/.config/picom/picom.conf>

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


# wallpaper

`xsetroot`

    xsetroot -solid "#ffffff"

    xsetroot -mod 20 20 -bg "$(xrdb -query|awk '/\*color0/ {print $2}')" -fg "$(xrdb -query|awk '/\*color8/ {print $2}')"
    xsetroot -mod 9 2 -bg "$(xrdb -query|awk '/\*color0/ {print $2}')" -fg "$(xrdb -query|awk '/\*color8/ {print $2}')"

<https://github.com/dkeg/bitmap-walls>

<https://github.com/himdel/hsetroot>

<https://github.com/l3ib/nitrogen>

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


# java

`javaws.itweb` 打开 JViewer **白屏** 问题：

<https://wiki.archlinux.org/title/Bspwm#Problems_with_Java_applications>

    export _JAVA_AWT_WM_NONREPARENTING=1

# paste

## parcellite

<https://github.com/rickyrockrat/parcellite>

<https://src.fedoraproject.org/rpms/parcellite>

# collection

    xrandr --output DP-4 --mode 1920x1080 --rate 164.97 &

<https://github.com/TheZoq2/dotfiles/blob/master/.config/bspwm/bspwmrc>

    # Move tint2 behind fullscreen windows
    xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" $(xdo id -n tint2)

<https://github.com/baskerville/bspwm/issues/700>

    if [ "$num_mon" -gt "1" ]; then
        TRAY_GEOM="1x1-2810"
    else
        TRAY_GEOM="1x1-250"
    fi

    stalonetray --geometry $TRAY_GEOM -i $PANEL_HEIGHT -bg "$COLOR_DEFAULT_BG" --grow-gravity NE --kludges force_icons_size &

    wid=$(xdo id -a stalonetray)
    tries_left=20

    while [ -z "$wid" -a "$tries_left" -gt 0 ] ; do
        sleep 0.05
        wid=$(xdo id -a stalonetray)
        tries_left=$((tries_left -1))
    done
    [ -n "$wid" ] && xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

<https://github.com/baskerville/bspwm/issues/1074>

    bspc rule -a '*:libreofficedev' state=tiled
    bspc rule -a "Genymotion Player" desktop='^5' privatee=on

    bspc rule -a net-sourceforge-jnlp-runtime-Boot state=floating
    bspc rule -a java-lang-Thread state=floating
    bspc rule -a sun-awt-X11-XFramePeer state=floating
    bspc rule -a Sxiv state=floating center=true

    # polybar hidden when fullscreen for vlc, youtube, mpv ...
    # find out the name of your monitor with xrandr
    xdo below -t $(xdo id -n root) $(xdo id -a polybar-left_DVI-D-0)
    xdo below -t $(xdo id -n root) $(xdo id -a polybar-right_DVI-D-1)

<https://github.com/spcmd/dotfiles/blob/master/bspwm/.config/bspwm/bspwmrc>

    # start these programs only once
    if [ ! -e /tmp/bspwm_autorun ]; then
        urxvtc &
        urxvtc -name ranger -e ranger &
        #urxvtc -name rtorrent -e rtorrent &
        #urxvtc -name newsbeuter -e newsbeuter &
        geary-light-theme.sh &
        sleep 30s && ~/bin/chromium-privoxy.sh &
        echo "false" > /tmp/bspwm_autorun
        sleep 4m && tvmusor &
    fi

