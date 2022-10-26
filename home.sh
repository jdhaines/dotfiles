#!/bin/bash

# GLOBALS
SSH_DIR="$HOME/.ssh"

# Install neovim
curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
  | grep "browser_download_url.*linux64.deb" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo apt install ./nvim-linux64.deb

# Install alacritty
curl -s https://api.github.com/repos/alacritty/alacritty/releases/latest \
  | grep "browser_download_url.*linux64.deb" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo apt install ./nvim-linux64.deb

# Install wget & curl to help with later installs
sudo apt install -y wget curl

# Instally Yarn Classic
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Add Repos
sudo apt-add-repository -y ppa:fish-shell/release-3 # fish
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - # node

# Install Packages with apt
sudo apt update
sudo apt install -y \
  stow \
  git \
  build-essential \
  bat \
  make \
  vlc \
  fish \
  nodejs \
  xclip \
  feh \
  rofi \
  ripgrep\
  picom \
  i3 \
  xcwd \
  jq \
  rclone \
  rclone-browser

# reconfigure i3 ??
sudo dpkg-reconfigure i3

# Install Packages with snap
sudo snap install alacritty --classic

# Fix bat executable
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

# stow Dotfiles
cd .dotfiles
stow alacritty
stow git
stow i3
stow nvim
stow picom
stow profile
stow rofi
stow lazygit
stow jetbrains
cd ~

# install pip
python -m ensurepip --upgrade
python -m pip install --upgrade pip

# install psutils for bumblebee-status bar on i3
python -m pip install psutil
python -m pip install pygit2


# Install Fisher & Configure Fish
# source /dev/stdin <<< "$(curl -sL https://git.io/fisher)"
fish -c "curl -sL --insecure https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install IlanCosman/tide@v5"
fish -c "fisher install rkbk60/onedark-fish"
rm -f $HOME/.config/fish/conf.d/omf.fish
rm -f $HOME/.config/fish/config.fish
fish -c "echo 1 1 1 1 2 2 y | tide configure >/dev/null"
rm -rf ~/.config/fish
cd ~/.dotfiles
stow fish
cd ~

# Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Jet Brains Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
fc-cache -f -v # rebuild font cache
cd ~

# add fish as a login shell
command -v fish | sudo tee -a /etc/shells

# use fish as default shell
sudo chsh -s $(which fish) $USER

# Set up SSH
if ! [ -f "$SSH_DIR/id_rsa" ]; then
    mkdir -p "$SSH_DIR"

    chmod 700 "$SSH_DIR"

    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "Josh@JoshHaines.com"

    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"

    chmod 600 "$SSH_DIR/authorized_keys"
fi

# Install Bumblebee-status bar for i3
npx -y degit tobi-wan-kenobi/bumblebee-status $HOME/.dotfiles/bumblebee-status

# Reconfigure Locales
# export LANGUAGE="en_US.UTF-8"
# export LC_ALL="en_US.UTF-8"
# export LANG="en_US.UTF-8"
# sudo dpkg-reconfigure locales

# Install tree-sitter-cli
curl -s https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest \
  | grep "browser_download_url.*linux-x64.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
gzip -d tree-sitter-linux-x64.gz
chmod +x tree-sitter-linux-x64
mv tree-sitter-linux-x64 tree-sitter
sudo mv tree-sitter /usr/local/bin

# set keyboard repeat rate
xset r rate 350 90
