#
# ~/.zshrc
#
# vim:fileencoding=utf-8:foldmethod=marker

# Prompt Setup {{{
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{red}${vcs_info_msg_0_}%f%1~ '
RPROMPT='%F{green}%*%f'
# }}}

# Load auto-completions
autoload -U compinit; compinit

# Globals: useful for scripts {{{
PATH="$PATH:$HOME/.local/bin"
export TERMINAL=urxvt
export EDITOR=nvim
export BROWSER=ungoogled-chromium
# }}}

# Aliases {{{
alias ls="ls --color=tty"
alias cd="z"
alias vi="/usr/bin/vim"
alias vim="/usr/bin/nvim"
alias yay="/usr/bin/paru"
alias dot="/usr/bin/git --git-dir=$HOME/.local/src/dotfiles/ --work-tree=$HOME"
# }}}

# Functions {{{
function ytdlp_transcript() {
    yt-dlp --skip-download --write-subs --write-auto-subs --sub-lang en --sub-format ttml --convert-subs srt --output "transcript.%(ext)s" $1;
    cat ./transcript.en.srt | sed '/^$/d' | grep -v '^[0-9]*$' | grep -v '\-->' | sed 's/<[^>]*>//g' > output.txt;
}
# }}}

# Binds {{{
bindkey -e -r '^[x'
bindkey -a -r ':'
# }}}

# Loads
eval "$(zoxide init zsh)"
