set fish_greeting
set SELF %self

set -gx TERM "xterm-kitty"
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
set -gx FCEDIT "nvim"
set -gx BROWSER "brave"

set -gx DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

set -gx CARGO_HOME "$HOME/.cargo"
set -gx GOPATH     "$HOME/go"
# set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"

fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.spicetify"

alias ..="cd .."
alias ls="exa -a --group-directories-first"
alias ll="exa -la --group-directories-first"
alias cat="bat"
alias clippy="cargo clippy --          \
				-W clippy::pedantic    \
				-W clippy::nursery     \
				-W clippy::unwrap_used \
				-W clippy::expect_used"

set -gx FZF_CTRL_T_COMMAND "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
# Themes: https://github.com/junegunn/fzf/wiki/Color-schemes
# https://github.com/catppuccin/fzf/blob/main/mocha.md
set -gx FZF_DEFAULT_OPTS "                                         \
	--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8      \
	--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
	--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

bind ! __history_previous_command
bind '$' __history_previous_command_arguments

zoxide init fish | source
