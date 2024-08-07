if status is-interactive
    # Commands to run in interactive sessions can go here
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# go
set --export GOROOT /usr/local/go
set --export PATH $GOROOT/bin $PATH
set --export GOPATH $HOME/golibs
set --export PATH $GOPATH/bin $PATH

# tmux
set --export PATH $HOME/.tmux/plugins/tmuxifier/bin $PATH
eval (tmuxifier init - fish)
set --export TMUXIFIER_LAYOUT_PATH $HOME/.tmux/layouts

# editor
set --export EDITOR nvim

# starship
starship init fish | source
