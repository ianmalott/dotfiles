#!/usr/bin/env bash

echo "Sourcing $BASH_SOURCE"

#
# Environment
#

PATH=/usr/local/bin:/usr/local/sbin:$HOME/.bin:/usr/local/heroku/bin:$PATH
TERM=xterm-256color
export EDITOR=vim
export PROJECTS_DIR=$HOME/projects
export TEXTS_DIR=$HOME/texts

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
