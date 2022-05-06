
#TELES THEME
function git_prompt_info {
  inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

  if [ "$inside_git_repo" ]; then
    current_branch=$(git branch --show-current)
    print -P " on %{%F{yellow}%}$current_branch%{%f%}"
  else
    echo ""
  fi
}

function prompt_exit_code() {
  local EXIT="$?"

  if [ $EXIT -eq 0 ]; then
    echo -n green
  else
    echo -n red
  fi
}

export PROMPT='%{%F{$(prompt_exit_code)}%}%n%{%f%} @ %d$(git_prompt_info):'