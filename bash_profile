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
# Bash interactive shell initialization
#

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Prevent duplicates in PATH when using Tmux
if [[ -z $TMUX ]]; then
  PATH=$GOPATH/bin:/usr/local/bin:/usr/local/sbin:$HOME/.bin:$HOME/.yat.sh/bin:/usr/local/heroku/bin:$PATH

  if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
fi
