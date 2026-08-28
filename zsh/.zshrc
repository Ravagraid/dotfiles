if ((${+commands[tmux]})) && [[ ! -v TMUX && ! -v SSH_TTY ]] && ((EUID != 0)) && ! tmux list-sessions &>/dev/null; then
    exec tmux new-session
fi

autoload -Uz clear-screen-soft-bottom
if ! [[ -v SSH_TTY || -v SUDO_USER ]]; then
    clear-screen-soft-bottom
fi

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
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt LIST_TYPES
setopt LONG_LIST_JOBS
setopt AUTO_RESUME
setopt NOTIFY
setopt RM_STAR_WAIT

unsetopt FLOW_CONTROL
unsetopt BEEP
unsetopt NOMATCH
unsetopt RM_STAR_SILENT

############################################################
# History/cache Config
############################################################

HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE

############################################################
# autoload
############################################################

# Initialise colors
autoload -Uz colors
colors

((${+aliases[run-help]})) && unalias run-help
autoload -Uz run-help
alias help=run-help

autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

#custom functions
autoload -z bag fgb fgd fgl fz

############################################################
# add bin to Path
############################################################

# Add directories to end of path if they exist and not in path
function pathappend() {
    for ARG in '$@'; do
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
            PATH="${PATH:+"$PATH:"}$ARG"
        fi
    done
}

# add directories to beginning of path if they exist and not in path
function pathprepend() {
    for ARG in '$@'; do
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
            PATH="$ARG${PATH:+":$PATH:"}"
        fi
    done
}

# Add most common bin paths inside home folder
pathprepend "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin" "$HOME/local/bin" "$HOME/.bin"

MANPATH=$XDG_DATA_HOME/man:$MANPATH

############################################################
# Aliases
############################################################

alias zshconfig='nvim $ZDOTDIR/.zshrc'

# nvim
((${+commands[nvim]})) && {
    alias nv='nvim'
    alias vi='nvim'
    alias vim='nvim'
}

((${+commands[find]})) && alias find='noglob find'
((${+commands[ag]})) && alias ag='noglob ag'
((${+commands[fd]})) && alias fd='noglob fd'
((${+commands[sudo]})) && alias sudo='noglob wrap-sudo '

if ((${+commands[dircolors]})); then
    # Human file sizes
    ((${+commands[df]})) && alias df='df --human-readable --print-type'
    ((${+commands[du]})) && alias du='du --human-readable --total'
    ((${+commands[dd]})) && alias dd='dd status=progress'
    ((${+commands[grep]})) && alias grep='grep --color=auto --binary-files=without-match --devices=skip'
    (($+commands[diff])) && alias diff='diff --color=auto --new-file --text --recursive --unified'
    ((${+commands[mkdir]})) && alias mkdir="mkdir --parents --verbose"
    ((${+commands[cp]})) && alias cp="cp --verbose --reflink=auto"
    ((${+commands[mv]} )) && alias mv="mv --verbose"
    ((${+commands[rm]})) && alias rm="rm -I --preserve-root=all"
    ((${+commands[chmod]})) && alias chmod="chmod --preserve-root --changes"
    ((${+commands[chown]})) && alias chown="chown --preserve-root --changes"
    ((${+commands[chgrp]})) && alias chgrp="chgrp --preserve-root --changes"
fi


# useful stuff
((${+commands[tmux]})) && alias stmux='tmux new-session 'sudo --login''
((${+commands[wget]})) && alias wget='wget --hsts-file=$XDG_CACHE_HOME/wget-hsts'
((${+commands[lsd]})) && {
    alias ls='lsd -F --group-dirs first --hyperlink=auto'
    alias ll='lsd --almost-all --header --long --group-dirs first'
    alias tree='lsd --tree'
}

# # launch document/file/URL in default X application
((${+commands[xdg-open]})) && alias open='runfree xdg-open'

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
    alias fzf='fzf --preview 'bat --style=numbers --color=always --line-range :500 {}''
    # fuzzy find files, preview and launch in editor
    if [[ -x "$(command -v xdg-open)" ]]; then
        alias preview='open $(fzf --info=inline --query='${@}')'
    fi
fi

# local IP addresses
if [[ -x "$(command -v ip)" ]]; then
    alias iploc='ip -br -c a'
