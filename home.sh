#!/bin/bash

# GLOBALS
SSH_DIR="$HOME/.ssh"

# Install wget & curl to help with later installs
sudo apt install -y wget curl

# Install neovim
curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
  | grep "browser_download_url.*linux64.deb" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo apt install ./nvim-linux64.deb

# Install lf
curl -s https://api.github.com/repos/gokcehan/lf/releases/latest \
  | grep "browser_download_url.*linux-amd64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo tar -xf lf-linux-amd64.tar.gz  
sudo cp ~/lf /usr/local/bin

# Install discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install -y ./discord.deb
# Install Inkdrop - need the version, no auto install

# Instally Yarn Classic
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update && sudo apt install yarn

export PATH="$(yarn global bin):$PATH"

# Add Repos
  # fish
sudo apt-add-repository -y ppa:fish-shell/release-3
  # node
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  #kdenlive
sudo add-apt-repository -y ppa:kdenlive/kdenlive-stable
  # Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

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
  rclone-browser \
  gimp \
  kdenlive \
  cargo \
  cmake \
  pkg-config \
  libfreetype6-dev \
  libfontconfig1-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  guvcview \
  python3-pip \
  dotool \
  x11-xserver-utils \
  indent \
  libanyevent-i3-perl \
  flameshot \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin 

# Docker post install
sudo usermod -aG docker $USER

# Install alacritty
cargo install alacritty
sudo cp ~/.cargo/bin/alacritty /usr/local/bin

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

# Install Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client

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
stow jetbrains
stow lazygit
stow lf
stow nvim
stow picom
stow profile
stow rofi
stow neofetch
cd ~

# install pip
python -m ensurepip --upgrade
python -m pip install --upgrade pip

# install psutils for bumblebee-status bar on i3
python -m pip install psutil
python -m pip install pygit2


# Install Fisher & Configure Fish
# source /dev/stdin <<< "$(curl -sL https://git.io/fisher)"
# allow fisher,tide,onedark install
sudo rm $HOME/.dotfiles/fish/.config/fish/functions/fisher.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/completions/fisher.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/functions/fish_mode_prompt.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/functions/fish_prompt.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/conf.d/_tide_init.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/completions/tide.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/functions/set_onedark.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/functions/set_onedark_color.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/completions/set_onedark.fish
sudo rm $HOME/.dotfiles/fish/.config/fish/completions/set_onedark_color.fish
fish -c "curl -sL --insecure https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install IlanCosman/tide@v5"
fish -c "fisher install rkbk60/onedark-fish"
rm -f $HOME/.dotfiles/fish/.config/fish/conf.d/omf.fish
rm -f $HOME/.dotfiles/fish/.config/fish/config.fish
fish -c "echo 1 2 1 1 2 2 y | tide configure >/dev/null"
rm -rf ~/.config/fish
cd ~/.dotfiles
stow fish
cd ~

# add fish as a login shell
command -v fish | sudo tee -a /etc/shells

# use fish as default shell
chsh -s /usr/bin/fish


# Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Jet Brains Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
fc-cache -f -v # rebuild font cache
cd ~

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
xset r rate 350 75

# Install Neovim Plugins
nvim --headless +'Slowly install' +qall

# Cleanup
cd ~
rm google-chrome-stable_current_amd64.deb
rm nvim-linux64.deb
rm nvim-linux64.deb.sha256sum
rm lf-linux-amd64.tar.gz
rm lf
rm .fehbg

