#!/bin/bash
set -e
#Install Oh My Zsh
echo "💪 Installing Oh-My-Zsh"
if [ ! -d "$ZSH" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✅ Oh-My-Zsh installed successfully!"
else 
    echo "👍 Oh-My-Zsh already installed!"
    echo "👀 Updating Oh-My-Zsh"
    "$ZSH/tools/upgrade.sh"
    echo "✅ Oh-My-Zsh updated successfully!"
fi

#Download git submodules
echo "💪 Downloading git submodules in .dotfiles!"
cd $HOME/.dotfiles
git submodule init && git submodule update && cd $HOME
echo "✅ git submodules in .dotfiles! downloaded successfully!"

# Install Homebrew
echo "💪 Installing Homebrew!"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "✅ Homebrew installed successfully!"
else
    echo "👍 Homebrew already installed!"
    echo "👀 Upgrading apps"
    brew upgrade
    echo "✅ Apps upgraded successfully!"
fi




#Init Shell files
echo "💪 Installing Init Shell files"
sh $HOME/.dotfiles/shell/init.sh
retval=$?
if [ $retval -eq 0 ]; then
    echo "✅Init Shell files installed successfully!"
else
    "💔 Error installing Init Shell files $retval" >&2
fi


# Install dotfiles bundle
echo "💪 Intalling bundle from Brewfile!"
brew bundle --file="$HOMEBREW_BUNDLE_FILE" --force
retval=$?
if [ $retval -eq 0 ]; then
    echo "✅Homebrew Bundle installed successfully!"
else
    "💔 Error installing Homebrew bundle $retval" >&2
fi

# Creating links
echo "💪 Creating symlinks"
sh $HOME/.dotfiles/symlinks/links.sh
echo "✅Symlinks created successfully!"

# Run mac-os script(default macosx configs)
echo "💪 Config Mac defaults"
sh $HOME/.dotfiles/mac/mac-os.sh
echo "✅Mac defaults confured successfully!"

#Restart
echo "Restart is needed, do you wish to restart?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo shutdown -r now; echo "💫 Restarting..."; break;;
        No ) echo "👏🥳 Installation finished 👀without restarting⚠️";exit;;
    esac
done
