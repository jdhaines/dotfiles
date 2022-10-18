if status is-interactive
    # Commands to run in interactive sessions can go here
    set -l onedark_options '-b'
    if set -q VIM
        # Using from vim/neovim.
        set onedark_options "-256"
    else if string match -iq "eterm*" $TERM
        # Using from emacs.
        function fish_title; true; end
        set onedark_options "-256"
    end

    set_onedark $onedark_options
end

# Useful Abbreviations (Maintain auto-complete)
abbr -a -g nv nvim-qt
abbr -a -g dc docker-compose

# bare git directory at $HOME/dotfiles - use config instead of git
alias config='/usr/bin/git --git-dir=/home/josh/dotfiles --work-tree=/home/josh'

alias logseq='/home/josh/.local/bin/Logseq* &'
alias sls='cd /home/josh/git/sfknowledge && git add . && git commit -m "docs(updates): auto update content" && git pull && git push'
alias vim=nvim
alias vi=nvim
alias sshb='ssh -p 8443 josh@192.168.180.144'
alias cat=bat
