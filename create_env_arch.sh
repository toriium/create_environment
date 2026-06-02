#!/bin/sh

echo "[sudo] Checking sudo access"
sudo -v || exit 1

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
	uidmap \
	yay

# Add mise
curl https://mise.run | sh
mkdir -p ~/.config/mise
cp ./config.toml ~/.config/mise/config.toml
mise install
# In case you need
# echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc

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
