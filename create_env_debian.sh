#!/bin/sh

echo "[sudo] Checking sudo access"
sudo -v || exit 1

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
	uidmap

# Add mise
curl https://mise.run | sh
cp ./config.toml ~/.config/mise/config.toml  # Copy config file to mise config directory
mise install
# In case you need
# echo "eval \"\$(/home/toriium/.local/bin/mise activate bash)\"" >> ~/.bashrc

# Add Docker
printf "Install Docker? (Y/n): "
read -r install_docker
case "$install_docker" in
	""|[Yy]*)
		curl -fsSL https://get.docker.com -o get-docker.sh \
			&& sh get-docker.sh \
			&& rm get-docker.sh \
			&& sudo usermod -aG docker "$USER"
		;;
esac

# Add VS Code
printf "Install VS Code? (Y/n): "
read -r install_vscode
case "$install_vscode" in
	""|[Yy]*)
		wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" \
			&& sudo dpkg -i vscode.deb \
			&& sudo apt install -f -y \
			&& rm vscode.deb
		;;
esac

# Add Chrome
printf "Install Chrome? (Y/n): "
read -r install_chrome
case "$install_chrome" in
	""|[Yy]*)
		wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
			&& sudo dpkg -i google-chrome-stable_current_amd64.deb \
			&& sudo apt install -f -y \
			&& rm google-chrome-stable_current_amd64.deb
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
