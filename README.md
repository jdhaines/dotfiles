# Dotfiles

## Usage

> If you are running in Gnome Boxes, first run `sudo apt install spice-vdagent` to install the helper libraries then reboot the machine (`shutdown -r now`)

```bash
# clone the repo
git clone https://github.com/jdhaines/dotfiles.git $HOME/.dotfiles

# run the install script
./.dotfiles/home.sh

# restart
shutdown -r now

# When you log back in, select i3 as the desktop manager
```

**Helpful Commands**

| Command                                      | Notes                                                                      |
| -------------------------------------------- | -------------------------------------------------------------------------- |
| `xrandr --output Virtual-1 --mode 2560x1600` | Set the resolution on a VM to 2560x1600                                    |
| `xset r rate 350 90`                         | Fix keyboard repeat rates                                                  |
| `sudo apt install spice-vdagent`             | If on boxes vm, use this to get proper resolutions, restart after          |
| `flusdns`                                    | Alias for `sudo resolvectl flush-caches` wihch will flush the dns cache(s) |
| `tf`                                         | Alias for `terraform`                                                      |
| `tg`                                         | Alias for `terragrunt`                                                     |
| pn                                           | Alias for pnpm                                                             |

## Config

### Fish Config

### Neovim

Things should set up correctly automatically. You might need to run neovim twice in case of error. While in neovim the command `:PackerSync` and/or `:PackerCompile` may be helpful.

| Command             | Notes                                   |
| ------------------- | --------------------------------------- |
| `:Slowly install`   | Install current plugins list            |
| `:Slowly update`    | Upgrade currently installed plugins     |
| `:Slowly reinstall` | Reinstall current plugin list           |
| `:Slowly restore`   | Restore saved plugin list               |
| `:Slowly save`      | Save current plugins to restorable file |
| `:LspInstall`       | Install a new lsp server                |
| `:LspInfo`          | Current file and LSP information        |
| `:Mason`            | Open mason to install plugins           |
| `:TSUpdate`         | Update Tree-Sitter/Highlighting Plugins |
| `:TSInstall lang`   | Install new tree-sitter module          |
| `:TSInstallInfo`    | Check other modules to be installed     |
| `:Copilot setup`    | Configure GitHub Copilot and Login      |

| Key               | Function                                                                    |
| ----------------- | --------------------------------------------------------------------------- |
| `Space+w`         | Activate hop, type next two characters to hop                               |
| `Space+e`         | Toggle nvim-tree                                                            |
| `Space+f`         | Open Telescope (find)                                                       |
| `Space+/`         | Open Telescope (fuzzy find)                                                 |
| `Space+g`         | Open Telescope (git)                                                        |
| `Space+Space`     | Telescope fuzzy find                                                        |
| `Ctrl+n/p`        | Telescope select item                                                       |
| `Space+F`         | Format document and save                                                    |
| `Space+c`         | Open LSP menu                                                               |
| `Shift+h`         | Back to last buffer                                                         |
| `gd`              | Go to item definition                                                       |
| `Ctrl+P`          | List completions                                                            |
| `Shift+k`         | List Help/Hints on underlying item                                          |
| `Space+uh`        | Toggle greyed-out type hints                                                |
| `Tab/Shift + Tab` | Move through completions, Enter to Select                                   |
| `zM/zR`           | Fold/Unfold All                                                             |
| `zm/zr`           | Fold/Unfold One                                                             |
| `zo/zc`           | Open and Close a Fold                                                       |
| `ctrl+w hjkl`     | Switch to another nvim buffer                                               |
| `ctrl+w <>`       | Expand or Contract when buffers are side-by-side. Can add number before <>. |
| `ctrl+w J`        | Change to horizontal split                                                  |
| `ctrl+w H`        | Change to vertical split                                                    |
| `gcc`             | Toggle Comment on Selection                                                 |

#### Harpoon


| Key               | Function  |
| ----------------- | ---------------- |
| `Shift+hm` | Open Harpoon Menu       |
| `Shift+ha` | Add File to Harpoon     |
| `Shift+hr` | Remove File from Harpoon|
| `Shift+hj` | Previous Harpoon File   |
| `Shift+hh` | Next Harpoon File       |

### Rofi

- Win key should open rofi launcher

### tmux

| Key               | Function                                                           |
| ----------------- | ------------------------------------------------------------------ |
| `Ctrl + b`        | Prefix                                                             |
| `Prefix + I       | Install new Plugins after adding to tmux.conf                      |
| `Prefix + u       | Update Plugins                                                     |
| `Prefix + alt + u | Remove Plugins installed but missing from plugin list in tmux.conf |
| `Prefix + h` | Switch Pane Left |
| `Prefix + j | Switch Pane Down |
| `Prefix + k` | Switch Pane Up |
| `Prefix + l` | Switch Pane Right |
| `Prefix + "` | New Pane Below |
| `Prefix + %` | New Pane Right |

### i3

| Key                 | Function                                                     |
| ------------------- | ------------------------------------------------------------ |
| `Win-h/j/k/l`       | select windows                                               |
| `Win-Shift-h/j/k/l` | move windows                                                 |
| `Win-e`             | toggle layout                                                |
| `Win-c`             | close application                                            |
| `Win-enter`         | open terminal (alacritty)                                    |
| `Win-Shift-c`       | reload the i3 config                                         |
| `Win-Shift-r`       | refresh the i3 config                                        |
| `Win-Shift-s`       | reset the monitor config to laptop only (**s**ingle monitor) |
| `Win-Shift-d`       | reset the monitor config to dual monitor (**d**ual monitor)  |

### LazyGit

| Key     | Function                    |
| ------- | --------------------------- |
| `?`     | hotkey map                  |
| `lg`    | alias for lazygit           |
| `jk`    | move within a block         |
| `hl`    | move between blocks         |
| `p`     | pull                        |
| `P`     | push                        |
| `space` | In _Files_, stage file      |
| `a`     | In _Files_, stage all files |
| `c`     | commit                      |

## Other Notes

**Lid Switch:** Look in `/etc/systemd/logind.conf` and change the value of the 3 lid values (after uncommenting the line) to `ignore` so that closing the laptop lid doesn't blow up your i3 config.
