#
# ~/.zshrc
#

# Prompt Setup
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{red}${vcs_info_msg_0_}%f%1~ '
RPROMPT='%F{green}%*%f'

# Load auto-completions
autoload -U compinit; compinit

# Globals: useful for scripts
PATH="$PATH:$HOME/.local/bin"
export TERMINAL=xterm
export EDITOR=nvim
export BROWSER=ungoogled-chromium

# Aliases
alias ls="ls --color=tty"
alias cd="z"
alias vi="/usr/bin/vim"
alias vim="/usr/bin/nvim"
alias dot="/usr/bin/git --git-dir=$HOME/.local/src/dotfiles/ --work-tree=$HOME"

# Loads
eval "$(zoxide init zsh)"
