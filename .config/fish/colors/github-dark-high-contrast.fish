set -l comment bdc4cc

set -g fish_color_normal brwhite
set -g fish_color_command brwhite
set -g fish_color_quote green
set -g fish_color_param blue
set -g fish_color_comment $comment
set -g fish_color_operator red
set -g fish_color_autosuggestion $comment

set -g fish_pager_color_completion $fish_color_param
set -g fish_pager_color_description green
set -g fish_pager_color_prefix red --underline
set -g fish_pager_color_progress brwhite
set -g fish_pager_color_selected_background --background=$selection

set -gx BAT_THEME "base16"

set -agx FZF_DEFAULT_OPTS "                             \
	--color=fg:#f0f3f6,bg:#0a0c10,hl:#ffb757            \
	--color=fg+:#f0f3f6,bg+:#0f1b28,hl+:#ffb757         \
	--color=info:#f0b72f,prompt:#71b7ff,pointer:#b780ff \
	--color=marker:#26cd4d,spinner:#ffffff,header:#454a51"
