# Dotfiles

These are my dotfiles!

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

### Commands

| Command                                      | Notes                                                                                                                                                                                                                                                                                                                                    |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `xrandr --output Virtual-1 --mode 2560x1600` | Set the resolution on a VM to 2560x1600                                                                                                                                                                                                                                                                                                  |
| `xset r rate 350 90`                         | Fix keyboard repeat rates                                                                                                                                                                                                                                                                                                                |
| `sudo apt install spice-vdagent`             | If on boxes vm, use this to get proper resolutions, restart after                                                                                                                                                                                                                                                                        |
| `flusdns`                                    | Alias for `sudo resolvectl flush-caches` wihch will flush the dns cache(s)                                                                                                                                                                                                                                                               |
| `tf`                                         | Alias for `terraform`                                                                                                                                                                                                                                                                                                                    |
| `tg`                                         | Alias for `terragrunt`                                                                                                                                                                                                                                                                                                                   |
| `pn`                                         | Alias for `pnpm`                                                                                                                                                                                                                                                                                                                         |
| `tmf`                                        | Alias for `tmuxifier`                                                                                                                                                                                                                                                                                                                    |
| `mdclean`                                    | Runs a list of find and replace commands found in the `~/.replace_rules.txt` file. If run with no flags it works downward recursively from the current directory. If you pass a directory it'll go down from there. (`e.g. mdclean ./git/news`) There is also a `-d` / `--dry-run` flag if you want to check what it is going to change. |
| `add_mdclean_rule "x" "o"`                   | Adds a new "find" and "replace" to the execution in mdclean. This command would have mdclean replace all x's with o's in recursively down from the current directory.                                                                                                                                                                    |

> located in `~/.dotfiles/fish` directory and simlinked to `$HOME`.

## Config and Keybindings

### Fish Config

### Neovim

Things should set up correctly automatically.  I've switched to LazyVim for my config and setup.

| Command             | Notes                                   |
| ------------------- | --------------------------------------- |
| `:Lazy`   | Lazy menu for updates, installs, etc.            |
| `:Mason`    | Upgrade or install plugins     |
| `:Copilot setup`    | Configure GitHub Copilot and Login      |

**Keybindings**

| Key               | Function                                                                    |
| ----------------- | --------------------------------------------------------------------------- |
| `Space` | Leader |
| `\` | LocalLeader |
| `Space+w`         | Activate hop, type next two characters to hop                               |
| `Space+e`         | Toggle nvim-tree                                                            |
| `Space+f`         | Open Telescope (find)                                                       |
| `Space+/`         | Open Telescope (fuzzy find)                                                 |
| `Space+g`         | Open Telescope (git)                                                        |
| `Space+Space`     | Telescope fuzzy find                                                        |
| `Ctrl+n/p`        | Telescope select item                                                       |
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

#### LSP

| Key       | Function                                                |
| --------- | ------------------------------------------------------- |
| `K`       | Hover (show documentation)                              |
| `Space+F` | Format document and save                                |
| `gd`      | Go to Definition                                        |
| `gr`      | Go to References                                        |
| `gi`      | Go to Implementation                                    |
| `gy`      | Go to Type Definition                                   |
| `ctrl+T`  | Go back to previous location after using an LSP command |

#### Harpoon

| Key        | Function                 |
| ---------- | ------------------------ |
| `Shift+hm` | Open Harpoon Menu        |
| `Shift+ha` | Add File to Harpoon      |
| `Shift+hr` | Remove File from Harpoon |
| `Shift+hh` | Next Harpoon File        |
| `Shift+hj` | Previous Harpoon File    |

### Rofi

`Win` or `Super` key should open rofi launcher

### tmux

**General**

| Key               | Function                                                           |
| ----------------- | ------------------------------------------------------------------ |
| `Alt+M` or _Right Nuclear Key_        | Prefix                                          |
| `Prefix + I`       | Install new Plugins after adding to tmux.conf                      |
| `Prefix + u`       | Update Plugins                                                     |
| `Prefix + alt + u` | Remove Plugins installed but missing from plugin list in tmux.conf |

**Panes**

| Key               | Function                                                           |
| ----------------- | ------------------------------------------------------------------ |
| `Prefix + h`      | Switch Pane Left                                                   |
| `Prefix + j`       | Switch Pane Down                                                   |
| `Prefix + k`      | Switch Pane Up                                                     |
| `Prefix + l`      | Switch Pane Right                                                  |
| `Prefix + \|`      | Draw Vertical Line (New Pane to Left)                          |
| `Prefix + _`      | Draw Horizontal Line (New Pane to Bottom)                          |
| `Prefix + x` | Kill Current Pane

**Windows**

| Key               | Function                                                           |
| ----------------- | ------------------------------------------------------------------ |
| `Prefix + c` | New Window |
| `Prefix + n` | Next Window |
| `Prefix + p` | Previous Window |

**Sessions**

| Key               | Function                                                           |
| ----------------- | ------------------------------------------------------------------ |
| `Prefix + d` | Kill Current Session |

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
