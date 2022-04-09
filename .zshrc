export ZSH="/Users/estebancontreras/.oh-my-zsh"
ZSH_THEME="cloud"
plugins=(
    git 
    zsh-autosuggestions 
    web-search
    history
    macos
    colorize
    zsh-syntax-highlighting
    colored-man-pages
    command-not-found
    dotenv
    copy-pasta
    )

## COMMAND-NOT-FOUND PLUGING HOMEBREW CONFIG
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# GOLANG WALMART
export GOPRIVATE="gecgithub01.walmart.com/*"
export GONOPROXY="gecgithub01.walmart.com/*"
export GONOSUMDB="gecgithub01.walmart.com/*"
#export HTTP_PROXY="http://sysproxy.wal-mart.com:8080"
#export HTTPS_PROXY="http://sysproxy.wal-mart.com:8080"

export SLEDGE_BIN=/Users/estebancontreras/.sledge/bin
export PATH="${PATH}:${SLEDGE_BIN}"

export PROJECT_PATH=$PWD

export PATH=/usr/local/go/bin:$PATH
export GOPATH=~/go
export GOBIN=$GOPATH/bin

#wic
export PROJECT_PATH=$PWD
source $ZSH/oh-my-zsh.sh
