set -gx fish_greeting

set -gx EDITOR "nvim --cmd 'let g:minimal = 1'"
set -gx FCEDIT $EDITOR
set -gx GIT_EDITOR $EDITOR
set -gx VISUAL $EDITOR

set -gx BAT_STYLE "plain"
set -gx BAT_THEME "base16"

set -gx FZF_DEFAULT_OPTS "--color=dark"
set -gx FZF_DEFAULT_COMMAND "fd --type file --hidden"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -gx HOMEBREW_NO_ENV_HINTS true

set -gx nvm_default_version lts

set -gx PNPM_HOME $HOME/Library/pnpm

fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin
fish_add_path $PNPM_HOME
fish_add_path /opt/homebrew/bin

alias .. "cd .."
alias ls "exa -la --group-directories-first"
alias ls "exa -a --group-directories-first"
alias cat bat

zoxide init fish | source
