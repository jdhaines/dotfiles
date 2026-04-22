#!/bin/bash

### Variables ###
SSH_DIR="$HOME/.ssh"
DEBIAN_FRONTEND=noninteractive
NODE_MAJOR=24

### Functions ###

function breaker() {
  read -p "Press [Enter] key to continue..."
}

function successwriter() {
  echo ""
  gum style --foreground 77 --border-foreground 77 --border rounded -- "$1 Installed"
  echo ""
}
function failurewriter() {
  echo ""
  gum style --foreground 212 --border-foreground 212 --border rounded "$1 Failed"
  echo ""
}

# pass parameter to install with apt, and verify it got installed
function addpkg() {
  echo "Installing $1..."
  sudo apt install -qy $1
  if dpkg -s $1 2>/dev/null >/dev/null; then
    successwriter $1
  else
    failurewriter $1
  fi
}

# pass parameter to install with apt and make sure it's callable in the PATH
function addcmd() {
  echo "Installing $1..."
  sudo apt install -qy $1
  if command -v $1 &>/dev/null; then
    successwriter $1
  else
    failurewriter $1
  fi
}

# pass parameter to make sure cmd is available and in the PATH
function testcmd() {
  echo "Installing $1..."
  if command -v $1 &>/dev/null; then
    successwriter $1
  else
    failurewriter $1
  fi
}

### Install Gum for UI ###
sudo apt install -yq curl

# mise
# sudo add-apt-repository -y ppa:jdxcode/mise
# sudo apt update -y
# sudo apt install -y mise
# eval "$(mise activate bash)"
curl https://mise.run/bash | sh
source ~/.bashrc
breaker

### Stow Dotfiles ###
addcmd stow
cd ~/.dotfiles
stow alacritty
stow arandr
stow gh-dash
stow ghostty
stow git
stow i3
stow jetbrains
stow lazygit
stow lf
stow mise
stow neofetch
stow nvim
stow obs
stow picom
stow profile
stow rofi
stow silicon
stow ssh
stow starship
stow tmux
stow wezterm
stow zellij
cd ~

# Install Mise Binaries
testcmd mise
mise install
breaker

### Run the Installs from apt ###
#   addpkg - installs package, ensures it's installed
#   addcmd - installs package, ensures that command is avialable in the PATH
testcmd curl
testcmd gum
# breaker

addpkg apt-transport-https
addcmd arandr
addpkg pulseaudio-utils
testcmd pactl
# breaker

addpkg build-essential
addpkg ca-certificates
addcmd cmake
addcmd feh
#breaker

addcmd flameshot
addcmd gimp
addcmd git
addpkg gnome-tweaks
addpkg gnupg
#breaker

addcmd guvcview
addcmd i3
addcmd indent
addcmd jq
addcmd kleopatra
#breaker

addpkg libanyevent-i3-perl
addpkg libfontconfig1-dev
addpkg libfreetype-dev
addpkg libfuse2
addpkg libxcb-xfixes0-dev
#breaker

addpkg libxkbcommon-dev
addpkg lsb-release
addcmd tmux
addcmd make
addcmd picom
#breaker

addpkg pkg-config
addcmd rclone
addcmd rclone-browser
#breaker

addcmd rofi
addpkg scdaemon
addpkg software-properties-common
#breaker

addcmd vlc
addcmd wget
addpkg x11-xserver-utils
addcmd xclip
addcmd xcwd
addpkg xdotool
addpkg lxpolkit
addpkg pavucontrol
breaker

### Add Repos ###
function addrepos() {

  # fish
  sudo add-apt-repository -y ppa:fish-shell/release-4

  # ghostty
  sudo add-apt-repository ppa:mkasberg/ghostty-ubuntu
  sudo apt update
  sudo apt install ghostty

  # kdenlive
  sudo add-apt-repository -y ppa:kdenlive/kdenlive-stable

  # docker
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

  # spotify
  curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  echo "after spotify"
  # breaker

  # inkscape
  sudo add-apt-repository -y ppa:inkscape.dev/stable

  # obs studio
  sudo add-apt-repository -y ppa:obsproject/obs-studio

  # hashicorp
  wget -O- https://apt.releases.hashicorp.com/gpg |
    gpg --dearmor |
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
  gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
    sudo tee /etc/apt/sources.list.d/hashicorp.list

  # charm
  curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list

  # git lfs
  curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

  # yubikey
  sudo add-apt-repository -y ppa:yubico/stable
}

