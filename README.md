# Set up steps
1. Clone this repo to .dotfiles folder in Home folder with it's submodules
```sh
cd
git clone git@github.com:Esteam85/dotfiles.git .dotfiles
git submodule init && git submodule update
```
2. Run symlinks
```sh
sh $HOME/.dotfiles/symlinks/links.sh
```
3. install brew bundle
```sh
cd $HOME/.dotfiles/mac/brew
brew bundle
```
3. run mac-os script(default macosx configs)
```sh
sh $HOME/.dotfiles/mac/mac-os.sh
```
4. after all restart

## TODO
1. Add .nvm folder
2. refactor README.md
3. improve setup
4. update Brewfile