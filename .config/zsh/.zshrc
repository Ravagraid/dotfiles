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
)

############################################################
# History/cache Config
############################################################

HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE

############################################################
# opts
############################################################

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt HIST_NO_STORE
setopt CORRECT_ALL
setopt AUTO_CD
setopt AUTO_PARAM_SLASH
setopt LIST_TYPES
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt LONG_LIST_JOBS
setopt AUTO_RESUME
setopt NOTIFY
setopt RM_STAR_WAIT

unsetopt FLOW_CONTROL
unsetopt BEEP
unsetopt NOMATCH
unsetopt RM_STAR_SILENT

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

alias zshconfig='nvim $ZDOTDIR/.zshrc'
alias clear="clear && printf '\n%.0s' {1..$LINES}"

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
# completion
############################################################

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion::complete:*' use-cache true
zstyle ':completion::complete:*' cache-path $XDG_CACHE_HOME/zsh/compcache
zstyle ':completion:*:descriptions' format [%d]
zstyle ':completion:*:manuals' separate-sections true

# Enable cached completions, if found
[[ -d $XDG_CACHE_HOME/zsh/fpath ]] || fpath=($XDG_CACHE_HOME/zsh/fpath $fpath)

# more completions
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

zmodload zsh/complist

autoload -Uz compinit
if [[ -n $XDG_CACHE_HOME/zsh/compdump(#qN.mh+20) ]]; then
  compinit -u -d $XDG_CACHE_HOME/zsh/compdump
  {
    autoload -Uz zrecompile
    zrecompile -pq $XDG_CACHE_HOME/zsh/compdump
  } &|
else
  compinit -u -C -d $XDG_CACHE_HOME/zsh/compdump
fi
############################################################
# integrations
############################################################

eval "$(pay-respects zsh)"

print ${(pl:$LINES::\n:):-}
source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source $ZDOTDIR/plugins/zsh-autopair/autopair.zsh

source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets regexp cursor)
