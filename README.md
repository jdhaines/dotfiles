
# Dotfiles

## Usage

>If you are running in Gnome Boxes, first run `sudo apt install spice-vdagent` to install the helper libraries then reboot the machine (`shutdown -r now`)

```bash
# clone the repo
git clone https://github.com/jdhaines/dotfiles.git $HOME/.dotfiles

# run the install script
./.dotfiles/install.sh

# restart
shutdown -r now

# When you log back in, select i3 as the desktop manager
```

**Helpful Commands**

|Command|Notes|
|---|---|
|`xrandr --output Virtual-1 --mode 2560x1600`|Set the resolution on a VM to 2560x1600|
|`xset r rate 350 90`|Fix keyboard repeat rates|
|`sudo apt install spice-vdagent`|If on boxes vm, use this to get proper resolutions, restart after|

## Config

### Fish Config


### Neovim

Things should set up correctly automatically.  You might need to run neovim twice in case of error.  While in neovim the command `:PackerSync` and/or `:PackerCompile` may be helpful.

|Command|Notes|
|---|---|
|`:PackerInstall`|Install current plugins list|
|`:PackerSync`|Similar to above|
|`:LspInstall`|Install a new lsp server|
|`:LspInstallInfo`|Details on currently installed language servers|
|`:LspInfo`|Current file and LSP information|

|Key|Function|
|---|---|
|`Space+w`|Activate hop, type next two characters to hop|
|`Ctrl+P`|List completions|
|`Tab/Shift + Tab`|Move through completions, Enter to Select|
|`zM/zR`|Fold/Unfold All|
|`zm/zr`|Fold/Unfold One|
|`zM`|Fold All|
|`zo/zc`|Open and Close a Fold|


### Rofi
- Win key should open rofi launcher

### i3
- Win-h/j/k/l select windows
- Win-Shift-h/j/k/l move windows
- Win-e toggle layout
- Win-shift-q close window
- Win-enter open terminal (alacritty)

