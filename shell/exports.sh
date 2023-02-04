#NVM TODO add this folder inside dotfiles repo
export NVM_DIR=~/.nvm

#GOLANG
export PATH=/usr/local/go/bin:$PATH

#GOLANG
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$GOPATH:$PATH

#BREW
export HOMEBREW_BUNDLE_FILE_PATH="$DOTFILES_PATH/mac/brew"

#Oh-my-zsh
export ZSH_CUSTOM="$DOTFILES_PATH/mac/oh-my-zsh/custom"