### Install from New Repos ###
addrepos
breaker
sudo apt update -q
testcmd ffmpeg
addpkg yubikey-manager
testcmd ykman
addcmd fish
addpkg nodejs
testcmd node
testcmd npm
testcmd npx
addpkg kdenlive
addpkg obs-studio
addpkg inkscape
addpkg containerd.io
addpkg docker-ce
addpkg docker-ce-cli
addpkg docker-compose-plugin
addpkg spotify-client
addcmd vhs
addcmd glow
addpkg git-lfs
addcmd kubectl
testcmd ghostty
#breaker

### Post Install ###
sudo usermod -aG docker $USER                                   # docker
export PATH="$(yarn global bin):$PATH"                          # yarn
sudo dpkg-reconfigure i3                                        # i3

### Custom Installs ###
cd ~

# ttyd
sudo snap install ttyd --classic

# tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
breaker

# discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install -qy ./discord.deb
testcmd discord

# Google Chrome #TODO
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -qy ./google-chrome-stable_current_amd64.deb
testcmd google-chrome

# psutils & pygit2 for bumblebee-status bar on i3
python3 -m pip install --no-input psutil pygit2

# Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Jet Brains Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
fc-cache -f -v # rebuild font cache
cd ~

# SSH Key
if ! [ -f "$SSH_DIR/id_rsa" ]; then
  mkdir -p "$SSH_DIR"
  chmod 700 "$SSH_DIR"
  ssh-keygen -t ed25519 -f "$SSH_DIR/id_rsa" -N "" -C "Josh@JoshHaines.com"
  cat "$SSH_DIR/id_rsa.pub" >>"$SSH_DIR/authorized_keys"
  chmod 600 "$SSH_DIR/authorized_keys"
fi

# JetBrains Toolbox #TODO
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash
testcmd jetbrains-toolbox
echo "after jetbrains toolbox"
breaker

# Install Bumblebee-status bar for i3
npx -y degit tobi-wan-kenobi/bumblebee-status $HOME/.dotfiles/bumblebee-status
addpkg python3-psutil
addpkg python3-pygit2

# Install tree-sitter-cli
curl -s https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest |
  grep "browser_download_url.*linux-x64.gz" |
  cut -d : -f 2,3 |
  tr -d \" |
  wget -qi -
gzip -d tree-sitter-linux-x64.gz
chmod +x tree-sitter-linux-x64
mv tree-sitter-linux-x64 tree-sitter
sudo mv tree-sitter /usr/local/bin
testcmd tree-sitter

# Install Fisher & Configure Fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/fisher.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/completions/fisher.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/fish_mode_prompt.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/fish_prompt.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/conf.d/_tide_init.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/completions/tide.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/set_onedark.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/set_onedark_color.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/_tide*
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/tide
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/functions/tide.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/completions/set_onedark.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/completions/set_onedark_color.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/conf.d/omf.fish
sudo rm -rf $HOME/.dotfiles/fish/.config/fish/config.fish
fish -c "curl -sL --insecure https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install IlanCosman/tide@v5"
fish -c "fisher install jorgebucaran/nvm.fish"
fish -c "fisher install catppuccin/fish"
fish -c "fisher install nickeb96/puffer-fish"
fish -c "echo 1 2 1 1 2 2 y | tide configure >/dev/null"
fish -c "fish_config theme save "Catppucin Macchiato"
rm -rf ~/.config/fish
cd $HOME/.dotfiles
stow fish
cd $HOME
# add fish as a login shell
command -v fish | sudo tee -a /etc/shells
# use fish as default shell
sudo chsh -s $(which fish) $(whoami)
breaker

### Cleanup ###
cd ~
rm -rf google-chrome-stable_current_amd64.deb
rm -rf nvim-linux64.deb
rm -rf nvim.appimage*
rm -rf lf-linux-amd64.tar.gz
rm -rf lf
rm -rf .fehbg
rm -rf LICENSE
rm -rf README.md
rm -rf discord.deb
rm -rf slack.deb
rm -rf lazygit.tar.gz
rm -rf gum*
rm -rf home.sh2

#
# # Reconfigure Locales
# # export LANGUAGE="en_US.UTF-8"
# # export LC_ALL="en_US.UTF-8"
# # export LANG="en_US.UTF-8"
# # sudo dpkg-reconfigure locales
