set -U fish_greeting
# set -Ux FZF_DEFAULT_OPTS "
# 	--color=fg:#797593,bg:#faf4ed,hl:#d7827e
# 	--color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
# 	--color=border:#dfdad9,header:#286983,gutter:#faf4ed
# 	--color=spinner:#ea9d34,info:#56949f
# 	--color=pointer:#907aa9,marker:#b4637a,prompt:#797593"
fish_config theme choose "Catppuccin Mocha"
    
# set -U fish_color_autosuggestion 797593

# fish_config theme choose "rose-pine-dawn"

abbr -a l eza --icons -a --group-directories-first -1
abbr -a ll eza --icons  -a --group-directories-first -1 --no-user --long
abbr -a tree eza --icons --tree --group-directories-first

set -g fish_color_autosuggestion 9699c7 

function fish_prompt
    echo $PWD '>'
end
if status is-interactive
    fastfetch
end
fzf --fish | source
starship init fish | source
