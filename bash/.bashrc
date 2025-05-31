#!/usr/bin/env bash

# Abort unless running interactively.
if [ -n "$PS1" ]; then
  echo "Sourcing $BASH_SOURCE"
else
  return
fi

. ~/.dotfiles/bash/aliases
. ~/.dotfiles/bash/functions
