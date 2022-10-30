set fish_greeting
set SELF %self
# set -g fish_history ""

# default applications
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
set -gx FCEDIT "nvim"

# path
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/bin"

# programming paths
set -gx CARGO_HOME "$HOME/.cargo"
set -gx GOPATH     "$HOME/go"

# alias
alias ..="cd .."
alias cat="bat"
alias ll="exa -la --group-directories-first"
alias ls="exa -a --group-directories-first"
alias clippy="cargo clippy --          \
				-W clippy::pedantic    \
				-W clippy::nursery     \
				-W clippy::unwrap_used \
				-W clippy::expect_used"

# applications configurations
set -gx BAT_THEME "base16"
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden"
set -gx FZF_DEFAULT_OPTS "--color=dark" # https://github.com/junegunn/fzf/wiki/Color-schemes
set -gx PF_INFO "ascii title os host kernel uptime memory"
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"

# custom keybindings
bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# init zoxide
zoxide init fish | source
