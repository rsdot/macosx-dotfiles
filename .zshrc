#!/bin/sh

neofetch --color_blocks off

eval "$(/opt/homebrew/bin/brew shellenv)"

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$HOME/.config/zsh/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-case --glob '!.git/*'"
# export FZF_DEFAULT_OPTS="--history-size=10000 -x --inline-info -i --multi --reverse --height 40% --preview-window down:50% --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500' --bind 'f1:execute(nvim {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'"
export FZF_DEFAULT_OPTS="--history-size=10000 -x --inline-info -i --multi --reverse --height 40% --bind 'f1:execute(nvim {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# completions
[ -d /usr/local/share/zsh/site-functions ] && fpath+="/usr/local/share/zsh/site-functions/"
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.


# AWS
# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

ulimit -n 1024
