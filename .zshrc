
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
# export PATH="/Users/curtismalainey/.cargo/bin:$PATH"

# only keep unique history, speeds up ZSH plugins in theory
HISTCONTROL=ignoreboth:erasedups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# tool replacements
alias ls='eza'
alias gitk='gitg'
alias grep='rg'
alias du='dust'

# short names
alias vi='nvim'
alias vim='vi'

# Useful things
alias cdg='cd $(git rev-parse --show-toplevel)'

# setup fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# configure fzf to respect gitignore by using ripgrep
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-mouse'
bindkey -s "\C-p" 'vim \"$(fzf)\"\n'
bindkey "ã" fzf-cd-widget

setopt NO_NOMATCH

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
