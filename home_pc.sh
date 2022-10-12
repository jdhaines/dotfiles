 install nix
curl -L https://nixos.org/nix/install | sh

# source nix
. $HOME/.nix-profile/etc/profile.d/nix.sh

# Allow discord install
export NIXPKGS_ALLOW_UNFREE=1

nix-env -iA \
  nixpkgs.discord \
  nixpkgs.slack \
  nixpkgs.spotify \
  nixpkgs.jetbrains.webstorm \
  nixpkgs.teams \
  nixpkgs.gnome.gnome-boxes \
  nixpkgs.insomnia \

