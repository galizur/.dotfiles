#!/bin/sh

have() { type "$1" > /dev/null 2>&1; }

if pgrep sway && have mako; then
	mako --background-color "#2e3440" --border-color "#5e81ac" --font "Source Code Pro Medium 10" --padding 10 --default-timeout 10000 &
fi

if have emacs; then
    emacs --daemon &
fi

if have mpd; then
    [ ! -s ~/.config/mpd/pid ] && mpd &
fi

if have razercfg; then
    razercfg -r 4 &
fi

if have gammastep; then
    gammastep -l `whereami.py` &
fi

if have syncthing; then
    syncthing -no-browser &
fi

if have xbindkeys; then
    [ -f "$XDG_CONFIG_HOME/X11/xbindkeysrc" ] && xbindkeys -f "$XDG_CONFIG_HOME/X11/xbindkeysrc" &
fi

if have udiskie; then
    udiskie --tray &
fi

if have sworkstyle; then
    [ -f "$XDG_CONFIG_HOME/sworkstyle/config.toml" ] && sworkstyle -c "$XDG_CONFIG_HOME/sworkstyle/config.toml" &
fi

#if have wob; then
 #   set $WOBSOCK $XDG_RUNTIME_DIR/wob.sock
  #  mkfifo $WOBSOCK && tail -f $WOBSOCK | wob
#fi
