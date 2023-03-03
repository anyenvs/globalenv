if [[ ! -o interactive ]]; then
    return
fi

compctl -K _pdenv pdenv

_pdenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(pdenv commands)"
  else
    completions="$(pdenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
