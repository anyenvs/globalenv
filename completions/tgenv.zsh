if [[ ! -o interactive ]]; then
    return
fi

compctl -K _tgenv tgenv

_tgenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(tgenv commands)"
  else
    completions="$(tgenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
