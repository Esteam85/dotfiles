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

#oh-my-zsh
source $ZSH/oh-my-zsh.sh

## COMMAND-NOT-FOUND PLUGIN HOMEBREW CONFIG
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
  source "$HB_CNF_HANDLER"
fi

# NVM
source $(brew --prefix nvm)/nvm.sh

zle      -N   _display_dirmove
bindkey '^h' _display_dirmove

zle -N _reverse_search
bindkey '^r' _reverse_search

# OpenSSL
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CPPFLAGS="-I$(brew --prefix openssl)/include"
export PYTHON_CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)"

# Homebrew
export HOMEBREW_BIN_LOCATION="/opt/homebrew/bin"
export PATH="$HOMEBREW_BIN_LOCATION:$PATH"

# Fury CLI
export RANGER_FURY_LOCATION="$HOME/.fury"
export RANGER_FURY_VENV_LOCATION="$HOME/.fury/fury_venv"
export FURY_BIN_LOCATION="$HOME/.fury/fury_venv/bin"
export PATH="$FURY_BIN_LOCATION:$PATH"

fury() {
  if [[ "$1" != "get" || -z "$2" ]]; then
    command fury "$@"
    return $?
  fi

  local repo_path="$HOME/Development/fury_$2"
  local ssh_config="$HOME/.ssh/config"

  command fury "$@"
  local exit_code=$?

  # fury exits 0 even on clone failure; detect real success by checking the repo
  local clone_ok=false
  git -C "$repo_path" rev-parse HEAD &>/dev/null && clone_ok=true

  if [[ "$clone_ok" == false ]] && ! grep -q "Host github.com-emu" "$ssh_config" 2>/dev/null; then
    echo "⚡ fury get failed, adding github.com-emu host and retrying..."

    # Remove partial dir left by the failed attempt (fury aborts if dir exists)
    if [[ -d "$repo_path" ]] && ! git -C "$repo_path" rev-parse --git-dir &>/dev/null; then
      rm -rf "$repo_path"
    fi

    mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
    printf '\n# BEGIN fury-emu-temp\nHost github.com-emu\n  HostName github.com\n  User git\n  IdentityFile ~/.ssh/id_ed25519_melisource\n  IdentitiesOnly yes\n  AddKeysToAgent yes\n  UseKeychain yes\n# END fury-emu-temp\n' >> "$ssh_config"
    chmod 600 "$ssh_config"

    command fury "$@"
    exit_code=$?

    sed -i '' '/# BEGIN fury-emu-temp/,/# END fury-emu-temp/d' "$ssh_config"
    echo "✔ Removed temporary github.com-emu host"
  fi

  if [[ $exit_code -eq 0 && -d "$repo_path/.git" ]]; then
    local current_url
    current_url=$(git -C "$repo_path" remote get-url origin 2>/dev/null)
    if [[ "$current_url" == *"github.com-emu"* ]]; then
      git -C "$repo_path" remote set-url origin "${current_url/github.com-emu/github.com}"
      echo "✔ Remote fixed: ${current_url/github.com-emu/github.com}"
    fi
  fi

  return $exit_code
}

# Go private for Meli
export GOPRIVATE=github.com/mercadolibre/*,github.com/melisource/*
export GONOSUMDB=github.com/mercadolibre/*,github.com/melisource/*
export PATH="$HOME/go/bin:$PATH"

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Anthropic
export ANTHROPIC_MODEL="claude-sonnet-4-6"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# >>> es-wrapper initialize >>>
# Agregado automáticamente por el instalador de es-wrapper
# Para desinstalar, ejecuta: ~/.es-wrapper/uninstall.sh
export PATH="$HOME/.es-wrapper/bin:$PATH"

unalias source 2>/dev/null
unalias . 2>/dev/null
source() {
    builtin source "$@"
    local ret=$?
    if [[ -n "$VIRTUAL_ENV" ]]; then
        export PATH="$HOME/.es-wrapper/bin:$PATH"
    fi
    return $ret
}
alias .='source'

_es_wrapper_guard() {
    case ":$PATH:" in
        *":$HOME/.es-wrapper/bin:"*)
            if [[ "$PATH" != "$HOME/.es-wrapper/bin:"* ]]; then
                export PATH="$HOME/.es-wrapper/bin:${PATH//$HOME\/.es-wrapper\/bin:/}"
            fi
            ;;
        *)
            export PATH="$HOME/.es-wrapper/bin:$PATH"
            ;;
    esac
}
precmd_functions+=(_es_wrapper_guard)
# <<< es-wrapper initialize <<<

# Local secrets (not in repo)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
