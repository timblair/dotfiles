ZSH=$HOME/.oh-my-zsh
ZSH_THEME="miloshadzic"
plugins=(git brew bundler osx rbenv)

source $ZSH/oh-my-zsh.sh

BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-default-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

eval "$(rbenv init -)"
RBENV_ROOT=$HOME/.rbenv

export GOPATH=$HOME/go
export GOROOT=`go env GOROOT`

export PATH="$HOME/.rbenv/shims:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

export EDITOR=/usr/local/bin/vi
export COPYFILE_DISABLE=true

alias ls='ls -G'
alias ll='ls -hl'
alias gi='gem install --no-ri --no-rdoc'
alias grep='GREP_COLOR="0;30;44" LANG=C grep --color=auto'
alias finder='open -a Finder .'
alias gitx='open -a GitX'
alias ports='sudo lsof -i -P | grep -i "listen"'
alias be='bundle exec'
alias ber='bundle exec rails'
alias wld='cd ~/Projects/wld'
alias mobile='cd ~/Projects/mobile'
alias vm='ssh vm'
alias tigs='tig status'
alias g='git'
alias shadow-off='defaults write com.apple.screencapture disable-shadow -bool true; killall SystemUIServer'
alias shadow-on='defaults write com.apple.screencapture disable-shadow -bool false; killall SystemUIServer'
alias v="vim"
alias p="cd ~/Projects"
alias _p="cd ~/Projects/_personal"
alias s="vi + -c 'set filetype=markdown' ~/Dropbox/scratch.md"
alias oh-my-zsh-up="upgrade_oh_my_zsh"
alias b="git browse"
alias gtw="fswatch -o -0 . | xargs -0 -n 1 -I {} go test"

function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
