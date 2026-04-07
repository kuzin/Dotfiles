# Better defaults
alias ls='eza --group-directories-first --icons=auto'
alias ll='eza -lah --group-directories-first --icons=auto'
alias lt='eza -T --level=2 --group-directories-first --icons=auto'
alias cat='bat --style=plain --paging=never'

# Navigation / search
alias ..='cd ..'
alias ...='cd ../..'
alias grep='rg'

# Git
alias g='git'
alias gs='git status -sb'
alias gd='git diff'
alias gl='git log --oneline --decorate --graph -20'
