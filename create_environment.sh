#! /bin/sh

# [APT]
echo "[APT] apt update"
sudo apt update

# [ZSH]
echo "[ZSH] apt install zsh -y"
sudo apt install zsh -y
echo "[ZSH] chsh -s /usr/bin/zsh"
chsh -s /usr/bin/zsh
#zsh

# [PowerLevel10K]
echo "[PowerLevel10K] git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
#echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# [GIT]
echo "[GIT] Configuring git"
git config --global user.name "John Doe"
git config --global user.email "John.Doe@hotmail.com"

# [ASDF]
echo "[ASDF] Cloning repository"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1
source ~/.asdf/asdf.sh
#echo '. "$HOME/.asdf/asdf.sh"' >>~.zshrc

# [ASDF] Python
echo "[ASDF] Python: Installing dependencies"
apt install make libssl-dev build-essential zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
echo "[ASDF] asdf plugin add python"
asdf plugin add python
echo "[ASDF] asdf install python latest"
asdf install python latest
echo "[ASDF] asdf global python latest"
asdf global python latest

# [ASDF] Poetry
echo "[ASDF] asdf plugin add poetry"
asdf plugin add poetry
echo "[ASDF] asdf install poetry latest"
asdf install poetry latest
echo "[ASDF] asdf global poetry latest"
asdf global poetry latest
#poetry config virtualenvs.prefer-active-python true

# [ASDF] Golang
echo "[ASDF] asdf plugin add golang"
asdf plugin add golang
echo "[ASDF] asdf install golang latest"
asdf install golang latest
echo "[ASDF] asdf global golang latest"
asdf global golang latest

# [ASDF] Rust
echo "[ASDF] asdf plugin add rust"
asdf plugin add rust
echo "[ASDF] asdf install rust latest"
asdf install rust latest
echo "[ASDF] asdf global rust latest"
asdf global rust latest

# [APT]
echo "[APT] apt install exa"
apt install exa

