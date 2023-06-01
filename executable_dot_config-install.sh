#! /bin/bash

#configs
if ! command -v chezmoi &> /dev/null
then
	sh -c "$(curl -fsLS get.chezmoi.io)"
fi

chezmoi init https://github.com/FreezingSnail/dotfiles.git
chezmoi apply

#tools
if ! command -v cargo
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

cargo install -j 4 exa bat ripgrep

#source
source ~/.bashrc
