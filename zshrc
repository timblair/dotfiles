# Load just the bits of OMZ that I care about (the theming and history).
# At some point I'll pull these out so I don't actually need OMZ at all.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="miloshadzic"
source $ZSH/lib/git.zsh
HIST_STAMPS=yyyy-mm-dd source $ZSH/lib/history.zsh
source $ZSH/lib/theme-and-appearance.zsh
source $ZSH/themes/$ZSH_THEME.zsh-theme

BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-default-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

eval "$(rbenv init --no-rehash - zsh)"
(rbenv rehash &) 2> /dev/null
RBENV_ROOT=$HOME/.rbenv

export PATH="$HOME/.rbenv/shims:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export GOPATH=$HOME/govuk/gopath
export GOROOT=`go env GOROOT`
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"

export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

export EDITOR=/usr/local/bin/vim
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
alias tigs='tig status'
alias g='git'
alias v="vim"
alias s="vi + -c 'set filetype=markdown' ~/Dropbox/scratch.md"
alias b="git browse"
alias gtw="fswatch -o -0 . | xargs -0 -n 1 -I {} go test"
alias repath="cd && cd -"
alias gup-all='for D in $(ls); do (echo "\n\n>>> $D\n"; cd "$D"; g up); done'
alias p="ping 8.8.8.8"
alias venv="virtualenv ENV && source ENV/bin/activate && pip install -r requirements.txt"

alias vm='cd ~/govuk/govuk-puppet/development-vm && vagrant up && vagrant ssh && cd -'
alias vm-off='cd ~/govuk/govuk-puppet/development-vm && vagrant suspend && cd -'
gov() { cd ~/govuk/$1; }
compctl -W ~/govuk/ -/ gov

gosrc() { cd $GOPATH/src/$1; }
compctl -W $GOPATH/src/ -/ gosrc

function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
