if [[ ! -o interactive ]]; then
    return
fi

compctl -K _veleroenv veleroenv

_veleroenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(veleroenv commands)"
  else
    completions="$(veleroenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
