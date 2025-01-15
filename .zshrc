export ZSH=/usr/local/google/home/cujomalainey/.oh-my-zsh

plugins=(macos tmux git)

source $ZSH/oh-my-zsh.sh

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# auto completes
export fpath=(/usr/local/share/zsh-completions $fpath)

# 24 bit color support
#export TERM="xterm-256color"

# cause vim is amazing
export EDITOR="vim"
export VISUAL="vim"
export GIT_EDITOR='nvim'

# used for signing git commits
export GPG_TTY=$(tty)

# gpg i think needs this
export PATH="/usr/local/sbin:$PATH"

# cargo pathing when needed
# export PATH="/Users/curtismalainey/.cargo/bin:$PATH"

# only keep unique history, speeds up ZSH plugins in theory
HISTCONTROL=ignoreboth:erasedups

# tool replacements
alias ls='eza'
alias gitk='gitg'
alias grep='rg'
alias du='dust'

# short names
alias vi='nvim'
alias vim='vi'

# bind non-arrow keys for autosuggestions/navigation
bindkey '^j' autosuggest-accept
bindkey '^h' autosuggest-execute
bindkey '^[k' up-history
bindkey '^[j' down-history

# Useful things
alias cdg='cd $(git rev-parse --show-toplevel)'

# setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# configure fzf to respect gitignore by using ripgrep
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-mouse --bind "ctrl-j:down,ctrl-k:up"'
bindkey -s "\C-p" 'vim \"$(fzf)\"^M'
bindkey "ã" fzf-cd-widget

setopt NO_NOMATCH

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
