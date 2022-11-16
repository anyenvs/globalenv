if [[ ! -o interactive ]]; then
    return
fi

compctl -K _helmenv helmenv

_helmenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(helmenv commands)"
  else
    completions="$(helmenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
