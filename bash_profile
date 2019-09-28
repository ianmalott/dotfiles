#!/usr/bin/env bash

echo "Sourcing $BASH_SOURCE"


#
# Environment
#

export EDITOR=vim
export GOPATH=~/projects/go
export PROJECTS_DIR=~/projects
export TERM=xterm-256color
export TEXTS_DIR=~/texts


#
# Preemptively source /etc/profile so it doesn't prepend PATH later
#

if [[ -f /etc/profile ]]; then
  PATH=""
  source /etc/profile
fi


#
# Bash interactive shell initialization
#

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi


#
# PATH
#

if [[ -z $PATH_ALREADY_MODIFIED ]]; then
  PREPEND=$GOPATH/bin
  PREPEND=$PREPEND:/usr/local/bin
  PREPEND=$PREPEND:/usr/local/sbin
  PREPEND=$PREPEND:$HOME/.bin
  PREPEND=$PREPEND:/usr/local/heroku/bin

  PATH=$PREPEND:$PATH
  unset PREPEND

  PATH_ALREADY_MODIFIED=true # Prevent duplicates in PATH when using Tmux
fi

# Initialize asdf version manager
# Add ASDF_BIN and ASDF_USER_SHIMS to front of PATH
if which asdf > /dev/null; then source /usr/local/opt/asdf/asdf.sh; fi


#
# Completion
#

# Completion via the bash-completion@2 homebrew package (requires bash 4.1+)
# Source all completion scripts in /usr/local/etc/bash_completion.d/
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Enable completion for 'g' (git)
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null || complete -o default -o nospace -F _git g

# Enable completion for 'y' (yat.sh)
complete -F _yat.sh y


#
# Primary prompt string
#

source ~/.dotfiles/bash/colors
GIT_PS1_SHOWDIRTYSTATE=true # unstaged (*), staged (+)
GIT_PS1_SHOWSTASHSTATE=true # stashed ($)
GIT_PS1_SHOWUNTRACKEDFILES=true # untracked (%)
PS1="\n$BLD_WHI\u$REG_RED@$REG_BLU\h $REG_CYA\w$BLD_GRE \$(__git_ps1 "%s")\n\$$DEFAULT "
