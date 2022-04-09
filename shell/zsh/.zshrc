#shell init
source "$DOTFILES_PATH/shell/init.sh"

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
source $(brew --prefix nvm)/nvm.sh

#oh-my-zsh
source $ZSH/oh-my-zsh.sh
