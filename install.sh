#!/bin/sh
set -e

GITHUB_USERNAME="uptonm"

git config --global user.email "mikeupton@fb.com"
git config --global user.name "Mike Upton"

echo "[INSTALL] Ohmyzsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

echo "[INSTALL] Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "[SETUP] TheFuck"
sudo apt update -y
sudo apt install python3-dev python3-pip python3-setuptools -y
pip3 install thefuck --user

echo "[SETUP] Vim"
sudo apt-get install vim -y

echo "[INSTALL] Chezmoi"
export BINDIR=$HOME/.local/bin
sh -c "$(curl -fsLS chezmoi.io/get)"

echo "[SETUP] Chezmoi"
$BINDIR/chezmoi init $GITHUB_USERNAME

echo "[APPLY] dotfiles"
$BINDIR/chezmoi apply

declare -a codeExtensions=("1yib.rust-bundle" "arcanis.vscode-zipfs" "cardinal90.multi-cursor-case-preserve" "dbaeumer.vscode-eslint" "dotjoshjohnson.xml" "dustypomerleau.rust-syntax" "eamodio.gitlens" "esbenp.prettier-vscode" "foxundermoon.shell-format" "github.copilot" "github.copilot-chat" "graphql.vscode-graphql" "graphql.vscode-graphql-syntax" "leuisken.latency" "meezilla.json" "ms-azuretools.vscode-docker" "mutantdino.resourcemonitor" "mxsdev.typescript-explorer" "naumovs.color-highlight" "redhat.vscode-xml" "rust-lang.rust-analyzer" "searking.preview-vscode" "serayuzgur.crates" "sibiraj-s.vscode-scss-formatter" "tamasfe.even-better-toml")

echo "[APPLY] VSCode Extensions"
for extension in "${codeExtensions[@]}"
do
    echo "Installing $extension" 
    code --install-extension $extension
done