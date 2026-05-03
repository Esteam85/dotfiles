#Open Ides
alias c.='(code $PWD &>/dev/null &)'
alias w.='(webstorm $PWD &>/dev/null &)'
alias g.='(goland $PWD &>/dev/null &)'
alias i.='(idea $PWD &>/dev/null &)'
alias p.='(pycharm $PWD &>/dev/null &)'
alias ac.='(goland $HOME/Development/fury_cx-cases-actions &>/dev/null &)'
alias ap.='(goland $HOME/Development/fury_cx-cases-api &>/dev/null &)'

#apps
alias cat='ccat'

#os
alias o.='open .'
alias cdd='cd $HOME/Development'
alias s.='source $HOME/.zshrc'
alias zshrc='code $DOTFILES_PATH/shell/zsh/.zshrc'

# eza shortcuts
alias ld='eza -lD'
alias lf='eza -lF --color=always | grep -v /'
alias lh='eza -dl .* --group-directories-first'
alias ll='eza -al --group-directories-first'
alias ls='eza -alF --color=always --sort=size | grep -v /'
alias lt='eza -al --sort=modified'

# dotfiles
alias idf='$HOME/.dotfiles/install.sh'