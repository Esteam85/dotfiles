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


# OpenSSL
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CPPFLAGS="-I$(brew --prefix openssl)/include"
export PYTHON_CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)"

export RANGER_FURY_LOCATION=/Users/estcontreras/.fury
export RANGER_FURY_VENV_LOCATION=/Users/estcontreras/.fury/fury_venv 
declare FURY_BIN_LOCATION="/Users/estcontreras/.fury/fury_venv/bin"
export PATH="$PATH:$FURY_BIN_LOCATION"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Go private for Meli
export GOPRIVATE=github.com/mercadolibre/*,github.com/melisource/*
export GONOSUMDB=github.com/mercadolibre/*,github.com/melisource/*export RANGER_FURY_LOCATION=/Users/estcontreras/.fury #Added by Fury CLI
export RANGER_FURY_VENV_LOCATION=/Users/estcontreras/.fury/fury_venv 

# Added by furycli:
export PATH="$HOME/.fury/fury_venv/bin:$PATH" # Added by furycli

#oh-my-zsh
source $ZSH/oh-my-zsh.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"