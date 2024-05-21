source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

#fish_add_path ~/.local/bin

set -gx GNUPGHOME $XDG_CONFIG_HOME/gnupg
set -gx EDITOR "emacsclient -a '' -t"
set -gx EMAIL kartri@proton.me
set -gx NAME Karolos Triantafyllou
set -gx TZ Europe/Athens
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx WINEPREFIX $XDG_DATA_HOME/wine
set -gx GIT_SSH_COMMAND "ssh -F $XDG_CONFIG_HOME/ssh/config"
