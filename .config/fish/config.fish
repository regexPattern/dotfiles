alias ls 'eza --group-directories-first'
alias ll 'eza -al --group-directories-first'
alias tree 'eza -aT --git-ignore --group-directories-first'

set --export --global EDITOR nvim
set --export --global VISUAL $EDITOR

fish_add_path ~/.local/bin
fish_add_path ~/.local/share/bob/nvim-bin

direnv hook fish | source
fzf --fish | source
zoxide init fish | source
