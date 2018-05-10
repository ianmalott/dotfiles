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
  PREPEND=$PREPEND:/usr/local/sbin
  PREPEND=$PREPEND:$HOME/.bin
  PREPEND=$PREPEND:$HOME/.yat.sh/bin
  PREPEND=$PREPEND:/usr/local/heroku/bin

  PATH=$PREPEND:$PATH

  if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

  PATH_ALREADY_MODIFIED=true
fi
