_argoenv() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(argoenv commands)" -- "$word") )
  else
    local words=("${COMP_WORDS[@]}")
    unset words[0]
    unset words[$COMP_CWORD]
    local completions=$(argoenv completions "${words[@]}")
    COMPREPLY=( $(compgen -W "$completions" -- "$word") )
  fi
}

complete -F _argoenv argoenv
