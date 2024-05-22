source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

#fish_add_path ~/.local/bin

set -gx EDITOR "emacsclient -a '' -t"
set -gx EMAIL kartri@proton.me
set -gx NAME Karolos Triantafyllou
set -gx TZ Europe/Athens
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx WINEPREFIX $XDG_DATA_HOME/wine
