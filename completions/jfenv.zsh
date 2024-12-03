if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jfenv jfenv

_jfenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jfenv commands)"
  else
    completions="$(jfenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}
