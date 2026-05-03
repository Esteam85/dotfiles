#ZSH
rm $HOME/.zshrc
rm $HOME/.zshenv
rm $HOME/.zprofile
ln -s $HOME/.dotfiles/shell/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/shell/zsh/.zshenv $HOME/.zshenv
ln -s $HOME/.dotfiles/shell/zsh/.zprofile $HOME/.zprofile

#GIT
rm $HOME/.gitconfig
ln -s $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig

#ITERM2
rm $HOME/.hushlogin
ln -s $HOME/.dotfiles/mac/iterm2/.hushlogin $HOME/.hushlogin

#ROCKET
rm $HOME/Library/Application\ Support/Rocket/rocket.db
ln -s $HOME/.dotfiles/mac/Rocket/rocket.db $HOME/Library/Application\ Support/Rocket/rocket.db

#VSCODE
rm $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $HOME/.dotfiles/ides/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

#AEROSPACE
rm $HOME/.aerospace.toml
ln -s $HOME/.dotfiles/mac/aerospace/.aerospace.toml $HOME/.aerospace.toml

#GH CLI
rm $HOME/.config/gh/config.yml
ln -s $HOME/.dotfiles/ides/gh/config.yml $HOME/.config/gh/config.yml

#ICLOUD
rm $HOME/icloud
ln -s $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/ $HOME/icloud

#FAMILY FOLDERS
rm $HOME/Samy
rm $HOME/Amorcita
ln -s $HOME/icloud/Samy $HOME/Samy
ln -s $HOME/icloud/Amorcita $HOME/Amorcita

#NVM
rm -rf $HOME/.nvm
