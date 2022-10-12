# GLOBALS
SSH_DIR="$HOME/.ssh"

# install nix
curl -L https://nixos.org/nix/install | sh

# source nix
. $HOME/.nix-profile/etc/profile.d/nix.sh

# allow chrome install
export NIXPKGS_ALLOW_UNFREE=1

# install packages
nix-env -iA \
  nixpkgs.git \
  nixpkgs.neovim \
  nixpkgs.yarn \
  nixpkgs.stow \
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
stow fish
fish -c "echo 1 1 1 1 2 2 y | tide configure >/dev/null"

# Stow Dotfiles

# Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Jet Brains Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

# add fish as a login shell
command -v fish | sudo tee -a /etc/shells

# use fish as default shell
sudo chsh -s $(which fish) $USER

# install neovim plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Set up SSH
if ! [ -f "$SSH_DIR/id_rsa" ]; then
    mkdir -p "$SSH_DIR"

    chmod 700 "$SSH_DIR"

    ssh-keygen -b 4096 -t rsa -f "$SSH_DIR/id_rsa" -N "" -C "Josh@JoshHaines.com"

    cat "$SSH_DIR/id_rsa.pub" >> "$SSH_DIR/authorized_keys"

    chmod 600 "$SSH_DIR/authorized_keys"
fi

# install i3
sudo apt install -y i3
sudo dpkg-reconfigure i3

# install alacritty
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault   # or replace `nixGLDefault` with your desired wrapper

# run alacritty through nixGL
nixGL alacrittyy

