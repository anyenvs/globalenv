if [[ ! -o interactive ]]; then
    return
fi

compctl -K _fishenv fishenv

_fishenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(fishenv commands)"
  else
    completions="$(fishenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
