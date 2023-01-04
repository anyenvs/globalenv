if [[ ! -o interactive ]]; then
    return
fi

compctl -K _dcenv dcenv

_dcenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(dcenv commands)"
  else
    completions="$(dcenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
