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
