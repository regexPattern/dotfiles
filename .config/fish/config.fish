# XDG Dirs
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

# Variables
set fish_greeting
set SELF %self

set -gx TERM "xterm-kitty"
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
set -gx FCEDIT "nvim"
set -gx BROWSER "brave"

set -gx GIT_EDITOR "nvim"
set -gx GIT_PAGER "delta"

set -gx BAT_STYLE "plain"
set -gx BAT_THEME "Catppuccin-mocha"

# Temporal fix for Valgrind
set -gx DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

# Programming Paths
set -gx CARGO_HOME "$HOME/.cargo"
set -gx GOPATH     "$HOME/go"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/bin"

# Aliases
alias ..="cd .."
alias ls="exa -a --group-directories-first"
alias ll="exa -la --group-directories-first"
alias rg="rg --hidden -g '!{node_modules/*,.git/*}'"
alias cat="bat --tabs 4"
alias clippy="cargo clippy -- \
-W clippy::pedantic \
-W clippy::nursery \
-W clippy::unwrap_used \
-W clippy::expect_used"

# FZF config
set -g FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
set -g FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
# Themes: https://github.com/junegunn/fzf/wiki/Color-schemes
# https://github.com/catppuccin/fzf/blob/main/mocha.md
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# starship init fish | source
zoxide init fish | source
