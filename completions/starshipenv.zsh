if [[ ! -o interactive ]]; then
    return
fi

compctl -K _starshipenv starshipenv

_starshipenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(starshipenv commands)"
  else
    completions="$(starshipenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
