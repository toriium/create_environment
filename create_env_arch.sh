#!/bin/sh

echo "[sudo] Checking sudo access"
sudo -v || exit 1


# Add user to sudo group
echo "Add user to sudo group? (Y/n): "
read -r add_sudo
case "$add_sudo" in
  ""|[Yy]*)
    sudo usermod -aG wheel $USER
    # Enable wheel group in sudoers if not already enabled
    if ! sudo grep -q '^%wheel ALL=(ALL:ALL) ALL' /etc/sudoers; then
        sudo sed -i 's/^# \(%wheel ALL=(ALL:ALL) ALL\)/\1/' /etc/sudoers
    fi
    echo "User added to sudo group. Log out and back in for changes to take effect."
    ;;
esac

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
	yay

# Install DEV packages
sudo yay -S --noconfirm \
	rclone \
	fuse3

# Add mise
curl https://mise.run | sh
mkdir -p ~/.config/mise
cp ./config.toml ~/.config/mise/config.toml
mise install
# In case you need
# echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
# echo "~/.local/bin/mise activate fish | source" >> ~/.config/fish/config.fish


# Add Docker
printf "Install Docker (Y/n): "
read -r install_docker
case "$install_docker" in
	""|[Yy]*)
        yay -S --noconfirm docker docker-compose
        sudo usermod -aG docker $USER
        sudo systemctl start docker.service
        sudo systemctl enable docker.service
		printf "Docker installed. Log out and back in to use docker without sudo.\n"
		;;
esac

# Add VS Code
printf "Install VS Code? (Y/n): "
read -r install_vscode
case "$install_vscode" in
	""|[Yy]*)
		yay -S --noconfirm visual-studio-code-bin
		;;
esac

# Add Remmina
printf "Install Remmina? (Y/n): "
read -r install_remmina
case "$install_remmina" in
  ""|[Yy]*)
    yay -S --noconfirm remmina freerdp
    ;;
esac

# Add Database
printf "Install Dbeaver? (Y/n): "
read -r install_dbeaver
case "$install_dbeaver" in
  ""|[Yy]*)
    yay -S --noconfirm Dbeaver

    ;;
esac

# Add Slack
printf "Install Slack? (Y/n): "
read -r install_slack
case "$install_slack" in
	""|[Yy]*)
		yay -S --noconfirm slack-desktop
		;;
esac


# Add Chrome
printf "Install Chrome? (Y/n): "
read -r install_chrome
case "$install_chrome" in
	""|[Yy]*)
		yay -S --noconfirm google-chrome
		;;
esac

# [GIT]
echo "[GIT] Configuring git"
printf "Enter git user.name: "
read -r git_user_name
printf "Enter git user.email: "
read -r git_user_email
git config --global user.name "$git_user_name"
git config --global user.email "$git_user_email"
