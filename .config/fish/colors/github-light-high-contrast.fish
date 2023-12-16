set -l comment 66707b

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

set -gx BAT_THEME "Github"

set -agx FZF_DEFAULT_OPTS "                             \
	--color=fg:#0e1116,bg:#ffffff,hl:#702c00            \
	--color=fg+:#010409,bg+:#dbe8fb,hl+:#702c00         \
	--color=info:#744500,prompt:#0349b4,pointer:#622cbc \
	--color=marker:#055d20,spinner:#0e1116,header:#eef0f2"
