function export_apps() {
brew services stop --all
brew bundle dump --file="$HOMEBREW_BUNDLE_FILE_PATH" --force
echo "Homebrew apps exportded..."
}

function import_apps(){
brew services stop --all
brew bundle --file="$HOMEBREW_BUNDLE_FILE_PATH" --force
echo "Homebrew apps imported..."
}
