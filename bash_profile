#!/usr/bin/env bash

echo "Sourcing $BASH_SOURCE"

#
# Environment
#

export EDITOR=vim
export PROJECTS_DIR=$HOME/projects
export TERM=xterm-256color
export TEXTS_DIR=$HOME/texts

export GOPATH=$PROJECTS_DIR/go

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
# Prevent duplicates in PATH when using Tmux
#


if [[ -z $PATH_ALREADY_MODIFIED ]]; then
  PREPEND=$GOPATH/bin
  PREPEND=$PREPEND:/usr/local/bin
  PREPEND=$PREPEND:/usr/local/op/qt@5.5/bin # remove when obsolete at work
  PREPEND=$PREPEND:$HOME/.bin
  PREPEND=$PREPEND:/usr/local/heroku/bin

  PATH=$PREPEND:$PATH

  if which asdf  > /dev/null; then source /usr/local/opt/asdf/asdf.sh; fi
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

  PATH_ALREADY_MODIFIED=true
fi


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
