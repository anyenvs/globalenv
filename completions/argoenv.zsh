if [[ ! -o interactive ]]; then
    return
fi

compctl -K _argoenv argoenv

_argoenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(argoenv commands)"
  else
    completions="$(argoenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
