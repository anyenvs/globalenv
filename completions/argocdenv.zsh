if [[ ! -o interactive ]]; then
    return
fi

compctl -K _argocdenv argocdenv

_argocdenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(argocdenv commands)"
  else
    completions="$(argocdenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
