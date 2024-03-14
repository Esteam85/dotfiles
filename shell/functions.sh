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

# most used alias
function zsh_stats() { 
 fc -l 1 | awk '{CMD[$2]++;count++;} END { for (a in CMD)	print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n25; 
}

# reverse search for used lastest commands, alike history 
_reverse_search() {
  local selected_command=$(fc -rl 1 | awk '{$1="";print substr($0,2)}' | fzf)
  LBUFFER=$selected_command
}

_display_dirmove() {
  dirtomove=$(ls | fzf)
  cd "$dirtomove"
}

# oxxo-labs
function pipeline_to_dev() {
  echo "🤖 Starting Pipeline to Dev ⭐🏃‍♂️"
  colima start
  echo "🤖 Colima started ✅"
  make login-aws-ecr aws_account=500107401034
  echo "🤖 Login to AWS finished ✅"
  make push-deployment-ecr stage_mioxxo=staging aws_account=500107401034
  echo "🤖 Push image to ECR finished ✅"
  make apply-deployment-k8s stage_mioxxo=staging aws_account=500107401034 ns-k8s=mioxxo-dev
  echo "🤖 Deployed to Dev finished ✅🚀"
}

function deploy_to_qa() {
  echo "🤖🚀 Deploying to QA ⭐🏃‍♂️"
  make apply-deployment-k8s stage_mioxxo=staging aws_account=500107401034 ns-k8s=mioxxo-qa
  echo "🤖🚀 Deployed to Dev finished ✅🚀"
}
