
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

## Config

**Fish Config**

- Alias `vim` -> `nvim`
- Alias `vi` -> `nvim`

**Neovim**

Things should set up correctly automatically.  You might need to run neovim twice in case of error.  While in neovim the command `:PlugSync` and/or `:PlugCompile` may be helpful.

**Rofi**
- Win key should open rofi launcher

**i3**
- Win-h/j/k/l select windows
- Win-Shift-h/j/k/l move windows
- Win-e toggle layout
- Win-shift-q close window
- Win-enter open terminal (alacritty)
