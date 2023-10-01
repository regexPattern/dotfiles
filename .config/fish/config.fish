set -gx fish_greeting

set -gx EDITOR "nvim --cmd 'lua vim.g.minimal = true'"
set -gx FCEDIT "$EDITOR"
set -gx GIT_EDITOR "$EDITOR"
set -gx VISUAL "$EDITOR"

set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden"
set -gx FZF_DEFAULT_OPTS "\
--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B"

fish_add_path "$HOME/.local/bin"
fish_add_path "/opt/homebrew/bin"

alias .. "cd .."
alias cat "bat --style=plain --tabs=4"
alias ls "exa -la --group-directories-first"
alias ls "exa -a --group-directories-first"

zoxide init fish | source

# pnpm
set -gx PNPM_HOME "/Users/carlosecp/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end