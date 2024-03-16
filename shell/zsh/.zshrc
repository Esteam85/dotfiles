#shell init
source "$DOTFILES_PATH/shell/init.sh"

#ZSH options
setopt PROMPT_SUBST

ZSH_THEME="cloud"
plugins=(
    git 
    zsh-autosuggestions 
    web-search
    macos
    colorize
    zsh-syntax-highlighting
    colored-man-pages
    command-not-found
    copy-pasta
    z
    )

## COMMAND-NOT-FOUND PLUGING HOMEBREW CONFIG
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi

# NVM
source $(brew --prefix nvm)/nvm.sh


zle         -N    _display_dirmove
bindkey  '^h'  _display_dirmove

zle -N _reverse_search
bindkey '^r' _reverse_search


#oh-my-zsh
source $ZSH/oh-my-zsh.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
