#!/usr/bin/env bash

# Abort unless running interactively.
if [ -n "$PS1" ]; then
  echo "Sourcing ~/.bashrc"
else
  return
fi

. ~/.dotfiles/bash/colors
. ~/.dotfiles/bash/aliases
. ~/.dotfiles/bash/functions
. ~/.dotfiles/bash/config
