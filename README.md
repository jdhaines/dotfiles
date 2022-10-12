
# Dotfiles

## Usage

>If you are running in Gnome Boxes, first run `sudo apt install spice-vdagent` to install the helper libraries then reboot the machine (`shutdown -r now`)

```bash
# clone the repo
git clone https://github.com/jdhaines/dotfiles.git $HOME/.dotfiles

# run the install script
./.dotfiles/install.sh

# It will hang after some packer actions.  Kill it and run the script again and it should proceed
./.dotfiles/install.sh
```

## Config

**Fish Config**

- Alias `vim` -> `nvim`
- Alias `vi` -> `nvim`

**Neovim**

Things should set up correctly automatically.  You might need to run neovim twice in case of error.  While in neovim the command `:PlugSync` and/or `:PlugCompile` may be helpful.
