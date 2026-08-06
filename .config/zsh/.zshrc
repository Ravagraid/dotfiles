# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

############################################################
# oh-my-zsh
############################################################

plugins=(
  aliases
  archlinux
  colored-man-pages
  git
  git-commit
  gitfast
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

############################################################
# Environment Variables
############################################################

export SUDO_EDITOR=nvim

############################################################
# History/cache Config
############################################################

HISTFILE="$XDG_CACHE_HOME/zsh/.zsh_history"
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
  if [[ -x "$(command -v xdg-open)" ]]; then
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
function runfree() {
  "$@" >/dev/null 2>&1 &
  disown
}

# copy file with progress bar
function cpp() {
  if [[ -x "$(command -v rsync)" ]]; then
    rsync -ah --info=progress2 "${1}" "${2}"
  else
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
      awk '{
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

source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
