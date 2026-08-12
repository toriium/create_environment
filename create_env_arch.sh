#!/bin/sh

echo "[sudo] Checking sudo access"
sudo -v || exit 1

# Vars
shell_type=$(basename "$SHELL")

# Questions
## Sudo
echo "Add user to sudo group? (Y/n): "
read -r add_sudo

## Docker
printf "Install Docker (Y/n): "
read -r install_docker

## VS Code
printf "Install VS Code? (Y/n): "
read -r install_vscode

## Remmina
printf "Install Remmina? (Y/n): "
read -r install_remmina

## Dbeaver
printf "Install Dbeaver? (Y/n): "
read -r install_dbeaver

## Slack
printf "Install Slack? (Y/n): "
read -r install_slack

## Chrome
printf "Install Chrome? (Y/n): "
read -r install_chrome

## Claude Code
printf "Install Claude Code? (Y/n): "
read -r install_claude

## PyCharm
printf "Install PyCharm Community Edition? (Y/n): "
read -r install_pycharm

## Fish
printf "Install Fish shell? (Y/n): "
read -r install_fish

printf "Set Fish as the default shell? (Y/n): "
read -r set_fish_default

## Starship
printf "Install Starship prompt? (Y/n): "
read -r install_starship

## Nerd Fonts
printf "Install Nerd Fonts? (Y/n): "
read -r install_nerd_fonts

## Git
printf "Enter git user.name: "
read -r git_user_name
printf "Enter git user.email: "
read -r git_user_email

# Add user to sudo group
case "$add_sudo" in
"" | [Yy]*)
    sudo usermod -aG wheel $USER
    # Enable wheel group in sudoers if not already enabled
    if ! sudo grep -q '^%wheel ALL=(ALL:ALL) ALL' /etc/sudoers; then
        sudo sed -i 's/^# \(%wheel ALL=(ALL:ALL) ALL\)/\1/' /etc/sudoers
    fi
    echo "User added to sudo group. Log out and back in for changes to take effect."
    ;;
esac

# Start-enable ssh-agent
sudo systemctl --user start ssh-agent
sudo systemctl --user enable ssh-agent

# [UPDATE SYSTEM]
echo "[pacman] UPDATE SYSTEM"
sudo pacman -Syu --noconfirm

# Install necessary packages
sudo pacman -S --needed --noconfirm \
    git \
    base-devel \
    curl \
    wget \
    make \
    openssl \
    unzip \
    yay

# Install DEV packages
sudo yay -S --noconfirm \
    rclone \
    fuse3

# Gnome
sudo pacman -S gnome-browser-connector gnome-clocks

# Add mise
curl https://mise.run | sh
mkdir -p ~/.config/mise
cp ./config.toml ~/.config/mise/config.toml
## Activate mise
if [ "$shell_type" = "fish" ]; then
    ~/.local/bin/mise activate fish | source
elif [ "$shell_type" = "zsh" ]; then
    eval "$(~/.local/bin/mise activate zsh)"
elif [ "$shell_type" = "bash" ]; then
    eval "$(~/.local/bin/mise activate bash)"
fi
mise install

# Add Docker
case "$install_docker" in
"" | [Yy]*)
    sudo pacman -S --noconfirm docker docker-compose
    sudo usermod -aG docker $USER
    sudo systemctl start docker.service
    sudo systemctl enable docker.service
    printf "Docker installed. Log out and back in to use docker without sudo.\n"
    ;;
esac

# Add VS Code
case "$install_vscode" in
"" | [Yy]*)
    sudo pacman -S --noconfirm visual-studio-code-bin
    ;;
esac

# Add Remmina
case "$install_remmina" in
"" | [Yy]*)
    sudo pacman -S --noconfirm remmina freerdp
    ;;
esac

# Add Database
case "$install_dbeaver" in
"" | [Yy]*)
    sudo pacman -S --noconfirm Dbeaver

    ;;
esac

# Add Slack
case "$install_slack" in
"" | [Yy]*)
    sudo pacman -S --noconfirm slack-desktop
    ;;
esac

# Add Chrome
case "$install_chrome" in
"" | [Yy]*)
    sudo pacman -S --noconfirm google-chrome
    ;;
esac

# Add Claude Code
case "$install_claude" in
"" | [Yy]*)
    curl -fsSL https://claude.ai/install.sh | bash
    ;;
esac

# Add PyCharm
case "$install_pycharm" in
"" | [Yy]*)
    sudo pacman -S --noconfirm pycharm-community-edition
    ;;
esac

# Add Fish
case "$install_fish" in
"" | [Yy]*)
    sudo pacman -S --noconfirm fish

    ;;
esac

# Add fish default
case "$set_fish_default" in
"" | [Yy]*)
    chsh -s /usr/bin/fish "$USER"
    ;;
esac

# Add Starship
case "$install_starship" in
"" | [Yy]*)
    sudo pacman -S --noconfirm starship
    ;;
esac

# Add Nerd Fonts
case "$install_nerd_fonts" in
"" | [Yy]*)
    mkdir -p ~/.local/share/fonts/JetBrainsMono
    wget -O ~/.local/share/fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.0/JetBrainsMono.zip
    unzip -o ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
    rm ~/.local/share/fonts/JetBrainsMono.zip
    fc-cache -f
    ;;
esac

# [GIT]
echo "[GIT] Configuring git"
git config --global user.name "$git_user_name"
git config --global user.email "$git_user_email"
