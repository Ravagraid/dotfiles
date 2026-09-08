#!/usr/bin/env zsh

setopt extended_glob err_exit

zmodload -m -F zsh/files b:zf_\*

SCRIPT_DIR=${0:A:h}
# systemd-homed 'a'/'A' expands to storage location '/home/username.homedir'
# this conditional moves SCRIPT_DIR to proper home location by removing '.homedir'
if [[$SCRIPT_DIR == $HOME.homedir*]]; then
    SCRIPT_DIR=${SCRIPT_DIR/.homedir/}
fi
cd $SCRIPT_DIR

# Set XDG paths
XDG_CACHE_HOME=$HOME/.cache
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state

# Create directories
print "Creating directory tree..."
zf_mkdir -p $XDG_CONFIG_HOME/{fastfetch,git/local,kitty,nvim,tmux,tombi,yazi}
zf_mkdir -p $XDG_CACHE_HOME/zsh
zf_mkdir -p $XDG_DATA_HOME/{zsh,man/man1}
zf_mkdir -p $XDG_STATE_HOME
zf_mkdir -p $HOME/.local/{bin,etc}
print " ...done!"

# Link zshenv
print "Checking for ZDOTDIR..."
if [[ $ZDOTDIR == $SCRIPT_DIR/zsh ]]; then
    print " ...found! skipping .zshenv symlinking."
else
    print " ...unable to find. ZDOTDIR is \"$ZDOTDIR\""
    print " ZDOTDIR doesn't match expected value \"$SCRIPT_DIR/zsh\" symlinking now."
    zf_ln -sfn $SCRIPT_DIR/zsh.zshenv ${ZDOTDIR:-$HOME}/.zshenv
fi

print "Linking configuration files..."
zf_ln -sfn $SCRIPT_DIR/fastfetch/config.jsonc $XDG_CONFIG_HOME/fastfetch/config.jsonc
zf_ln -sfn $SCRIPT_DIR/kitty/current-theme.conf $XDG_CONFIG_HOME/kitty/current-theme.conf
zf_ln -sfn $SCRIPT_DIR/kitty/dank-tabs.conf $XDG_CONFIG_HOME/kitty/dank-tabs.conf
zf_ln -sfn $SCRIPT_DIR/kitty/dank-theme.conf $XDG_CONFIG_HOME/kitty/dank-theme.conf
zf_ln -sfn $SCRIPT_DIR/kitty/kitty.conf $XDG_CONFIG_HOME/kitty/kitty.conf
zf_ln -sfn $SCRIPT_DIR/nvim/init.lua $XDG_CONFIG_HOME/nvim/init.lua
zf_ln -sfn $SCRIPT_DIR/nvim/lua $XDG_CONFIG_HOME/nvim/lua
zf_ln -sfn $SCRIPT_DIR/nvim/.stylua.toml $XDG_CONFIG_HOME/nvim/.stylua.toml
zf_ln -sfn $SCRIPT_DIR/tmux $XDG_CONFIG_HOME/tmux
zf_ln -sfn $SCRIPT_DIR/tombi/tombi.toml $XDG_CONFIG_HOME/tombi/tombi.toml
zf_ln -sfn $SCRIPT_DIR/yazi/init.lua $XDG_CONFIG_HOME/yazi/init.lua
zf_ln -sfn $SCRIPT_DIR/yazi/yazi.toml $XDG_CONFIG_HOME/yazi/yazi.toml
zf_ln -sfn $SCRIPT_DIR/yazi/theme.toml $XDG_CONFIG_HOME/yazi/theme.toml
zf_ln -sfn $SCRIPT_DIR/yazi/package.toml $XDG_CONFIG_HOME/yazi/package.toml
zf_ln -sfn $SCRIPT_DIR/yazi/flavors $XDG_CONFIG_HOME/yazi/flavors
zf_ln -sfn $SCRIPT_DIR/yazi/plugins $XDG_CONFIG_HOME/yazi/plugins
print " ...done!"
