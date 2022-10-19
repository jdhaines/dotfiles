# GLOBALS
SSH_DIR="$HOME/.ssh"

# install nix
curl -L https://nixos.org/nix/install | sh

# source nix
. $HOME/.nix-profile/etc/profile.d/nix.sh

# allow chrome install
export NIXPKGS_ALLOW_UNFREE=1

# stow Dotfiles
nix-env -iA nixpkgs.stow
stow -d ~/.dotfiles alacritty
stow -d ~/.dotfiles git
stow -d ~/.dotfiles i3
stow -d ~/.dotfiles nvim
stow -d ~/.dotfiles picom
stow -d ~/.dotfiles profile
stow -d ~/.dotfiles rofi

# install packages
nix-env -iA \
  nixpkgs.git \
  nixpkgs.neovim \
  nixpkgs.yarn \
  # nixpkgs.stow \
  nixpkgs.gcc \
  nixpkgs.bat \
  nixpkgs.gnumake \
  nixpkgs.google-chrome \
  nixpkgs.vlc \
  nixpkgs.nodejs \
  nixpkgs.python3 \
  nixpkgs.fish \
  nixpkgs.xclip \
  nixpkgs.alacritty \
  nixpkgs.feh \
  nixpkgs.xcwd \
  nixpkgs.ripgrep \
  nixpkgs.jq \
  nxpkgs.bat \

# install pip
python -m ensurepip --upgrade
python -m pip install --upgrade pip

# install psutils for bumblebee-status bar on i3
python -m pip install psutil
python -m pip install pygit2

# to fix bug with locale for rofi
# set LOCALE_ARCHIVE (nix-build --no-out-link "<nixpkgs>" -A glibcLocales | grep /nix/store/)''/lib/locale/locale-archive

# home pc pkgs

# nix-env -iA \
# nixpkgs.discord \
# nixpkgs.slack \
# nixpkgs.spotify \
# nixpkgs.webstorm \
# nixpkgs.teams \
# nixpkgs.gnome-boxes \
# nixpkgs.insomnia \

# Install Fisher & Configure Fish
# source /dev/stdin <<< "$(curl -sL https://git.io/fisher)"
fish -c "curl -sL --insecure https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install IlanCosman/tide@v5"
fish -c "fisher install rkbk60/onedark-fish"
rm -f $HOME/.config/fish/conf.d/omf.fish
rm -f $HOME/.config/fish/config.fish
# stow -d ~/.dotfiles fish
fish -c "echo 1 1 1 1 2 2 y | tide configure >/dev/null"
rm -rf ~/.config/fish
stow -d ~/.dotfiles fish

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

# install i3
sudo apt install -y i3
sudo dpkg-reconfigure i3

# install rofi
sudo apt install -y rofi picom

# install alacritty
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault   # or replace `nixGLDefault` with your desired wrapper
# run alacritty through nixGL like `nixGL alacritty

# Reconfigure Locales
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
sudo dpkg-reconfigure locales

# Install tree-sitter-cli
curl -s https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest \
  | grep "browser_download_url.*linux-x64.gz" \
  | cut -d : -f 2,3 \
  | tr -d \" \
  | wget -qi -
gzip -d tree-sitter-linux-x64.gz
chmod +x tree-sitter-linux-x64
mv tree-sitter-linux-x64 ~/.local/bin/


# finishing up neovim setup
nvim --headless +PackerSync +qall

# set keyboard repeat rate
xset r rate 350 90
