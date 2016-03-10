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
export PATH=$GOPATH/bin:/usr/local/bin:/usr/local/sbin:$HOME/.bin:/usr/local/heroku/bin:$PATH

#
# Bash interactive shell initialization
#

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

#
# rbenv
#

eval "$(rbenv init -)"

#
# docker
#

eval "$(docker-machine env default)"
