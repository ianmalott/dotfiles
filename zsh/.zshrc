# Aliases
alias dotfiles='cd ~/.dotfiles'
alias g='git'
alias ls='ls -Gp'

# Initialize completion
autoload -U compinit; compinit
compdef _git g

# Initialize starship prompt
eval "$(starship init zsh)"
