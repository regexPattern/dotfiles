alias ls 'eza --group-directories-first'
alias ll 'eza -al --group-directories-first --git-ignore'
alias tree 'eza -aT --group-directories-first --git-ignore'
alias oc 'opencode'
alias lg 'lazygit'

set --export --global EDITOR nvim
set --export --global VISUAL $EDITOR

fish_add_path ~/.local/bin/
fish_add_path ~/.local/share/bob/nvim-bin/
fish_add_path ~/.amp/bin/
fish_add_path ~/.opencode/bin/

direnv hook fish | source
fzf --fish | source
zoxide init fish | source
