set -gx fish_greeting

set -gx EDITOR code
set -gx FCEDIT nvim
set -gx GIT_EDITOR nvim
set -gx VISUAL nvim

set -gx PNPM_HOME $HOME/Library/pnpm

set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden"

fish_add_path $HOME/.local/bin
fish_add_path $PNPM_HOME
fish_add_path /opt/homebrew/bin

alias .. "cd .."
alias ls "exa -la --group-directories-first"
alias ls "exa -a --group-directories-first"

zoxide init fish | source

# pnpm
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
