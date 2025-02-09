if [[ ! -o interactive ]]; then
    return
fi

compctl -K _ollamaenv ollamaenv

_ollamaenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(ollamaenv commands)"
  else
    completions="$(ollamaenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
