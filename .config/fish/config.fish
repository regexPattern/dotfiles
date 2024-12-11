# TODO: https://github.com/fish-shell/fish-shell/blob/5918bca1eba861e3e8f69f055aac20e9cae1af3c/doc_src/cmds/fish_should_add_to_history.rst

alias ls 'eza --group-directories-first'
alias ll 'eza -la --group-directories-first'

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/rustup/bin
fish_add_path $HOME/.local/share/bob/nvim-bin

set --export --global nvm_default_version lts
set --export --global EDITOR 'env NVIM_MINIMAL=1 nvim'

set --export --global BAT_THEME ansi
set --export --global BAT_STYLE plain
set --export --global DOCKER_CONFIG $HOME/.config/docker

zoxide init fish | source
