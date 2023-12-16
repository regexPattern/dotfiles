set -gx fish_greeting

set -gx EDITOR "nvim"
set -gx FCEDIT "nvim"
set -gx GIT_EDITOR "nvim"
set -gx VISUAL "nvim"

set -gx BAT_STYLE "plain"

set -gx FZF_DEFAULT_COMMAND "fd --type file --hidden"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -gx PNPM_HOME $HOME/Library/pnpm

fish_add_path $HOME/.local/bin
fish_add_path $HOME/Library/Python/**/bin
fish_add_path $PNPM_HOME
fish_add_path /opt/homebrew/bin

alias .. "cd .."
alias ls "exa -la --group-directories-first"
alias ls "exa -a --group-directories-first"
alias cat "bat"

# Returns not zero when MacOS's mode is not set to dark.
if defaults read -globalDomain AppleInterfaceStyle &> /dev/null
	source $__fish_config_dir/colors/github-dark-high-contrast.fish
else
	source $__fish_config_dir/colors/github-light-high-contrast.fish
end

zoxide init fish | source
