#!/usr/bin/env bash

echo "Sourcing $BASH_SOURCE"


#
# Environment
#

export EDITOR=nvim
export GOPATH=~/projects/go
export KERL_BUILD_DOCS=yes # Enable kerl to build Erlang docs on asdf install
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
# Initialize asdf version manager
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"


#
# PATH
#

if [[ -z $PATH_ALREADY_MODIFIED ]]; then
  PREPEND=$GOPATH/bin
  PREPEND=$PREPEND:/usr/local/bin
  PREPEND=$PREPEND:/usr/local/sbin
  PREPEND=$PREPEND:$HOME/.bin
  PREPEND=$PREPEND:/usr/local/heroku/bin
  PREPEND=$PREPEND:/usr/local/share/git-core/contrib/diff-highlight
  PREPEND=$PREPEND:/Applications/Postgres.app/Contents/Versions/latest/bin

  PATH=$PREPEND:$PATH
  unset PREPEND

  PATH_ALREADY_MODIFIED=true # Prevent duplicates in PATH when using Tmux
fi

#
# Completion
#

# Completion via the bash-completion@2 homebrew package (requires bash 4.1+)
# Source all completion scripts in /usr/local/etc/bash_completion.d/
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Enable completion for 'd' (docker)
# The _docker completion function is defined in /usr/local/etc/bash_completion.d/docker.
# It was downloaded from https://github.com/docker/cli/blob/master/contrib/completion/bash/docker.
complete -F _docker d

# Enable completion for 'g' (git)
__git_complete g __git_main

# Enable completion for 'y' (yat.sh)
complete -F _yat.sh y


#
# Primary prompt string
#

source ~/.dotfiles/bash/colors
GIT_PS1_SHOWDIRTYSTATE=true # unstaged (*), staged (+)
GIT_PS1_SHOWSTASHSTATE=true # stashed ($)
GIT_PS1_SHOWUNTRACKEDFILES=true # untracked (%)
PS1="\n$BLD_YEL\u$BLD_BLU@$BLD_BLA\h $REG_BLU\w$BLD_BLU \$(__git_ps1 "%s")\n\$$DEFAULT "


#
# Miscellaneous
#

# FZF: set up PATH, completion, and key bindings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
