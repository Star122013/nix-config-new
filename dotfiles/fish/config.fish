set -g fish_greeting
set -gx FZF_DEFAULT_OPTS "
    --style full
    --height 40% --tmux bottom,40% --layout reverse --border top
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC 
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 
    --color=selected-bg:#45475A 
    --color=border:#6C7086,label:#CDD6F4"

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
direnv hook fish | source

