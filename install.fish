#!/usr/bin/env fish

# Symlinks tracked configs into ~/.config. Existing real files are moved aside
# to <name>.pre-dotfiles rather than deleted, so a bad run is always reversible.

set -l repo (realpath (status dirname))
set -l config $HOME/.config

set -l links \
    "alacritty/alacritty.toml:alacritty/alacritty.toml" \
    "alacritty/frutiger_aero.toml:alacritty/frutiger_aero.toml" \
    "alacritty/alacritty-frutiger-aero.toml:alacritty/alacritty-frutiger-aero.toml" \
    "alacritty/alacritty-nord.toml:alacritty/alacritty-nord.toml" \
    "nvim/colors/frutiger-aero.lua:nvim/colors/frutiger-aero.lua" \
    "tmux/aero-git.sh:tmux/aero-git.sh" \
    "tmux/aero-fish.sh:tmux/aero-fish.sh"

for entry in $links
    set -l source $repo/(string split -m 1 ':' -- $entry)[1]
    set -l target $config/(string split -m 1 ':' -- $entry)[2]

    if not test -f "$source"
        printf 'missing in repo, skipped: %s\n' "$source"
        continue
    end

    mkdir -p (dirname "$target")
    if test -L "$target"
        rm "$target"
    else if test -e "$target"
        mv "$target" "$target.pre-dotfiles"
        printf 'backed up: %s.pre-dotfiles\n' "$target"
    end

    ln -s "$source" "$target"
    printf 'linked: %s\n' "$target"
end

printf '\nNext: tmux source-file ~/.config/tmux/tmux.conf\n'
printf 'Nord profile also needs the upstream theme clone:\n'
printf '  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes\n'
