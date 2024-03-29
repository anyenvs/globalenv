if [[ ! -o interactive ]]; then
    return
fi

compctl -K _divenv divenv

_divenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(divenv commands)"
  else
    completions="$(divenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
