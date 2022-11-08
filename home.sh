#!/bin/bash

### Todo ###
# inkdrop

### Variables ###
SSH_DIR="$HOME/.ssh"
DEBIAN_FRONTEND=noninteractive

### Functions ###

function successwriter() 
{
  echo "\n"
  gum style --foreground 77 --border-foreground 77 --border rounded -- "$1 Installed"
  echo "\n"
}
function failurewriter() 
{
  echo "\n"
  gum style --foreground 212 --border-foreground 212 --border rounded "$1 Failed"
  echo "\n"
}

# pass parameter to install with apt, and verify it got installed
function addpkg()
{
  echo "Installing $1..."
  sudo apt install -qy $1
  if dpkg -s $1 2>/dev/null >/dev/null
  then
    successwriter $1
  else
    failurewriter $1
  fi
}

# pass parameter to install with apt and make sure it's callable in the PATH
function addcmd()
{
  echo "Installing $1..."
  sudo apt install -qy $1
  if command -v $1 &> /dev/null
  then
    successwriter $1
  else
    failurewriter $1
  fi
}

# pass parameter to make sure cmd is available and in the PATH
function testcmd()
{
  echo "Installing $1..."
  if command -v $1 &> /dev/null
  then
    successwriter $1
  else
    failurewriter $1
  fi
}

### Add Repos ###
function addrepos() {
  echo 'deb [trusted=yes] https://repo.charm.sh/apt/ /' | sudo tee /etc/apt/sources.list.d/charm.list
  sudo apt-add-repository -qy ppa:fish-shell/release-3
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo add-apt-repository -qy ppa:kdenlive/kdenlive-stable
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
}
 
### Run the Installs ###
# repos
addrepos

# update
sudo apt update -q 

# install things
#   addpkg - installs package, ensures it's installed
#   addcmd - installs package, ensures that command is avialable in the PATH
addpkg spotify-client
addcmd yarn
addpkg containerd.io
addcmd curl
addpkg docker-ce 
addpkg docker-ce-cli 
addpkg docker-compose-plugin 
addcmd git
addcmd gum
addcmd fish
addpkg kdenlive
addpkg nodejs
testcmd npx
addcmd wget
addpkg build-essential
addpkg bat
addcmd make
addcmd vlc
addcmd xclip
addcmd feh
addcmd rofi
addpkg ripgrep
addcmd picom
addcmd i3
addcmd xcwd
addcmd jq
addcmd rclone
addcmd rclone-browser
addcmd gimp
addcmd cargo
addcmd cmake
addpkg pkg-config
addpkg libfreetype6-dev
addpkg libfontconfig1-dev
addpkg libxcb-xfixes0-dev
addpkg libxkbcommon-dev
addcmd guvcview
addcmd python3
addpkg python3-pip
addpkg xdotool
addpkg x11-xserver-utils
addcmd indent
addpkg libanyevent-i3-perl
addcmd flameshot
addpkg ca-certificates
addpkg gnupg
addpkg lsb-release
addcmd stow

### Post Install ###
sudo usermod -aG docker $USER  # docker
export PATH="$(yarn global bin):$PATH"  # yarn
sudo dpkg-reconfigure i3  # i3
mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat  # bat fix

### Custom Installs ###
cd ~

# neovim
curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
  | grep "browser_download_url.*linux64.deb" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo apt install -yq ./nvim-linux64.deb
testcmd nvim
nvim --headless +'Slowly install' +qall

# lf
curl -s https://api.github.com/repos/gokcehan/lf/releases/latest \
  | grep "browser_download_url.*linux-amd64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo tar -xf lf-linux-amd64.tar.gz  
sudo cp ~/lf /usr/local/bin
testcmd lf

# yamlfmt
curl -s https://api.github.com/repos/google/yamlfmt/releases/latest \
  | grep "browser_download_url.*Linux_x86_64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo mv yamlfmt* yamlfmt.tar.gz
sudo tar -xf yamlfmt.tar.gz
sudo cp ~/yamlfmt /usr/local/bin
testcmd yamlfmt

# discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install -qy ./discord.deb
testcmd discord

# alacritty
cargo install alacritty
sudo cp ~/.cargo/bin/alacritty /usr/local/bin
testcmd alacritty

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
testcmd lazygit

# Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -qy ./google-chrome-stable_current_amd64.deb
testcmd google-chrome

# psutils & pygit2 for bumblebee-status bar on i3
python3 -m pip install --no-input psutil pygit2

# Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Jet Brains Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
fc-cache -f -v # rebuild font cache
cd ~

# SSH Key
if ! [ -f "$SSH_DIR/id_rsa" ]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "Josh@JoshHaines.com"
    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"
    chmod 600 "$SSH_DIR/authorized_keys"
fi

# Install Bumblebee-status bar for i3
npx -y degit tobi-wan-kenobi/bumblebee-status $HOME/.dotfiles/bumblebee-status

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
testcmd tree-sitter

### Stow Dotfiles ###
cd ~/.dotfiles
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

# Install Fisher & Configure Fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/fisher.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/completions/fisher.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/fish_mode_prompt.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/fish_prompt.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/conf.d/_tide_init.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/completions/tide.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/set_onedark.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/set_onedark_color.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/completions/set_onedark.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/completions/set_onedark_color.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/conf.d/omf.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/config.fish
fish -c "curl -sL --insecure https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install IlanCosman/tide@v5"
fish -c "fisher install rkbk60/onedark-fish"
fish -c "echo 1 2 1 1 2 2 y | tide configure >/dev/null"
rm -rf ~/.config/fish
cd ~/.dotfiles
stow fish
cd ~
# add fish as a login shell
command -v fish | sudo tee -a /etc/shells
# use fish as default shell
chsh -s /usr/bin/fish


### Cleanup ###
cd ~
rm -rf google-chrome-stable_current_amd64.deb
rm -rf nvim-linux64.deb
rm -rf nvim-linux64.deb.sha256sum
rm -rf lf-linux-amd64.tar.gz
rm -rf lf
rm -rf .fehbg
rm -rf yamlfmt
#
# # Reconfigure Locales
# # export LANGUAGE="en_US.UTF-8"
# # export LC_ALL="en_US.UTF-8"
# # export LANG="en_US.UTF-8"
# # sudo dpkg-reconfigure locales
