# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

zstyle ':omz:update' mode auto      # update automatically without asking

DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

export DOTFILES=$HOME/.config/dotfiles.git

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

alias dot='git --git-dir=$DOTFILES --work-tree=$HOME'
alias whatami='curl ipinfo.io/ip'
alias fuck='sudo $(history -p !!)'

alias orphans='paru -Qtdq'
alias coalmine='sudo paru -Rns $(paru -Qtdq)'
alias list="paru -Qqe | fzf --preview 'paru -Qil {}' --height=97% --layout=reverse --bind 'enter:execute(paru -Qil {} | less)'"
alias remove='paru -Rcs'
