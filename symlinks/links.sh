#REMOVER
rm -rf $HOME/.nvm
rm $HOME/.zshrc
rm $HOME/.zshenv
rm $HOME/.gitconfig
rm $HOME/.hushlogin
rm $HOME/Library/Application\ Support/Rocket/rocket.db
rm $HOME/Library/Application\ Support/Code/User/settings.json


#ZSH
ln -s $HOME/.dotfiles/shell/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/shell/zsh/.zshenv $HOME/.zshenv
ln -s $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig

ln -s $HOME/.dotfiles/mac/.nvm $HOME/.nvm
ln -s $HOME/.dotfiles/mac/iterm2/.hushlogin $HOME/.hushlogin
ln -s $HOME/.dotfiles/mac/Rocket/rocket.db $HOME/Library/Application\ Support/Rocket/rocket.db
ln -s $HOME/.dotfiles/ides/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json