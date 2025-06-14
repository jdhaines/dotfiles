#!/bin/bash

### Variables ###
SSH_DIR="$HOME/.ssh"
DEBIAN_FRONTEND=noninteractive
NODE_MAJOR=20

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
curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest |
  grep "browser_download_url.*Linux_x86_64.tar.gz" |
  cut -d : -f 2,3 |
  tr -d \" |
  wget -qi -
sudo rm -rf *.sbom
sudo mv gum* gum.tar.gz
sudo tar -xf gum.tar.gz
sudo cp ~/gum /usr/local/bin
#breaker

### Run the Installs from apt ###
#   addpkg - installs package, ensures it's installed
#   addcmd - installs package, ensures that command is avialable in the PATH
testcmd curl
testcmd gum
#breaker

addpkg apt-transport-https
addcmd arandr
addpkg pulseaudio-utils
testcmd pactl
#breaker

addpkg build-essential
addpkg ca-certificates
addcmd cargo
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
addcmd python3
addpkg python3-pip
addcmd rclone
addcmd rclone-browser
#breaker

addpkg ripgrep
addcmd rofi
addpkg scdaemon
addpkg software-properties-common
addcmd stow
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

  # node
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  # echo "after node"
  # breaker

  # ghostty

  # kdenlive
  sudo add-apt-repository -y ppa:kdenlive/kdenlive-stable

  # docker
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

  # yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

  # spotify
  curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  echo "after spotify"
  breaker

  # inkscape
  sudo add-apt-repository -y ppa:inkscape.dev/stable

  # obs studio
  sudo add-apt-repository -y ppa:obsproject/obs-studio

  # github cli
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

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

  # ghostty
  curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh

  # yubikey
  sudo add-apt-repository -y ppa:yubico/stable

  # kubectl
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
  # helm
  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg >/dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
}

### Install from New Repos ###
addrepos
breaker
sudo apt update -q
testcmd ffmpeg
addpkg yubikey-manager
testcmd ykman
addcmd fish
addpkg gh
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
addpkg terraform
addcmd vhs
addcmd glow
addcmd yarn
addpkg git-lfs
addcmd kubectl
addcmd helm
testcmd ghostty
#breaker

### Post Install ###
sudo usermod -aG docker $USER                                   # docker
export PATH="$(yarn global bin):$PATH"                          # yarn
sudo dpkg-reconfigure i3                                        # i3

### Custom Installs ###
cd ~

# stew
curl -s https://api.github.com/repos/marwanhawari/stew/releases/latest |
  grep "browser_download_url.*linux-amd64.tar.gz" |
  cut -d : -f 2,3 |
  tr -d \" |
  wget -qi -
sudo mv stew* stew.tar.gz
sudo tar -xf stew.tar.gz
sudo chmod +x stew
sudo cp stew /usr/local/bin
testcmd stew

# ttyd
sudo snap install ttyd --classic

# tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
breaker

# discord #TODO
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install -qy ./discord.deb
testcmd discord

# slack TODO
wget -O slack.deb "https://downloads.slack-edge.com/releases/linux/4.29.149/prod/x64/slack-desktop-4.29.149-amd64.deb"
sudo apt install -qy ./slack.deb
testcmd slack

# alacritty #TODO
cargo install alacritty
sudo cp ~/.cargo/bin/alacritty /usr/local/bin
testcmd alacritty
breaker

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

### Stow Dotfiles ###
cd ~/.dotfiles
stow alacritty
stow arandr
stow gh-dash
stow git
stow jetbrains
stow lazygit
stow i3
stow lf
stow neofetch
stow nvim
stow picom
stow profile
stow rofi
stow silicon
stow starship
stow tmux
stow stew
cd ~
breaker

# Install Stew Binaries
stew install $HOME/.config/stew/Stewfile.lock.json

testcmd bat
testcmd nvim
testcmd eza
testcmd lazygit
testcmd lazydocker
testcmd snyk
testcmd tailwindcss
testcmd yamlfmt
testcmd yq
testcmd zoxide

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