fi

# public IP information
alias ipex='curl -s ipinfo.io/ip'
alias ipexc='curl -s ipinfo.io/country'

# utils and suppressing history
alias pwd=' pwd'
alias exit=' exit'
alias orphans=' paru -Qtdq'
alias coalmine=' sudo paru -Rns $(paru -Qtdq)'
alias list=' paru -Qqe | fzf --preview 'paru -Qil {}' --height=97% --layout=reverse --bind 'enter:execute(paru -Qil {} | less)''
alias remove='paru -Rcs'
alias clear=' clear-screen-soft-bottom'

############################################################
# functions
############################################################

# run, disown, and detach from terminal
function runfree() {
    '$@' >/dev/null 2>&1 &
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
            printf '%3d%% [', percent
            for ( i = 0; iw <= percent; i++)
              printf '='
              printf '>'
              for ( i = percent; i < 100; i++ )
                printf ' '
                printf ']\r'
            }
        }
    END { print '' }' total_size=$(stat -c '%s' "${1}") count = 0
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
    mkdir -p '$@' && cd '$@'
}

############################################################
# completion
############################################################

# Completion: tweaks
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' verbose true
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/compcache
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:descriptions' format [%d]
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:approximate:*' max-errors 2 numeric
zstyle ':completion:*:(approximate|correct)*:*' original true
zstyle ':completion:*:corrections' format '[%d (errors: %e)]'
zstyle ':fzf-tab:*' prefix ''

# Completion: ignore
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:git-*:*:heads*' ignored-patterns '(FETCH_|ORIG_|MERGE_|*/|)HEAD'
zstyle ':completion:*:*:(vi|vim|nvim|nv|bat|cat|less):*:*' ignored-patterns '*.zwc'
zstyle ':completion:*:parameters'ignored-patterns \
    '_(p9k|_p9k|POWERLEVEL9K|gitstatus|GITSTATUS|zsh_highlight|ZSH_HIGHLIGHT|zsh_autosuggest|ZSH_AUTOSUGGEST|abbr|ABBR|ftb|FTB)*'

# Enable cached completions, if found
[[ -d $XDG_CACHE_HOME/zsh/fpath ]] || fpath=($XDG_CACHE_HOME/zsh/fpath $fpath)

# more completions
fpath=($ZDOTDIR/plugins/completions/src $ZDOTDIR/plugins/git-completion/src $fpath)

# git-extras completions
source $DOTFILES/tools/git-extras/etc/git-extras-completion.zsh

zmodload zsh/complist

_compdump=$XDG_CACHE_HOME/zsh/compdump-$ZSH_VERSION
autoload -Uz compinit
# regenerate compdump when completions change
() {
    local -a mtimes dirs=(${^fpath}(-/N))
    (($#dirs)) && zstat -A mtimes +mtime -- $dirs
    local -a sig=($ZSH_VERSION$ZSH_PATCHLEVEL$dirs$mtimes)
    local want=${(j.:.)sig} have

    if [[ -r $_compdump && -r $_compdump.sig ]] && IFS= read -r have <$_compdump.sig && [[ $have == $want ]]; then
        compinit -C -d $_compdump
    else
        compinit -i -d $_compdump
        print -r -- $want >$_compdump.sig
        {
            autoload -Uz zrecompile
            zrecompile -pq $_compdump
        } &!
    fi
}
unset _compdump

############################################################
# integrations
############################################################

eval "$(starship init zsh)"

source $ZDOTDIR/plugins/z/zsh-z.plugin.zsh
ZSHZ_DATA=$XDG_CACHE_HOME/zsh/z/
ZSHZ_UNCOMMON=1
ZSHZ_CASE=smart

source $ZDOTDIR/plugins/autopair/autopair.zsh

source $ZDOTDIR/plugins/abbr/zsh-abbr.zsh

source $ZDOTDIR/plugins/autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/autosuggestions-abbreviations-strategy/zsh-autosuggestions-abbreviations-strategy.zsh
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
ZSH_AUTOSUGGEST_STRATEGY=(abbreviations history completion)

source $ZDOTDIR/plugins/fzf-tab/fzf-tab.zsh

source $ZDOTDIR/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets regexp cursor)
