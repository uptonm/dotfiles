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

echo "[APPLY] apply dotfiles"
$BINDIR/chezmoi apply