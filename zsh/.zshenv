zmodload -F zsh/files b:zf_ln b:zf_mkdir b:zf_rm
zmodload -F zsh/stat b:zstat

export PAGER=less
export LESS="--RAW-CONTROL-CHARS --ignore-case --hilite-unread --LONG-PROMPT --window=-4 --tabs=4 --mouse --wheel-lines=3"
export READNULLCMD=$PAGER

if [[ ! -v XDG_CONFIG_HOME ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [[ ! -v XDG_CACHE_HOME ]]; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi
if [[ ! -v XDG_DATA_HOME ]]; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [[ ! -v XDG_STATE_HOME ]]; then
    export XDG_STATE_HOME="$HOME/.local/state"
fi
if [[ ! -v XDG_RUNTIME_DIR ]]; then
    export XDG_RUNTIME_DIR=${TMPDIR:-/tmp}/runtime-$USER
fi

# if XDG_RUNTIME_DIR doesn't exist, make it
if [[ ! -d $XDG_RUNTIME_DIR ]]; then
    zf_mkdir -m 0700 -p $XDG_RUNTIME_DIR
fi

if [[ -z $ZDOTDIR || -L $HOME/.zshenv ]]; then
    local homezshenv=$HOME/.zshenv
    ZDOTDIR=${homezshenv:A:h}
fi

export DOTFILES=${ZDOTDIR:h}

fpath=($ZDOTDIR/fpath/ $fpath)

if ((${+commands[nvim]})); then
    export EDITOR=nvim
    export VISUAL=nvim
elif ((${+commands[vim]})); then
    export EDITOR=vim
    export VISUAL=vim
fi

export TERM=kitty
export FZF_DEFAULT_OPTS="--ansi --height=50% --tmux=bottom,50%,border-native --border=top --layout=reverse-list"
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"
