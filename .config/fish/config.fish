set -gx fish_greeting

set -gx EDITOR "nvim --cmd 'let g:minimal = 1'"
set -gx FCEDIT $EDITOR
set -gx GIT_EDITOR $EDITOR
set -gx VISUAL $EDITOR

set -gx BAT_STYLE "plain"
set -gx BAT_THEME "ansi"

set -gx DOCKER_CONFIG $HOME/.config/docker

set -gx FZF_DEFAULT_OPTS "--color=dark"
set -gx FZF_DEFAULT_COMMAND "fd --type file --hidden"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -gx HOMEBREW_NO_ENV_HINTS true

set -gx nvm_default_version lts

set -gx PNPM_HOME $HOME/Library/pnpm

fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin
fish_add_path $PNPM_HOME
fish_add_path (brew --prefix)/bin

alias .. "cd .."
alias ls "eza -la --group-directories-first"
alias ls "eza -a --group-directories-first"

zoxide init fish | source
