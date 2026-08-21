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
    sudo usermod -aG sudo "$USER"
    echo "User added to sudo group. Log out and back in for changes to take effect."
    ;;
esac

# Start-enable ssh-agent
sudo systemctl --user start ssh-agent
sudo systemctl --user enable ssh-agent

# [UPDATE SYSTEM]
echo "[apt] UPDATE SYSTEM"
sudo apt update && sudo apt upgrade -y

# Install necessary packages
sudo apt install -y \
    git \
    build-essential \
    curl \
    wget \
    apt-transport-https \
    make \
    libssl-dev \
    unzip \
    fontconfig \
    uidmap

# Install DEV packages
sudo apt install -y \
    rclone \
    fuse3

# Gnome
sudo apt install -y \
    gnome-browser-connector \
    gnome-clocks \
    gnome-snapshot \
    gnome-tweaks \
    gnome-extensions-app

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
    curl -fsSL https://get.docker.com -o get-docker.sh \
        && sh get-docker.sh \
        && rm get-docker.sh \
        && sudo usermod -aG docker "$USER" \
        && sudo systemctl start docker.service \
        && sudo systemctl enable docker.service
    printf "Docker installed. Log out and back in to use docker without sudo.\n"
    ;;
esac

# Add VS Code
case "$install_vscode" in
"" | [Yy]*)
    wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" \
        && sudo dpkg -i vscode.deb \
        && sudo apt install -f -y \
        && rm vscode.deb
    ;;
esac

# Add Remmina
case "$install_remmina" in
"" | [Yy]*)
    sudo apt install -y remmina remmina-plugin-rdp
    ;;
esac

# Add Database
case "$install_dbeaver" in
"" | [Yy]*)
    wget -O dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb \
        && sudo dpkg -i dbeaver.deb \
        && sudo apt install -f -y \
        && rm dbeaver.deb
    ;;
esac

# Add Slack
case "$install_slack" in
"" | [Yy]*)
    curl -fsSL https://packagecloud.io/slacktechnologies/slack/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/slack-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/slack-archive-keyring.gpg] https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" | sudo tee /etc/apt/sources.list.d/slack.list
    sudo apt update
    sudo apt install -y slack-desktop
    ;;
esac

# Add Chrome
case "$install_chrome" in
"" | [Yy]*)
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
        && sudo dpkg -i google-chrome-stable_current_amd64.deb \
        && sudo apt install -f -y \
        && rm google-chrome-stable_current_amd64.deb
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
    wget -O pycharm.tar.gz https://download.jetbrains.com/python/pycharm-community-latest.tar.gz \
        && sudo tar -xzf pycharm.tar.gz -C /opt \
        && rm pycharm.tar.gz \
        && sudo ln -sf /opt/pycharm-community-*/bin/pycharm.sh /usr/local/bin/pycharm
    ;;
esac

# Add Fish
case "$install_fish" in
"" | [Yy]*)
    sudo apt install -y fish
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
    curl -sS https://starship.rs/install.sh | sh -s -- -y
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
