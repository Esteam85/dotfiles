#NVM
export NVM_DIR=~/.nvm

# GOLANG WALMART
export GOPRIVATE="gecgithub01.walmart.com/*"
export GONOPROXY="gecgithub01.walmart.com/*"
export GONOSUMDB="gecgithub01.walmart.com/*"
#export HTTP_PROXY="http://sysproxy.wal-mart.com:8080"
#export HTTPS_PROXY="http://sysproxy.wal-mart.com:8080"

#GOLANG
export PATH=/usr/local/go/bin:$PATH

#GOLANG
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$GOPATH:$PATH

#WALMART
export SLEDGE_BIN=/Users/estebancontreras/.sledge/bin
export PATH="${PATH}:${SLEDGE_BIN}"

#wic
export PROJECT_PATH=$HOME/Develop/wic/wic-backend
export WIC_REPOS=$HOME/Develop/wic

#NAVI
export NAVI_PATH="$DOTFILES_PATH/doc/navi"

#BREW
export HOMEBREW_BUNDLE_FILE_PATH="$DOTFILES_PATH/mac/brew"

#MAIN PRODUCT REPO
export MAIN_PRODUCT_REPO=$WIC_REPOS/wic-backend

#Oh-my-zsh
export ZSH_CUSTOM="$DOTFILES_PATH/mac/oh-my-zsh/custom"
