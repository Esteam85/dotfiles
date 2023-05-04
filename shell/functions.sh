function export_apps() {
brew services stop --all
brew bundle dump --file="$HOMEBREW_BUNDLE_FILE" --force
echo "Homebrew apps exportded..."
}

function import_apps(){
brew services stop --all
brew bundle --file="$HOMEBREW_BUNDLE_FILE" --force
echo "Homebrew apps imported..."
}

#most used alias
function zsh_stats() { 
 fc -l 1 | awk '{CMD[$2]++;count++;} END { for (a in CMD)	print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n25; 
}

#reverse search for used lastest commands, alike history 
_reverse_search() {
  local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | fzf)
  LBUFFER=$selected_command
}

_display_dirmove() {
  dirtomove=$(ls | fzf)
  cd "$dirtomove"
}
