if [[ ! -o interactive ]]; then
    return
fi

compctl -K _kindenv kindenv

_kindenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(kindenv commands)"
  else
    completions="$(kindenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
