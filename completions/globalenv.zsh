if [[ ! -o interactive ]]; then
    return
fi

compctl -K _globalenv globalenv

_globalenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(globalenv commands)"
  else
    completions="$(globalenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
