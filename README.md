
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
|`:Slowly install`|Install current plugins list|
|`:Slowly upgrade`|Upgrade currently installed plugins|
|`:Slowly reinstall`|Reinstall current plugin list|
|`:Slowly restore`|Restore saved plugin list|
|`:Slowly save`|Save current plugins to restorable file|
|`:LspInstall`|Install a new lsp server|
|`:LspInfo`|Current file and LSP information|
|`:Mason`|Open mason to install plugins|

|Key|Function|
|---|---|
|`Space+w`|Activate hop, type next two characters to hop|
|`Space+e`|Toggle nvim-tree|
|`Space+f`|Telescope fuzzy find|
|`Space+F`|Format document and save|
|`Space+g`|Telescope grep search|
|`Space+c`|Telescope git commits|
|`Ctrl+P`|List completions|
|`Tab/Shift + Tab`|Move through completions, Enter to Select|
|`zM/zR`|Fold/Unfold All|
|`zm/zr`|Fold/Unfold One|
|`zo/zc`|Open and Close a Fold|

### Rofi

- Win key should open rofi launcher

### i3

|Key|Function|
|---|---|
|`Win-h/j/k/l`|select windows|
|`Win-Shift-h/j/k/l`|move windows|
|`Win-e`|toggle layout|
|`Win-c`|close application|
|`Win-enter`|open terminal (alacritty)|
|`Win-Shift-c`|reload the i3 config|
|`Win-Shift-r`|refresh the i3 config|
|`Win-Shift-s`|reset the monitor config to laptop only (**s**ingle monitor)|
|`Win-Shift-d`|reset the monitor config to dual monitor (**d**ual monitor)|

## Other Notes

**Lid Switch:** Look in `/etc/systemd/logind.conf` and change the value of the 3 lid values (after uncommenting the line) to `ignore` so that closing the laptop lid doesn't blow up your i3 config.

