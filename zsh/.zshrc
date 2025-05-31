# Aliases
alias dotfiles='cd ~/.dotfiles'
alias g='git'
alias ls='ls -Gp'
alias n='nvim'

# Initialize completion
autoload -U compinit; compinit
compdef _git g

# Initialize starship prompt
eval "$(starship init zsh)"

# Initialize zoxide
eval "$(zoxide init zsh)"
