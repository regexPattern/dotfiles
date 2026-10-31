set --export --global EDITOR nvim
set --export --global VISUAL $EDITOR

fish_add_path --global $HOME/.local/bin
fish_add_path --global $HOME/.local/share/bob/nvim-bin

if status is-interactive
  alias ls 'eza --group-directories-first'
  alias ll 'eza -al --group-directories-first --git-ignore'
  alias tree 'eza -aT --group-directories-first --git-ignore'

  if command -q mise
    mise activate fish | source
  end
  if command -q direnv
    direnv hook fish | source
  end
  if command -q zoxide
    zoxide init fish | source
  end
end
