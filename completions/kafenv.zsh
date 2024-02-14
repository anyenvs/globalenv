if [[ ! -o interactive ]]; then
    return
fi

compctl -K _kafenv kafenv

_kafenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(kafenv commands)"
  else
    completions="$(kafenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
