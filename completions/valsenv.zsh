if [[ ! -o interactive ]]; then
    return
fi

compctl -K _valsenv valsenv

_valsenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(valsenv commands)"
  else
    completions="$(valsenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
