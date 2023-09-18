#!/bin/bash

### Variables ###
SSH_DIR="$HOME/.ssh"
DEBIAN_FRONTEND=noninteractive

### Functions ###

function breaker()
{
  read -p "Press [Enter] key to continue..."
}

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
curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest \
  | grep "browser_download_url.*Linux_x86_64.tar.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
sudo rm -rf *.sbom
sudo mv gum* ~
cd ~
sudo mv gum* gum.tar.gz
sudo tar -xf gum.tar.gz
sudo cp ~/gum /usr/local/bin
breaker

### Run the Installs from apt ###
#   addpkg - installs package, ensures it's installed
#   addcmd - installs package, ensures that command is avialable in the PATH
testcmd curl
testcmd gum
breaker

addpkg apt-transport-https
addcmd arandr
addpkg bat
addpkg pulseaudio-utils
testcmd pactl
breaker

addpkg build-essential
addpkg ca-certificates
addcmd cargo
addcmd cmake
addcmd feh
breaker

addcmd flameshot
addcmd gimp
addcmd git
addpkg gnome-tweaks
addpkg gnupg
breaker

addcmd guvcview
addcmd i3
addcmd indent
addcmd jq
addcmd kleopatra
breaker

addpkg libanyevent-i3-perl
addpkg libfontconfig1-dev
addpkg libfreetype6-dev
addpkg libfuse2
addpkg libxcb-xfixes0-dev
breaker

addpkg libxkbcommon-dev
addpkg lsb-release
addcmd tmux
addcmd make
addcmd picom
breaker

addpkg pkg-config
addcmd python3
addpkg python3-pip
addcmd rclone
addcmd rclone-browser
breaker

addpkg ripgrep
addcmd rofi
addpkg scdaemon
addpkg software-properties-common
addcmd stow
breaker

addcmd vlc
addcmd wget
addpkg x11-xserver-utils
addcmd xclip
addcmd xcwd
addpkg xdotool
breaker

### Add Repos ###
function addrepos() {
  
# fish
sudo apt-add-repository -qy ppa:fish-shell/release-3

# node
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# kdenlive
sudo add-apt-repository -qy ppa:kdenlive/kdenlive-stable

# docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
breaker
  
# spotify
  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# inkscape
sudo add-apt-repository ppa:inkscape.dev/stable

# obs studio
sudo add-apt-repository ppa:obsproject/obs-studio

# github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# hashicorp
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
breaker

# charm
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list

# git lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

# yubikey
sudo add-apt-repository ppa:yubico/stable

# kubectl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
}
breaker
 
### Install from New Repos ###
addrepos
sudo apt update -q 
testcmd ffmpeg
addpkg yubikey-manager
testcmd ykman
addcmd fish
addpkg gh
breaker
 
addpkg nodejs
addpkg npm
testcmd npx
addpkg kdenlive
addpkg obs-studio
breaker
 
addpkg inkscape
addpkg containerd.io
addpkg docker-ce 
addpkg docker-ce-cli 
addpkg docker-compose-plugin 
breaker
 
addpkg spotify-client
addpkg terraform
addcmd vhs
addcmd yarn
addpkg git-lfs
addcmd kubectl
addcmd helm
breaker

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

# tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# snyk cli tool
sudo wget https://static.snyk.io/cli/latest/snyk-linux -O /usr/local/bin/snyk
sudo chmod +x /usr/local/bin/snyk
testcmd snyk
breaker

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

# pulumi
curl -fsSL https://get.pulumi.com | sh
sudo cp -r ~/.pulumi/bin/. /usr/local/bin/
testcmd pulumi

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
breaker

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

# terragrunt
TERRAGRUNT_VERSION=$(curl -s "https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64"
chmod +x terragrunt
sudo mv terragrunt /usr/local/bin
testcmd terragrunt
breaker

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
breaker

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
breaker

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
breaker

### Cleanup ###
cd ~
rm -rf google-chrome-stable_current_amd64.deb
rm -rf nvim-linux64.deb
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
