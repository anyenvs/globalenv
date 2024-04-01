if [[ ! -o interactive ]]; then
    return
fi

compctl -K _k9senv k9senv

_k9senv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(k9senv commands)"
  else
    completions="$(k9senv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
