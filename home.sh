#!/bin/bash

### Variables ###
SSH_DIR="$HOME/.ssh"
DEBIAN_FRONTEND=noninteractive

### Functions ###

function successwriter() 
{
  echo ""
  gum style --foreground 77 --border-foreground 77 --border rounded -- "$1 Installed"
  echo ""
}
function failurewriter() 
{
  echo ""
  gum style --foreground 212 --border-foreground 212 --border rounded "$1 Failed"
  echo ""
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

### Install Gum for UI ###
sudo apt install -yq curl
testcmd curl
curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest \
  | grep "browser_download_url.*linux_x86_64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo rm -rf *.sbom
sudo mv gum* gum.tar.gz
sudo tar -xf gum.tar.gz
sudo cp ~/gum /usr/local/bin

### Run the Installs from apt ###
#   addpkg - installs package, ensures it's installed
#   addcmd - installs package, ensures that command is avialable in the PATH
testcmd gum

addcmd arandr
addpkg bat
addpkg pulseaudio-utils
testcmd pactl
addpkg build-essential
addpkg ca-certificates
addcmd cargo
addcmd cmake
addcmd feh
addcmd flameshot
addcmd gimp
addcmd git
addpkg gnome-tweaks
addpkg gnupg
addcmd guvcview
addcmd i3
addcmd indent
addcmd jq
addcmd kleopatra
addpkg libanyevent-i3-perl
addpkg libfontconfig1-dev
addpkg libfreetype6-dev
addpkg libfuse2
addpkg libxcb-xfixes0-dev
addpkg libxkbcommon-dev
addpkg lsb-release
addcmd make
addcmd picom
addpkg pkg-config
addcmd python3
addpkg python3-pip
addcmd rclone
addcmd rclone-browser
addpkg ripgrep
addcmd rofi
addpkg scdaemon
addpkg software-properties-common
addcmd stow
addcmd vlc
addcmd wget
addpkg x11-xserver-utils
addcmd xclip
addcmd xcwd
addpkg xdotool

### Add Repos ###
function addrepos() {
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
sudo add-apt-repository ppa:inkscape.dev/stable
sudo add-apt-repository ppa:obsproject/obs-studio
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo add-apt-repository ppa:yubico/stable
}
 
### Install from New Repos ###
addrepos
sudo apt update -q 
testcmd ffmpeg
addpkg yubikey-manager
testcmd ykman
addcmd fish
addpkg gh
addpkg nodejs
addpkg npm
testcmd npx
addpkg kdenlive
addpkg obs-studio
addpkg inkscape
addpkg containerd.io
addpkg docker-ce 
addpkg docker-ce-cli 
addpkg docker-compose-plugin 
addpkg spotify-client
addpkg terraform
addcmd vhs
addcmd yarn
addpkg git-lfs

### Post Install ###
sudo usermod -aG docker $USER  # docker
export PATH="$(yarn global bin):$PATH"  # yarn
sudo dpkg-reconfigure i3  # i3
mkdir -p ~/.local/bin && ln -s /usr/bin/batcat ~/.local/bin/bat  # bat fix

### Custom Installs ###
cd ~

# inkdrop
wget https://api.inkdrop.app/download/linux/deb -O /tmp/inkdrop.deb && sudo dpkg -i /tmp/inkdrop.deb && rm /tmp/inkdrop.deb
testcmd inkdrop

# ttyd
sudo snap install ttyd --classic

# snyk cli tool
sudo wget https://static.snyk.io/cli/latest/snyk-linux -O /usr/local/bin/snyk
sudo chmod +x /usr/local/bin/snyk
testcmd snyk

# neovim
curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
  | grep "browser_download_url.*vim.appimage" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
mv nvim.appimage nvim
sudo cp nvim /usr/local/bin/
sudo chmod +x /usr/local/bin/nvim
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

# slack
wget -O slack.deb "https://downloads.slack-edge.com/releases/linux/4.29.149/prod/x64/slack-desktop-4.29.149-amd64.deb"
sudo apt install -qy ./slack.deb
testcmd slack

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
    ssh-keygen -t ed25519 -f "$SSH_DIR/id_rsa" -N "" -C "Josh@JoshHaines.com"
    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"
    chmod 600 "$SSH_DIR/authorized_keys"
fi

# JetBrains Toolbox
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash
testcmd jetbrains-toolbox

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
stow arandr
stow inkdrop
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
fish -c "echo 1 2 1 1 2 2 y | tide configure >/dev/null"
rm -rf ~/.config/fish
cd $HOME/.dotfiles
stow fish
cd $HOME
# add fish as a login shell
command -v fish | sudo tee -a /etc/shells
# use fish as default shell
sudo chsh -s $(which fish) $(whoami)

### Cleanup ###
cd ~
rm -rf google-chrome-stable_current_amd64.deb
rm -rf nvim.appimage
rm -rf nvim.appimage.sha256sum
rm -rf nvim.appimage.zsync
rm -rf nvim.appimage.zsync.sha256sum
rm -rf lf-linux-amd64.tar.gz
rm -rf lf
rm -rf .fehbg
rm -rf yamlfmt
rm -rf LICENSE
rm -rf README.md
rm -rf discord.deb
rm -rf slack.deb
rm -rf lazygit.tar.gz
rm -rf yamlfmt.tar.gz
rm -rf gum*
rm -rf home.sh2

#
# # Reconfigure Locales
# # export LANGUAGE="en_US.UTF-8"
# # export LC_ALL="en_US.UTF-8"
# # export LANG="en_US.UTF-8"
# # sudo dpkg-reconfigure locales
