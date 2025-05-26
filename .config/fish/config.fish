if not status --is-interactive
    return
end

alias ls 'eza --group-directories-first'
alias ll 'eza -al --group-directories-first'
alias tree 'eza -aT --git-ignore --group-directories-first'

set -xg EDITOR nvim
set -xg VISUAL $EDITOR

set -xg BAT_THEME ansi

if test (uname) = Darwin && test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/share/bob/**/bin
fish_add_path (go env GOPATH)/bin

zoxide init fish | source
