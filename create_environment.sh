#! /bin/sh

# [UPDATE SYSTEM]
echo "[pacman] UPDATE SYSTEM"
sudo pacman -Syu

# Install yay
sudo pacman -S --needed git base-devel yay


yay -S visual-studio-code-bin
yay -S google-chrome


# [GIT]
echo "[GIT] Configuring git"
git config --global user.name "John Doe"
git config --global user.email "John.Doe@hotmail.com"
