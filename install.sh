#!/bin/bash
set -e
# Load in the functions and animations
source ~/.dotfiles/shell/loading/bash_loading_animations.sh
# Run BLA::stop_loading_animation if the script is interrupted
trap BLA::stop_loading_animation SIGINT

#Updating Dotfiles
BLA::start_loading_animation "${BLA_classic[@]}"
echo "🆙 Updating Dotfiles Repository"
git -C ~/.dotfiles pull origin main
echo "✅ Dotfiles Repository Updated"

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
    echo "✅ Init Shell files installed successfully!"
else
    "💔 Error installing Init Shell files $retval" >&2
fi

# Install dotfiles bundle
echo "💪 Intalling bundle from Brewfile!"
brew bundle --quiet --file="$HOME/.dotfiles/mac/brew/Brewfile" --force
retval=$?
if [ $retval -eq 0 ]; then
    echo "✅ Homebrew Bundle installed successfully!"
else
    "💔 Error installing Homebrew bundle $retval" >&2
fi

# Creating links
echo "💪 Creating symlinks"
sh $HOME/.dotfiles/symlinks/links.sh
echo "✅ Symlinks created successfully!"


#Creating Development Folder
echo "💪 Making Folder for Development ${HOME}/Development, ${HOME}/go, ${HOME}/.kube, ${HOME}/.aws"
if [ -d "${HOME}/Development" ] || [ -d "${HOME}/go" ] || [ -d "${HOME}/.kube" ] || [ -d "${HOME}/.aws" ]; then
    echo "👍 Folders already exist."
else
    mkdir "${HOME}/Development" "${HOME}/go" "${HOME}/.kube" "${HOME}/.aws"
    if [ $? -ne 0 ]; then
        echo "🛑 Error making folders."
    else     
        echo "✅ Development folders created successfully in ${HOME}!"
    fi
fi

# Run mac-os script(default macosx configs)
echo "💪 Config Mac defaults"
sh $HOME/.dotfiles/mac/mac-os.sh
echo "✅ Mac defaults configured successfully!"

# Run mac-os script(default macosx configs)
echo "💪 Config extensions defaults apps"
sh $HOME/.dotfiles/mac/duti/default-app-extensions.sh
echo "✅ Config extensions defaults apps configured successfully!"

# Run docker and colima installation script, only works for M1
echo "💪 Installing Docker and Colima for M1"
sh $HOME/.dotfiles/mac/docker/install-docker-colima.sh
echo "✅ Docker and Colima installed successfully!"
BLA::stop_loading_animation &> /dev/null

#Restart
echo "⚠️ Restart is needed, do you wish to restart? (y/n)"
read -t 5 yn
if [ "$yn" = "y" ]; then
    sudo shutdown -r now
    echo "💫 Restarting..."
else
    echo "👏🥳 Installation finished👀 without restarting⚠️"
    exit
fi