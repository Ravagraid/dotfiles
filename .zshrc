############################################################
# oh-my-zsh
############################################################

# if does not exist, install it
if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# update automatically without asking
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

DISABLE_MAGIC_FUNCTIONS="true"

COMPLETION_WAITING_DOTS="true"

plugins=(
    aliases
    archlinux
    colored-man-pages
    git
    git-commit
    gitfast
    hitchhiker
    lol
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

############################################################
# Environment Variables
############################################################

export EDITOR=nvim visudo
export VISUAL=nvim visudo
export SUDO_EDITOR=nvim
export TERMINAL=kitty
export DOTFILES=$HOME/.config/dotfiles.git

############################################################
# History Config
############################################################

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_NO_STORE

############################################################
# add bin to Path
############################################################

# Add directories to end of path if they exist and not in path
function pathappend() {
    for ARG in "$@"; do
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
            PATH="${PATH:+"$PATH:"}$ARG"
        fi
    done
}

# add directories to beginning of path if they exist and not in path
function pathprepend() {
    for ARG in "$@"; do
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
            PATH="$ARG${PATH:+":$PATH:"}"
        fi
    done
}

# Add most common bin paths inside home folder
pathprepend "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin" "$HOME/local/bin" "$HOME/.bin"

############################################################
# Aliases
############################################################

# configs
alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'

# dotfiles
alias dot='git --git-dir=$DOTFILES --work-tree=$HOME'
alias lazydot='lazygit --git-dir=$DOTFILES --work-tree=$HOME'

# lsd
if [[ -x "$(command -v lsd)" ]]; then
    alias ls='lsd -F --group-dirs first'
    alias ll='lsd --all --header --long --group-dirs first'
    alias tree='lsd --tree'
fi

# launch document/file/URL in default X application
if [[ -x "$(command -v xdg-open)" ]]; then
    alias open='runfree xdg-open'
fi

# launch document/file/URL in default PDF reader
if [[ -x "$(command -v zathura)" ]]; then
    alias pdf='runfree zathura'
fi

# bat > cat
if [[ -x "$(command -v bat)" ]]; then
    alias cat='bat'
fi

# FZF customisation
if [[ -x "$(command -v fzf)" ]]; then
    alias fzf='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
    # fuzzy find files, preview and launch in editor
    if [[ -x "$(command -v xdg-open )" ]]; then
        alias preview='open $(fzf --info=inline --query="${@}")'
    fi
fi

# local IP addresses
if [[ -x "$(command -v ip)" ]]; then
    alias iploc="ip -br -c a"
fi

# public IP information
alias ipex="curl -s ipinfo.io/ip"
alias ipexc="curl -s ipinfo.io/country"

# utils
alias orphans='paru -Qtdq'
alias coalmine='sudo paru -Rns $(paru -Qtdq)'
alias list="paru -Qqe | fzf --preview 'paru -Qil {}' --height=97% --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'"
alias remove='paru -Rcs'

############################################################
# functions
############################################################

# run, disown, and detach from terminal
function runfree() { "$@" > /dev/null 2>&1 & disown }

# copy file with progress bar
function cpp() {
    if [[ -x "$(command -v rsync)" ]]; then
        rsync -ah --info=progress2 "${1}" "${2}"
    else
        set -e
        strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
        | awk '{
          count += $NF
          if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for ( i = 0; iw <= percent; i++)
              printf "="
              printf ">"
              for ( i = percent; i < 100; i++ )
                printf " "
                printf "]\r"
            }
        }
    END { print "" }' total_size=$(stat -c '%s' "${1}") count = 0
    fi
}

# copy and go to dir
function cpg() {
    if [[ -d "$2" ]]; then
        cp "$1" "$2" && cd "$2"
    else
        cp "$1" "$2"
    fi
}

# move and go to dir
function mvg() {
    if [[ -d "$2" ]]; then
        mv "$1" "$2" && cd "$2"
    else
        mv "$1" "$2"
    fi
}

# Make and go to dir
function mdg() {
    mkdir -p "$@" && cd "$@"
}

############################################################
# integrations
############################################################

eval "$(pay-respects zsh)"
